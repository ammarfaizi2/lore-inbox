Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUCWVCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbUCWVCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:02:09 -0500
Received: from mail0.lsil.com ([147.145.40.20]:47276 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262815AbUCWU7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 15:59:48 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57040DB6D7@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com
Subject: [PATCH 2.6 ] MPT Fusion driver 3.01.03 update
Date: Tue, 23 Mar 2004 15:59:40 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C41119.C2278140"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C41119.C2278140
Content-Type: text/plain;
	charset="iso-8859-1"

This is an update for the MPT Fusion drivers 2.6 kernel.

This is mpt version is 3.01.03.  The attached patch is made
against 2.6.5-rc2-bk3, which has the 3.01.01 driver with
a recent patch from Andi Kleen.  This driver will contain
the changes from mpt version 3.01.02 as well.

----------------------------------------------------------------

Changelog for mpt version 3.01.03:

(1)  Fix fifo memory allocation under 64bit systems
by merging 3 seperate memory allocations into one call.
Before this fix, it was possible that these seperate 
pci_alloc_consistent() calls were crossing the 4GB 
hardware boundary.
Delete the MPTBASE_MEM_ALLOC_FIFO_FIX logic.
Backout recent ak@muc.de workaround.

(2) Replace wrappers for CHIPREG_XXX with defines;
per request from Jeff Garzik [jgarzik@pobox.com]

(3) Remove support for FC909.

(4) Remove PortIo modules parameter.

(5) Move procmpt_destroy function before pci_unregister_driver,
as the memory allocated for the proc was not being deallocated.

(6) Remove mptscshi_reset_timeouts function. The timer was
already expired when mod_timer is called.

(7) Fix small bug in slave_destroy, which could prevent domain
validation on hidden drive in a RAID volume.

----------------------------------------------------------------------

Changelog for mpt version 3.01.02:

(1) Andi Kleen[ak@suse.de]
put warning "Device (0:0:0) reported QUEUE_FULL!" into debug messages

(2) Alexander Stohr[Alexander.Stohr@gmx.de]
fix warnings from mptscsih_setup when driver isn't compiled as module

(3) Randy.Dunlap[rddunlap@osdl.org]
Remove unnecessary min/max macros and change calls to 
use kernel.h macros instead.


You can download full source as well as the patches for this 
driver at:
ftp://ftp.lsil.com/HostAdapterDrivers/linux/FiberChannel/2.6-patches/3.01.03


Eric Moore
Staff Engineer
Standard Storage Products Division
LSI Logic Corporation
4420 Arrowswest Drive
Colorado Springs, CO 80907
Email: emoore@lsil.com
Web: http://www.lsilogic.com/




------_=_NextPart_000_01C41119.C2278140
Content-Type: application/octet-stream;
	name="mptlinux-3.01.03.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mptlinux-3.01.03.patch"

diff -uarN b/drivers/message/fusion/Makefile =
a/drivers/message/fusion/Makefile=0A=
--- b/drivers/message/fusion/Makefile	2004-03-23 08:47:47.000000000 =
-0700=0A=
+++ a/drivers/message/fusion/Makefile	2004-03-22 13:14:40.000000000 =
-0700=0A=
@@ -22,11 +22,6 @@=0A=
 #EXTRA_CFLAGS +=3D -DMPT_DEBUG_MSG_FRAME=0A=
 #EXTRA_CFLAGS +=3D -DMPT_DEBUG_SG=0A=
 =0A=
-# This is a temporary fix for the reply/request fifo=0A=
-# for some 64bit archs. Uncommenting this line=0A=
-# will place the fifo's in 32bit space=0A=
-#EXTRA_CFLAGS +=3D -DMPTBASE_MEM_ALLOC_FIFO_FIX=0A=
-=0A=
 #=0A=
 # driver/module specifics...=0A=
 #=0A=
diff -uarN b/drivers/message/fusion/mptbase.c =
a/drivers/message/fusion/mptbase.c=0A=
--- b/drivers/message/fusion/mptbase.c	2004-03-23 08:47:54.000000000 =
-0700=0A=
+++ a/drivers/message/fusion/mptbase.c	2004-03-23 11:46:26.735236928 =
-0700=0A=
@@ -123,12 +123,6 @@=0A=
 /*=0A=
  *  cmd line parameters=0A=
  */=0A=
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,59)=0A=
-MODULE_PARM(PortIo, "0-1i");=0A=
-MODULE_PARM_DESC(PortIo, "[0]=3DUse mmap, 1=3DUse port io");=0A=
-#endif=0A=
-static int PortIo =3D 0;=0A=
-=0A=
 #ifdef MFCNT=0A=
 static int mfcounter =3D 0;=0A=
 #define PRINT_MF_COUNT 20000=0A=
@@ -269,8 +263,6 @@=0A=
  */=0A=
 =0A=
 static struct pci_device_id mptbase_pci_table[] =3D {=0A=
-	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC909,=0A=
-		PCI_ANY_ID, PCI_ANY_ID },=0A=
 	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC929,=0A=
 		PCI_ANY_ID, PCI_ANY_ID },=0A=
 	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC919,=0A=
@@ -287,39 +279,10 @@=0A=
 };=0A=
 MODULE_DEVICE_TABLE(pci, mptbase_pci_table);=0A=
 =0A=
-=0A=
-/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
-/* 20000207 -sralston=0A=
- *  GRRRRR...  IOSpace (port i/o) register access (for the 909) is =
back!=0A=
- * 20000517 -sralston=0A=
- *  Let's trying going back to default mmap register access...=0A=
- */=0A=
-=0A=
-static inline u32 CHIPREG_READ32(volatile u32 *a)=0A=
-{=0A=
-	if (PortIo)=0A=
-		return inl((unsigned long)a);=0A=
-	else=0A=
-		return readl(a);=0A=
-}=0A=
-=0A=
-static inline void CHIPREG_WRITE32(volatile u32 *a, u32 v)=0A=
-{=0A=
-	if (PortIo)=0A=
-		outl(v, (unsigned long)a);=0A=
-	else=0A=
-		writel(v, a);=0A=
-}=0A=
-=0A=
-static inline void CHIPREG_PIO_WRITE32(volatile u32 *a, u32 v)=0A=
-{=0A=
-	outl(v, (unsigned long)a);=0A=
-}=0A=
-=0A=
-static inline u32 CHIPREG_PIO_READ32(volatile u32 *a)=0A=
-{=0A=
-	return inl((unsigned long)a);=0A=
-}=0A=
+#define CHIPREG_READ32(addr) 		readl(addr)=0A=
+#define CHIPREG_WRITE32(addr,val) 	writel(val, addr)=0A=
+#define CHIPREG_PIO_WRITE32(addr,val)	outl(val, (unsigned =
long)addr)=0A=
+#define CHIPREG_PIO_READ32(addr) 	inl((unsigned long)addr)=0A=
 =0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 /*=0A=
@@ -1280,17 +1243,12 @@=0A=
 		return r;=0A=
 	}=0A=
 =0A=
-#if 0=0A=
-	/* broken because some code assumes that multiple calls=0A=
-	   to pci_alloc_consistent return data in the same 4GB segment. =0A=
-	   This cannot work on machines with enough memory. */=0A=
 	if (!pci_set_consistent_dma_mask(pdev, mask))=0A=
 		dprintk((KERN_INFO MYNAM=0A=
 			": Using 64 bit consistent mask\n"));=0A=
 	else=0A=
 		dprintk((KERN_INFO MYNAM=0A=
 			": Not using 64 bit consistent mask\n"));=0A=
