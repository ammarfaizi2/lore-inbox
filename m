Return-Path: <linux-kernel-owner+w=401wt.eu-S932097AbXALP1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXALP1B (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbXALP1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:27:00 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:64437 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbXALP07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:26:59 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of do_mmap()
Date: Fri, 12 Jan 2007 16:23:13 +0100
User-Agent: KMail/1.8.2
Cc: Nathan Lynch <ntl@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com> <20070111194054.GA11770@localdomain> <adaodp5ibh9.fsf@cisco.com>
In-Reply-To: <adaodp5ibh9.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121623.13687.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland!
>  > >  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
>  > >  	while (my_cq->nr_callbacks)
>  > >  		yield();
> 
>  > Isn't that code outright buggy?  Calling into the scheduler with a
>  > spinlock held and local interrupts disabled...
> 
> Yes, absolutely -- if nr_callbacks is ever nonzero then this will
> obviously crash instantly.
As Christoph R. mentioned in another thread I'm sending you a patch
to fix this bug. Thanks to all for this hint!
Purpose of the while loop is to wait until all completion entries
have been processed by a running completion handler. First then
the function continue with destroying completion queue. Thus, we do
unlock and lock around yield(), ie yield() is now called from a normal
process context without active lock. Hope that this pattern is ok.
In addition of yield issue this patch also fixes an unproper use of
spin_unlock() in ehca_irq.c.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_cq.c  |    5 ++++-
 ehca_irq.c |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_cq.c	2007-01-11 19:54:06.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c	2007-01-12 15:27:50.000000000 +0100
@@ -330,8 +330,11 @@ int ehca_destroy_cq(struct ib_cq *cq)
 	}
 
 	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
-	while (my_cq->nr_callbacks)
+	while (my_cq->nr_callbacks) {
+		spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 		yield();
+		spin_lock_irqsave(&ehca_cq_idr_lock, flags);
+	}
 
 	idr_remove(&ehca_cq_idr, my_cq->token);
 	spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_irq.c	2007-01-11 19:53:33.000000000 +0100
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c	2007-01-12 15:27:50.000000000 +0100
@@ -440,7 +440,9 @@ void ehca_tasklet_eq(unsigned long data)
 					cq = idr_find(&ehca_cq_idr, token);
 
 					if (cq == NULL) {
-						spin_unlock(&ehca_cq_idr_lock);
+						spin_unlock_irqrestore(
+							&ehca_cq_idr_lock,
+							flags);
 						break;
 					}
 

