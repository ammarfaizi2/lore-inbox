Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318951AbSHSRv1>; Mon, 19 Aug 2002 13:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSHSRv1>; Mon, 19 Aug 2002 13:51:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47368 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318951AbSHSRv0>;
	Mon, 19 Aug 2002 13:51:26 -0400
Message-ID: <3D61338C.E53C5AB9@zip.com.au>
Date: Mon, 19 Aug 2002 11:06:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] LTP-Nightly bk test
References: <2553170000.1029775843@flay> <1029777883.4073.4.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> On Mon, 2002-08-19 at 11:50, Martin J. Bligh wrote:
> > > page allocation failure. order:0, mode:0x50
> > >
> > > The test was: 'mtest01 -p80 -w' which will essentially allocate up to
> > > 80% of the memory and write to it.  I'll keep pounding on it with LTP to
> > > see if I can reproduce the swap.c:80 oops.
> >
> > I think akpm posted a patch for similar mem exhaustion a few days ago,
> > but I can't find it at the moment. Would be interesting to see what
> > /proc/meminfo and /proc/slabinfo look like as you march to your death ;-)
> Anyone know where to find that patch?  I'll look at doing this again
> while grabbing those files periodically.  I ran this again though and
> got a different error:
> 
> kernel BUG at page_alloc.c:97!

It's hard to tell where this is coming from.  Please quote
line 97 of page_alloc.c?

For the page allocation failures you'll probably need this, which
makes block-highmem work again.


--- 2.5.31/drivers/scsi/scsi_scan.c~scsi_hack	Sat Aug 17 02:43:05 2002
+++ 2.5.31-akpm/drivers/scsi/scsi_scan.c	Sat Aug 17 02:43:07 2002
@@ -1379,6 +1379,12 @@ static int scsi_add_lun(Scsi_Device *sde
 		printk(KERN_INFO "scsi: unknown device type %d\n", sdev->type);
 	}
 
+	/*
+	 * scsi_alloc_sdev did this, but do it again because we can now set
+	 * the bounce limit because the device type is known
+	 */
+	scsi_initialize_merge_fn(sdev);
+
 	sdev->random = (sdev->type == TYPE_TAPE) ? 0 : 1;
 
 	print_inquiry(inq_result);

.

If your machine is uniprocessor (?) you'll need this:


--- 2.5.31/mm/vmscan.c~pte-chain-fix	Sun Aug 18 19:38:15 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 18 19:38:37 2002
@@ -398,10 +398,7 @@ static /* inline */ void refill_inactive
 		page = list_entry(l_hold.prev, struct page, lru);
 		list_del(&page->lru);
 		if (page->pte.chain) {
-			if (test_and_set_bit(PG_chainlock, &page->flags)) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
+			pte_chain_lock(page);
 			if (page->pte.chain && page_referenced(page)) {
 				pte_chain_unlock(page);
 				list_add(&page->lru, &l_active);

.
