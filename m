Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWF2U1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWF2U1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWF2U1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:27:07 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:26794 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S932413AbWF2U1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:27:05 -0400
Message-ID: <44A43769.5040601@interia.pl>
Date: Thu, 29 Jun 2006 22:26:17 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060628)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Longhaul - infrastructure(?) proposal
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-EMID: 9abaeacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case that flushing and disabling caches will not work.
(but it is possible that I do above in wrong way).
Would this code below be acceptable as infrastructure?
Is this infrastructure or maybe hack? Are there any HOWTO 
write correct infrastructure?
This is draft/proposal.
Can I continue in this way or I shouldn't?

This code (more correct version) will be included in 
longhaul.c. There should be include file "cpufreq_longhaul.h"
for drivers knowing about "longhaul problem".

Driver would have all code for longhaul in
"#ifdef CONFIG_X86_LONGHAUL / #else / #endif".

Basic support for longhaul in driver:
1. driver calls longhaul_bmdma_register("driver_name_wq")
   at init,
2. driver calls longhaul_bmdma_begin before starting BMDMA
   with function that is starting DMA for this driver
   (or in case of via-rhine driver with function which queues
   packet in hardware queue). You can do it multiple times 
   before calling longhaul_bmdma_end for the first time,
3. driver calls longhaul_bmdma_end after BMDMA transfer is 
   completed (via-rhine - after packet was send).

Longhaul would simply lock write longhaul_sem before 
CPU frequency change.
 
Sorry to bother You all again.

Rafa³

---

/*
 * Longhaul "infrastructure" for bus master DMA
 */

struct longhaul_work {
	struct list_head entry;
	struct work_struct work;
	struct longhaul_data *data;
	void (*device_func) (void *data);
	void *device_data;
};

struct longhaul_data {
	struct workqueue_struct *wq;
	spinlock_t lock;
	struct list_head work_unused;
	struct list_head work_inuse;
	struct list_head work_used;
};

/* Access control for PCI bus */
static struct rw_semaphore longhaul_sem;

struct longhaul_data *longhaul_bmdma_register(char *name)
{
	struct longhaul_data *longdata;
	struct longhaul_work *longwork;
	struct workqueue_struct *workqueue;

	longdata = kmalloc(sizeof(struct longhaul_data), GFP_KERNEL);
	if (longdata == NULL)
		return NULL;
	spin_lock_init(&longdata->lock);
	INIT_LIST_HEAD(&longdata->work_unused);
	INIT_LIST_HEAD(&longdata->work_inuse);
	INIT_LIST_HEAD(&longdata->work_used);

	longwork = kmalloc(sizeof(struct longhaul_work), GFP_KERNEL);
	if (longwork == NULL) {
		goto free_longdata;
	}
	INIT_WORK(&longwork->work, &longhaul_bmdma_work, NULL);
	list_add(longwork, &longdata->work_unused);
	longwork->data = longdata;

	workqueue = create_singlethread_workqueue(name);
	if (workqueue == NULL) {
		printk(KERN_ERR PFX "Can't create workqueue \"%s\".\n", name);
		goto free_longwork;
	}
	longdata->wq = workqueue;

	return longdata;

free_longwork:
	kfree(longwork);
free_longdata:
	kfree(longdata);
	return NULL;
}
EXPORT_SYMBOL(longhaul_bmdma_register);


void longhaul_bmdma_unregister(struct longhaul_data *longdata)
{
}
EXPORT_SYMBOL(longhaul_bmdma_unregister);


static void longhaul_bmdma_work(void *data)
{
	struct longhaul_work *longwork = data;
	struct longhaul_data *longdata = longwork->data;
	unsigned long flags;

	down_read(&longhaul_sem);

	longdata->device_func(longdata->device_data);

	spin_lock_irqsave(&longdata->lock, flags);
	list_move(longwork, &longdata->work_used);
	spin_unlock_irqrestore(&longdata->lock, flags);
}

int longhaul_bmdma_begin(struct longhaul_data *longdata,
			void (*device_func) (void *data),
			void *device_data);
{
	struct longhaul_work *longwork;
	unsigned long flags;

	spin_lock_irqsave(&longdata->lock, flags);

	if ( list_empty(&longdata->work_unused) ) {
		longwork = kmalloc(sizeof(struct longhaul_work), GFP_ATOMIC);
		if (longwork == NULL) {
			spin_unlock_irqrestore(&longdata->lock, flags);
			return -ENOMEM;
		}
		INIT_WORK(&longwork->work, &longhaul_bmdma_work, NULL);
		longwork->data = longdata;
		list_add(longwork, &longdata->work_inuse);
	} else {
		longwork = longdata->work_unused->next;
		list_move(longwork, &longdata->work_inuse);
	}

	spin_unlock_irqrestore(&longdata->lock, flags);

	longwork->device_func = device_func;
	longwork->device_data = device_data;
	PREPARE_WORK(longwork, &longhaul_bmdma_work, (void*)longwork);
	queue_work(longdata->wq, longwork);

	return 0;
}
EXPORT_SYMBOL(longhaul_bmdma_begin);


void longhaul_bmdma_end(struct longhaul_data *longdata)
{
	struct list_head pos;
	unsigned long flags;

	spin_lock_irqsave(&longdata->lock, flags);

	if ( !list_empty(&longdata->work_used) ) {
		list_for_each(pos, &longdata->work_used) {
			list_move(longwork, &longdata->work_unused);
		}
	}

	spin_unlock_irqrestore(&longdata->lock, flags);

	up_read(&longhaul_sem);
}
EXPORT_SYMBOL(longhaul_bmdma_end);



----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a

