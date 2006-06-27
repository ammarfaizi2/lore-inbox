Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWF0PPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWF0PPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWF0PPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:15:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22453 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161087AbWF0PPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:15:42 -0400
Subject: Re: + delay-accounting-taskstats-interface-send-tgid-once.patch
	added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       jlan@engr.sgi.com
In-Reply-To: <200606261906.k5QJ6vCp025201@shell0.pdx.osdl.net>
References: <200606261906.k5QJ6vCp025201@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 17:15:36 +0200
Message-Id: <1151421336.5217.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also in response to
                           Subject: 
Re: 2.6.17-mm3
                              Date: 
Tue, 27 Jun 2006 16:12:42 +0200
with Message-ID:
<6bffcb0e0606270712w166f04a6u237d695e2bfa1913@mail.gmail.com>

On Mon, 2006-06-26 at 12:06 -0700, akpm@osdl.org wrote:

> +static inline void taskstats_tgid_alloc(struct signal_struct *sig)
> +{
> +	struct taskstats *stats;
> +
> +	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
> +	if (!stats)
> +		return;
> +
> +	spin_lock(&sig->stats_lock);
> +	if (!sig->stats) {

+static inline void taskstats_tgid_free(struct signal_struct *sig)
+{
+       struct taskstats *stats = NULL;
+       spin_lock(&sig->stats_lock);
+       if (sig->stats) {
+               stats = sig->stats;
+               sig->stats = NULL;
+       }
+       spin_unlock(&sig->stats_lock);
+       if (stats)
+               kmem_cache_free(taskstats_cache, stats);
+}

this is buggy and deadlock prone!
(found by lockdep)

stats_lock nests within tasklist_lock, which is taken in irq context.
(and thus needs irq_save treatment). But because of this nesting, it is
not allowed to take stats_lock without disabling irqs, or you can have
the following scenario

CPU 0                		CPU 1
(in irq)            	 	(in the code above)
		     		stats_lock is taken
tasklist_lock is taken	     	
stats_lock_is taken <spin>	
				<interrupt happens>
		     		tasklist_lock is taken
		     
which now forms an AB-BA deadlock!


this happens at least in copy_process which can call taskstats_tgid_free
without first disabling interrupts (via cleanup_signal). There may be
many other cases, I've not checked deeper yet.

Solution should be to make these functions use irqsave variant... any
comments from the authors of this patch ?


