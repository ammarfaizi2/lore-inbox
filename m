Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVIMQxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVIMQxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVIMQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:53:51 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:34696 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S964895AbVIMQx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:53:28 -0400
Date: Tue, 13 Sep 2005 18:52:56 +0200
Message-Id: <200509131652.j8DGquBH022119@localhost.localdomain>
In-reply-to: <200509131649.j8DGnNnw021871@localhost.localdomain>
Subject: [PATCH 4/5] isicom: firmware
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 drivers/char/isicom.c  |  409 ++++++++++++++++++++-----------------------------
 include/linux/isicom.h |   35 ----
 2 files changed, 171 insertions(+), 273 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -114,6 +114,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -122,7 +123,6 @@
 #include <linux/sched.h>
 #include <linux/serial.h>
 #include <linux/mm.h>
-#include <linux/miscdevice.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/delay.h>
@@ -177,8 +177,6 @@ static struct tty_driver *isicom_normal;
 static struct timer_list tx;
 static char re_schedule = 1;
 
-static int ISILoad_ioctl(struct inode *inode, struct file *filp, unsigned  int cmd, unsigned long arg);
-
 static void isicom_tx(unsigned long _data);
 static void isicom_start(struct tty_struct *tty);
 
@@ -387,233 +385,6 @@ static inline void kill_queue(struct isi
 	unlock_card(card);
 }
 
