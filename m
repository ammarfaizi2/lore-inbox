Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264210AbUESOuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbUESOuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUESOuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:50:07 -0400
Received: from mail0.lsil.com ([147.145.40.20]:40874 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S264228AbUESOq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:46:26 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C86B@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "Mukker, Atul" <Atulm@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Matthew Wilcox'" <willy@debian.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'paul@wagland.net'" <paul@wagland.net>
Subject: [ANNOUNCE]: megaraid driver version 2.10.6
Date: Tue, 18 May 2004 00:15:38 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C43C8E.C62829C0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C43C8E.C62829C0
Content-Type: text/plain;
	charset="iso-8859-1"

Hello All,

We are releasing megaraid2 driver version 2.10.6 for lk 2.4. The inlined 
patch is made against 2.10.3 driver which was released on 04-09-2004.
The same patch is also attached to this mail.

This driver will be available at:

ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.10.6/

Changes:

1. Run-time allocation of memory for IOCTLS resulted in not servicing some
applications in low-memory situations. 2.10.6 pre-allocates buffers required
by most common commands.

2. A minor bug in random deletion of logical drives is fixed.

Thanks,
Sreenivas


diff -Naur 3.10.3/drivers/scsi/megaraid2.c 2.10.6/drivers/scsi/megaraid2.c
--- 2.10.3/drivers/scsi/megaraid2.c	2004-05-18 00:36:59.671176480 -0400
+++ 2.10.6/drivers/scsi/megaraid2.c	2004-05-18 00:37:06.262174496 -0400
@@ -14,7 +14,7 @@
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)
  *	  - lots of cleanups.
  *
- * Version : v2.10.3 (Apr 08, 2004)
+ * Version : v2.10.6 (May 14, 2004)
  *
  * Authors:	Atul Mukker <Atul.Mukker@lsil.com>
  *		Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
