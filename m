Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313315AbSDYV44>; Thu, 25 Apr 2002 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313328AbSDYV4z>; Thu, 25 Apr 2002 17:56:55 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:59144 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313315AbSDYV4r>;
	Thu, 25 Apr 2002 17:56:47 -0400
Date: Thu, 25 Apr 2002 17:56:42 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/char/pcwd.c
Message-ID: <Pine.LNX.4.33.0204251752030.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The attached patch against 2.4.19-pre7 is pretty much a complete rewrite
of drivers/char/pcwd.c done by Lindsay Harris.  The rewrite has been in
Alan's tree for a while now, and seems to work Ok.  The patch below also
includes expect close support and the WDIOC_GETTIMEOUT ioctl.

Regards,
Rob Radez

--- linux-2.4.19-pre7/drivers/char/pcwd.c	Tue Apr 16 13:18:17 2002
+++ watchdog-tree/drivers/char/pcwd.c	Sat Apr 20 18:42:58 2002
@@ -40,57 +40,69 @@
  *		fairly useless proc entry.
  * 990610	removed said useless proc code for the merge <alan>
  * 000403	Removed last traces of proc code. <davej>
- * 020210	Backported 2.5 open_allowed changes, and got rid of a useless
- *		variable <rob@osinvestor.com>
+ * 011214	Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT <Matt_Domsch@dell.com>
+ * 020210       Backported 2.5 open_allowed changes, and got rid of a useless
+ *              variable <rob@osinvestor.com>
+ *              Added timeout module option to override default
+ * 020306	Support the PCI version [Lindsay Harris <lindsay@bluegum.com>]
+ * 020412	Added expect close support and WDIOC_GETTIMEOUT <rob@osinvestor.com
  */

+/*
+ *  A bells and whistles driver is available from http://www.pcwd.de/
+ */
 #include <linux/module.h>

 #include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/tty.h>
-#include <linux/timer.h>
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/wait.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/miscdevice.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/spinlock.h>
-#include <linux/smp_lock.h>

 #include <asm/uaccess.h>
 #include <asm/io.h>

-/*
- * These are the auto-probe addresses available.
- *
- * Revision A only uses ports 0x270 and 0x370.  Revision C introduced 0x350.
- * Revision A has an address range of 2 addresses, while Revision C has 3.
- */
-static int pcwd_ioports[] = { 0x270, 0x350, 0x370, 0x000 };
-
-#define WD_VER                  "1.10 (06/05/99)"
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+
+#define WD_VER                  "1.13 (03/06/2002)"
+
+/*  Stuff for the PCI version  */
+#ifndef	PCI_VENDOR_ID_QUICKLOGIC
+#define	PCI_VENDOR_ID_QUICKLOGIC	0x11e3
+#endif
+#ifndef	PCI_DEVICE_ID_BERKSHIRE
+#define	PCI_DEVICE_ID_BERKSHIRE	0x5030
+#endif

 /*
- * It should be noted that PCWD_REVISION_B was removed because A and B
+ * It should be noted that PCWD_REV_B was removed because A and B
  * are essentially the same types of card, with the exception that B
  * has temperature reporting.  Since I didn't receive a Rev.B card,
  * the Rev.B card is not supported.  (It's a good thing too, as they
  * are no longer in production.)
  */
-#define	PCWD_REVISION_A		1
-#define	PCWD_REVISION_C		2
+#define	PCWD_REV_A	0
+#define	PCWD_REV_C	1
+#define	PCWD_REV_PCI	2
+
+static int timeout_val;
+static int timeout = 2;
+static char pcwd_expect_close;
+
+MODULE_PARM (timeout, "i");
+MODULE_PARM_DESC (timeout, "Watchdog probe timeout in seconds (default=2)");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif

-#define	WD_TIMEOUT		3	/* 1 1/2 seconds for a timeout */
+MODULE_PARM (nowayout, "i");
+MODULE_PARM_DESC (nowayout,
+		  "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");

 /*
  * These are the defines for the PC Watchdog card, revision A.
@@ -101,333 +113,329 @@
 #define WD_RLY2                 0x08	/* External relay triggered */
 #define WD_SRLY2                0x80	/* Software external relay triggered */

-static int current_readport, revision, temp_panic;
-static atomic_t open_allowed = ATOMIC_INIT(1);
-static int initial_status, supports_temp, mode_debug;
-static spinlock_t io_lock;
-
 /*
- * PCWD_CHECKCARD
- *
- * This routine checks the "current_readport" to see if the card lies there.
- * If it does, it returns accordingly.
+ *  Differences between cards regarding how they perform some operations
+ *  are handled by an array of structs, with per card functions for the
+ *  incompatible operations.  It's all defined here.
  */
