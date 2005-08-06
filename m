Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVHFJPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVHFJPD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 05:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVHFJPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 05:15:03 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:30596 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262415AbVHFJPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 05:15:01 -0400
Date: Sat, 6 Aug 2005 11:15:02 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix invalid kmalloc flags (GFP_DMA alone)
Message-ID: <20050806091502.GC11835@ens-lyon.fr>
References: <20050806002603.GA29515@ens-lyon.fr> <20050805173629.78f3a0e6.akpm@osdl.org> <20050806020035.GA24455@kvack.org> <20050805190500.1a78322b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805190500.1a78322b.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 07:05:00PM -0700, Andrew Morton wrote:
> Benjamin LaHaise <bcrl@kvack.org> wrote:
> >
> > On Fri, Aug 05, 2005 at 05:36:29PM -0700, Andrew Morton wrote:
> > > No, GFP_DMA should work OK.  Except GFP_DMA doesn't have __GFP_VALID set. 
> > > It's strange that this didn't get noticed earlier.
> > > 
> > > Ben, was there a reason for not giving GFP_DMA the treatment?
> > 
> > Not really.  Traditionally GFP_DMA was always mixed in with GFP_KERNEL or 
> > GFP_ATOMIC.  It seems that GFP_DMA wasn't in the hunk of defines that all 
> > the other kernel flags were in, so if GFP_DMA is really valid all by itself, 
> > adding in the __GFP_VALID should be okay.
> > 
> 
> OK, it seems that pretty much all callers do remember to add GFP_KERNEL so
> I guess we can treat this as a bug-which-ben's-patch-found and merge
> Benoit's fix.

The following patch should catch all the other calls with GFP_DMA and
without either GFP_KERNEL or GFP_ATOMIC.
I didn't included the previous patch (for arch/s390/mm/extmem.c).

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


diff -urp -X other/Documentation/dontdiff truc/arch/s390/appldata/appldata_os.c other/arch/s390/appldata/appldata_os.c
--- truc/arch/s390/appldata/appldata_os.c	2005-08-06 02:13:50.000000000 +0200
+++ other/arch/s390/appldata/appldata_os.c	2005-08-06 09:26:53.000000000 +0200
@@ -194,7 +194,7 @@ static int __init appldata_os_init(void)
 	P_DEBUG("sizeof(os) = %i, sizeof(os_cpu) = %lu\n", size,
 		sizeof(struct appldata_os_per_cpu));
 
