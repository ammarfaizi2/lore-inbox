Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUEFUng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUEFUng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUEFUng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:43:36 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:36246 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262045AbUEFUn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:43:28 -0400
Date: Thu, 6 May 2004 22:43:26 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [CFT] updated gcc-3.4.0 fixes patch for 2.4.27-pre1
In-Reply-To: <200405021153.i42Br4qt007808@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.55.0405051842110.17257@jurand.ds.pg.gda.pl>
References: <200405021153.i42Br4qt007808@harpo.it.uu.se>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004, Mikael Pettersson wrote:

> There is now an updated patch for compiling 2.4.27-pre1
> with gcc-3.4.0. It's 50KB+ so I'm not inlining it in
> this message; instead get it from:
> 
> http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v2-2.4.27-pre1
> 
> The changes since the first version are:
> - updates for the x86_64 and ppc kernels
> - more drivers corrected (parport_pc, fbcon, hid-core, ...)
> - corrected evaluation order in UP version of __IRQ_STAT

 I propose fixing problems that will appear with gcc 3.5, too.  The
"invalid lvalue in assignment" warning became an error in 3.5.  As the
constructs are dubious anyway and make code obscure, removing them may be
worth the trouble.  Here is a patch for the few places I got hit at.  A
few changes are straight backports from 2.6, others are original.  Most of
them are obvious.

 I've applied your patch to 2.4.26 (with two trivial adjustments due to
differences to 2.4.27-pre1) and together with my patch I built a working
kernel for the i386 with gcc 3.5.0 20040322.  I admit the changes below
weren't tested at the run time, though.

 Please consider.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.26-gcc35-0
diff -up --recursive --new-file linux-2.4.26.macro/drivers/atm/eni.c linux-2.4.26/drivers/atm/eni.c
--- linux-2.4.26.macro/drivers/atm/eni.c	2004-01-13 12:06:52.000000000 +0000
+++ linux-2.4.26/drivers/atm/eni.c	2004-05-04 16:00:09.000000000 +0000
@@ -1879,7 +1879,7 @@ static void eni_close(struct atm_vcc *vc
 	DPRINTK("eni_close: done waiting\n");
 	/* deallocate memory */
 	kfree(ENI_VCC(vcc));
-	ENI_VCC(vcc) = NULL;
+	vcc->dev_data = NULL;
 	clear_bit(ATM_VF_ADDR,&vcc->flags);
 	/*foo();*/
 }
@@ -1951,7 +1951,7 @@ static int eni_open(struct atm_vcc *vcc,
 
 	DPRINTK(">eni_open\n");
 	EVENT("eni_open\n",0,0);
-	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags)) ENI_VCC(vcc) = NULL;
+	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags)) vcc->dev_data = NULL;
 	eni_dev = ENI_DEV(vcc->dev);
 	error = get_ci(vcc,&vpi,&vci);
 	if (error) return error;