-static int __init pcwd_checkcard(void)
-{
-	int card_dat, prev_card_dat, found = 0, count = 0, done = 0;

-	/* As suggested by Alan Cox - this is a safety measure. */
-	if (check_region(current_readport, 4)) {
-		printk("pcwd: Port 0x%x unavailable.\n", current_readport);
-		return 0;
-	}
+/*  ENABLE/DISABLE the card  */
+typedef int (*fn_enable) (int);	/* Enable/disable card */

-	card_dat = 0x00;
-	prev_card_dat = 0x00;
+static int pcwd_enable_card (int enable);	/* Actually works */
+static int pcwd_enable_nop (int enable);	/* NOP - REV A cannot */

-	prev_card_dat = inb(current_readport);
-	if (prev_card_dat == 0xFF)
-		return 0;
+/* Obtain firmware version, if possible */
+#define	PCWD_FIRMWARE_BSZ	16	/* Version buffer size */
+typedef void (*fn_firmware) (char *bp);
+
+static void pcwd_firmware_ver_none (char *bp);	/* REV A can't do it */
+static void pcwd_firmware_ver_revc (char *bp);	/* REV C boards can */
+static void pcwd_firmware_ver_pci (char *bp);	/* PCI boards can too */
+
+/*  Tickle the watchdog timer */
+typedef void (*fn_tickle) (void);
+
+static void pcwd_tickle_reva (void);	/* Rev A only */
+static void pcwd_tickle (void);	/* Rev C, PCI */
+
+/*  Determine reboot and temperature status */
+typedef int (*fn_status) (int reset_boot);
+
+static int pcwd_get_stat_reva (int reset_boot);
+static int pcwd_get_stat (int reset_boot);
+
+/*  Per card type specifications */
+typedef struct {
+	fn_tickle wd_tickle;	/* Reset the watchdog */
+	fn_enable enable_card;	/* Enable/disable card, if possible */
+	fn_firmware firmware_ver;	/* Get firmware version, if possible */
+	fn_status wd_status;	/* Card reset and/or over temp */
+	int io_size;		/* I/O space used */
+	const char *name;	/* Nice name to display */
+} PCWD_CARD_INFO;

-	while(count < WD_TIMEOUT) {
-
-	/* Read the raw card data from the port, and strip off the
-	   first 4 bits */
-
-		card_dat = inb_p(current_readport);
-		card_dat &= 0x000F;
-
-	/* Sleep 1/2 second (or 500000 microseconds :) */
-
-		mdelay(500);
-		done = 0;
+/* Per card information, indexed by card version ID */
+static PCWD_CARD_INFO pcwd_card_info[] = {
+	{
+	 pcwd_tickle_reva,
+	 pcwd_enable_nop,
+	 pcwd_firmware_ver_none,
+	 pcwd_get_stat_reva,
+	 2,
+	 "Berkshire Products PC Watchdog (REV A)",
+	 },
+	{
+	 pcwd_tickle,
+	 pcwd_enable_card,
+	 pcwd_firmware_ver_revc,
+	 pcwd_get_stat,
+	 4,
+	 "Berkshire Products PC Watchdog (REV C)",
+	 },
+	{
+	 pcwd_tickle,
+	 pcwd_enable_card,
+	 pcwd_firmware_ver_pci,
+	 pcwd_get_stat,
+	 8,
+	 "Berkshire Products PC Watchdog (PCI)",
+	 },
+};

-	/* If there's a heart beat in both instances, then this means we
-	   found our card.  This also means that either the card was
-	   previously reset, or the computer was power-cycled. */
+/*  Overall driver information, including per card pointer */
+static struct {
+	PCWD_CARD_INFO *card_info;	/* Points to one of the above */
+	atomic_t open_allowed;	/* Watchdog is single open */
+	int flags;		/* Defined below */
+	int boot_status;	/* Card status at boot time */
+	int io_addr;		/* Card's base address */
+} pcwd_info = {
+NULL, ATOMIC_INIT (1), 0, 0, 0};
+
+/*  Bits allocated in flags above. */
+#define	PCWD_HAS_TEMP	0x0001	/* Set when thermometer available */
+#define	PCWD_PCI_REG	0x0002	/* Set if PCI register code worked */
+#define	PCWD_TEMP_PANIC	0x0004	/* Panic when over temperature */

-		if ((card_dat & WD_HRTBT) && (prev_card_dat & WD_HRTBT) &&
-			(!done)) {
-			found = 1;
-			done = 1;
-			break;
-		}
+static spinlock_t io_lock;

-	/* If the card data is exactly the same as the previous card data,
-	   it's safe to assume that we should check again.  The manual says
-	   that the heart beat will change every second (or the bit will
-	   toggle), and this can be used to see if the card is there.  If
-	   the card was powered up with a cold boot, then the card will
-	   not start blinking until 2.5 minutes after a reboot, so this
-	   bit will stay at 1. */
-
-		if ((card_dat == prev_card_dat) && (!done)) {
-			count++;
-			done = 1;
-		}
+/* D E T E R M I N E   C A R D   S T A T U S   F U N C T I O N S  */
+/*   Rev A cards return status information from the base register,
+ * which is used for the temperature in other cards.  */
+
+static int
+pcwd_get_stat_reva (int reset_boot)
+{
+	int retval;
+	int status;
+
+	spin_lock (&io_lock);
+	status = inb_p (pcwd_info.io_addr);
+	spin_unlock (&io_lock);
+
+	/* Transform the card register to the ioctl bits we use internally */
+	retval = 0;
+	if (status & WD_WDRST)
+		retval |= WDIOF_CARDRESET;
+	if (status & WD_T110)
+		retval |= WDIOF_OVERHEAT;

-	/* If the card data is toggling any bits, this means that the heart
-	   beat was detected, or something else about the card is set. */
+	return retval;
+}

-		if ((card_dat != prev_card_dat) && (!done)) {
-			done = 1;
-			found = 1;
-			break;
-		}
+/*
+ *  Rev C and PCI cards return card status in the base address + 1 register.
+ *  And use different bits to indicate a card initiated reset, and
+ *  an over-temperature condition.  And the reboot status can be reset.
+ */

-	/* Otherwise something else strange happened. */
+static int
+pcwd_get_stat (int reset_boot)
+{
+	int retval;
+	int status;

-		if (!done)
-			count++;
+	spin_lock (&io_lock);
+	status = inb_p (pcwd_info.io_addr + 1);
+	if (reset_boot) {
+		/*  NOTE:  the REV C card clears the "card caused reboot"
+		 * flag when writing ANY value to this port.  However,
+		 * the PCI card requires writing a 1 to bit 0.  */
+		outb_p (0x01, pcwd_info.io_addr + 1);
 	}
+	spin_unlock (&io_lock);

-	return((found) ? 1 : 0);
-}
-
-void pcwd_showprevstate(void)
-{
-	int card_status = 0x0000;
+	retval = 0;
+	if (status & 0x01)
+		retval |= WDIOF_CARDRESET;
+	if (status & 0x04)
+		retval |= WDIOF_OVERHEAT;

-	if (revision == PCWD_REVISION_A)
-		initial_status = card_status = inb(current_readport);
-	else {
-		initial_status = card_status = inb(current_readport + 1);
-		outb_p(0x00, current_readport + 1); /* clear reset status */
-	}
+	return retval;
+}

-	if (revision == PCWD_REVISION_A) {
-		if (card_status & WD_WDRST)
-			printk("pcwd: Previous reboot was caused by the card.\n");
+/*  W A T C H D O G   T I M E R   R E S E T   F U N C T I O N S   */
+/*  Rev A cards are reset by setting a specific bit in register 1.  */

-		if (card_status & WD_T110) {
-			printk("pcwd: Card senses a CPU Overheat.  Panicking!\n");
-			panic("pcwd: CPU Overheat.\n");
-		}
+static void
+pcwd_tickle_reva (void)
+{
+	int wdrst_stat;

-		if ((!(card_status & WD_WDRST)) &&
-		    (!(card_status & WD_T110)))
-			printk("pcwd: Cold boot sense.\n");
-	} else {
-		if (card_status & 0x01)
-			printk("pcwd: Previous reboot was caused by the card.\n");
+	spin_lock (&io_lock);
+	wdrst_stat = inb_p (pcwd_info.io_addr);
+	wdrst_stat = (wdrst_stat & 0x0F) | WD_WDRST;

-		if (card_status & 0x04) {
-			printk("pcwd: Card senses a CPU Overheat.  Panicking!\n");
-			panic("pcwd: CPU Overheat.\n");
-		}
+	outb_p (wdrst_stat, pcwd_info.io_addr + 1);
+	spin_unlock (&io_lock);

-		if ((!(card_status & 0x01)) &&
-		    (!(card_status & 0x04)))
-			printk("pcwd: Cold boot sense.\n");
-	}
+	return;
 }

-static void pcwd_send_heartbeat(void)
-{
-	int wdrst_stat;
-
-	wdrst_stat = inb_p(current_readport);
-	wdrst_stat &= 0x0F;
+/*  Other cards are reset by writing anything to the base register.  */

-	wdrst_stat |= WD_WDRST;
+static void
+pcwd_tickle (void)
+{
+	spin_lock (&io_lock);
+	outb_p (0x42, pcwd_info.io_addr);
+	spin_unlock (&io_lock);

-	if (revision == PCWD_REVISION_A)
-		outb_p(wdrst_stat, current_readport + 1);
-	else
-		outb_p(wdrst_stat, current_readport);
+	return;
 }

-static int pcwd_ioctl(struct inode *inode, struct file *file,
-		      unsigned int cmd, unsigned long arg)
+static int
+pcwd_ioctl (struct inode *inode, struct file *file,
+	    unsigned int cmd, unsigned long arg)
 {
-	int cdat, rv;
-	static struct watchdog_info ident=
-	{
-		WDIOF_OVERHEAT|WDIOF_CARDRESET,
-		1,
-		"PCWD"
-	};
+	int rv;
+	int retval;

-	switch(cmd) {
-	default:
-		return -ENOTTY;
+	static struct watchdog_info ident = {
+		options:		WDIOF_OVERHEAT | WDIOF_CARDRESET,
+		firmware_version:	1,
+		identity:		"PCWD"
+	};

+	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		if(copy_to_user((void*)arg, &ident, sizeof(ident)))
-			return -EFAULT;
-		return 0;
+		rv = copy_to_user ((void *) arg, &ident, sizeof (ident));
+		return rv ? -EFAULT : 0;

 	case WDIOC_GETSTATUS:
-		spin_lock(&io_lock);
-		if (revision == PCWD_REVISION_A)
-			cdat = inb(current_readport);
-		else
-			cdat = inb(current_readport + 1 );
-		spin_unlock(&io_lock);
-		rv = 0;
-
-		if (revision == PCWD_REVISION_A)
-		{
-			if (cdat & WD_WDRST)
-				rv |= WDIOF_CARDRESET;
-
-			if (cdat & WD_T110)
-			{
-				rv |= WDIOF_OVERHEAT;
-
-				if (temp_panic)
-					panic("pcwd: Temperature overheat trip!\n");
-			}
-		}
-		else
-		{
-			if (cdat & 0x01)
-				rv |= WDIOF_CARDRESET;
-
-			if (cdat & 0x04)
-			{
-				rv |= WDIOF_OVERHEAT;
+		rv = pcwd_info.card_info->wd_status (0);

-				if (temp_panic)
-					panic("pcwd: Temperature overheat trip!\n");
-			}
+		if (rv & WDIOF_OVERHEAT) {
+			if (pcwd_info.flags & PCWD_TEMP_PANIC)
+				panic ("pcwd: Temperature overheat trip!\n");
 		}

-		if(put_user(rv, (int *) arg))
+		if (put_user (rv, (int *) arg))
 			return -EFAULT;
 		return 0;

 	case WDIOC_GETBOOTSTATUS:
-		rv = 0;
-
-		if (revision == PCWD_REVISION_A)
-		{
-			if (initial_status & WD_WDRST)
-				rv |= WDIOF_CARDRESET;
+		rv = pcwd_info.boot_status;

-			if (initial_status & WD_T110)
-				rv |= WDIOF_OVERHEAT;
-		}
-		else
-		{
-			if (initial_status & 0x01)
-				rv |= WDIOF_CARDRESET;
-
-			if (initial_status & 0x04)
-				rv |= WDIOF_OVERHEAT;
-		}
-
-		if(put_user(rv, (int *) arg))
+		if (put_user (rv, (int *) arg))
 			return -EFAULT;
 		return 0;

 	case WDIOC_GETTEMP:
-
 		rv = 0;
-		if ((supports_temp) && (mode_debug == 0))
-		{
-			spin_lock(&io_lock);
-			rv = inb(current_readport);
-			spin_unlock(&io_lock);
-			if(put_user(rv, (int*) arg))
-				return -EFAULT;
-		} else if(put_user(rv, (int*) arg))
-				return -EFAULT;
+		if (pcwd_info.flags & PCWD_HAS_TEMP) {
+			spin_lock (&io_lock);
+			rv = inb_p (pcwd_info.io_addr);
+			spin_unlock (&io_lock);
+		}
+		if (put_user (rv, (int *) arg))
+			return -EFAULT;
 		return 0;

 	case WDIOC_SETOPTIONS:
-		if (revision == PCWD_REVISION_C)
-		{
-			if(copy_from_user(&rv, (int*) arg, sizeof(int)))
-				return -EFAULT;
-
-			if (rv & WDIOS_DISABLECARD)
-			{
-				spin_lock(&io_lock);
-				outb_p(0xA5, current_readport + 3);
-				outb_p(0xA5, current_readport + 3);
-				cdat = inb_p(current_readport + 2);
-				spin_unlock(&io_lock);
-				if ((cdat & 0x10) == 0)
-				{
-					printk("pcwd: Could not disable card.\n");
-					return -EIO;
-				}
+		if (copy_from_user (&rv, (int *) arg, sizeof (int)))
+			return -EFAULT;

-				return 0;
-			}
+		retval = -EINVAL;

-			if (rv & WDIOS_ENABLECARD)
-			{
-				spin_lock(&io_lock);
-				outb_p(0x00, current_readport + 3);
-				cdat = inb_p(current_readport + 2);
-				spin_unlock(&io_lock);
-				if (cdat & 0x10)
-				{
-					printk("pcwd: Could not enable card.\n");
-					return -EIO;
-				}
-				return 0;
+		if (rv & WDIOS_DISABLECARD) {
+			if (!pcwd_info.card_info->enable_card (0)) {
+				printk (KERN_EMERG
+					"pcwd: Could not disable card\n");
+				return -EIO;
 			}

-			if (rv & WDIOS_TEMPPANIC)
-			{
-				temp_panic = 1;
+			retval = 0;
+		}
+
+		if (rv & WDIOS_ENABLECARD) {
+			if (!pcwd_info.card_info->enable_card (1)) {
+				printk (KERN_EMERG
+					"pcwd: Could not enable card\n");
+				return -EIO;
 			}
+			retval = 0;
+		}
+
+		if (rv & WDIOS_TEMPPANIC) {
+			pcwd_info.flags |= PCWD_TEMP_PANIC;
+
+			retval = 0;
 		}
-		return -EINVAL;
-
+
+		return retval;
+
 	case WDIOC_KEEPALIVE:
-		pcwd_send_heartbeat();
+		pcwd_info.card_info->wd_tickle ();
 		return 0;
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(0, (int *)arg);
+
+	default:
+		return -ENOTTY;
 	}

 	return 0;
 }

-static ssize_t pcwd_write(struct file *file, const char *buf, size_t len,
-			  loff_t *ppos)
+/*   Write:  only for the watchdog device (thermometer is read-only).  */
+
+static ssize_t
+pcwd_write (struct file *file, const char *buf, size_t len, loff_t * ppos)
 {
 	/*  Can't seek (pwrite) on this device  */
 	if (ppos != &file->f_pos)
 		return -ESPIPE;

-	if (len)
-	{
-		pcwd_send_heartbeat();
-		return 1;
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			pcwd_expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				if (buf[i] == 'V')
+					pcwd_expect_close = 42;
+			}
+		}
+
+		pcwd_info.card_info->wd_tickle ();
 	}
-	return 0;
+	return len;
 }

-static int pcwd_open(struct inode *ino, struct file *filep)
+static int
+pcwd_open (struct inode *ino, struct file *filep)
 {
-        switch (MINOR(ino->i_rdev))
-        {
-                case WATCHDOG_MINOR:
-                    if (!atomic_dec_and_test(&open_allowed)){
-                        atomic_inc(&open_allowed);
-                        return -EBUSY;
-                    }
-                    MOD_INC_USE_COUNT;
-                    /*  Enable the port  */
-                    if (revision == PCWD_REVISION_C)
-                    {
-                    	spin_lock(&io_lock);
-                    	outb_p(0x00, current_readport + 3);
-                    	spin_unlock(&io_lock);
-                    }
-                    return(0);
-                case TEMP_MINOR:
-                    return(0);
-                default:
-                    return (-ENODEV);
-        }
+	switch (MINOR (ino->i_rdev)) {
+	case WATCHDOG_MINOR:
+		if (!atomic_dec_and_test (&pcwd_info.open_allowed)) {
+			atomic_inc (&pcwd_info.open_allowed);
+			return -EBUSY;
+		}
+
+		/*  Enable the card  */
+		pcwd_info.card_info->enable_card (1);
+		pcwd_info.card_info->wd_tickle ();
+
+		return 0;
+
+	case TEMP_MINOR:
+		if (pcwd_info.flags & PCWD_HAS_TEMP) {
+			return 0;
+		}
+		return -ENODEV;
+
+	default:
+		return -ENODEV;
+	}
 }

-static ssize_t pcwd_read(struct file *file, char *buf, size_t count,
-			 loff_t *ppos)
+/*	Read:  applies only to the thermometer (watchdog is write only).  */
+static ssize_t
+pcwd_read (struct file *file, char *buf, size_t count, loff_t * ppos)
 {
 	unsigned short c;
 	unsigned char cp;
@@ -435,230 +443,507 @@
 	/*  Can't seek (pread) on this device  */
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
-	switch(MINOR(file->f_dentry->d_inode->i_rdev))
-	{
-		case TEMP_MINOR:
-			/*
-			 * Convert metric to Fahrenheit, since this was
-			 * the decided 'standard' for this return value.
-			 */
-
-			c = inb(current_readport);
-			cp = (c * 9 / 5) + 32;
-			if(copy_to_user(buf, &cp, 1))
-				return -EFAULT;
-			return 1;
-		default:
-			return -EINVAL;
+
+	/*
+	 * Convert celsius to fahrenheit, since this was
+	 * the decided 'standard' for this return value.
+	 */
+
+	spin_lock (&io_lock);
+	c = inb_p (pcwd_info.io_addr);
+	spin_unlock (&io_lock);
+
+	cp = (c * 9 / 5) + 32;
+	if (copy_to_user (buf, &cp, 1))
+		return -EFAULT;
+
+	return 1;
+}
+
+static int
+pcwd_close (struct inode *ino, struct file *filep)
+{
+	switch (MINOR (ino->i_rdev)) {
+	case WATCHDOG_MINOR:
+		if (!nowayout && pcwd_expect_close == 42)
+			pcwd_info.card_info->enable_card (0);
+
+		atomic_inc (&pcwd_info.open_allowed);
+		pcwd_expect_close = 0;
+		break;
+
+	case TEMP_MINOR:
+		break;
+	}
+	return 0;
+}
+
+/*
+ *  System is shutting down, so disable the card.  Otherwise the timeout
+ * may expire during shutdown.  Of course, this means a hang during
+ * shutdown will not be reset, but somebody is probably nearby and will
+ * notice.  The alternative is to have the shutdown aborted when the
+ * watchdog expires and hits reset.
+ */
+
+static int
+pcwd_notify_sys (struct notifier_block *this, unsigned long code, void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/*
+		 *  If initialisation is still in progress, the device pointer
+		 * may not be valid, so check, just to make sure.
+		 */
+
+		if (pcwd_info.card_info)
+			pcwd_info.card_info->enable_card (0);
 	}
+
+	return NOTIFY_DONE;
 }

-static int pcwd_close(struct inode *ino, struct file *filep)
+/*  C A R D   E N A B L E / D I S A B L E   F U N C T I O N S  */
+/*  Enable/disable the card, not REV A.  The two writes are required by card */
+
+static int
+pcwd_enable_card (int enable)
 {
-	if (MINOR(ino->i_rdev)==WATCHDOG_MINOR)
-	{
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		/*  Disable the board  */
-		if (revision == PCWD_REVISION_C) {
-			spin_lock(&io_lock);
-			outb_p(0xA5, current_readport + 3);
-			outb_p(0xA5, current_readport + 3);
-			spin_unlock(&io_lock);
-		}
-#endif
-		atomic_inc(&open_allowed);
+	int stat_reg;
+
+	spin_lock (&io_lock);
+	if (enable) {
+		outb_p (0x00, pcwd_info.io_addr + 3);
+	} else {
+		outb_p (0xA5, pcwd_info.io_addr + 3);
+		outb_p (0xA5, pcwd_info.io_addr + 3);
 	}
+	stat_reg = inb_p (pcwd_info.io_addr + 2);
+	spin_unlock (&io_lock);
+
+	stat_reg &= 0x10;	/* "disabled when set" bit */
+	if (enable) {
+		stat_reg ^= 0x10;
+	}
+
+	return stat_reg;
+}
+
+static int
+pcwd_enable_nop (int enable)
+{
 	return 0;
 }

-static inline void get_support(void)
+static void __init
+set_card_type (int is_pci)
 {
-	if (inb(current_readport) != 0xF0)
-		supports_temp = 1;
+
+	if (is_pci) {
+		pcwd_info.card_info = &pcwd_card_info[PCWD_REV_PCI];
+		pcwd_info.flags |= PCWD_PCI_REG;
+	} else {
+		pcwd_info.card_info = &pcwd_card_info[PCWD_REV_C];
+
+		/* REV A cards use only 2 io ports; test
+		 * presumes a floating bus reads as 0xff.  */
+		if ((inb (pcwd_info.io_addr + 2) == 0xFF) ||
+		    (inb (pcwd_info.io_addr + 3) == 0xFF)) {
+			pcwd_info.card_info = &pcwd_card_info[PCWD_REV_A];
+		}
+	}
+
+	return;
 }

-static inline int get_revision(void)
+/* G E T    F I R M W A R E   V E R S I O N   F U N C T I O N S    */
+/* REV A can't do it */
+static void __init
+pcwd_firmware_ver_none (char *bp)
 {
-	int r = PCWD_REVISION_C;
-
-	spin_lock(&io_lock);
-	if ((inb(current_readport + 2) == 0xFF) ||
-	    (inb(current_readport + 3) == 0xFF))
-		r=PCWD_REVISION_A;
-	spin_unlock(&io_lock);
+	strncpy (bp, "<unavailable>", PCWD_FIRMWARE_BSZ);

-	return r;
+	return;
 }

-static int __init send_command(int cmd)
+/* PCI boards can too */
+static void __init
+pcwd_firmware_ver_pci (char *bp)
 {
-	int i;
+	int count;
+
+	/* Write the 'Get Firmware Version' command to port 6 and wait */
+	outb (0x08, pcwd_info.io_addr + 6);
+
+	/* Card sets bit 0x40 (WRSP) bit in port 2.  Can take 10ms! */
+	for (count = 0; count < 15; ++count) {
+		mdelay (1);	/* Board responds slowly */

-	outb_p(cmd, current_readport + 2);
-	mdelay(1);
+		if (inb (pcwd_info.io_addr + 2) & 0x40) {
+			/* Board says data now valid */

-	i = inb(current_readport);
-	i = inb(current_readport);
+			snprintf (bp, PCWD_FIRMWARE_BSZ, "%u.%u",
+				  inb (pcwd_info.io_addr + 5),
+				  inb (pcwd_info.io_addr + 4));
+
+			return;
+		}
+	}
+	strncpy (bp, "<card no answer>", PCWD_FIRMWARE_BSZ);

-	return(i);
+	return;
 }

-static inline char *get_firmware(void)
+/*
+ *   REV C boards read diagnostic (including firmware version) data
+ * from the register 0.  To do this, the card is put into diagnostic
+ * mode, then the command is submitted and data read from register 0.
+ * NOTE:  the onboard processor writes 4 bits at a time to the register,
+ * so it's necessary to wait for the data to stabilise before
+ * accepting it.
+ */
+
+static int __init
+send_command (int cmd)
 {
-	int i, found = 0, count = 0, one, ten, hund, minor;
-	char *ret;
+	int ii;

-	ret = kmalloc(6, GFP_KERNEL);
-	if(ret == NULL)
-		return NULL;
+	int reg0, last_reg0;	/* Double read for stabilising */

-	while((count < 3) && (!found)) {
-		outb_p(0x80, current_readport + 2);
-		i = inb(current_readport);
+	outb (cmd, pcwd_info.io_addr + 2);
+	/*
+	 *    The following delay need only be 200 microseconds according
+	 *  to the spec I have.  But my card seems slower, as waiting
+	 *  250 microseconds returns valid data, but NOT from this
+	 *  command.  The 1000 value may be excessive, but is reliable.
+	 */
+	mdelay (1);

-		if (i == 0x00)
-			found = 1;
-		else if (i == 0xF3)
-			outb_p(0x00, current_readport + 2);
+	reg0 = inb (pcwd_info.io_addr);
+	for (ii = 0; ii < 25; ++ii) {
+		last_reg0 = reg0;
+		reg0 = inb (pcwd_info.io_addr);
+
+		if (reg0 == last_reg0)
+			break;	/* Data is stable */
+
+		udelay (250);
+	}

-		udelay(400L);
+	return reg0;
+}
+
+/*  REV C board function to retrieve firmware version */
+static void __init
+pcwd_firmware_ver_revc (char *bp)
+{
+	int i, found = 0, count = 0;
+
+	/*  Set the card into debug mode to find firmware version */
+	outb_p (0x00, pcwd_info.io_addr + 2);	/* Spec says to do this */
+	udelay (500);
+
+	while ((count < 3) && (!found)) {
+		i = send_command (0x80);
+
+		if (i == 0x00) {
+			found = 1;
+			break;
+		} else if (i == 0xF3) {
+			/* Card does not like what we've done to it */
+			outb_p (0x00, pcwd_info.io_addr + 2);
+			udelay (1200);	/* Spec says wait 1ms */
+			outb_p (0x00, pcwd_info.io_addr + 2);
+			udelay (500);
+		}
 		count++;
 	}

 	if (found) {
-		mode_debug = 1;

-		one = send_command(0x81);
-		ten = send_command(0x82);
-		hund = send_command(0x83);
-		minor = send_command(0x84);
-		sprintf(ret, "%c.%c%c%c", one, ten, hund, minor);
-	}
-	else
-		sprintf(ret, "ERROR");
+		*bp++ = send_command (0x81);
+		*bp++ = '.';
+		*bp++ = send_command (0x82);
+		*bp++ = send_command (0x83);
+		*bp++ = send_command (0x84);
+		*bp++ = '\0';
+
+		/* Out of debug mode */
+		outb (0x00, pcwd_info.io_addr + 2);
+	} else
+		strncpy (bp, "<err - no go>", PCWD_FIRMWARE_BSZ);

-	return(ret);
+	return;
 }

-static void debug_off(void)
+/*   Initialisation function called ONLY from the PCI layer.  */
+
+static int __init
+pcwd_init_one (struct pci_dev *dev, const struct pci_device_id *ent)
 {
-	outb_p(0x00, current_readport + 2);
-	mode_debug = 0;
+	static int devices = 0;
+
+	++devices;
+	if (devices > 1) {
+		printk (KERN_ERR "pcwd: Driver supports only ONE device\n");
+
+		return -ENODEV;
+	}
+
+	pcwd_info.io_addr = pci_resource_start (dev, 0);
+
+	if (pcwd_info.io_addr == 0 || pci_enable_device (dev))
+		return -ENODEV;
+
+	return 0;
 }

+static struct pci_device_id pcwd_pci_tbl[] __initdata = {
+	{PCI_VENDOR_ID_QUICKLOGIC, PCI_DEVICE_ID_BERKSHIRE,
+	 PCI_ANY_ID, PCI_ANY_ID,},
+	{0},			/* End of list */
+};
+
+MODULE_DEVICE_TABLE (pci, pcwd_pci_tbl);
+
+static struct pci_driver pcwd_driver = {
+	name:"pcwd",
+	id_table:pcwd_pci_tbl,
+	probe:pcwd_init_one,
+};
+
 static struct file_operations pcwd_fops = {
-	owner:		THIS_MODULE,
-	read:		pcwd_read,
-	write:		pcwd_write,
-	ioctl:		pcwd_ioctl,
-	open:		pcwd_open,
-	release:	pcwd_close,
+	owner:THIS_MODULE,
+	write:pcwd_write,
+	ioctl:pcwd_ioctl,
+	open:pcwd_open,
+	release:pcwd_close,
 };

 static struct miscdevice pcwd_miscdev = {
-	WATCHDOG_MINOR,
-	"watchdog",
-	&pcwd_fops
+	minor:		WATCHDOG_MINOR,
+	name:		"watchdog",
+	fops:		&pcwd_fops,
+};
+
+static struct file_operations pcwd_temp_fops = {
+	owner:THIS_MODULE,
+	read:pcwd_read,
+	open:pcwd_open,
+	release:pcwd_close,
 };

 static struct miscdevice temp_miscdev = {
-	TEMP_MINOR,
-	"temperature",
-	&pcwd_fops
+	minor:		TEMP_MINOR,
+	name:		"temperature",
+	fops:		&pcwd_temp_fops,
 };
-
-static int __init pcwatchdog_init(void)
+
+/* Need to know about shutdown to kill the timer - may reset during shutdown! */
+    static struct notifier_block pcwd_notifier =
 {
-	int i, found = 0;
-	spin_lock_init(&io_lock);
-
-	revision = PCWD_REVISION_A;
-
-	printk("pcwd: v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);
-
-	/* Initial variables */
-	supports_temp = 0;
-	mode_debug = 0;
-	temp_panic = 0;
-	initial_status = 0x0000;
-
-#ifndef	PCWD_BLIND
-	for (i = 0; pcwd_ioports[i] != 0; i++) {
-		current_readport = pcwd_ioports[i];
+	pcwd_notify_sys,
+	NULL,
+	0,
+};

-		if (pcwd_checkcard()) {
-			found = 1;
-			break;
+/*
+ *   The ISA cards have a heartbeat bit in one of the registers, which
+ *  register is card dependent.  The heartbeat bit is monitored, and if
+ *  found, is considered proof that a Berkshire card has been found.
+ *  The initial rate is once per second at board start up, then twice
+ *  per second for normal operation.
+ */
+static int __init
+check_isa_card (int base_addr)
+{
+	int reg0, last_reg0;	/* Reg 0, in case it's REV A */
+	int reg1, last_reg1;	/* Register 1 for REV C cards */
+	int ii;
+	int retval;
+
+	/* As suggested by Alan Cox - this is a safety measure. */
+	if (!request_region (base_addr, 4, "pcwd-isa")) {
+		printk (KERN_INFO "pcwd: Port 0x%x unavailable\n", base_addr);
+		return 0;
+	}
+
+	retval = 0;
+
+	reg0 = inb_p (base_addr);	/* For REV A boards */
+	reg1 = inb (base_addr + 1);	/* For REV C boards */
+	if (reg0 != 0xff || reg1 != 0xff) {
+		/* Not an 'ff' from a floating bus, so must be a card! */
+		for (ii = 0; ii < timeout_val; ++ii) {
+
+			set_current_state (TASK_INTERRUPTIBLE);
+			schedule_timeout (HZ / 2);
+
+			last_reg0 = reg0;
+			last_reg1 = reg1;
+
+			reg0 = inb_p (base_addr);
+			reg1 = inb (base_addr + 1);
+
+			/* Has either hearbeat bit changed?  */
+			if ((reg0 ^ last_reg0) & WD_HRTBT ||
+			    (reg1 ^ last_reg1) & 0x02) {
+
+				retval = 1;
+				break;
+			}
 		}
 	}
+	release_region (base_addr, 4);

-	if (!found) {
-		printk("pcwd: No card detected, or port not available.\n");
-		return(-EIO);
+	return retval;
+}
+
+static int __init
+pcwd_card_init (void)
+{
+	int retval;
+	char fvbuf[PCWD_FIRMWARE_BSZ];
+
+	pcwd_info.card_info->firmware_ver (fvbuf);
+
+	printk (KERN_INFO "pcwd: %s at port 0x%03x (Firmware: %s)\n",
+		pcwd_info.card_info->name, pcwd_info.io_addr, fvbuf);
+
+	/* Returns 0xf0 in temperature register if no thermometer */
+	if (inb (pcwd_info.io_addr) != 0xF0) {
+		pcwd_info.flags |= PCWD_HAS_TEMP;
+		printk (KERN_INFO "pcwd: Temperature option detected\n");
 	}
-#endif

-#ifdef	PCWD_BLIND
-	current_readport = PCWD_BLIND;
-#endif
+	if (nowayout)
+		printk (KERN_INFO
+			"pcwd: Watchdog cannot be stopped once started\n");
+
+	/* Record the power up status of "card did reset" and/or temp trip */
+	pcwd_info.boot_status = pcwd_info.card_info->wd_status (1);

-	get_support();
-	revision = get_revision();
+	if (pcwd_info.boot_status & WDIOF_CARDRESET)
+		printk (KERN_INFO
+			"pcwd: Previous reboot was caused by the card\n");

-	if (revision == PCWD_REVISION_A)
-		printk("pcwd: PC Watchdog (REV.A) detected at port 0x%03x\n", current_readport);
-	else if (revision == PCWD_REVISION_C)
-		printk("pcwd: PC Watchdog (REV.C) detected at port 0x%03x (Firmware version: %s)\n",
-			current_readport, get_firmware());
-	else {
-		/* Should NEVER happen, unless get_revision() fails. */
-		printk("pcwd: Unable to get revision.\n");
-		return -1;
+	if (pcwd_info.boot_status & WDIOF_OVERHEAT) {
+		printk (KERN_EMERG
+			"pcwd: Card senses a CPU Overheat.  Panicking!\n");
+		panic ("pcwd: CPU Overheat\n");
 	}

-	if (supports_temp)
-		printk("pcwd: Temperature Option Detected.\n");
+	if (pcwd_info.boot_status == 0)
+		printk (KERN_INFO "pcwd: Cold boot sense\n");

-	debug_off();
+	pcwd_info.card_info->enable_card (0);

-	pcwd_showprevstate();
+	retval = 0;
+	if (!request_region (pcwd_info.io_addr,
+			     pcwd_info.card_info->io_size,
+			     pcwd_info.card_info->name)) {
+		printk (KERN_ERR "pcwd: I/0 %d is not free\n",
+			pcwd_info.io_addr);

-	/*  Disable the board  */
-	if (revision == PCWD_REVISION_C) {
-		outb_p(0xA5, current_readport + 3);
-		outb_p(0xA5, current_readport + 3);
+		return retval;
 	}

-	if (revision == PCWD_REVISION_A)
-		request_region(current_readport, 2, "PCWD Rev.A (Berkshire)");
-	else
-		request_region(current_readport, 4, "PCWD Rev.C (Berkshire)");
+	retval = misc_register (&pcwd_miscdev);
+	if (retval) {
+		release_region (pcwd_info.io_addr,
+				pcwd_info.card_info->io_size);
+		printk (KERN_ERR "pcwd: can't misc_register on minor %d\n",
+			WATCHDOG_MINOR);
+		return retval;
+	}

-	misc_register(&pcwd_miscdev);
+	if (pcwd_info.flags & PCWD_HAS_TEMP) {
+		if (misc_register (&temp_miscdev)) {
+			printk (KERN_ERR
+				"pwcd: can't misc_register thermometer - disabling it\n");
+			pcwd_info.flags &= ~PCWD_HAS_TEMP;
+		}
+	}

-	if (supports_temp)
-		misc_register(&temp_miscdev);
+	retval = register_reboot_notifier (&pcwd_notifier);
+	if (retval) {
+		if (pcwd_info.flags & PCWD_HAS_TEMP)
+			misc_deregister (&temp_miscdev);
+		misc_deregister (&pcwd_miscdev);
+		release_region (pcwd_info.io_addr,
+				pcwd_info.card_info->io_size);
+	}

-	return 0;
+	return retval;
 }

-static void __exit pcwatchdog_exit(void)
+static int __init
+pcwatchdog_init (void)
 {
-	misc_deregister(&pcwd_miscdev);
-	/*  Disable the board  */
-	if (revision == PCWD_REVISION_C) {
-		outb_p(0xA5, current_readport + 3);
-		outb_p(0xA5, current_readport + 3);
+	int i, found = 0;
+	/*
+	 * ISA card auto-probe addresses available.  Last one is only
+	 * available on REV C cards.
+	 */
+	static int pcwd_ioports[] = { 0x270, 0x350, 0x370 };
+#define	PCWD_NUM_ADDR	(sizeof(pcwd_ioports)/sizeof(pcwd_ioports[0]))
+
+	timeout_val = timeout * 2;
+
+	spin_lock_init (&io_lock);
+
+	printk (KERN_INFO "pcwd: v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);
+
+	if (pci_register_driver (&pcwd_driver) > 0) {
+		found = 1;
+		set_card_type (1);	/* Set to PCI card model */
+	} else {
+		/* No PCI entry, try the ISA addresses.  */
+		for (i = 0; i < PCWD_NUM_ADDR; i++) {
+
+			if (check_isa_card (pcwd_ioports[i])) {
+				found = 1;
+
+				pcwd_info.io_addr = pcwd_ioports[i];
+
+				set_card_type (0);
+				break;
+			}
+		}
+	}
+
+	if (!found) {
+		printk (KERN_INFO
+			"pcwd: No card detected, or port not available\n");
+		return -EIO;
 	}
-	if (supports_temp)
-		misc_deregister(&temp_miscdev);

-	release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
+	return pcwd_card_init ();
 }

-module_init(pcwatchdog_init);
-module_exit(pcwatchdog_exit);
+static void __exit
+pcwatchdog_exit (void)
+{
+	unregister_reboot_notifier (&pcwd_notifier);
+	misc_deregister (&pcwd_miscdev);
+
+	if (!nowayout)
+		pcwd_info.card_info->enable_card (0);
+
+	if (pcwd_info.flags & PCWD_HAS_TEMP)
+		misc_deregister (&temp_miscdev);
+
+	release_region (pcwd_info.io_addr, pcwd_info.card_info->io_size);
+
+	if (pcwd_info.flags & PCWD_PCI_REG)
+		pci_unregister_driver (&pcwd_driver);
+
+	return;
+}

-MODULE_LICENSE("GPL");
+module_init (pcwatchdog_init);
+module_exit (pcwatchdog_exit);

+MODULE_LICENSE ("GPL");
+MODULE_AUTHOR ("Ken Hollis (khollis@bitgate.com)");
+MODULE_DESCRIPTION ("PC Watchdog Driver");
 EXPORT_NO_SYMBOLS;