-
-/*
- *  Firmware loader driver specific routines. This needs to mostly die
- *  and be replaced with request_firmware.
- */
-
-static struct file_operations ISILoad_fops = {
-	.owner		= THIS_MODULE,
-	.ioctl		= ISILoad_ioctl,
-};
-
-static struct miscdevice isiloader_device = {
-	ISILOAD_MISC_MINOR, "isictl", &ISILoad_fops
-};
-
-
-static inline int WaitTillCardIsFree(u16 base)
-{
-	unsigned long count=0;
-	while( (!(inw(base+0xe) & 0x1)) && (count++ < 6000000));
-	if (inw(base+0xe)&0x1)
-		return 0;
-	else
-		return 1;
-}
-
-static int ISILoad_ioctl(struct inode *inode, struct file *filp,
-	unsigned int cmd, unsigned long arg)
-{
-	unsigned int card, i, j, signature, status, portcount = 0;
-	unsigned long t;
-	u16 word_count, base;
-	bin_frame frame;
-	void __user *argp = (void __user *)arg;
-	/* exec_record exec_rec; */
-
-	if (get_user(card, (int __user *)argp))
-		return -EFAULT;
-
-	if (card < 0 || card >= BOARD_COUNT)
-		return -ENXIO;
-
-	base=isi_card[card].base;
-
-	if (base==0)
-		return -ENXIO;	/* disabled or not used */
-
-	switch(cmd) {
-	case MIOCTL_RESET_CARD:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		printk(KERN_DEBUG "ISILoad:Resetting Card%d at 0x%x ",card+1,base);
-
-		inw(base+0x8);
-
-		for (t=jiffies+HZ/100;time_before(jiffies, t););
-
-		outw(0,base+0x8); /* Reset */
-
-		for (j=1;j<=3;j++) {
-			for (t=jiffies+HZ;time_before(jiffies, t););
-			printk(".");
-		}
-		signature=(inw(base+0x4)) & 0xff;
-		if (isi_card[card].isa) {
-
-			if (!(inw(base+0xe) & 0x1) || (inw(base+0x2))) {
-#ifdef ISICOM_DEBUG
-				printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
-#endif
-				printk("\nISILoad:ISA Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
-				return -EIO;
-			}
-		}
-		else {
-			portcount = inw(base+0x2);
-			if (!(inw(base+0xe) & 0x1) || ((portcount!=0) && (portcount!=4) && (portcount!=8))) {
-#ifdef ISICOM_DEBUG
-				printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
-#endif
-				printk("\nISILoad:PCI Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
-				return -EIO;
-			}
-		}
-		switch(signature) {
-		case	0xa5:
-		case	0xbb:
-		case	0xdd:
-				if (isi_card[card].isa)
-					isi_card[card].port_count = 8;
-				else {
-					if (portcount == 4)
-						isi_card[card].port_count = 4;
-					else
-						isi_card[card].port_count = 8;
-				}
-				isi_card[card].shift_count = 12;
-				break;
-
-		case	0xcc:	isi_card[card].port_count = 16;
-				isi_card[card].shift_count = 11;
-				break;
-
-		default: printk("ISILoad:Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
-#ifdef ISICOM_DEBUG
-			printk("Sig=0x%x\n",signature);
-#endif
-			return -EIO;
-		}
-		printk("-Done\n");
-		return put_user(signature,(unsigned __user *)argp);
-
-	case	MIOCTL_LOAD_FIRMWARE:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-
-			if (copy_from_user(&frame, argp, sizeof(bin_frame)))
-				return -EFAULT;
-
-			if (WaitTillCardIsFree(base))
-				return -EIO;
-
-			outw(0xf0,base); /* start upload sequence */
-			outw(0x00,base);
-			outw((frame.addr), base); /* lsb of adderess */
-
-			word_count=(frame.count >> 1) + frame.count % 2;
-			outw(word_count, base);
-			InterruptTheCard(base);
-
-			for (i=0;i<=0x2f;i++);	/* a wee bit of delay */
-
-			if (WaitTillCardIsFree(base))
-				return -EIO;
-
-			if ((status=inw(base+0x4))!=0) {
-				printk(KERN_WARNING "ISILoad:Card%d rejected load header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n",
-				card+1, frame.addr, frame.count, status);
-				return -EIO;
-			}
-			outsw(base, (void *) frame.bin_data, word_count);
-
-			InterruptTheCard(base);
-
-			for (i=0;i<=0x0f;i++);	/* another wee bit of delay */
-
-			if (WaitTillCardIsFree(base))
-				return -EIO;
-
-			if ((status=inw(base+0x4))!=0) {
-				printk(KERN_ERR "ISILoad:Card%d got out of sync.Card Status:0x%x\n",card+1, status);
-				return -EIO;
-			}
-			return 0;
-
-	case	MIOCTL_READ_FIRMWARE:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-
-			if (copy_from_user(&frame, argp, sizeof(bin_header)))
-				return -EFAULT;
-
-			if (WaitTillCardIsFree(base))
-				return -EIO;
-
-			outw(0xf1,base); /* start download sequence */
-			outw(0x00,base);
-			outw((frame.addr), base); /* lsb of adderess */
-
-			word_count=(frame.count >> 1) + frame.count % 2;
-			outw(word_count+1, base);
-			InterruptTheCard(base);
-
-			for (i=0;i<=0xf;i++);	/* a wee bit of delay */
-
-			if (WaitTillCardIsFree(base))
-				return -EIO;
-
-			if ((status=inw(base+0x4))!=0) {
-				printk(KERN_WARNING "ISILoad:Card%d rejected verify header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n",
-				card+1, frame.addr, frame.count, status);
-				return -EIO;
-			}
-
-			inw(base);
-			insw(base, frame.bin_data, word_count);
-			InterruptTheCard(base);
-
-			for (i=0;i<=0x0f;i++);	/* another wee bit of delay */
-
-			if (WaitTillCardIsFree(base))
-				return -EIO;
-
-			if ((status=inw(base+0x4))!=0) {
-				printk(KERN_ERR "ISILoad:Card%d verify got out of sync.Card Status:0x%x\n",card+1, status);
-				return -EIO;
-			}
-
-			if (copy_to_user(argp, &frame, sizeof(bin_frame)))
-				return -EFAULT;
-			return 0;
-
-	case	MIOCTL_XFER_CTRL:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-			if (WaitTillCardIsFree(base))
-				return -EIO;
-
-			outw(0xf2, base);
-			outw(0x800, base);
-			outw(0x0, base);
-			outw(0x0, base);
-			InterruptTheCard(base);
-			outw(0x0, base+0x4); /* for ISI4608 cards */
-
-			isi_card[card].status |= FIRMWARE_LOADED;
-			return 0;
-
-	default:
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISILoad: Received Ioctl cmd 0x%x.\n", cmd);
-#endif
-		return -ENOIOCTLCMD;
-	}
-}
-
-
 /*
  *	ISICOM Driver specific routines ...
  *
@@ -1946,6 +1717,174 @@ end:
 	return retval;
 }
 
+static inline int WaitTillCardIsFree(u16 base)
+{
+	unsigned long count=0;
+	while( (!(inw(base+0xe) & 0x1)) && (count++ < 6000000));
+	if (inw(base+0xe)&0x1)
+		return 0;
+	else
+		return 1;
+}
+
+static int __devinit load_firmware(struct isi_board *board,
+	const unsigned int index, const unsigned int signature)
+{
+	int retval = -EIO;
+	unsigned int a;
+	char *name;
+	u8 *data;
+	u16 word_count, status, base = board->base;
+	const struct firmware *fw;
+	struct stframe {
+		u16	addr;
+		u16	count;
+		u8	data[0];
+	} *frame;
+
+	switch (signature) {
+	case 0xa5:
+		name = "isi608.bin";
+		break;
+	case 0xbb:
+		name = "isi608em.bin";
+		break;
+	case 0xcc:
+		name = "isi616em.bin";
+		break;
+	case 0xdd:
+		name = "isi4608.bin";
+		break;
+	case 0xee:
+		name = "isi4616.bin";
+		break;
+	default:
+		printk(KERN_ERR "Unknown signature.\n");
+		goto end;
+ 	}
+
+	retval = request_firmware(&fw, name, &board->device);
+	if (retval)
+		goto end;
+
+	for (frame = (struct stframe*)fw->data;
+			frame < (struct stframe*)(fw->data + fw->size);
+			frame++) {
+		if (WaitTillCardIsFree(base))
+			goto errrelfw;
+
+		outw(0xf0, base);	/* start upload sequence */
+		outw(0x00, base);
+		outw(frame->addr, base); /* lsb of address */
+
+		word_count = frame->count / 2 + frame->count % 2;
+		outw(word_count, base);
+		InterruptTheCard(base);
+
+		udelay(100); /* 0x2f */
+
+		if (WaitTillCardIsFree(base))
+			goto errrelfw;
+
+		if ((status = inw(base + 0x4)) != 0) {
+			printk(KERN_WARNING "ISILoad:Card%d rejected load "
+				"header:\nAddress:0x%x \nCount:0x%x \n"
+				"Status:0x%x \n", index + 1, frame->addr,
+				frame->count, status);
+			goto errrelfw;
+		}
+		outsw(base, frame->data, word_count);
+
+		InterruptTheCard(base);
+
+		udelay(50); /* 0x0f */
+
+		if (WaitTillCardIsFree(base))
+			goto errrelfw;
+
+		if ((status = inw(base + 0x4)) != 0) {
+			printk(KERN_ERR "ISILoad:Card%d got out of sync.Card "
+				"Status:0x%x\n", index + 1, status);
+			goto errrelfw;
+		}
+ 	}
+
+	retval = -EIO;
+
+	if (WaitTillCardIsFree(base))
+		goto errrelfw;
+
+	outw(0xf2, base);
+	outw(0x800, base);
+	outw(0x0, base);
+	outw(0x0, base);
+	InterruptTheCard(base);
+	outw(0x0, base + 0x4); /* for ISI4608 cards */
+
+/* XXX: should we test it by reading it back and comparing with original like
+ * in load firmware package? */
+	for (frame = (struct stframe*)fw->data;
+			frame < (struct stframe*)(fw->data + fw->size);
+			frame++) {
+		if (WaitTillCardIsFree(base))
+			goto errrelfw;
+
+		outw(0xf1, base); /* start download sequence */
+		outw(0x00, base);
+		outw(frame->addr, base); /* lsb of address */
+
+		word_count = (frame->count >> 1) + frame->count % 2;
+		outw(word_count + 1, base);
+		InterruptTheCard(base);
+
+		udelay(50); /* 0xf */
+
+		if (WaitTillCardIsFree(base))
+			goto errrelfw;
+
+		if ((status = inw(base + 0x4)) != 0) {
+			printk(KERN_WARNING "ISILoad:Card%d rejected verify "
+				"header:\nAddress:0x%x \nCount:0x%x\nStatus: "
+				"0x%x \n", index + 1, frame->addr, frame->count,
+				status);
+			goto errrelfw;
+		}
+
+		data = kmalloc(word_count * 2, GFP_KERNEL);
+		inw(base);
+		insw(base, data, word_count);
+		InterruptTheCard(base);
+
+		for (a = 0; a < frame->count; a++)
+			if (data[a] != frame->data[a]) {
+				kfree(data);
+				printk(KERN_ERR "ISILoad:Card%d, firmware "
+					"upload failed\n", index + 1);
+				goto errrelfw;
+			}
+		kfree(data);
+
+		udelay(50); /* 0xf */
+
+		if (WaitTillCardIsFree(base))
+			goto errrelfw;
+
+		if ((status = inw(base + 0x4)) != 0) {
+			printk(KERN_ERR "ISILoad:Card%d verify got out of "
+				"sync. Card Status:0x%x\n", index + 1, status);
+			goto errrelfw;
+		}
+	}
+
+	board->status |= FIRMWARE_LOADED;
+	retval = 0;
+
+errrelfw:
+	release_firmware(fw);
+end:
+	return retval;
+}
+
 /*
  *	Insmod can set static symbols so keep these static
  */
@@ -1994,9 +1933,9 @@ static int __devinit isicom_probe(struct
 	if (retval < 0)
 		goto errunri;
 
-/*	retval = load_firmware(board, index, signature);
+	retval = load_firmware(board, index, signature);
 	if (retval < 0)
-		goto errunri; */
+		goto errunri;
 
 	return 0;
 
@@ -2083,10 +2022,6 @@ static int __devinit isicom_setup(void)
 		goto errtty;
 	}
 
-	retval = misc_register(&isiloader_device);
-	if (retval < 0)
-		goto errpci;
-
 	init_timer(&tx);
 	tx.expires = jiffies + 1;
 	tx.data = 0;
@@ -2095,8 +2030,6 @@ static int __devinit isicom_setup(void)
 	add_timer(&tx);
 
 	return 0;
-errpci:
-	pci_unregister_driver(&isicom_driver);
 errtty:
 	isicom_unregister_tty_driver();
 error:
diff --git a/include/linux/isicom.h b/include/linux/isicom.h
--- a/include/linux/isicom.h
+++ b/include/linux/isicom.h
@@ -4,46 +4,11 @@
 /*#define		ISICOM_DEBUG*/
 /*#define		ISICOM_DEBUG_DTR_RTS*/
 
-
-/*
- *	Firmware Loader definitions ...
- */
- 
-#define		__MultiTech		('M'<<8)
-#define		MIOCTL_LOAD_FIRMWARE	(__MultiTech | 0x01)
-#define         MIOCTL_READ_FIRMWARE    (__MultiTech | 0x02)
-#define         MIOCTL_XFER_CTRL	(__MultiTech | 0x03)
-#define         MIOCTL_RESET_CARD	(__MultiTech | 0x04)
-
-#define		DATA_SIZE	16
-
-typedef	struct	{
-		unsigned short	exec_segment;
-		unsigned short	exec_addr;
-}	exec_record;
-
-typedef	struct	{
-		int		board;		/* Board to load */
-		unsigned short	addr;
-		unsigned short	count;
-}	bin_header;
-
-typedef	struct	{
-		int		board;		/* Board to load */
-		unsigned short	addr;
-		unsigned short	count;
-		unsigned short	segment;
-		unsigned char	bin_data[DATA_SIZE];
-}	bin_frame;
-
 #ifdef __KERNEL__
 
 #define		YES	1
 #define		NO	0
 
-#define		ISILOAD_MISC_MINOR	155	/* /dev/isctl */
-#define		ISILOAD_NAME		"ISILoad"
-
 /*	
  *  ISICOM Driver definitions ...
  *
