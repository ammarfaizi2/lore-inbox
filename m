Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWAYJCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWAYJCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWAYJCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:02:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:20188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751017AbWAYJCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:02:41 -0500
Date: Wed, 25 Jan 2006 10:02:40 +0100
From: Olaf Kirch <okir@suse.de>
To: Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: e100 oops on resume
Message-ID: <20060125090240.GA12651@suse.de>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20060124232142.GB6174@inferi.kami.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2006 at 12:21:42AM +0100, Mattia Dongili wrote:
> I experienced the same today, I was planning to get a photo tomorrow :)
> I'm running 2.6.16-rc1-mm2 and the last working kernel was 2.6.15-mm4
> (didn't try .16-rc1-mm1 being scared of the reiserfs breakage).

I think that's because the latest driver version wants to wait for
the ucode download, and e100_exec_cb_wait before allocating any
control blocks.

static inline int e100_exec_cb_wait(struct nic *nic, struct sk_buff *skb,
        void (*cb_prepare)(struct nic *, struct cb *, struct sk_buff *))
{
        int err = 0, counter = 50;
        struct cb *cb = nic->cb_to_clean;

        if ((err = e100_exec_cb(nic, NULL, e100_setup_ucode)))
                DPRINTK(PROBE,ERR, "ucode cmd failed with error %d\n", err);
	/* NOTE: the oops shows that e100_exec_cb fails with ENOMEM,
  	 * which also means there are no cbs */

	/* ... other stuff...
	 * and then we die here because cb is NULL: */
        while (!(cb->status & cpu_to_le16(cb_complete))) {
                msleep(10);
                if (!--counter) break;
        }

I'm not sure what the right fix would be. e100_resume would probably
have to call e100_alloc_cbs early on, while e100_up should avoid
calling it a second time if nic->cbs_avail != 0. A tentative patch
for testing is attached.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=e100-resume-fix

[PATCH] e100: allocate cbs early on when resuming

Signed-off-by: Olaf Kirch <okir@suse.de>

 drivers/net/e100.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

Index: build/drivers/net/e100.c
===================================================================
--- build.orig/drivers/net/e100.c
+++ build/drivers/net/e100.c
@@ -1298,8 +1298,10 @@ static inline int e100_exec_cb_wait(stru
 	int err = 0, counter = 50;
 	struct cb *cb = nic->cb_to_clean;
 
-	if ((err = e100_exec_cb(nic, NULL, e100_setup_ucode)))
+	if ((err = e100_exec_cb(nic, NULL, e100_setup_ucode))) {
 		DPRINTK(PROBE,ERR, "ucode cmd failed with error %d\n", err);
+		return err;
+	}
 
 	/* must restart cuc */
 	nic->cuc_cmd = cuc_start;
@@ -1721,9 +1723,11 @@ static int e100_alloc_cbs(struct nic *ni
 	struct cb *cb;
 	unsigned int i, count = nic->params.cbs.count;
 
+	/* bail out if we've been here before */
+	if (nic->cbs_avail)
+		return 0;
+
 	nic->cuc_cmd = cuc_start;
-	nic->cb_to_use = nic->cb_to_send = nic->cb_to_clean = NULL;
-	nic->cbs_avail = 0;
 
 	nic->cbs = pci_alloc_consistent(nic->pdev,
 		sizeof(struct cb) * count, &nic->cbs_dma_addr);
@@ -2578,6 +2582,8 @@ static int __devinit e100_probe(struct p
 	nic->pdev = pdev;
 	nic->msg_enable = (1 << debug) - 1;
 	pci_set_drvdata(pdev, netdev);
+	nic->cb_to_use = nic->cb_to_send = nic->cb_to_clean = NULL;
+	nic->cbs_avail = 0;
 
 	if((err = pci_enable_device(pdev))) {
 		DPRINTK(PROBE, ERR, "Cannot enable PCI device, aborting.\n");
@@ -2752,6 +2758,8 @@ static int e100_resume(struct pci_dev *p
 	retval = pci_enable_wake(pdev, 0, 0);
 	if (retval)
 		DPRINTK(PROBE,ERR, "Error clearing wake events\n");
+	if ((retval = e100_alloc_cbs(nic)))
+		DPRINTK(PROBE,ERR, "No memory for cbs\n");
 	if(e100_hw_init(nic))
 		DPRINTK(HW, ERR, "e100_hw_init failed\n");
 

--OgqxwSJOaUobr8KG--