@@ -1966,7 +1966,7 @@ static int eni_open(struct atm_vcc *vcc,
 	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags)) {
 		eni_vcc = kmalloc(sizeof(struct eni_vcc),GFP_KERNEL);
 		if (!eni_vcc) return -ENOMEM;
-		ENI_VCC(vcc) = eni_vcc;
+		vcc->dev_data = eni_vcc;
 		eni_vcc->tx = NULL; /* for eni_close after open_rx */
 		if ((error = open_rx_first(vcc))) {
 			eni_close(vcc);
@@ -2302,7 +2302,7 @@ static int __devinit eni_init_one(struct
 	if (!dev) goto out2;
 	pci_set_drvdata(pci_dev, dev);
 	eni_dev->pci_dev = pci_dev;
-	ENI_DEV(dev) = eni_dev;
+	dev->dev_data = eni_dev;
 	eni_dev->asic = ent->driver_data;
 	error = eni_do_init(dev);
 	if (error) goto out3;
diff -up --recursive --new-file linux-2.4.26.macro/drivers/atm/suni.c linux-2.4.26/drivers/atm/suni.c
--- linux-2.4.26.macro/drivers/atm/suni.c	2003-06-28 23:02:21.000000000 +0000
+++ linux-2.4.26/drivers/atm/suni.c	2004-05-04 15:57:08.000000000 +0000
@@ -230,7 +230,7 @@ static int suni_start(struct atm_dev *de
 	unsigned long flags;
 	int first;
 
-	if (!(PRIV(dev) = kmalloc(sizeof(struct suni_priv),GFP_KERNEL)))
+	if (!(dev->phy_data = kmalloc(sizeof(struct suni_priv),GFP_KERNEL)))
 		return -ENOMEM;
 
 	PRIV(dev)->dev = dev;
diff -up --recursive --new-file linux-2.4.26.macro/drivers/isdn/divert/divert_procfs.c linux-2.4.26/drivers/isdn/divert/divert_procfs.c
--- linux-2.4.26.macro/drivers/isdn/divert/divert_procfs.c	2002-01-09 12:07:35.000000000 +0000
+++ linux-2.4.26/drivers/isdn/divert/divert_procfs.c	2004-05-04 16:06:01.000000000 +0000
@@ -91,7 +91,7 @@ isdn_divert_read(struct file *file, char
 		return (0);
 
 	inf->usage_cnt--;	/* new usage count */
-	(struct divert_info **) file->private_data = &inf->next;	/* next structure */
+	file->private_data = &inf->next;	/* next structure */
 	if ((len = strlen(inf->info_start)) <= count) {
 		if (copy_to_user(buf, inf->info_start, len))
 			return -EFAULT;
@@ -140,9 +140,9 @@ isdn_divert_open(struct inode *ino, stru
 	cli();
 	if_used++;
 	if (divert_info_head)
-		(struct divert_info **) filep->private_data = &(divert_info_tail->next);
+		filep->private_data = &(divert_info_tail->next);
 	else
-		(struct divert_info **) filep->private_data = &divert_info_head;
+		filep->private_data = &divert_info_head;
 	restore_flags(flags);
 	/*  start_divert(); */
 	unlock_kernel();
diff -up --recursive --new-file linux-2.4.26.macro/drivers/isdn/hisax/callc.c linux-2.4.26/drivers/isdn/hisax/callc.c
--- linux-2.4.26.macro/drivers/isdn/hisax/callc.c	2002-01-09 12:07:35.000000000 +0000
+++ linux-2.4.26/drivers/isdn/hisax/callc.c	2004-05-04 16:10:08.000000000 +0000
@@ -925,7 +925,7 @@ static void stat_redir_result(struct Isd
 	ic.driver = cs->myid;
 	ic.command = ISDN_STAT_REDIR;
 	ic.arg = chan; 
-	(ulong)(ic.parm.num[0]) = result;
+	ic.parm.num[0] = result;
 	cs->iif.statcallb(&ic);
 } /* stat_redir_result */
 
diff -up --recursive --new-file linux-2.4.26.macro/drivers/usb/storage/scsiglue.c linux-2.4.26/drivers/usb/storage/scsiglue.c
--- linux-2.4.26.macro/drivers/usb/storage/scsiglue.c	2004-05-04 15:00:35.000000000 +0000
+++ linux-2.4.26/drivers/usb/storage/scsiglue.c	2004-05-04 16:15:01.000000000 +0000
@@ -127,7 +127,7 @@ static int release(struct Scsi_Host *psh
 	wait_for_completion(&(us->notify));
 
 	/* remove the pointer to the data structure we were using */
-	(struct us_data*)psh->hostdata[0] = NULL;
+	psh->hostdata[0] = NULL;
 
 	/* we always have a successful release */
 	return 0;
diff -up --recursive --new-file linux-2.4.26.macro/drivers/usb/storage/usb.c linux-2.4.26/drivers/usb/storage/usb.c
--- linux-2.4.26.macro/drivers/usb/storage/usb.c	2004-02-24 06:42:25.000000000 +0000
+++ linux-2.4.26/drivers/usb/storage/usb.c	2004-05-04 16:25:54.000000000 +0000
@@ -999,7 +999,7 @@ static void * storage_probe(struct usb_d
 		 * the host controller thread in us_detect.  But how else are
 		 * we to do it?
 		 */
-		(struct us_data *)ss->htmplt.proc_dir = ss; 
+		ss->htmplt.proc_dir = (void *)ss; 
 
 		/* Just before we start our control thread, initialize
 		 * the device if it needs initialization */
diff -up --recursive --new-file linux-2.4.26.macro/fs/hfs/file_hdr.c linux-2.4.26/fs/hfs/file_hdr.c
--- linux-2.4.26.macro/fs/hfs/file_hdr.c	2001-08-20 13:52:02.000000000 +0000
+++ linux-2.4.26/fs/hfs/file_hdr.c	2004-05-04 17:09:29.000000000 +0000
@@ -241,7 +241,9 @@ static struct hfs_hdr_layout *dup_layout
 	if (HFS_NEW(new)) {
 		memcpy(new, old, sizeof(*new));
 		for (lcv = 0; lcv < new->entries; ++lcv) {
-			(char *)(new->order[lcv]) += (char *)new - (char *)old;
+			new->order[lcv] = (struct hfs_hdr_layout *)
+					  ((char *)(new->order[lcv]) +
+					   ((char *)new - (char *)old));
 		}
 	}
 	return new;
diff -up --recursive --new-file linux-2.4.26.macro/fs/ntfs/fs.c linux-2.4.26/fs/ntfs/fs.c
--- linux-2.4.26.macro/fs/ntfs/fs.c	2004-02-24 06:42:27.000000000 +0000
+++ linux-2.4.26/fs/ntfs/fs.c	2004-05-04 16:56:20.000000000 +0000
@@ -1045,7 +1045,7 @@ struct super_block *ntfs_read_super(stru
 	}
 	ntfs_debug(DEBUG_OTHER, "$Mft at cluster 0x%lx\n", vol->mft_lcn);
 	brelse(bh);
-	NTFS_SB(vol) = sb;
+	vol->sb = sb;
 	if (vol->cluster_size > PAGE_SIZE) {
 		ntfs_error("Partition cluster size is not supported yet (it "
 			   "is > max kernel blocksize).\n");
diff -up --recursive --new-file linux-2.4.26.macro/fs/ntfs/util.c linux-2.4.26/fs/ntfs/util.c
--- linux-2.4.26.macro/fs/ntfs/util.c	2001-08-20 13:52:02.000000000 +0000
+++ linux-2.4.26/fs/ntfs/util.c	2004-05-04 17:31:43.000000000 +0000
@@ -165,13 +165,13 @@ int ntfs_decodeuni(ntfs_volume *vol, cha
 void ntfs_put(ntfs_io *dest, void *src, ntfs_size_t n)
 {
 	ntfs_memcpy(dest->param, src, n);
-	((char*)dest->param) += n;
+	dest->param = (char*)dest->param + n;
 }
 
 void ntfs_get(void* dest, ntfs_io *src, ntfs_size_t n)
 {
 	ntfs_memcpy(dest, src->param, n);
-	((char*)src->param) += n;
+	src->param = (char*)src->param + n;
 }
 
 void *ntfs_calloc(int size)
diff -up --recursive --new-file linux-2.4.26.macro/net/ipx/af_ipx.c linux-2.4.26/net/ipx/af_ipx.c
--- linux-2.4.26.macro/net/ipx/af_ipx.c	2001-10-26 09:45:31.000000000 +0000
+++ linux-2.4.26/net/ipx/af_ipx.c	2004-05-04 18:27:03.000000000 +0000
@@ -1544,7 +1544,8 @@ static int ipxrtr_route_packet(struct so
 	ipx->ipx_pktsize = htons(len + sizeof(struct ipxhdr));
 	IPX_SKB_CB(skb)->ipx_tctrl = 0;
 	ipx->ipx_type 	 = usipx->sipx_type;
-	skb->h.raw 	 = (void *)skb->nh.ipxh = ipx;
+	skb->nh.ipxh	 = ipx;
+	skb->h.raw 	 = (void *)skb->nh.ipxh;
 
 	IPX_SKB_CB(skb)->last_hop.index = -1;
 #ifdef CONFIG_IPX_INTERN