-	appldata_os_data = kmalloc(size, GFP_DMA);
+	appldata_os_data = kmalloc(size, GFP_DMA|GFP_KERNEL);
 	if (appldata_os_data == NULL) {
 		P_ERROR("No memory for %s!\n", ops.name);
 		rc = -ENOMEM;
diff -urp -X other/Documentation/dontdiff truc/drivers/net/b44.c other/drivers/net/b44.c
--- truc/drivers/net/b44.c	2005-08-06 02:14:41.000000000 +0200
+++ other/drivers/net/b44.c	2005-08-06 09:40:10.000000000 +0200
@@ -632,7 +632,7 @@ static int b44_alloc_rx_skb(struct b44 *
 		/* Sigh... */
 		pci_unmap_single(bp->pdev, mapping, RX_PKT_BUF_SZ,PCI_DMA_FROMDEVICE);
 		dev_kfree_skb_any(skb);
-		skb = __dev_alloc_skb(RX_PKT_BUF_SZ,GFP_DMA);
+		skb = __dev_alloc_skb(RX_PKT_BUF_SZ,GFP_ATOMIC|GFP_DMA);
 		if (skb == NULL)
 			return -ENOMEM;
 		mapping = pci_map_single(bp->pdev, skb->data,
diff -urp -X other/Documentation/dontdiff truc/drivers/net/wireless/hostap/hostap_hw.c other/drivers/net/wireless/hostap/hostap_hw.c
--- truc/drivers/net/wireless/hostap/hostap_hw.c	2005-08-06 02:14:41.000000000 +0200
+++ other/drivers/net/wireless/hostap/hostap_hw.c	2005-08-06 09:58:22.000000000 +0200
@@ -3308,7 +3308,7 @@ prism2_init_local_data(struct prism2_hel
 
 #if defined(PRISM2_PCI) && defined(PRISM2_BUS_MASTER)
 	local->bus_m0_buf = (u8 *) kmalloc(sizeof(struct hfa384x_tx_frame) +
-					   PRISM2_DATA_MAXLEN, GFP_DMA);
+					   PRISM2_DATA_MAXLEN, GFP_ATOMIC|GFP_DMA);
 	if (local->bus_m0_buf == NULL)
 		goto fail;
 #endif /* PRISM2_PCI and PRISM2_BUS_MASTER */
diff -urp -X other/Documentation/dontdiff truc/drivers/s390/net/claw.c other/drivers/s390/net/claw.c
--- truc/drivers/s390/net/claw.c	2005-08-06 02:14:41.000000000 +0200
+++ other/drivers/s390/net/claw.c	2005-08-06 10:18:19.000000000 +0200
@@ -2198,7 +2198,7 @@ init_ccw_bk(struct net_device *dev)
         */
         if (privptr->p_buff_ccw==NULL) {
                 privptr->p_buff_ccw=
-			(void *)__get_free_pages(__GFP_DMA,
+			(void *)__get_free_pages(__GFP_DMA|GFP_KERNEL,
 		        (int)pages_to_order_of_mag(ccw_pages_required ));
                 if (privptr->p_buff_ccw==NULL) {
                         printk(KERN_INFO "%s: %s()  "
@@ -2354,7 +2354,7 @@ init_ccw_bk(struct net_device *dev)
         if (privptr->p_buff_write==NULL) {
             if (privptr->p_env->write_size < PAGE_SIZE) {
                 privptr->p_buff_write=
-			(void *)__get_free_pages(__GFP_DMA,
+			(void *)__get_free_pages(__GFP_DMA|GFP_KERNEL,
 			(int)pages_to_order_of_mag(claw_write_pages ));
                 if (privptr->p_buff_write==NULL) {
                         printk(KERN_INFO "%s: %s() __get_free_pages for write"
@@ -2413,7 +2413,7 @@ init_ccw_bk(struct net_device *dev)
            {
                privptr->p_write_free_chain=NULL;
                for (i = 0; i< privptr->p_env->write_buffers ; i++) {
-                   p_buff=(void *)__get_free_pages(__GFP_DMA,
+                   p_buff=(void *)__get_free_pages(__GFP_DMA|GFP_KERNEL,
 		        (int)pages_to_order_of_mag(
 			privptr->p_buff_pages_perwrite) );
 #ifdef IOTRACE
@@ -2489,7 +2489,7 @@ init_ccw_bk(struct net_device *dev)
         if (privptr->p_buff_read==NULL) {
             if (privptr->p_env->read_size < PAGE_SIZE)  {
                 privptr->p_buff_read=
-			(void *)__get_free_pages(__GFP_DMA,
+			(void *)__get_free_pages(__GFP_DMA|GFP_KERNEL,
 			(int)pages_to_order_of_mag(claw_read_pages) );
                 if (privptr->p_buff_read==NULL) {
                         printk(KERN_INFO "%s: %s() "
@@ -2603,7 +2603,7 @@ init_ccw_bk(struct net_device *dev)
 		dev->name,__FUNCTION__);
 #endif
                 for (i=0 ; i< privptr->p_env->read_buffers ; i++) {
-                        p_buff = (void *)__get_free_pages(__GFP_DMA,
+                        p_buff = (void *)__get_free_pages(__GFP_DMA|GFP_KERNEL,
 				(int)pages_to_order_of_mag(privptr->p_buff_pages_perread) );
                         if (p_buff==NULL) {
                                 printk(KERN_INFO "%s: %s() __get_free_pages for read "
diff -urp -X other/Documentation/dontdiff truc/drivers/scsi/pluto.c other/drivers/scsi/pluto.c
--- truc/drivers/scsi/pluto.c	2005-08-06 02:14:41.000000000 +0200
+++ other/drivers/scsi/pluto.c	2005-08-06 10:26:21.000000000 +0200
@@ -116,7 +116,7 @@ int __init pluto_detect(Scsi_Host_Templa
 #endif
 			return 0;
 	}
-	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) * fcscount, GFP_DMA);
+	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) * fcscount, GFP_DMA|GFP_KERNEL);
 	if (!fcs) {
 		printk ("PLUTO: Not enough memory to probe\n");
 		return 0;