-#endif=0A=
 =0A=
 	ioc =3D kmalloc(sizeof(MPT_ADAPTER), GFP_ATOMIC);=0A=
 	if (ioc =3D=3D NULL) {=0A=
@@ -1304,23 +1262,6 @@=0A=
 =0A=
 	ioc->pcidev =3D pdev;=0A=
 =0A=
-#if defined(MPTBASE_MEM_ALLOC_FIFO_FIX)=0A=
-	memcpy(&ioc->pcidev32,ioc->pcidev,sizeof(struct pci_dev));=0A=
-	if (pci_set_dma_mask(&ioc->pcidev32, 0xFFFFFFFF)) {=0A=
-		dprintk((KERN_INFO MYNAM=0A=
-			": error setting 32bit mask\n"));=0A=
-		kfree(ioc);=0A=
-		return -ENODEV;=0A=
-	}=0A=
-=0A=
-	if (pci_set_consistent_dma_mask(&ioc->pcidev32, 0xFFFFFFFF)) {=0A=
-		dprintk((KERN_INFO MYNAM=0A=
-			": error setting 32bit mask\n"));=0A=
-		kfree(ioc);=0A=
-		return -ENODEV;=0A=
-	}=0A=
-#endif=0A=
-=0A=
 	ioc->diagPending =3D 0;=0A=
 	spin_lock_init(&ioc->diagLock);=0A=
 =0A=
@@ -1382,32 +1323,24 @@=0A=
 =0A=
 	dprintk((KERN_INFO MYNAM ": MPT adapter @ %lx, msize=3D%dd bytes\n", =
mem_phys, msize));=0A=
 	dprintk((KERN_INFO MYNAM ": (port i/o @ %lx, psize=3D%dd bytes)\n", =
port, psize));=0A=
-	dprintk((KERN_INFO MYNAM ": Using %s register access method\n", =
PortIo ? "PortIo" : "MemMap"));=0A=
 =0A=
 	mem =3D NULL;=0A=
-	if (! PortIo) {=0A=
-		/* Get logical ptr for PciMem0 space */=0A=
-		/*mem =3D ioremap(mem_phys, msize);*/=0A=
-		mem =3D ioremap(mem_phys, 0x100);=0A=
-		if (mem =3D=3D NULL) {=0A=
-			printk(KERN_ERR MYNAM ": ERROR - Unable to map adapter memory!\n");=0A=
-			kfree(ioc);=0A=
-			return -EINVAL;=0A=
-		}=0A=
-		ioc->memmap =3D mem;=0A=
+	/* Get logical ptr for PciMem0 space */=0A=
+	/*mem =3D ioremap(mem_phys, msize);*/=0A=
+	mem =3D ioremap(mem_phys, 0x100);=0A=
+	if (mem =3D=3D NULL) {=0A=
+		printk(KERN_ERR MYNAM ": ERROR - Unable to map adapter =
memory!\n");=0A=
+		kfree(ioc);=0A=
+		return -EINVAL;=0A=
 	}=0A=
+	ioc->memmap =3D mem;=0A=
 	dprintk((KERN_INFO MYNAM ": mem =3D %p, mem_phys =3D %lx\n", mem, =
mem_phys));=0A=
 =0A=
 	dprintk((KERN_INFO MYNAM ": facts @ %p, pfacts[0] @ %p\n",=0A=
 			&ioc->facts, &ioc->pfacts[0]));=0A=
-	if (PortIo) {=0A=
-		u8 *pmem =3D (u8*)port;=0A=
-		ioc->mem_phys =3D port;=0A=
-		ioc->chip =3D (SYSIF_REGS*)pmem;=0A=
-	} else {=0A=
-		ioc->mem_phys =3D mem_phys;=0A=
-		ioc->chip =3D (SYSIF_REGS*)mem;=0A=
-	}=0A=
+=0A=
+	ioc->mem_phys =3D mem_phys;=0A=
+	ioc->chip =3D (SYSIF_REGS*)mem;=0A=
 =0A=
 	/* Save Port IO values incase we need to do downloadboot */=0A=
 	{=0A=
@@ -1417,11 +1350,7 @@=0A=
 	}=0A=
 =0A=
 	ioc->chip_type =3D FCUNK;=0A=
-	if (pdev->device =3D=3D MPI_MANUFACTPAGE_DEVICEID_FC909) {=0A=
-		ioc->chip_type =3D FC909;=0A=
-		ioc->prod_name =3D "LSIFC909";=0A=
-	}=0A=
-	else if (pdev->device =3D=3D MPI_MANUFACTPAGE_DEVICEID_FC929) {=0A=
+	if (pdev->device =3D=3D MPI_MANUFACTPAGE_DEVICEID_FC929) {=0A=
 		ioc->chip_type =3D FC929;=0A=
 		ioc->prod_name =3D "LSIFC929";=0A=
 	}=0A=
@@ -2075,7 +2004,7 @@=0A=
 mpt_adapter_disable(MPT_ADAPTER *this, int freeup)=0A=
 {=0A=
 	if (this !=3D NULL) {=0A=
-		int sz;=0A=
+		int sz=3D0;=0A=
 		u32 state;=0A=
 		int ret;=0A=
 =0A=
@@ -2100,28 +2029,18 @@=0A=
 		/* Clear any lingering interrupt */=0A=
 		CHIPREG_WRITE32(&this->chip->IntStatus, 0);=0A=
 =0A=
-		if (freeup && this->reply_alloc !=3D NULL) {=0A=
-			sz =3D (this->reply_sz * this->reply_depth) + 128;=0A=
-			pci_free_consistent(this->pcidev, sz,=0A=
-					this->reply_alloc, this->reply_alloc_dma);=0A=
+		if (freeup && this->fifo_pool !=3D NULL) {=0A=
+			pci_free_consistent(this->pcidev,=0A=
+				this->fifo_pool_sz,=0A=
+				this->fifo_pool, this->fifo_pool_dma);=0A=
 			this->reply_frames =3D NULL;=0A=
 			this->reply_alloc =3D NULL;=0A=
-			this->alloc_total -=3D sz;=0A=
-		}=0A=
-=0A=
-		if (freeup && this->req_alloc !=3D NULL) {=0A=
-			sz =3D (this->req_sz * this->req_depth) + 128;=0A=
-			/*=0A=
-			 *  Rounding UP to nearest 4-kB boundary here...=0A=
-			 */=0A=
-			sz =3D ((sz + 0x1000UL - 1UL) / 0x1000) * 0x1000;=0A=
-			pci_free_consistent(this->pcidev, sz,=0A=
-					this->req_alloc, this->req_alloc_dma);=0A=
 			this->req_frames =3D NULL;=0A=
 			this->req_alloc =3D NULL;=0A=
-			this->alloc_total -=3D sz;=0A=
+			this->chain_alloc =3D NULL;=0A=
+			this->fifo_pool =3D NULL;=0A=
+			this->alloc_total -=3D this->fifo_pool_sz;=0A=
 		}=0A=
-=0A=
 		if (freeup && this->sense_buf_pool !=3D NULL) {=0A=
 			sz =3D (this->req_depth * MPT_SENSE_BUFFER_ALLOC);=0A=
 			pci_free_consistent(this->pcidev, sz,=0A=
@@ -2572,10 +2491,10 @@=0A=
 			 * Set values for this IOC's request & reply frame sizes,=0A=
 			 * and request & reply queue depths...=0A=
 			 */=0A=
-			ioc->req_sz =3D MIN(MPT_DEFAULT_FRAME_SIZE, facts->RequestFrameSize =
* 4);=0A=
-			ioc->req_depth =3D MIN(MPT_MAX_REQ_DEPTH, facts->GlobalCredits);=0A=
+			ioc->req_sz =3D min(MPT_DEFAULT_FRAME_SIZE, facts->RequestFrameSize =
* 4);=0A=
+			ioc->req_depth =3D min_t(int, MPT_MAX_REQ_DEPTH, =
facts->GlobalCredits);=0A=
 			ioc->reply_sz =3D MPT_REPLY_FRAME_SIZE;=0A=
-			ioc->reply_depth =3D MIN(MPT_DEFAULT_REPLY_DEPTH, =
facts->ReplyQueueDepth);=0A=
+			ioc->reply_depth =3D min_t(int, MPT_DEFAULT_REPLY_DEPTH, =
facts->ReplyQueueDepth);=0A=
 =0A=
 			dprintk((MYIOC_s_INFO_FMT "reply_sz=3D%3d, reply_depth=3D%4d\n",=0A=
 				ioc->name, ioc->reply_sz, ioc->reply_depth));=0A=
@@ -3799,105 +3718,126 @@=0A=
 	unsigned long b;=0A=
 	unsigned long flags;=0A=
 	dma_addr_t aligned_mem_dma;=0A=
-	u8 *mem, *aligned_mem;=0A=
+	u8 *aligned_mem;=0A=
 	int i, sz;=0A=
+	int chain_buffer_sz, reply_buffer_sz, request_buffer_sz;=0A=
+	int scale, num_sge, num_chain;=0A=
 =0A=
-	/*  Prime reply FIFO...  */=0A=
+	/* request buffer size,  rounding UP to nearest 4-kB boundary */=0A=
+	request_buffer_sz =3D (ioc->req_sz * ioc->req_depth) + 128;=0A=
+	request_buffer_sz =3D ((request_buffer_sz + 0x1000UL - 1UL) / 0x1000) =
* 0x1000;=0A=
 =0A=
-	if (ioc->reply_frames =3D=3D NULL) {=0A=
-		sz =3D (ioc->reply_sz * ioc->reply_depth) + 128;=0A=
-#if defined(MPTBASE_MEM_ALLOC_FIFO_FIX)=0A=
-		mem =3D pci_alloc_consistent(&ioc->pcidev32, sz, =
&ioc->reply_alloc_dma);=0A=
-#else		=0A=
-		mem =3D pci_alloc_consistent(ioc->pcidev, sz, =
&ioc->reply_alloc_dma);=0A=
-#endif		=0A=
-		if (mem =3D=3D NULL)=0A=
-			goto out_fail;=0A=
+	/* reply buffer size */=0A=
+	reply_buffer_sz =3D (ioc->reply_sz * ioc->reply_depth) + 128;=0A=
 =0A=
-		memset(mem, 0, sz);=0A=
-		ioc->alloc_total +=3D sz;=0A=
-		ioc->reply_alloc =3D mem;=0A=
-		dprintk((KERN_INFO MYNAM ": %s.reply_alloc  @ %p[%p], sz=3D%d =
bytes\n",=0A=
-			 	ioc->name, mem, (void *)(ulong)ioc->reply_alloc_dma, sz));=0A=
+	/* chain buffer size, copied from from mptscsih_initChainBuffers()=0A=
+	 *=0A=
+	 * Calculate the number of chain buffers needed(plus 1) per I/O=0A=
+	 * then multiply the the maximum number of simultaneous cmds=0A=
+	 *=0A=
+	 * num_sge =3D num sge in request frame + last chain buffer=0A=
+	 * scale =3D num sge per chain buffer if no chain element=0A=
+	 */=0A=
 =0A=
-		b =3D (unsigned long) mem;=0A=
-		b =3D (b + (0x80UL - 1UL)) & ~(0x80UL - 1UL); /* round up to =
128-byte boundary */=0A=
-		aligned_mem =3D (u8 *) b;=0A=
-		ioc->reply_frames =3D (MPT_FRAME_HDR *) aligned_mem;=0A=
-		ioc->reply_frames_dma =3D=0A=
-			(ioc->reply_alloc_dma + (aligned_mem - mem));=0A=
+	scale =3D ioc->req_sz/(sizeof(dma_addr_t) + sizeof(u32));=0A=
+	if (sizeof(dma_addr_t) =3D=3D sizeof(u64))=0A=
+		num_sge =3D  scale + (ioc->req_sz - 60) / (sizeof(dma_addr_t) + =
sizeof(u32));=0A=
+	else=0A=
+		num_sge =3D  1 + scale + (ioc->req_sz - 64) / (sizeof(dma_addr_t) + =
sizeof(u32));=0A=
 =0A=
-		ioc->reply_frames_low_dma =3D (u32) (ioc->reply_frames_dma & =
0xFFFFFFFF);=0A=
+	num_chain =3D 1;=0A=
+	while (MPT_SCSI_SG_DEPTH - num_sge > 0) {=0A=
+		num_chain++;=0A=
+		num_sge +=3D (scale - 1);=0A=
 	}=0A=
+	num_chain++;=0A=
 =0A=
-	/* Post Reply frames to FIFO=0A=
-	 */=0A=
-	aligned_mem_dma =3D ioc->reply_frames_dma;=0A=
-	dprintk((KERN_INFO MYNAM ": %s.reply_frames @ %p[%p]\n",=0A=
-		 	ioc->name, ioc->reply_frames, (void *)(ulong)aligned_mem_dma));=0A=
+	if ((int)ioc->chip_type > (int) FC929)=0A=
+		num_chain *=3D MPT_SCSI_CAN_QUEUE;=0A=
+	else=0A=
+		num_chain *=3D MPT_FC_CAN_QUEUE;=0A=
 =0A=
-	for (i =3D 0; i < ioc->reply_depth; i++) {=0A=
-		/*  Write each address to the IOC!  */=0A=
-		CHIPREG_WRITE32(&ioc->chip->ReplyFifo, aligned_mem_dma);=0A=
-		aligned_mem_dma +=3D ioc->reply_sz;=0A=
-	}=0A=
+	chain_buffer_sz =3D num_chain * ioc->req_sz;=0A=
 =0A=
+	if(ioc->fifo_pool =3D=3D NULL) {=0A=
 =0A=
-	/*  Request FIFO - WE manage this!  */=0A=
+		ioc->fifo_pool_sz =3D request_buffer_sz +=0A=
+			reply_buffer_sz + chain_buffer_sz;=0A=
 =0A=
-	if (ioc->req_frames =3D=3D NULL) {=0A=
-		sz =3D (ioc->req_sz * ioc->req_depth) + 128;=0A=
-		/*=0A=
-		 *  Rounding UP to nearest 4-kB boundary here...=0A=
-		 */=0A=
-		sz =3D ((sz + 0x1000UL - 1UL) / 0x1000) * 0x1000;=0A=
+		ioc->fifo_pool =3D pci_alloc_consistent(ioc->pcidev,=0A=
+		ioc->fifo_pool_sz, &ioc->fifo_pool_dma);=0A=
 =0A=
-#if defined(MPTBASE_MEM_ALLOC_FIFO_FIX)=0A=
-		mem =3D pci_alloc_consistent(&ioc->pcidev32, sz, =
&ioc->req_alloc_dma);=0A=
-#else=0A=
-		mem =3D pci_alloc_consistent(ioc->pcidev, sz, =
&ioc->req_alloc_dma);=0A=
-#endif		=0A=
-		if (mem =3D=3D NULL)=0A=
+		if( ioc->fifo_pool =3D=3D NULL)=0A=
 			goto out_fail;=0A=
 =0A=
-		memset(mem, 0, sz);=0A=
-		ioc->alloc_total +=3D sz;=0A=
-		ioc->req_alloc =3D mem;=0A=
+		ioc->alloc_total +=3D ioc->fifo_pool_sz;=0A=
+		memset(ioc->fifo_pool, 0, ioc->fifo_pool_sz);=0A=
+=0A=
+		/* reply fifo pointers */=0A=
+		ioc->reply_alloc =3D ioc->fifo_pool;=0A=
+		ioc->reply_alloc_dma =3D ioc->fifo_pool_dma;=0A=
+		/* request fifo pointers */=0A=
+		ioc->req_alloc =3D ioc->reply_alloc+reply_buffer_sz;=0A=
+		ioc->req_alloc_dma =3D ioc->reply_alloc_dma+reply_buffer_sz;=0A=
+		/* chain buffer pointers */=0A=
+		ioc->chain_alloc =3D ioc->req_alloc+request_buffer_sz;=0A=
+		ioc->chain_alloc_dma =3D ioc->req_alloc_dma+request_buffer_sz;=0A=
+		ioc->chain_alloc_sz =3D chain_buffer_sz;=0A=
+=0A=
+		/*  Prime reply FIFO...  */=0A=
+		dprintk((KERN_INFO MYNAM ": %s.reply_alloc  @ %p[%p], sz=3D%d =
bytes\n",=0A=
+			 	ioc->name, mem, (void *)(ulong)ioc->reply_alloc_dma, =
reply_buffer_sz));=0A=
+=0A=
+		b =3D (unsigned long) ioc->reply_alloc;=0A=
+		b =3D (b + (0x80UL - 1UL)) & ~(0x80UL - 1UL); /* round up to =
128-byte boundary */=0A=
+		aligned_mem =3D (u8 *) b;=0A=
+		ioc->reply_frames =3D (MPT_FRAME_HDR *) aligned_mem;=0A=
+		ioc->reply_frames_dma =3D=0A=
+			(ioc->reply_alloc_dma + (aligned_mem - ioc->reply_alloc));=0A=
+=0A=
+		ioc->reply_frames_low_dma =3D (u32) (ioc->reply_frames_dma & =
0xFFFFFFFF);=0A=
+	=0A=
+		/*  Request FIFO - WE manage this!  */=0A=
 		dprintk((KERN_INFO MYNAM ": %s.req_alloc    @ %p[%p], sz=3D%d =
bytes\n",=0A=
-			 	ioc->name, mem, (void *)(ulong)ioc->req_alloc_dma, sz));=0A=
+			 	ioc->name, mem, (void *)(ulong)ioc->req_alloc_dma, =
request_buffer_sz));=0A=
 =0A=
-		b =3D (unsigned long) mem;=0A=
+		b =3D (unsigned long) ioc->req_alloc;=0A=
 		b =3D (b + (0x80UL - 1UL)) & ~(0x80UL - 1UL); /* round up to =
128-byte boundary */=0A=
 		aligned_mem =3D (u8 *) b;=0A=
 		ioc->req_frames =3D (MPT_FRAME_HDR *) aligned_mem;=0A=
 		ioc->req_frames_dma =3D=0A=
-			(ioc->req_alloc_dma + (aligned_mem - mem));=0A=
+			(ioc->req_alloc_dma + (aligned_mem - ioc->req_alloc));=0A=
 =0A=
 		ioc->req_frames_low_dma =3D (u32) (ioc->req_frames_dma & =
0xFFFFFFFF);=0A=
 =0A=
-		if (sizeof(dma_addr_t) =3D=3D sizeof(u64)) {=0A=
-			/* Check: upper 32-bits of the request and reply frame=0A=
-			 * physical addresses must be the same.=0A=
-			 */=0A=
-			if (((u64)ioc->req_frames_dma >> 32) !=3D =
((u64)ioc->reply_frames_dma >> 32)){=0A=
-				goto out_fail;=0A=
-			}=0A=
-		}=0A=
-=0A=
 #if defined(CONFIG_MTRR) && 0=0A=
 		/*=0A=
 		 *  Enable Write Combining MTRR for IOC's memory region.=0A=
 		 *  (at least as much as we can; "size and base must be=0A=
 		 *  multiples of 4 kiB"=0A=
 		 */=0A=
-		ioc->mtrr_reg =3D mtrr_add(ioc->req_alloc_dma,=0A=
-					 sz,=0A=
+		ioc->mtrr_reg =3D mtrr_add(ioc->fifo_pool,=0A=
+					 ioc->fifo_pool_sz,=0A=
 					 MTRR_TYPE_WRCOMB, 1);=0A=
 		dprintk((MYIOC_s_INFO_FMT "MTRR region registered =
(base:size=3D%08x:%x)\n",=0A=
-				ioc->name, ioc->req_alloc_dma, sz));=0A=
+				ioc->name, ioc->fifo_pool, ioc->fifo_pool_sz));=0A=
 #endif=0A=
+=0A=
+	} /* ioc->fifo_pool =3D=3D NULL */=0A=
+	=0A=
+	/* Post Reply frames to FIFO=0A=
+	 */=0A=
+	aligned_mem_dma =3D ioc->reply_frames_dma;=0A=
+	dprintk((KERN_INFO MYNAM ": %s.reply_frames @ %p[%p]\n",=0A=
+		 	ioc->name, ioc->reply_frames, (void *)(ulong)aligned_mem_dma));=0A=
+=0A=
+	for (i =3D 0; i < ioc->reply_depth; i++) {=0A=
+		/*  Write each address to the IOC!  */=0A=
+		CHIPREG_WRITE32(&ioc->chip->ReplyFifo, aligned_mem_dma);=0A=
+		aligned_mem_dma +=3D ioc->reply_sz;=0A=
 	}=0A=
 =0A=
+=0A=
 	/* Initialize Request frames linked list=0A=
 	 */=0A=
 	aligned_mem_dma =3D ioc->req_frames_dma;=0A=
@@ -3931,24 +3871,17 @@=0A=
 	return 0;=0A=
 =0A=
 out_fail:=0A=
-	if (ioc->reply_alloc !=3D NULL) {=0A=
-		sz =3D (ioc->reply_sz * ioc->reply_depth) + 128;=0A=
+	if (ioc->fifo_pool !=3D NULL) {=0A=
 		pci_free_consistent(ioc->pcidev,=0A=
-				sz,=0A=
-				ioc->reply_alloc, ioc->reply_alloc_dma);=0A=
+				ioc->fifo_pool_sz,=0A=
+				ioc->fifo_pool, ioc->fifo_pool_dma);=0A=
 		ioc->reply_frames =3D NULL;=0A=
 		ioc->reply_alloc =3D NULL;=0A=
-		ioc->alloc_total -=3D sz;=0A=
-	}=0A=
-	if (ioc->req_alloc !=3D NULL) {=0A=
-		sz =3D (ioc->req_sz * ioc->req_depth) + 128;=0A=
-		/*=0A=
-		 *  Rounding UP to nearest 4-kB boundary here...=0A=
-		 */=0A=
-		sz =3D ((sz + 0x1000UL - 1UL) / 0x1000) * 0x1000;=0A=
-		pci_free_consistent(ioc->pcidev,=0A=
-				sz,=0A=
-				ioc->req_alloc, ioc->req_alloc_dma);=0A=
+		ioc->req_frames =3D NULL;=0A=
+		ioc->req_alloc =3D NULL;=0A=
+		ioc->chain_alloc =3D NULL;=0A=
+		ioc->fifo_pool =3D NULL;=0A=
+		ioc->alloc_total -=3D ioc->fifo_pool_sz;=0A=
 #if defined(CONFIG_MTRR) && 0=0A=
 		if (ioc->mtrr_reg > 0) {=0A=
 			mtrr_del(ioc->mtrr_reg, 0, 0);=0A=
@@ -3956,9 +3889,6 @@=0A=
 					ioc->name));=0A=
 		}=0A=
 #endif=0A=
-		ioc->req_frames =3D NULL;=0A=
-		ioc->req_alloc =3D NULL;=0A=
-		ioc->alloc_total -=3D sz;=0A=
 	}=0A=
 	if (ioc->sense_buf_pool !=3D NULL) {=0A=
 		sz =3D (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);=0A=
@@ -4070,7 +4000,7 @@=0A=
 		/*=0A=
 		 * Copy out the cached reply...=0A=
 		 */=0A=
-		for (ii=3D0; ii < MIN(replyBytes/2,mptReply->MsgLength*2); ii++)=0A=
+		for (ii=3D0; ii < min(replyBytes/2,mptReply->MsgLength*2); ii++)=0A=
 			u16reply[ii] =3D ioc->hs_reply[ii];=0A=
 	} else {=0A=
 		return -99;=0A=
@@ -4317,7 +4247,7 @@=0A=
 =0A=
 			if ((rc =3D mpt_config(ioc, &cfg)) =3D=3D 0) {=0A=
 				/* save the data */=0A=
-				copy_sz =3D MIN(sizeof(LANPage0_t), data_sz);=0A=
+				copy_sz =3D min_t(int, sizeof(LANPage0_t), data_sz);=0A=
 				memcpy(&ioc->lan_cnfg_page0, ppage0_alloc, copy_sz);=0A=
 =0A=
 			}=0A=
@@ -4362,7 +4292,7 @@=0A=
 =0A=
 		if ((rc =3D mpt_config(ioc, &cfg)) =3D=3D 0) {=0A=
 			/* save the data */=0A=
-			copy_sz =3D MIN(sizeof(LANPage1_t), data_sz);=0A=
+			copy_sz =3D min_t(int, sizeof(LANPage1_t), data_sz);=0A=
 			memcpy(&ioc->lan_cnfg_page1, ppage1_alloc, copy_sz);=0A=
 		}=0A=
 =0A=
@@ -4431,7 +4361,7 @@=0A=
 		if ((rc =3D mpt_config(ioc, &cfg)) =3D=3D 0) {=0A=
 			/* save the data */=0A=
 			pp0dest =3D &ioc->fc_port_page0[portnum];=0A=
-			copy_sz =3D MIN(sizeof(FCPortPage0_t), data_sz);=0A=
+			copy_sz =3D min_t(int, sizeof(FCPortPage0_t), data_sz);=0A=
 			memcpy(pp0dest, ppage0_alloc, copy_sz);=0A=
 =0A=
 			/*=0A=
@@ -5517,9 +5447,7 @@=0A=
 			(void) sprintf(pname+namelen, "/%s", =
mpt_ioc_proc_list[ii].name);=0A=
 			remove_proc_entry(pname, NULL);=0A=
 		}=0A=
-=0A=
 		remove_proc_entry(ioc->name, mpt_proc_root_dir);=0A=
-=0A=
 		ioc =3D mpt_adapter_find_next(ioc);=0A=
 	}=0A=
 =0A=
@@ -6329,7 +6257,6 @@=0A=
 {=0A=
 =0A=
 	dprintk((KERN_INFO MYNAM ": fusion_exit() called!\n"));=0A=
-	pci_unregister_driver(&mptbase_driver);=0A=
 =0A=
 	/* Whups?  20010120 -sralston=0A=
 	 *  Moved this *above* removal of all MptAdapters!=0A=
@@ -6337,7 +6264,7 @@=0A=
 #ifdef CONFIG_PROC_FS=0A=
 	(void) procmpt_destroy();=0A=
 #endif=0A=
-=0A=
+	pci_unregister_driver(&mptbase_driver);=0A=
 	mpt_reset_deregister(mpt_base_index);=0A=
 }=0A=
 =0A=
diff -uarN b/drivers/message/fusion/mptbase.h =
a/drivers/message/fusion/mptbase.h=0A=
--- b/drivers/message/fusion/mptbase.h	2004-03-23 08:47:47.000000000 =
-0700=0A=
+++ a/drivers/message/fusion/mptbase.h	2004-03-23 10:12:40.000000000 =
-0700=0A=
@@ -81,8 +81,8 @@=0A=
 #define COPYRIGHT	"Copyright (c) 1999-2004 " MODULEAUTHOR=0A=
 #endif=0A=
 =0A=
-#define MPT_LINUX_VERSION_COMMON	"3.01.01"=0A=
-#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-3.01.01"=0A=
+#define MPT_LINUX_VERSION_COMMON	"3.01.03"=0A=
+#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-3.01.03"=0A=
 #define WHAT_MAGIC_STRING		"@" "(" "#" ")"=0A=
 =0A=
 #define show_mptmod_ver(s,ver)  \=0A=
@@ -156,6 +156,28 @@=0A=
 #define C0_1030				0x08=0A=
 #define XL_929				0x01=0A=
 =0A=
+=0A=
+/*=0A=
+ *	Try to keep these at 2^N-1=0A=
+ */=0A=
+#define MPT_FC_CAN_QUEUE	127=0A=
+#define MPT_SCSI_CAN_QUEUE	127=0A=
+=0A=
+/*=0A=
+ * Set the MAX_SGE value based on user input.=0A=
+ */=0A=
+#ifdef  CONFIG_FUSION_MAX_SGE=0A=
+#if     CONFIG_FUSION_MAX_SGE  < 16=0A=
+#define MPT_SCSI_SG_DEPTH	16=0A=
+#elif   CONFIG_FUSION_MAX_SGE  > 128=0A=
+#define MPT_SCSI_SG_DEPTH	128=0A=
+#else=0A=
+#define MPT_SCSI_SG_DEPTH	CONFIG_FUSION_MAX_SGE=0A=
+#endif=0A=
+#else=0A=
+#define MPT_SCSI_SG_DEPTH	40=0A=
+#endif=0A=
+=0A=
 #ifdef __KERNEL__	/* { */=0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 =0A=
@@ -581,6 +603,12 @@=0A=
 	int			 alloc_total;=0A=
 	u32			 last_state;=0A=
 	int			 active;=0A=
+	u8			*fifo_pool;	/* dma pool for fifo's */=0A=
+	dma_addr_t		 fifo_pool_dma;=0A=
+	int			 fifo_pool_sz;	/* allocated size */=0A=
+	u8			*chain_alloc;	/* chain buffer alloc ptr */=0A=
+	dma_addr_t		chain_alloc_dma;=0A=
+	int			chain_alloc_sz;=0A=
 	u8			*reply_alloc;	/* Reply frames alloc ptr */=0A=
 	dma_addr_t		 reply_alloc_dma;=0A=
 	MPT_FRAME_HDR		*reply_frames;	/* Reply msg frames - rounded up! */=0A=
@@ -608,9 +636,6 @@=0A=
 	u32			 sense_buf_low_dma;=0A=
 	int			 mtrr_reg;=0A=
 	struct pci_dev		*pcidev;	/* struct pci_dev pointer */=0A=
-#if defined(MPTBASE_MEM_ALLOC_FIFO_FIX)=0A=
-	struct pci_dev		pcidev32;	/* struct pci_dev pointer */=0A=
-#endif	=0A=
 	u8			*memmap;	/* mmap address */=0A=
 	struct Scsi_Host	*sh;		/* Scsi Host pointer */=0A=
 	ScsiCfgData		spi_data;	/* Scsi config. data */=0A=
@@ -1061,13 +1086,6 @@=0A=
 /*=0A=
  *  More (public) macros...=0A=
  */=0A=
-#ifndef MIN=0A=
-#define MIN(a, b)   (((a) < (b)) ? (a) : (b))=0A=
-#endif=0A=
-#ifndef MAX=0A=
-#define MAX(a, b)   (((a) > (b)) ? (a) : (b))=0A=
-#endif=0A=
-=0A=
 #ifndef offsetof=0A=
 #define offsetof(t, m)	((size_t) (&((t *)0)->m))=0A=
 #endif=0A=
diff -uarN b/drivers/message/fusion/mptctl.c =
a/drivers/message/fusion/mptctl.c=0A=
--- b/drivers/message/fusion/mptctl.c	2004-03-23 08:47:47.000000000 =
-0700=0A=
+++ a/drivers/message/fusion/mptctl.c	2004-03-19 15:25:14.000000000 =
-0700=0A=
@@ -285,7 +285,7 @@=0A=
 				dctlprintk((MYIOC_s_INFO_FMT ": Copying Reply Frame @%p to =
IOC!\n",=0A=
 						ioc->name, reply));=0A=
 				memcpy(ioc->ioctl->ReplyFrame, reply,=0A=
-					MIN(ioc->reply_sz, 4*reply->u.reply.MsgLength));=0A=
+					min(ioc->reply_sz, 4*reply->u.reply.MsgLength));=0A=
 				ioc->ioctl->status |=3D MPT_IOCTL_STATUS_RF_VALID;=0A=
 =0A=
 				/* Set the command status to GOOD if IOC Status is GOOD=0A=
@@ -336,7 +336,7 @@=0A=
 			// NOTE: Expects/requires non-Turbo reply!=0A=
 			dctlprintk((MYIOC_s_INFO_FMT ":Caching MPI_FUNCTION_FW_DOWNLOAD =
reply!\n",=0A=
 				ioc->name));=0A=
-			memcpy(fwReplyBuffer, reply, MIN(sizeof(fwReplyBuffer), =
4*reply->u.reply.MsgLength));=0A=
+			memcpy(fwReplyBuffer, reply, min_t(int, sizeof(fwReplyBuffer), =
4*reply->u.reply.MsgLength));=0A=
 			ReplyMsg =3D (pMPIDefaultReply_t) fwReplyBuffer;=0A=
 		}=0A=
 	}=0A=
@@ -991,7 +991,7 @@=0A=
 	MptSge_t	*sgl;=0A=
 	int		 numfrags =3D 0;=0A=
 	int		 fragcnt =3D 0;=0A=
-	int		 alloc_sz =3D MIN(bytes,MAX_KMALLOC_SZ);	// avoid kernel warning =
msg!=0A=
+	int		 alloc_sz =3D min(bytes,MAX_KMALLOC_SZ);	// avoid kernel warning =
msg!=0A=
 	int		 bytes_allocd =3D 0;=0A=
 	int		 this_alloc;=0A=
 	dma_addr_t	 pa;					// phys addr=0A=
@@ -1036,7 +1036,7 @@=0A=
 	sgl =3D sglbuf;=0A=
 	sg_spill =3D ((ioc->req_sz - sge_offset)/(sizeof(dma_addr_t) + =
sizeof(u32))) - 1;=0A=
 	while (bytes_allocd < bytes) {=0A=
-		this_alloc =3D MIN(alloc_sz, bytes-bytes_allocd);=0A=
+		this_alloc =3D min(alloc_sz, bytes-bytes_allocd);=0A=
 		buflist[buflist_ent].len =3D this_alloc;=0A=
 		buflist[buflist_ent].kptr =3D pci_alloc_consistent(ioc->pcidev,=0A=
 								 this_alloc,=0A=
@@ -2293,9 +2293,9 @@=0A=
 		 */=0A=
 		if (ioc->ioctl->status & MPT_IOCTL_STATUS_RF_VALID) {=0A=
 			if (karg.maxReplyBytes < ioc->reply_sz) {=0A=
-				 sz =3D MIN(karg.maxReplyBytes, 4*ioc->ioctl->ReplyFrame[2]);=0A=
+				 sz =3D min(karg.maxReplyBytes, 4*ioc->ioctl->ReplyFrame[2]);=0A=
 			} else {=0A=
-				 sz =3D MIN(ioc->reply_sz, 4*ioc->ioctl->ReplyFrame[2]);=0A=
+				 sz =3D min(ioc->reply_sz, 4*ioc->ioctl->ReplyFrame[2]);=0A=
 			}=0A=
 =0A=
 			if (sz > 0) {=0A=
@@ -2314,7 +2314,7 @@=0A=
 		/* If valid sense data, copy to user.=0A=
 		 */=0A=
 		if (ioc->ioctl->status & MPT_IOCTL_STATUS_SENSE_VALID) {=0A=
-			sz =3D MIN(karg.maxSenseBytes, MPT_SENSE_BUFFER_SIZE);=0A=
+			sz =3D min(karg.maxSenseBytes, MPT_SENSE_BUFFER_SIZE);=0A=
 			if (sz > 0) {=0A=
 				if (copy_to_user((char *)karg.senseDataPtr, ioc->ioctl->sense, =
sz)) {=0A=
 					printk(KERN_ERR "%s@%d::mptctl_do_mpt_command - "=0A=
diff -uarN b/drivers/message/fusion/mptscsih.c =
a/drivers/message/fusion/mptscsih.c=0A=
--- b/drivers/message/fusion/mptscsih.c	2004-03-23 08:47:47.000000000 =
-0700=0A=
+++ a/drivers/message/fusion/mptscsih.c	2004-03-22 12:51:32.000000000 =
-0700=0A=
@@ -196,8 +196,9 @@=0A=
 static void	mptscsih_dv_parms(MPT_SCSI_HOST *hd, DVPARAMETERS *dv,void =
*pPage);=0A=
 static void	mptscsih_fillbuf(char *buffer, int size, int index, int =
width);=0A=
 #endif=0A=
+#ifdef MODULE=0A=
 static int	mptscsih_setup(char *str);=0A=
-=0A=
+#endif=0A=
 /* module entry point */=0A=
 static int  __init   mptscsih_init  (void);=0A=
 static void __exit   mptscsih_exit  (void);=0A=
@@ -1061,26 +1062,6 @@=0A=
 	return;=0A=
 }=0A=
 =0A=
-static void=0A=
-mptscsih_reset_timeouts (MPT_SCSI_HOST *hd)=0A=
-{=0A=
-	Scsi_Cmnd	*SCpnt;=0A=
-	int		 ii;=0A=
-	int		 max =3D hd->ioc->req_depth;=0A=
-		=0A=
-=0A=
-	for (ii=3D 0; ii < max; ii++) {=0A=
-		if ((SCpnt =3D hd->ScsiLookup[ii]) !=3D NULL) {=0A=
-	/* calling mod_timer() panics in 2.6 kernel...=0A=
-	 * need to investigate=0A=
-	 */=0A=
-//			mod_timer(&SCpnt->eh_timeout, jiffies + (HZ * 60));=0A=
-			dtmprintk((MYIOC_s_WARN_FMT "resetting SCpnt=3D%p timeout + =
60HZ",=0A=
-				(hd && hd->ioc) ? hd->ioc->name : "ioc?", SCpnt));=0A=
-		}=0A=
-	}=0A=
-}=0A=
-=0A=
 /*=0A=
  *	mptscsih_flush_running_cmds - For each command found, search=0A=
  *		Scsi_Host instance taskQ and reply to OS.=0A=
@@ -1239,6 +1220,16 @@=0A=
 	int		sz, ii, num_chain;=0A=
 	int 		scale, num_sge;=0A=
 =0A=
+	/* chain buffer allocation done from PrimeIocFifos */	=0A=
+	if (hd->ioc->fifo_pool =3D=3D NULL) =0A=
+		return -1;=0A=
+	=0A=
+	hd->ChainBuffer =3D hd->ioc->chain_alloc;=0A=
+	hd->ChainBufferDMA =3D hd->ioc->chain_alloc_dma;=0A=
+	=0A=
+	dprintk((KERN_INFO "  ChainBuffer    @ %p(%p), sz=3D%d\n",=0A=
+		 hd->ChainBuffer, (void *)(ulong)hd->ChainBufferDMA, =
hd->ioc->chain_alloc_sz));=0A=
+		=0A=
 	/* ReqToChain size must equal the req_depth=0A=
 	 * index =3D req_idx=0A=
 	 */=0A=
@@ -1294,26 +1285,7 @@=0A=
 		mem =3D (u8 *) hd->ChainToChain;=0A=
 	}=0A=
 	memset(mem, 0xFF, sz);=0A=
-	sz =3D num_chain * hd->ioc->req_sz;=0A=
-	if (hd->ChainBuffer =3D=3D NULL) {=0A=
-		/* Allocate free chain buffer pool=0A=
-		 */=0A=
-#if defined(MPTBASE_MEM_ALLOC_FIFO_FIX)=0A=
-		mem =3D pci_alloc_consistent(&hd->ioc->pcidev32, sz, =
&hd->ChainBufferDMA);=0A=
-#else		=0A=
-		mem =3D pci_alloc_consistent(hd->ioc->pcidev, sz, =
&hd->ChainBufferDMA);=0A=
-#endif		=0A=
-		if (mem =3D=3D NULL)=0A=
-			return -1;=0A=
 =0A=
-		hd->ChainBuffer =3D (u8*)mem;=0A=
-	} else {=0A=
-		mem =3D (u8 *) hd->ChainBuffer;=0A=
-	}=0A=
-	memset(mem, 0, sz);=0A=
-=0A=
-	dprintk((KERN_INFO "  ChainBuffer    @ %p(%p), sz=3D%d\n",=0A=
-		 hd->ChainBuffer, (void *)(ulong)hd->ChainBufferDMA, sz));=0A=
 =0A=
 	/* Initialize the free chain Q.=0A=
 	 */=0A=
@@ -1366,8 +1338,8 @@=0A=
 =0A=
 		if (sc->device && sc->device->host !=3D NULL && =
sc->device->host->hostdata !=3D NULL)=0A=
 			ioc_str =3D ((MPT_SCSI_HOST =
*)sc->device->host->hostdata)->ioc->name;=0A=
-		printk(MYIOC_s_WARN_FMT "Device (%d:%d:%d) reported =
QUEUE_FULL!\n",=0A=
-				ioc_str, 0, sc->device->id, sc->device->lun);=0A=
+		dprintk((MYIOC_s_WARN_FMT "Device (%d:%d:%d) reported =
QUEUE_FULL!\n",=0A=
+				ioc_str, 0, sc->device->id, sc->device->lun));=0A=
 		last_queue_full =3D time;=0A=
 	}=0A=
 }=0A=
@@ -1761,7 +1733,6 @@=0A=
 		int sz1, sz2, sz3, sztarget=3D0;=0A=
 		int szr2chain =3D 0;=0A=
 		int szc2chain =3D 0;=0A=
-		int szchain =3D 0;=0A=
 		int szQ =3D 0;=0A=
 =0A=
 		mptscsih_shutdown(&pdev->dev);=0A=
@@ -1786,15 +1757,6 @@=0A=
 			hd->ChainToChain =3D NULL;=0A=
 		}=0A=
 =0A=
-		if (hd->ChainBuffer !=3D NULL) {=0A=
-			sz2 =3D hd->num_chain * hd->ioc->req_sz;=0A=
-			szchain =3D szr2chain + szc2chain + sz2;=0A=
-=0A=
-			pci_free_consistent(hd->ioc->pcidev, sz2,=0A=
-				    hd->ChainBuffer, hd->ChainBufferDMA);=0A=
-			hd->ChainBuffer =3D NULL;=0A=
-		}=0A=
-=0A=
 		if (hd->memQ !=3D NULL) {=0A=
 			szQ =3D host->can_queue * sizeof(MPT_DONE_Q);=0A=
 			kfree(hd->memQ);=0A=
@@ -3375,7 +3337,7 @@=0A=
 					raid_volume=3D=3D0;i++)=0A=
 						=0A=
 					if(device->id =3D=3D =0A=
-					  hd->ioc->spi_data.pIocPg3->PhysDisk[i].PhysDiskNum) {=0A=
+					  hd->ioc->spi_data.pIocPg3->PhysDisk[i].PhysDiskID) {=0A=
 						raid_volume=3D1;=0A=
 						hd->ioc->spi_data.forceDv |=3D=0A=
 						  MPT_SCSICFG_RELOAD_IOC_PG3;=0A=
@@ -3706,8 +3668,6 @@=0A=
 		 */=0A=
 		hd->resetPending =3D 1;=0A=
 =0A=
-		mptscsih_reset_timeouts (hd);=0A=
-	=0A=
 	} else if (reset_phase =3D=3D MPT_IOC_PRE_RESET) {=0A=
 		dtmprintk((MYIOC_s_WARN_FMT "Pre-Diag Reset\n", ioc->name));=0A=
 =0A=
@@ -4519,7 +4479,7 @@=0A=
 					if (nfactor < pspi_data->minSyncFactor )=0A=
 						nfactor =3D pspi_data->minSyncFactor;=0A=
 =0A=
-					factor =3D MAX (factor, nfactor);=0A=
+					factor =3D max(factor, nfactor);=0A=
 					if (factor =3D=3D MPT_ASYNC)=0A=
 						offset =3D 0;=0A=
 				} else {=0A=
@@ -4727,7 +4687,7 @@=0A=
 		maxid =3D ioc->sh->max_id - 1;=0A=
 	} else if (ioc->sh) {=0A=
 		id =3D target_id;=0A=
-		maxid =3D MIN(id, ioc->sh->max_id - 1);=0A=
+		maxid =3D min_t(int, id, ioc->sh->max_id - 1);=0A=
 	}=0A=
 =0A=
 	for (; id <=3D maxid; id++) {=0A=
@@ -5134,7 +5094,7 @@=0A=
 				sense_data =3D ((u8 *)hd->ioc->sense_buf_pool +=0A=
 					(req_idx * MPT_SENSE_BUFFER_ALLOC));=0A=
 =0A=
-				sz =3D MIN (pReq->SenseBufferLength,=0A=
+				sz =3D min_t(int, pReq->SenseBufferLength,=0A=
 							SCSI_STD_SENSE_BYTES);=0A=
 				memcpy(hd->pLocal->sense, sense_data, sz);=0A=
 =0A=
@@ -5786,7 +5746,7 @@=0A=
 				ioc->spi_data.forceDv &=3D ~MPT_SCSICFG_RELOAD_IOC_PG3;=0A=
 			}=0A=
 =0A=
-			maxid =3D MIN (ioc->sh->max_id, MPT_MAX_SCSI_DEVICES);=0A=
+			maxid =3D min_t(int, ioc->sh->max_id, MPT_MAX_SCSI_DEVICES);=0A=
 =0A=
 			for (id =3D 0; id < maxid; id++) {=0A=
 				spin_lock_irqsave(&dvtaskQ_lock, flags);=0A=
@@ -6509,7 +6469,7 @@=0A=
 	if (echoBufSize > 0) {=0A=
 		iocmd.flags |=3D MPT_ICFLAG_ECHO;=0A=
 		if (dataBufSize > 0)=0A=
-			bufsize =3D MIN(echoBufSize, dataBufSize);=0A=
+			bufsize =3D min(echoBufSize, dataBufSize);=0A=
 		else=0A=
 			bufsize =3D echoBufSize;=0A=
 	} else if (dataBufSize =3D=3D 0)=0A=
@@ -6520,7 +6480,7 @@=0A=
 =0A=
 	/* Data buffers for write-read-compare test max 1K.=0A=
 	 */=0A=
-	sz =3D MIN(bufsize, 1024);=0A=
+	sz =3D min(bufsize, 1024);=0A=
 =0A=
 	/* --- loop ----=0A=
 	 * On first pass, always issue a reserve.=0A=
@@ -6875,9 +6835,9 @@=0A=
 		}=0A=
 =0A=
 		/* limit by adapter capabilities */=0A=
-		width =3D MIN(width, hd->ioc->spi_data.maxBusWidth);=0A=
-		offset =3D MIN(offset, hd->ioc->spi_data.maxSyncOffset);=0A=
-		factor =3D MAX(factor, hd->ioc->spi_data.minSyncFactor);=0A=
+		width =3D min(width, hd->ioc->spi_data.maxBusWidth);=0A=
+		offset =3D min(offset, hd->ioc->spi_data.maxSyncOffset);=0A=
+		factor =3D max(factor, hd->ioc->spi_data.minSyncFactor);=0A=
 =0A=
 		/* Check Consistency */=0A=
 		if (offset && (factor < MPT_ULTRA2) && !width)=0A=
@@ -7217,19 +7177,22 @@=0A=
 #define	ARG_SEP	','=0A=
 #endif=0A=
 =0A=
+#ifdef MODULE=0A=
 static char setup_token[] __initdata =3D=0A=
 	"dv:"=0A=
 	"width:"=0A=
 	"factor:"=0A=
 	"saf-te:"=0A=
        ;	/* DO NOT REMOVE THIS ';' */=0A=
-=0A=
+#endif=0A=
+       =0A=
 #define OPT_DV			1=0A=
 #define OPT_MAX_WIDTH		2=0A=
 #define OPT_MIN_SYNC_FACTOR	3=0A=
 #define OPT_SAF_TE		4=0A=
 =0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
*/=0A=
+#ifdef MODULE=0A=
 static int=0A=
 get_setup_token(char *p)=0A=
 {=0A=
@@ -7298,7 +7261,7 @@=0A=
 	}=0A=
 	return 1;=0A=
 }=0A=
-=0A=
+#endif=0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 =0A=
 =0A=
diff -uarN b/drivers/message/fusion/mptscsih.h =
a/drivers/message/fusion/mptscsih.h=0A=
--- b/drivers/message/fusion/mptscsih.h	2004-03-23 08:47:47.000000000 =
-0700=0A=
+++ a/drivers/message/fusion/mptscsih.h	2004-03-23 10:12:56.000000000 =
-0700=0A=
@@ -66,12 +66,6 @@=0A=
  *	SCSI Public stuff...=0A=
  */=0A=
 =0A=
-/*=0A=
- *	Try to keep these at 2^N-1=0A=
- */=0A=
-#define MPT_FC_CAN_QUEUE	127=0A=
-#define MPT_SCSI_CAN_QUEUE	127=0A=
-=0A=
 #define MPT_SCSI_CMD_PER_DEV_HIGH	31=0A=
 #define MPT_SCSI_CMD_PER_DEV_LOW	7=0A=
 =0A=
@@ -79,21 +73,6 @@=0A=
 =0A=
 #define MPT_SCSI_MAX_SECTORS    8192=0A=
 =0A=
-/*=0A=
- * Set the MAX_SGE value based on user input.=0A=
- */=0A=
-#ifdef  CONFIG_FUSION_MAX_SGE=0A=
-#if     CONFIG_FUSION_MAX_SGE  < 16=0A=
-#define MPT_SCSI_SG_DEPTH	16=0A=
-#elif   CONFIG_FUSION_MAX_SGE  > 128=0A=
-#define MPT_SCSI_SG_DEPTH	128=0A=
-#else=0A=
-#define MPT_SCSI_SG_DEPTH	CONFIG_FUSION_MAX_SGE=0A=
-#endif=0A=
-#else=0A=
-#define MPT_SCSI_SG_DEPTH	40=0A=
-#endif=0A=
-=0A=
 /* To disable domain validation, uncomment the=0A=
  * following line. No effect for FC devices.=0A=
  * For SCSI devices, driver will negotiate to=0A=

------_=_NextPart_000_01C41119.C2278140--