@@ -90,10 +90,15 @@
 static struct mega_hbas mega_hbas[MAX_CONTROLLERS];
 
 /*
+ * Lock to protect access to IOCTL
+ */
+static struct semaphore megaraid_ioc_mtx;
+
+/*
  * The File Operations structure for the serial/ioctl interface of the
driver
  */
 static struct file_operations megadev_fops = {
-	.ioctl		= megadev_ioctl,
+	.ioctl		= megadev_ioctl_entry,
 	.open		= megadev_open,
 	.release	= megadev_close,
 	.owner		= THIS_MODULE,
@@ -107,7 +112,7 @@
 static struct mcontroller mcontroller[MAX_CONTROLLERS];
 
 /* The current driver version */
-static u32 driver_ver = 0x02100000;
+static u32 driver_ver = 0x02104000;
 
 /* major number used by the device for character interface */
 static int major;
@@ -189,6 +194,11 @@
 		 */
 		mega_reorder_hosts();
 
+		/*
+		 * Initialize the IOCTL lock
+		 */
+		init_MUTEX( &megaraid_ioc_mtx );
+
 #ifdef CONFIG_PROC_FS
 		mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
 
@@ -273,6 +283,8 @@
 	unsigned long	tbase;
 	unsigned long	flag = 0;
 	int	i, j;
+	u8	did_int_pthru_f	= 0;
+	u8	did_int_data_f	= 0;
 
 	while((pdev = pci_find_device(pci_vendor, pci_device, pdev))) {
 
@@ -465,6 +477,33 @@
 
 		alloc_scb_f = 1;
 
+		/*
+		 * Allocate memory for ioctls
+		 */
+		adapter->int_pthru = pci_alloc_consistent ( 
+					adapter->dev,
+					sizeof(mega_passthru),
+					&adapter->int_pthru_dma_hndl );
+
+		if( adapter->int_pthru == NULL ) {
+			printk(KERN_WARNING "megaraid: out of RAM.\n");
+			goto fail_attach;
+		}
+		else
+			did_int_pthru_f = 1;
+
+		adapter->int_data = pci_alloc_consistent (
+					adapter->dev,
+					INT_MEMBLK_SZ,
+					&adapter->int_data_dma_hndl );
+
+		if( adapter->int_data == NULL ) {
+			printk(KERN_WARNING "megaraid: out of RAM.\n");
+			goto fail_attach;
+		}
+		else
+			did_int_data_f = 1;
+
 		/* Request our IRQ */
 		if( adapter->flag & BOARD_MEMMAP ) {
 			if(request_irq(irq, megaraid_isr_memmapped,
SA_SHIRQ,
@@ -676,6 +715,19 @@
 		continue;
 
 fail_attach:
+		if( did_int_data_f ) {
+			pci_free_consistent(
+				adapter->dev, INT_MEMBLK_SZ,
adapter->int_data, 
+				adapter->int_data_dma_hndl );
+		}
+
+		if( did_int_pthru_f ) {
+			pci_free_consistent(
+				adapter->dev, sizeof(mega_passthru),
+				(void*) adapter->int_pthru,
+				adapter->int_pthru_dma_hndl );
+		}
+
 		if( did_setup_mbox_f ) {
 			pci_free_consistent(adapter->dev, sizeof(mbox64_t),
 					(void *)adapter->una_mbox64,
@@ -2568,6 +2620,13 @@
 	pci_free_consistent(adapter->dev, sizeof(mbox64_t),
 			(void *)adapter->una_mbox64,
adapter->una_mbox64_dma);
 
+	pci_free_consistent( adapter->dev, sizeof(mega_passthru),
+				(void*) adapter->int_pthru, 
+				adapter->int_pthru_dma_hndl );
+
+	pci_free_consistent( adapter->dev, INT_MEMBLK_SZ, adapter->int_data,
+				adapter->int_data_dma_hndl );
+
 	hba_count--;
 
 	if( hba_count == 0 ) {
@@ -4076,10 +4135,20 @@
 {
 	struct inode *inode = filep->f_dentry->d_inode;
 
-	return megadev_ioctl(inode, filep, cmd, arg);
+	return megadev_ioctl_entry(inode, filep, cmd, arg);
 }
 #endif
 
+static int
+megadev_ioctl_entry(struct inode *inode, struct file *filep, unsigned int
cmd,
+		unsigned long arg)
+{
+	int rval;
+	down( &megaraid_ioc_mtx );
+	rval = megadev_ioctl( inode, filep, cmd, arg );
+	up( &megaraid_ioc_mtx );
+	return rval;
+}
 
 /**
  * megadev_ioctl()
@@ -4103,9 +4172,8 @@
 	int		rval;
 	mega_passthru	*upthru;	/* user address for passthru */
 	mega_passthru	*pthru;		/* copy user passthru here */
-	dma_addr_t	pthru_dma_hndl;
 	void		*data = NULL;	/* data to be transferred */
-	dma_addr_t	data_dma_hndl;	/* dma handle for data xfer area */
+	dma_addr_t	data_dma_hndl = 0;
 	megacmd_t	mc;
 	megastat_t	*ustats;
 	int		num_ldrv;
@@ -4221,7 +4289,7 @@
 		/*
 		 * Which adapter
 		 */
-		if( (adapno = GETADAP(uioc.adapno)) >= hba_count )
+		if( (adapno = GETADAP(uioc.adapno)) >= hba_count ) 
 			return (-ENODEV);
 
 		adapter = hba_soft_state[adapno];
@@ -4277,13 +4345,7 @@
 		if( uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
 			/* Passthru commands */
 
-			pthru = pci_alloc_consistent(pdev,
-					sizeof(mega_passthru),
-					&pthru_dma_hndl);
-
-			if( pthru == NULL ) {
-				return (-ENOMEM);
-			}
+			pthru = adapter->int_pthru;
 
 			/*
 			 * The user passthru structure
@@ -4295,29 +4357,27 @@
 			 */
 			if( copy_from_user(pthru, (char *)upthru,
 						sizeof(mega_passthru)) ) {
-
-				pci_free_consistent(pdev,
-						sizeof(mega_passthru),
pthru,
-						pthru_dma_hndl);
-
 				return (-EFAULT);
 			}
 
 			/*
-			 * Is there a data transfer
+			 * Is there a data transfer; If the data transfer
+			 * length is <= INT_MEMBLK_SZ, usr the buffer 
+			 * allocated at the load time. Otherwise, allocate
it 
+			 * here.
 			 */
-			if( pthru->dataxferlen ) {
-				data = pci_alloc_consistent(pdev,
-						pthru->dataxferlen,
-						&data_dma_hndl);
-
-				if( data == NULL ) {
-					pci_free_consistent(pdev,
-
sizeof(mega_passthru),
-							pthru,
-							pthru_dma_hndl);
+			if (pthru->dataxferlen) {
+				if (pthru->dataxferlen > INT_MEMBLK_SZ) {
+					data = pci_alloc_consistent (
+							pdev,
+							pthru->dataxferlen,
+							&data_dma_hndl );
 
-					return (-ENOMEM);
+					if (data == NULL)
+						return (-ENOMEM);
+				}
+				else {
+					data = adapter->int_data;
 				}
 
 				/*
@@ -4325,7 +4385,11 @@
 				 * address at just allocated memory
 				 */
 				uxferaddr = pthru->dataxferaddr;
-				pthru->dataxferaddr = data_dma_hndl;
+				if (data_dma_hndl)
+					pthru->dataxferaddr = data_dma_hndl;
+				else
+					pthru->dataxferaddr = 
+						adapter->int_data_dma_hndl;
 			}
 
 
@@ -4340,14 +4404,14 @@
 						(char *)((ulong)uxferaddr),
 						pthru->dataxferlen) ) {
 					rval = (-EFAULT);
-					goto freemem_and_return;
+					goto freedata_and_return;
 				}
 			}
 
 			memset(&mc, 0, sizeof(megacmd_t));
 
 			mc.cmd = MEGA_MBOXCMD_PASSTHRU;
-			mc.xferaddr = (u32)pthru_dma_hndl;
+			mc.xferaddr = (u32)adapter->int_pthru_dma_hndl;
 
 			/*
 			 * Issue the command
@@ -4356,7 +4420,7 @@
 
 			rval = mega_n_to_m((void *)arg, &mc);
 
-			if( rval ) goto freemem_and_return;
+			if( rval ) goto freedata_and_return;
 
 
 			/*
@@ -4375,18 +4439,14 @@
 			 */
 			copy_to_user(upthru->reqsensearea,
 					pthru->reqsensearea, 14);
-
-freemem_and_return:
-			if( pthru->dataxferlen ) {
-				pci_free_consistent(pdev,
-						pthru->dataxferlen, data,
-						data_dma_hndl);
+freedata_and_return:
+			if (data_dma_hndl) {
+				pci_free_consistent( pdev,
pthru->dataxferlen,
+							data, data_dma_hndl
);
 			}
 
-			pci_free_consistent(pdev, sizeof(mega_passthru),
-					pthru, pthru_dma_hndl);
-
 			return rval;
+
 		}
 		else {
 			/* DCMD commands */
@@ -4395,13 +4455,18 @@
 			 * Is there a data transfer
 			 */
 			if( uioc.xferlen ) {
-				data = pci_alloc_consistent(pdev,
-						uioc.xferlen,
&data_dma_hndl);
+				if (uioc.xferlen > INT_MEMBLK_SZ) {
+					data = pci_alloc_consistent(
+							pdev,
+							uioc.xferlen,
+							&data_dma_hndl );
 
-				if( data == NULL ) {
-					return (-ENOMEM);
+					if (data == NULL)
+						return (-ENOMEM);
+				}
+				else {
+					data = adapter->int_data;
 				}
-
 				uxferaddr = MBOX(uioc)->xferaddr;
 			}
 
@@ -4416,9 +4481,9 @@
 						(char *)((ulong)uxferaddr),
 						uioc.xferlen) ) {
 
-					pci_free_consistent(pdev,
-						uioc.xferlen, data,
-						data_dma_hndl);
+					pci_free_consistent(
+						pdev, uioc.xferlen,
+						data, data_dma_hndl );
 
 					return (-EFAULT);
 				}
@@ -4426,7 +4491,10 @@
 
 			memcpy(&mc, MBOX(uioc), sizeof(megacmd_t));
 
-			mc.xferaddr = (u32)data_dma_hndl;
+			if (data_dma_hndl )
+				mc.xferaddr = (u32)data_dma_hndl;
+			else
+				mc.xferaddr =
(u32)(adapter->int_data_dma_hndl);
 
 			/*
 			 * Issue the command
@@ -4436,12 +4504,10 @@
 			rval = mega_n_to_m((void *)arg, &mc);
 
 			if( rval ) {
-				if( uioc.xferlen ) {
-					pci_free_consistent(pdev,
-							uioc.xferlen, data,
-							data_dma_hndl);
+				if (data_dma_hndl) {
+					pci_free_consistent( pdev,
uioc.xferlen,
+							data, data_dma_hndl
);
 				}
-
 				return rval;
 			}
 
@@ -4456,10 +4522,9 @@
 				}
 			}
 
-			if( uioc.xferlen ) {
-				pci_free_consistent(pdev,
-						uioc.xferlen, data,
-						data_dma_hndl);
+			if (data_dma_hndl) {
+				pci_free_consistent( pdev, uioc.xferlen,
+							data, data_dma_hndl
);
 			}
 
 			return rval;
@@ -4644,19 +4709,22 @@
 	else {
 		uioc_mimd = (struct uioctl_t *)arg;
 
-		if( put_user(mc->status, (u8 *)&uioc_mimd->mbox[17]) )
+		if( put_user(mc->status, (u8 *)&uioc_mimd->mbox[17]) ) {
 			return (-EFAULT);
+		}
 
 		if( mc->cmd == MEGA_MBOXCMD_PASSTHRU ) {
 
 			umc = (megacmd_t *)uioc_mimd->mbox;
-			if (copy_from_user(&kmc, umc, sizeof(megacmd_t)))
+			if (copy_from_user(&kmc, umc, sizeof(megacmd_t))) {
 				return -EFAULT;
+			}
 
 			upthru = (mega_passthru *)((ulong)kmc.xferaddr);
 
-			if( put_user(mc->status, (u8 *)&upthru->scsistatus)
)
+			if( put_user(mc->status, (u8 *)&upthru->scsistatus)
){
 				return (-EFAULT);
+			}
 		}
 	}
 
@@ -5116,13 +5184,7 @@
 	 */
 
 	if (adapter->support_random_del && adapter->read_ldidmap )
-		switch (cmd->cmnd[0]) {
-		case READ_6:	/* fall through */
-		case WRITE_6:	/* fall through */
-		case READ_10:	/* fall through */
-		case WRITE_10:
-			ldrv_num += 0x80;
-		}
+		ldrv_num += 0x80;
 
 	return ldrv_num;
 }
diff -Naur 2.10.3/drivers/scsi/megaraid2.h 2.10.6/drivers/scsi/megaraid2.h
--- 2.10.3/drivers/scsi/megaraid2.h	2004-05-18 00:36:59.673176176 -0400
+++ 2.10.6/drivers/scsi/megaraid2.h	2004-05-18 00:37:06.264174192 -0400
@@ -6,7 +6,7 @@
 
 
 #define MEGARAID_VERSION	\
-	"v2.10.3 (Release Date: Thu Apr  8 16:16:05 EDT 2004)\n"
+	"v2.10.6 (Release Date: Fri May 14 08:36:49 EDT 2004)\n"
 
 /*
  * Driver features - change the values to enable or disable features in the
@@ -979,6 +979,13 @@
 						 cmds */
 
 	int	has_cluster;	/* cluster support on this HBA */
+
+#define INT_MEMBLK_SZ		(28*1024)
+	mega_passthru		*int_pthru;		/*internal pthru*/
+	dma_addr_t		int_pthru_dma_hndl;
+	caddr_t			int_data;		/*internal data*/
+	dma_addr_t		int_data_dma_hndl;
+
 }adapter_t;
 
 
@@ -1136,6 +1143,8 @@
 	struct file *);
 #endif
 
+static int megadev_ioctl_entry (struct inode *, struct file *, unsigned
int,
+		unsigned long);
 static int megadev_ioctl (struct inode *, struct file *, unsigned int,
 		unsigned long);
 static int mega_m_to_n(void *, nitioctl_t *);


------_=_NextPart_000_01C43C8E.C62829C0
Content-Type: application/octet-stream;
	name="megaraid-2.10.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid-2.10.6.patch"

diff -Naur 2.10.3/drivers/scsi/megaraid2.c =
2.10.6/drivers/scsi/megaraid2.c=0A=
--- 2.10.3/drivers/scsi/megaraid2.c	2004-05-18 00:36:59.671176480 =
-0400=0A=
+++ 2.10.6/drivers/scsi/megaraid2.c	2004-05-18 00:37:06.262174496 =
-0400=0A=
@@ -14,7 +14,7 @@=0A=
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)=0A=
  *	  - lots of cleanups.=0A=
  *=0A=
- * Version : v2.10.3 (Apr 08, 2004)=0A=
+ * Version : v2.10.6 (May 14, 2004)=0A=
  *=0A=
  * Authors:	Atul Mukker <Atul.Mukker@lsil.com>=0A=
  *		Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>=0A=
@@ -90,10 +90,15 @@=0A=
 static struct mega_hbas mega_hbas[MAX_CONTROLLERS];=0A=
 =0A=
 /*=0A=
+ * Lock to protect access to IOCTL=0A=
+ */=0A=
+static struct semaphore megaraid_ioc_mtx;=0A=
+=0A=
+/*=0A=
  * The File Operations structure for the serial/ioctl interface of the =
driver=0A=
  */=0A=
 static struct file_operations megadev_fops =3D {=0A=
-	.ioctl		=3D megadev_ioctl,=0A=
+	.ioctl		=3D megadev_ioctl_entry,=0A=
 	.open		=3D megadev_open,=0A=
 	.release	=3D megadev_close,=0A=
 	.owner		=3D THIS_MODULE,=0A=
@@ -107,7 +112,7 @@=0A=
 static struct mcontroller mcontroller[MAX_CONTROLLERS];=0A=
 =0A=
 /* The current driver version */=0A=
-static u32 driver_ver =3D 0x02100000;=0A=
+static u32 driver_ver =3D 0x02104000;=0A=
 =0A=
 /* major number used by the device for character interface */=0A=
 static int major;=0A=
@@ -189,6 +194,11 @@=0A=
 		 */=0A=
 		mega_reorder_hosts();=0A=
 =0A=
+		/*=0A=
+		 * Initialize the IOCTL lock=0A=
+		 */=0A=
+		init_MUTEX( &megaraid_ioc_mtx );=0A=
+=0A=
 #ifdef CONFIG_PROC_FS=0A=
 		mega_proc_dir_entry =3D proc_mkdir("megaraid", &proc_root);=0A=
 =0A=
@@ -273,6 +283,8 @@=0A=
 	unsigned long	tbase;=0A=
 	unsigned long	flag =3D 0;=0A=
 	int	i, j;=0A=
+	u8	did_int_pthru_f	=3D 0;=0A=
+	u8	did_int_data_f	=3D 0;=0A=
 =0A=
 	while((pdev =3D pci_find_device(pci_vendor, pci_device, pdev))) {=0A=
 =0A=
@@ -465,6 +477,33 @@=0A=
 =0A=
 		alloc_scb_f =3D 1;=0A=
 =0A=
+		/*=0A=
+		 * Allocate memory for ioctls=0A=
+		 */=0A=
+		adapter->int_pthru =3D pci_alloc_consistent ( =0A=
+					adapter->dev,=0A=
+					sizeof(mega_passthru),=0A=
+					&adapter->int_pthru_dma_hndl );=0A=
+=0A=
+		if( adapter->int_pthru =3D=3D NULL ) {=0A=
+			printk(KERN_WARNING "megaraid: out of RAM.\n");=0A=
+			goto fail_attach;=0A=
+		}=0A=
+		else=0A=
+			did_int_pthru_f =3D 1;=0A=
+=0A=
+		adapter->int_data =3D pci_alloc_consistent (=0A=
+					adapter->dev,=0A=
+					INT_MEMBLK_SZ,=0A=
+					&adapter->int_data_dma_hndl );=0A=
+=0A=
+		if( adapter->int_data =3D=3D NULL ) {=0A=
+			printk(KERN_WARNING "megaraid: out of RAM.\n");=0A=
+			goto fail_attach;=0A=
+		}=0A=
+		else=0A=
+			did_int_data_f =3D 1;=0A=
+=0A=
 		/* Request our IRQ */=0A=
 		if( adapter->flag & BOARD_MEMMAP ) {=0A=
 			if(request_irq(irq, megaraid_isr_memmapped, SA_SHIRQ,=0A=
@@ -676,6 +715,19 @@=0A=
 		continue;=0A=
 =0A=
 fail_attach:=0A=
+		if( did_int_data_f ) {=0A=
+			pci_free_consistent(=0A=
+				adapter->dev, INT_MEMBLK_SZ, adapter->int_data, =0A=
+				adapter->int_data_dma_hndl );=0A=
+		}=0A=
+=0A=
+		if( did_int_pthru_f ) {=0A=
+			pci_free_consistent(=0A=
+				adapter->dev, sizeof(mega_passthru),=0A=
+				(void*) adapter->int_pthru,=0A=
+				adapter->int_pthru_dma_hndl );=0A=
+		}=0A=
+=0A=
 		if( did_setup_mbox_f ) {=0A=
 			pci_free_consistent(adapter->dev, sizeof(mbox64_t),=0A=
 					(void *)adapter->una_mbox64,=0A=
@@ -2568,6 +2620,13 @@=0A=
 	pci_free_consistent(adapter->dev, sizeof(mbox64_t),=0A=
 			(void *)adapter->una_mbox64, adapter->una_mbox64_dma);=0A=
 =0A=
+	pci_free_consistent( adapter->dev, sizeof(mega_passthru),=0A=
+				(void*) adapter->int_pthru, =0A=
+				adapter->int_pthru_dma_hndl );=0A=
+=0A=
+	pci_free_consistent( adapter->dev, INT_MEMBLK_SZ, =
adapter->int_data,=0A=
+				adapter->int_data_dma_hndl );=0A=
+=0A=
 	hba_count--;=0A=
 =0A=
 	if( hba_count =3D=3D 0 ) {=0A=
@@ -4076,10 +4135,20 @@=0A=
 {=0A=
 	struct inode *inode =3D filep->f_dentry->d_inode;=0A=
 =0A=
-	return megadev_ioctl(inode, filep, cmd, arg);=0A=
+	return megadev_ioctl_entry(inode, filep, cmd, arg);=0A=
 }=0A=
 #endif=0A=
 =0A=
+static int=0A=
+megadev_ioctl_entry(struct inode *inode, struct file *filep, unsigned =
int cmd,=0A=
+		unsigned long arg)=0A=
+{=0A=
+	int rval;=0A=
+	down( &megaraid_ioc_mtx );=0A=
+	rval =3D megadev_ioctl( inode, filep, cmd, arg );=0A=
+	up( &megaraid_ioc_mtx );=0A=
+	return rval;=0A=
+}=0A=
 =0A=
 /**=0A=
  * megadev_ioctl()=0A=
@@ -4103,9 +4172,8 @@=0A=
 	int		rval;=0A=
 	mega_passthru	*upthru;	/* user address for passthru */=0A=
 	mega_passthru	*pthru;		/* copy user passthru here */=0A=
-	dma_addr_t	pthru_dma_hndl;=0A=
 	void		*data =3D NULL;	/* data to be transferred */=0A=
-	dma_addr_t	data_dma_hndl;	/* dma handle for data xfer area */=0A=
+	dma_addr_t	data_dma_hndl =3D 0;=0A=
 	megacmd_t	mc;=0A=
 	megastat_t	*ustats;=0A=
 	int		num_ldrv;=0A=
@@ -4221,7 +4289,7 @@=0A=
 		/*=0A=
 		 * Which adapter=0A=
 		 */=0A=
-		if( (adapno =3D GETADAP(uioc.adapno)) >=3D hba_count )=0A=
+		if( (adapno =3D GETADAP(uioc.adapno)) >=3D hba_count ) =0A=
 			return (-ENODEV);=0A=
 =0A=
 		adapter =3D hba_soft_state[adapno];=0A=
@@ -4277,13 +4345,7 @@=0A=
 		if( uioc.uioc_rmbox[0] =3D=3D MEGA_MBOXCMD_PASSTHRU ) {=0A=
 			/* Passthru commands */=0A=
 =0A=
-			pthru =3D pci_alloc_consistent(pdev,=0A=
-					sizeof(mega_passthru),=0A=
-					&pthru_dma_hndl);=0A=
-=0A=
-			if( pthru =3D=3D NULL ) {=0A=
-				return (-ENOMEM);=0A=
-			}=0A=
+			pthru =3D adapter->int_pthru;=0A=
 =0A=
 			/*=0A=
 			 * The user passthru structure=0A=
@@ -4295,29 +4357,27 @@=0A=
 			 */=0A=
 			if( copy_from_user(pthru, (char *)upthru,=0A=
 						sizeof(mega_passthru)) ) {=0A=
-=0A=
-				pci_free_consistent(pdev,=0A=
-						sizeof(mega_passthru), pthru,=0A=
-						pthru_dma_hndl);=0A=
-=0A=
 				return (-EFAULT);=0A=
 			}=0A=
 =0A=
 			/*=0A=
-			 * Is there a data transfer=0A=
+			 * Is there a data transfer; If the data transfer=0A=
+			 * length is <=3D INT_MEMBLK_SZ, usr the buffer =0A=
+			 * allocated at the load time. Otherwise, allocate it =0A=
+			 * here.=0A=
 			 */=0A=
-			if( pthru->dataxferlen ) {=0A=
-				data =3D pci_alloc_consistent(pdev,=0A=
-						pthru->dataxferlen,=0A=
-						&data_dma_hndl);=0A=
-=0A=
-				if( data =3D=3D NULL ) {=0A=
-					pci_free_consistent(pdev,=0A=
-							sizeof(mega_passthru),=0A=
-							pthru,=0A=
-							pthru_dma_hndl);=0A=
+			if (pthru->dataxferlen) {=0A=
+				if (pthru->dataxferlen > INT_MEMBLK_SZ) {=0A=
+					data =3D pci_alloc_consistent (=0A=
+							pdev,=0A=
+							pthru->dataxferlen,=0A=
+							&data_dma_hndl );=0A=
 =0A=
-					return (-ENOMEM);=0A=
+					if (data =3D=3D NULL)=0A=
+						return (-ENOMEM);=0A=
+				}=0A=
+				else {=0A=
+					data =3D adapter->int_data;=0A=
 				}=0A=
 =0A=
 				/*=0A=
@@ -4325,7 +4385,11 @@=0A=
 				 * address at just allocated memory=0A=
 				 */=0A=
 				uxferaddr =3D pthru->dataxferaddr;=0A=
-				pthru->dataxferaddr =3D data_dma_hndl;=0A=
+				if (data_dma_hndl)=0A=
+					pthru->dataxferaddr =3D data_dma_hndl;=0A=
+				else=0A=
+					pthru->dataxferaddr =3D =0A=
+						adapter->int_data_dma_hndl;=0A=
 			}=0A=
 =0A=
 =0A=
@@ -4340,14 +4404,14 @@=0A=
 						(char *)((ulong)uxferaddr),=0A=
 						pthru->dataxferlen) ) {=0A=
 					rval =3D (-EFAULT);=0A=
-					goto freemem_and_return;=0A=
+					goto freedata_and_return;=0A=
 				}=0A=
 			}=0A=
 =0A=
 			memset(&mc, 0, sizeof(megacmd_t));=0A=
 =0A=
 			mc.cmd =3D MEGA_MBOXCMD_PASSTHRU;=0A=
-			mc.xferaddr =3D (u32)pthru_dma_hndl;=0A=
+			mc.xferaddr =3D (u32)adapter->int_pthru_dma_hndl;=0A=
 =0A=
 			/*=0A=
 			 * Issue the command=0A=
@@ -4356,7 +4420,7 @@=0A=
 =0A=
 			rval =3D mega_n_to_m((void *)arg, &mc);=0A=
 =0A=
-			if( rval ) goto freemem_and_return;=0A=
+			if( rval ) goto freedata_and_return;=0A=
 =0A=
 =0A=
 			/*=0A=
@@ -4375,18 +4439,14 @@=0A=
 			 */=0A=
 			copy_to_user(upthru->reqsensearea,=0A=
 					pthru->reqsensearea, 14);=0A=
-=0A=
-freemem_and_return:=0A=
-			if( pthru->dataxferlen ) {=0A=
-				pci_free_consistent(pdev,=0A=
-						pthru->dataxferlen, data,=0A=
-						data_dma_hndl);=0A=
+freedata_and_return:=0A=
+			if (data_dma_hndl) {=0A=
+				pci_free_consistent( pdev, pthru->dataxferlen,=0A=
+							data, data_dma_hndl );=0A=
 			}=0A=
 =0A=
-			pci_free_consistent(pdev, sizeof(mega_passthru),=0A=
-					pthru, pthru_dma_hndl);=0A=
-=0A=
 			return rval;=0A=
+=0A=
 		}=0A=
 		else {=0A=
 			/* DCMD commands */=0A=
@@ -4395,13 +4455,18 @@=0A=
 			 * Is there a data transfer=0A=
 			 */=0A=
 			if( uioc.xferlen ) {=0A=
-				data =3D pci_alloc_consistent(pdev,=0A=
-						uioc.xferlen, &data_dma_hndl);=0A=
+				if (uioc.xferlen > INT_MEMBLK_SZ) {=0A=
+					data =3D pci_alloc_consistent(=0A=
+							pdev,=0A=
+							uioc.xferlen,=0A=
+							&data_dma_hndl );=0A=
 =0A=
-				if( data =3D=3D NULL ) {=0A=
-					return (-ENOMEM);=0A=
+					if (data =3D=3D NULL)=0A=
+						return (-ENOMEM);=0A=
+				}=0A=
+				else {=0A=
+					data =3D adapter->int_data;=0A=
 				}=0A=
-=0A=
 				uxferaddr =3D MBOX(uioc)->xferaddr;=0A=
 			}=0A=
 =0A=
@@ -4416,9 +4481,9 @@=0A=
 						(char *)((ulong)uxferaddr),=0A=
 						uioc.xferlen) ) {=0A=
 =0A=
-					pci_free_consistent(pdev,=0A=
-						uioc.xferlen, data,=0A=
-						data_dma_hndl);=0A=
+					pci_free_consistent(=0A=
+						pdev, uioc.xferlen,=0A=
+						data, data_dma_hndl );=0A=
 =0A=
 					return (-EFAULT);=0A=
 				}=0A=
@@ -4426,7 +4491,10 @@=0A=
 =0A=
 			memcpy(&mc, MBOX(uioc), sizeof(megacmd_t));=0A=
 =0A=
-			mc.xferaddr =3D (u32)data_dma_hndl;=0A=
+			if (data_dma_hndl )=0A=
+				mc.xferaddr =3D (u32)data_dma_hndl;=0A=
+			else=0A=
+				mc.xferaddr =3D (u32)(adapter->int_data_dma_hndl);=0A=
 =0A=
 			/*=0A=
 			 * Issue the command=0A=
@@ -4436,12 +4504,10 @@=0A=
 			rval =3D mega_n_to_m((void *)arg, &mc);=0A=
 =0A=
 			if( rval ) {=0A=
-				if( uioc.xferlen ) {=0A=
-					pci_free_consistent(pdev,=0A=
-							uioc.xferlen, data,=0A=
-							data_dma_hndl);=0A=
+				if (data_dma_hndl) {=0A=
+					pci_free_consistent( pdev, uioc.xferlen,=0A=
+							data, data_dma_hndl );=0A=
 				}=0A=
-=0A=
 				return rval;=0A=
 			}=0A=
 =0A=
@@ -4456,10 +4522,9 @@=0A=
 				}=0A=
 			}=0A=
 =0A=
-			if( uioc.xferlen ) {=0A=
-				pci_free_consistent(pdev,=0A=
-						uioc.xferlen, data,=0A=
-						data_dma_hndl);=0A=
+			if (data_dma_hndl) {=0A=
+				pci_free_consistent( pdev, uioc.xferlen,=0A=
+							data, data_dma_hndl );=0A=
 			}=0A=
 =0A=
 			return rval;=0A=
@@ -4644,19 +4709,22 @@=0A=
 	else {=0A=
 		uioc_mimd =3D (struct uioctl_t *)arg;=0A=
 =0A=
-		if( put_user(mc->status, (u8 *)&uioc_mimd->mbox[17]) )=0A=
+		if( put_user(mc->status, (u8 *)&uioc_mimd->mbox[17]) ) {=0A=
 			return (-EFAULT);=0A=
+		}=0A=
 =0A=
 		if( mc->cmd =3D=3D MEGA_MBOXCMD_PASSTHRU ) {=0A=
 =0A=
 			umc =3D (megacmd_t *)uioc_mimd->mbox;=0A=
-			if (copy_from_user(&kmc, umc, sizeof(megacmd_t)))=0A=
+			if (copy_from_user(&kmc, umc, sizeof(megacmd_t))) {=0A=
 				return -EFAULT;=0A=
+			}=0A=
 =0A=
 			upthru =3D (mega_passthru *)((ulong)kmc.xferaddr);=0A=
 =0A=
-			if( put_user(mc->status, (u8 *)&upthru->scsistatus) )=0A=
+			if( put_user(mc->status, (u8 *)&upthru->scsistatus) ){=0A=
 				return (-EFAULT);=0A=
+			}=0A=
 		}=0A=
 	}=0A=
 =0A=
@@ -5116,13 +5184,7 @@=0A=
 	 */=0A=
 =0A=
 	if (adapter->support_random_del && adapter->read_ldidmap )=0A=
-		switch (cmd->cmnd[0]) {=0A=
-		case READ_6:	/* fall through */=0A=
-		case WRITE_6:	/* fall through */=0A=
-		case READ_10:	/* fall through */=0A=
-		case WRITE_10:=0A=
-			ldrv_num +=3D 0x80;=0A=
-		}=0A=
+		ldrv_num +=3D 0x80;=0A=
 =0A=
 	return ldrv_num;=0A=
 }=0A=
diff -Naur 2.10.3/drivers/scsi/megaraid2.h =
2.10.6/drivers/scsi/megaraid2.h=0A=
--- 2.10.3/drivers/scsi/megaraid2.h	2004-05-18 00:36:59.673176176 =
-0400=0A=
+++ 2.10.6/drivers/scsi/megaraid2.h	2004-05-18 00:37:06.264174192 =
-0400=0A=
@@ -6,7 +6,7 @@=0A=
 =0A=
 =0A=
 #define MEGARAID_VERSION	\=0A=
-	"v2.10.3 (Release Date: Thu Apr  8 16:16:05 EDT 2004)\n"=0A=
+	"v2.10.6 (Release Date: Fri May 14 08:36:49 EDT 2004)\n"=0A=
 =0A=
 /*=0A=
  * Driver features - change the values to enable or disable features =
in the=0A=
@@ -979,6 +979,13 @@=0A=
 						 cmds */=0A=
 =0A=
 	int	has_cluster;	/* cluster support on this HBA */=0A=
+=0A=
+#define INT_MEMBLK_SZ		(28*1024)=0A=
+	mega_passthru		*int_pthru;		/*internal pthru*/=0A=
+	dma_addr_t		int_pthru_dma_hndl;=0A=
+	caddr_t			int_data;		/*internal data*/=0A=
+	dma_addr_t		int_data_dma_hndl;=0A=
+=0A=
 }adapter_t;=0A=
 =0A=
 =0A=
@@ -1136,6 +1143,8 @@=0A=
 	struct file *);=0A=
 #endif=0A=
 =0A=
+static int megadev_ioctl_entry (struct inode *, struct file *, =
unsigned int,=0A=
+		unsigned long);=0A=
 static int megadev_ioctl (struct inode *, struct file *, unsigned =
int,=0A=
 		unsigned long);=0A=
 static int mega_m_to_n(void *, nitioctl_t *);=0A=

------_=_NextPart_000_01C43C8E.C62829C0--
