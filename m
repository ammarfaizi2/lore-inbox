Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbSJIMbf>; Wed, 9 Oct 2002 08:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbSJIMas>; Wed, 9 Oct 2002 08:30:48 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:57759 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261617AbSJIM3z> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390 (7/8): 3270.
Date: Wed, 9 Oct 2002 14:31:38 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091431.38989.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 3270 console reboot loop. Recognize 3270 control unit type 3174.
Fix tubfs kmallocs. Dynamically get 3270 input buffer. Get bootup colors
right on 3270 console

diff -urN linux-2.5.41/Documentation/s390/3270.ChangeLog linux-2.5.41-s390/Documentation/s390/3270.ChangeLog
--- linux-2.5.41/Documentation/s390/3270.ChangeLog	Mon Oct  7 20:23:23 2002
+++ linux-2.5.41-s390/Documentation/s390/3270.ChangeLog	Wed Oct  9 14:01:46 2002
@@ -1,5 +1,34 @@
 ChangeLog for the UTS Global 3270-support patch
 
+Sep 2002:	Get bootup colors right on 3270 console
+	* In tubttybld.c, substantially revise ESC processing so that
+	  ESC sequences (especially coloring ones) and the strings
+	  they affect work as right as 3270 can get them.  Also, set
+	  screen height to omit the two rows used for input area, in
+	  tty3270_open() in tubtty.c.
+
+Sep 2002:	Dynamically get 3270 input buffer
+	* Oversize 3270 screen widths may exceed GEOM_MAXINPLEN columns,
+	  so get input-area buffer dynamically when sizing the device in
+	  tubmakemin() in tuball.c (if it's the console) or tty3270_open()
+	  in tubtty.c (if needed).  Change tubp->tty_input to be a
+	  pointer rather than an array, in tubio.h.
+
+Sep 2002:	Fix tubfs kmalloc()s
+	* Do read and write lengths correctly in fs3270_read()
+	  and fs3270_write(), whilst never asking kmalloc()
+	  for more than 0x800 bytes.  Affects tubfs.c and tubio.h.
+
+Sep 2002:	Recognize 3270 control unit type 3174
+	* Recognize control-unit type 0x3174 as well as 0x327?.
+	  The IBM 2047 device emulates a 3174 control unit.
+	  Modularize control-unit recognition in tuball.c by
+	  adding and invoking new tub3270_is_ours().
+
+Apr 2002:	Fix 3270 console reboot loop
+	* (Belated log entry) Fixed reboot loop if 3270 console,
+	  in tubtty.c:ttu3270_bh().
+
 Feb 6, 2001:
 	* This changelog is new
 	* tub3270 now supports 3270 console:
diff -urN linux-2.5.41/drivers/s390/char/tuball.c linux-2.5.41-s390/drivers/s390/char/tuball.c
--- linux-2.5.41/drivers/s390/char/tuball.c	Mon Oct  7 20:23:58 2002
+++ linux-2.5.41-s390/drivers/s390/char/tuball.c	Wed Oct  9 14:01:46 2002
@@ -228,6 +228,16 @@
 	MOD_DEC_USE_COUNT;
 }
 
+static int
+tub3270_is_ours(s390_dev_info_t *dp)
+{
+	if ((dp->sid_data.cu_type & 0xfff0) == 0x3270)
+		return 1;
+	if (dp->sid_data.cu_type == 0x3174)
+		return 1;
+	return 0;
+}
+
 /*
  * tub3270_init() called by kernel or module initialization
  */
@@ -283,7 +293,7 @@
 		}
 #endif /* LINUX_VERSION_CODE */
 #endif /* CONFIG_TN3270_CONSOLE */
-		if ((d.sid_data.cu_type & 0xfff0) != 0x3270)
+		if (!tub3270_is_ours(&d))
 			continue;
 
 		rc = tubmakemin(i, &d);
@@ -498,6 +508,10 @@
 			tty3270_rcl_fini(tubp);
 			kfree(tubp->tty_bcb.bc_buf);
 			tubp->tty_bcb.bc_buf = NULL;
+			if (tubp->tty_input) {
+				kfree(tubp->tty_input);
+				tubp->tty_input = NULL;
+			}
 			tubp->ttyscreen = NULL;
 			kfree(tubp);
 			*tubpp = NULL;
diff -urN linux-2.5.41/drivers/s390/char/tubfs.c linux-2.5.41-s390/drivers/s390/char/tubfs.c
--- linux-2.5.41/drivers/s390/char/tubfs.c	Wed Oct  9 14:01:28 2002
+++ linux-2.5.41-s390/drivers/s390/char/tubfs.c	Wed Oct  9 14:01:46 2002
@@ -233,12 +233,18 @@
 {
 	long flags;
 	tub_t *tubp;
+	addr_t *ip;
 
 	tubp = (tub_t *) data;
 	TUBLOCK(tubp->irq, flags);
 	tubp->flags &= ~TUB_BHPENDING;
 
 	if (tubp->wbuf) {       /* if we were writing */
+		for (ip = tubp->wbuf; ip < tubp->wbuf+33; ip++) {
+			if (*ip == 0)
+				break;
+			kfree(phys_to_virt(*ip));
+		}
 		kfree(tubp->wbuf);
 		tubp->wbuf = NULL;
 	}
@@ -280,8 +286,6 @@
 #define	DEV_UE_BUSY \
 	(DEV_STAT_CHN_END | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP)
 
-	tubp->dstat = dsp->dstat;
-
 #ifdef RBHNOTYET
 	/* XXX needs more work; must save 2d arg to fs370_io() */
 	/* Handle CE-DE-UE and subsequent UDE */
@@ -364,47 +368,78 @@
 	ccw1_t *cp;
 	int rc;
 	long flags;
+	addr_t *idalp, *ip;
+	char *tp;
+	int count, piece;
+	int size;
+
+	if (len == 0 || len > 65535) {
+		return -EINVAL;
+	}
 
 	if ((tubp = INODE2TUB((struct inode *)fp->private_data)) == NULL)
 		return -ENODEV;
-	if ((rc = fs3270_wait(tubp, &flags)) != 0) {
-		TUBUNLOCK(tubp->irq, flags);
-		return rc;
+
+	ip = idalp = kmalloc(33*sizeof(addr_t), GFP_ATOMIC|GFP_DMA);
+	if (idalp == NULL)
+		return -EFAULT;
+	memset(idalp, 0, 33 * sizeof *idalp);
+	count = len;
+	while (count) {
+		piece = MIN(count, 0x800);
+		size = count == len? piece: 0x800;
+		if ((kp = kmalloc(size, GFP_KERNEL|GFP_DMA)) == NULL) {
+			len = -ENOMEM;
+			goto do_cleanup;
+		}
+		*ip++ = virt_to_phys(kp);
+		count -= piece;
 	}
 
-	kp = kmalloc(len, GFP_KERNEL|GFP_DMA);
-	if (kp == NULL) {
+	if ((rc = fs3270_wait(tubp, &flags)) != 0) {
 		TUBUNLOCK(tubp->irq, flags);
-		return -ENOMEM;
+		len = rc;
+		goto do_cleanup;
 	}
-
 	cp = &tubp->rccw;
 	if (tubp->icmd == 0 && tubp->ocmd != 0)  tubp->icmd = 6;
 	cp->cmd_code = tubp->icmd?:2;
-	cp->flags = CCW_FLAG_SLI;
+	cp->flags = CCW_FLAG_SLI | CCW_FLAG_IDA;
 	cp->count = len;
-	cp->cda = virt_to_phys(kp);
+	cp->cda = virt_to_phys(idalp);
 	tubp->flags |= TUB_RDPENDING;
 	TUBUNLOCK(tubp->irq, flags);
 
 	if ((rc = fs3270_wait(tubp, &flags)) != 0) {
 		tubp->flags &= ~TUB_RDPENDING;
+		len = rc;
 		TUBUNLOCK(tubp->irq, flags);
-		kfree(kp);
-		return rc;
+		goto do_cleanup;
 	}
+	TUBUNLOCK(tubp->irq, flags);
 
 	len -= tubp->cswl;
-	TUBUNLOCK(tubp->irq, flags);
-	if (tubdebug & 1)
-		printk(KERN_DEBUG "minor %d: %.8x %.8x %.8x %.8x\n",
-			tubp->minor,
-			*(int*)((long)kp + 0),
-			*(int*)((long)kp + 4),
-			*(int*)((long)kp + 8),
-			*(int*)((long)kp + 12));
-	copy_to_user(dp, kp, len);
-	kfree(kp);
+	count = len;
+	tp = dp;
+	ip = idalp;
+	while (count) {
+		piece = MIN(count, 0x800);
+		if (copy_to_user(tp, phys_to_virt(*ip), piece) != 0) {
+			len = -EFAULT;
+			goto do_cleanup;
+		}
+		count -= piece;
+		tp += piece;
+		ip++;
+	}
+
+do_cleanup:
+	for (ip = idalp; ip < idalp+33; ip++) {
+		if (*ip == 0)
+			break;
+		kfree(phys_to_virt(*ip));
+	}
+	kfree(idalp);
 	return len;
 }
 
@@ -419,34 +454,65 @@
 	int rc;
 	long flags;
 	void *kb;
+	addr_t *idalp, *ip;
+	int count, piece;
+	int index;
+	int size;
+
+	if (len > 65535 || len == 0)
+		return -EINVAL;
 
 	/* Locate the tube */
 	if ((tubp = INODE2TUB((struct inode *)fp->private_data)) == NULL)
 		return -ENODEV;
 
-	/* Copy data to write from user address space */
-	if ((kb = kmalloc(len, GFP_KERNEL|GFP_DMA)) == NULL)
-		return -ENOMEM;
-	if (copy_from_user(kb, dp, len) != 0) {
-		kfree(kb);
+	ip = idalp = kmalloc(33*sizeof(addr_t), GFP_ATOMIC|GFP_DMA);
+	if (idalp == NULL)
 		return -EFAULT;
+	memset(idalp, 0, 33 * sizeof *idalp);
+
+	count = len;
+	index = 0;
+	while (count) {
+		piece = MIN(count, 0x800);
+		size = count == len? piece: 0x800;
+		if ((kb = kmalloc(size, GFP_KERNEL|GFP_DMA)) == NULL) {
+			len = -ENOMEM;
+			goto do_cleanup;
+		}
+		*ip++ = virt_to_phys(kb);
+		if (copy_from_user(kb, &dp[index], piece) != 0) {
+			len = -EFAULT;
+			goto do_cleanup;
+		}
+		count -= piece;
+		index += piece;
 	}
 
 	/* Wait till tube's not working or signal is pending */
 	if ((rc = fs3270_wait(tubp, &flags))) {
+		len = rc;
 		TUBUNLOCK(tubp->irq, flags);
-		kfree(kb);
-		return rc;
+		goto do_cleanup;
 	}
 
-	/* Make CCW and start I/O.  Back end will free buffer. */
-	tubp->wbuf = kb;
+	/* Make CCW and start I/O.  Back end will free buffers & idal. */
+	tubp->wbuf = idalp;
 	cp = &tubp->wccw;
 	cp->cmd_code = tubp->ocmd? tubp->ocmd == 5? 13: tubp->ocmd: 1;
-	cp->flags = CCW_FLAG_SLI;
+	cp->flags = CCW_FLAG_SLI | CCW_FLAG_IDA;
 	cp->count = len;
 	cp->cda = virt_to_phys(tubp->wbuf);
 	fs3270_io(tubp, cp);
 	TUBUNLOCK(tubp->irq, flags);
 	return len;
+
+do_cleanup:
+	for (ip = idalp; ip < idalp+33; ip++) {
+		if (*ip == 0)
+			break;
+		kfree(phys_to_virt(*ip));
+	}
+	kfree(idalp);
+	return len;
 }
diff -urN linux-2.5.41/drivers/s390/char/tubio.h linux-2.5.41-s390/drivers/s390/char/tubio.h
--- linux-2.5.41/drivers/s390/char/tubio.h	Mon Oct  7 20:22:52 2002
+++ linux-2.5.41-s390/drivers/s390/char/tubio.h	Wed Oct  9 14:01:46 2002
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <asm/irq.h>
 #include <asm/io.h>
+#include <asm/idals.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
 #include <asm/ebcdic.h>
@@ -81,10 +82,17 @@
 #define TAT_CHARS 0x43
 #define TAT_TRANS 0x46
 
+/* Extended-Highlighting Bytes */
+#define TAX_RESET 0x00
+#define TAX_BLINK 0xf1
+#define TAX_REVER 0xf2
+#define TAX_UNDER 0xf4
+
 /* Reset value */
 #define TAR_RESET 0x00
 
 /* Color values */
+#define TAC_RESET 0x00
 #define TAC_BLUE 0xf1
 #define TAC_RED 0xf2
 #define TAC_PINK 0xf3
@@ -220,7 +228,7 @@
 	devstat_t       devstat;
 	ccw1_t          rccw;
 	ccw1_t          wccw;
-	void            *wbuf;
+	addr_t		*wbuf;
 	int             cswl;
 	void            (*intv)(struct tub_s *, devstat_t *);
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
@@ -242,12 +250,13 @@
 
 	/* Stuff for tty-driver support */
 	struct tty_struct *tty;
-	char tty_input[GEOM_MAXINPLEN]; /* tty input area */
+	char *tty_input;		/* tty input area */
 	int tty_inattr;         	/* input-area field attribute */
 #define TTY_OUTPUT_SIZE 1024
 	bcb_t tty_bcb;			/* Output buffer control info */
 	int tty_oucol;                  /* Kludge */
 	int tty_nextlogx;               /* next screen-log position */
+	int tty_savecursor;		/* saved cursor position */
 	int tty_scrolltime;             /* scrollforward wait time, sec */
 	struct timer_list tty_stimer;   /* timer for scrolltime */
 	aid_t tty_aid[64];              /* Aid descriptors */
diff -urN linux-2.5.41/drivers/s390/char/tubtty.c linux-2.5.41-s390/drivers/s390/char/tubtty.c
--- linux-2.5.41/drivers/s390/char/tubtty.c	Mon Oct  7 20:24:49 2002
+++ linux-2.5.41-s390/drivers/s390/char/tubtty.c	Wed Oct  9 14:01:46 2002
@@ -216,8 +216,10 @@
 	tubp->tty = tty;
 	tubp->lnopen = 1;
 	tty->driver_data = tubp;
-	tty->winsize.ws_row = tubp->geom_rows;
+	tty->winsize.ws_row = tubp->geom_rows - 2;
 	tty->winsize.ws_col = tubp->geom_cols;
+	if (tubp->tty_input == NULL)
+		tubp->tty_input = kmalloc(GEOM_INPLEN, GFP_KERNEL|GFP_DMA);
 	tubp->tty_inattr = TF_INPUT;
 	tubp->cmd = cmd;
 	tty3270_build(tubp);
@@ -801,7 +803,9 @@
 static void
 tty3270_start_input(tub_t *tubp)
 {
-	tubp->ttyccw.cda = virt_to_phys(&tubp->tty_input);
+	if (tubp->tty_input == NULL)
+		return;
+	tubp->ttyccw.cda = virt_to_phys(tubp->tty_input);
 	tubp->ttyccw.cmd_code = TC_READMOD;
 	tubp->ttyccw.count = GEOM_INPLEN;
 	tubp->ttyccw.flags = CCW_FLAG_SLI;
@@ -818,7 +822,8 @@
 	char *aidstring;
 
 	count = GEOM_INPLEN - tubp->cswl;
-	in = tubp->tty_input;
+	if ((in = tubp->tty_input) == NULL)
+		goto do_build;
 	tty3270_aid_get(tubp, in[0], &aidflags, &aidstring);
 
 	if (aidflags & TA_CLEARKEY) {
diff -urN linux-2.5.41/drivers/s390/char/tubttybld.c linux-2.5.41-s390/drivers/s390/char/tubttybld.c
--- linux-2.5.41/drivers/s390/char/tubttybld.c	Mon Oct  7 20:24:05 2002
+++ linux-2.5.41-s390/drivers/s390/char/tubttybld.c	Wed Oct  9 14:01:46 2002
@@ -15,10 +15,12 @@
 extern int tty3270_io(tub_t *);
 static void tty3270_set_status_area(tub_t *, char **);
 static int tty3270_next_char(tub_t *);
+static void tty3270_unnext_char(tub_t *, char);
 static void tty3270_update_log_area(tub_t *, char **);
-static void tty3270_update_log_area_esc(tub_t *, char **);
+static int tty3270_update_log_area_esc(tub_t *, char **, int *);
 static void tty3270_clear_log_area(tub_t *, char **);
 static void tty3270_tub_bufadr(tub_t *, int, char **);
+static void tty3270_set_bufadr(tub_t *, char **, int *);
 
 /*
  * tty3270_clear_log_area(tub_t *tubp, char **cpp)
@@ -47,69 +49,73 @@
 	int sba_needed = 1;
 	char *overrun = &(*tubp->ttyscreen)[tubp->ttyscreenl - TS_LENGTH];
 
-	/* Place characters */
-	while (tubp->tty_bcb.bc_cnt != 0) {
-		if (tubp->tty_nextlogx >= lastx) {
-			if (sba_needed == 0 || tubp->stat == TBS_RUNNING) {
-				tubp->stat = TBS_MORE;
-				tty3270_set_status_area(tubp, cpp);
-				tty3270_scl_settimer(tubp);
-			}
-			break;
+	/* Check for possible ESC sequence work to do */
+	if (tubp->tty_escx != 0) {
+		/* If compiling new escape sequence */
+		if (tubp->tty_esca[0] == 0x1b) {
+			if (tty3270_update_log_area_esc(tubp, cpp, &sba_needed))
+				return;
+		/* If esc seq needs refreshing after a write */
+		} else if (tubp->tty_esca[0] == TO_SA) {
+			tty3270_set_bufadr(tubp, cpp, &sba_needed);
+			for (i = 0; i < tubp->tty_escx; i++)
+				*(*cpp)++ = tubp->tty_esca[i];
+		} else {
+			printk(KERN_WARNING "tty3270_update_log_area esca "
+			"character surprising:  %.2x\n", tubp->tty_esca[0]);
 		}
+	}
 
-		/* Check for room for another char + possible ESCs */
-		if (&(*cpp)[tubp->tty_escx + 1] >= overrun)
+	/* Place characters */
+	while (tubp->tty_bcb.bc_cnt != 0) {
+		/* Check for room.  TAB could take up to 4 chars. */
+		if (&(*cpp)[4] >= overrun)
 			break;
 
 		/* Fetch a character */
 		if ((c = tty3270_next_char(tubp)) == -1)
 			break;
 
-		/* Add a Set-Buffer-Address Order if we haven't */
-		if (sba_needed) {
-			sba_needed = 0;
-			*(*cpp)++ = TO_SBA;
-			TUB_BUFADR(tubp->tty_nextlogx, cpp);
-		}
-
 		switch(c) {
 		default:
-			if (c < ' ')    /* Blank it if we don't know it */
-				c = ' ';
-			for (i = 0; i < tubp->tty_escx; i++)
-				*(*cpp)++ = tubp->tty_esca[i];
-			tubp->tty_escx = 0;
-			*(*cpp)++ = tub_ascebc[(int)c];
+			if (tubp->tty_nextlogx >= lastx) {
+				if (sba_needed == 0 ||
+				    tubp->stat == TBS_RUNNING) {
+					tty3270_unnext_char(tubp, c);
+					tubp->stat = TBS_MORE;
+					tty3270_set_status_area(tubp, cpp);
+					tty3270_scl_settimer(tubp);
+				}
+				goto do_return;
+			}
+			tty3270_set_bufadr(tubp, cpp, &sba_needed);
+			/* Use blank if we don't know the character */
+			*(*cpp)++ = tub_ascebc[(int)(c < ' '? ' ': c)];
 			tubp->tty_nextlogx++;
 			tubp->tty_oucol++;
 			break;
 		case 0x1b:              /* ESC */
-			tty3270_update_log_area_esc(tubp, cpp);
+			tubp->tty_escx = 0;
+			if (tty3270_update_log_area_esc(tubp, cpp, &sba_needed))
+				return;
+			break;
+		case '\r':		/* 0x0d -- Carriage Return */
+			tubp->tty_nextlogx -=
+				tubp->tty_nextlogx % GEOM_COLS;
+			sba_needed = 1;
 			break;
-		case '\r':
-			break;          /* completely ignore 0x0d = CR. */
-		case '\n':
+		case '\n':		/* 0x0a -- New Line */
 			if (tubp->tty_oucol == GEOM_COLS) {
 				tubp->tty_oucol = 0;
 				break;
 			}
 			next = (tubp->tty_nextlogx + GEOM_COLS) /
 				GEOM_COLS * GEOM_COLS;
-			next = MIN(next, lastx);
-			fill = next - tubp->tty_nextlogx;
-			if (fill < 5) {
-				for (i = 0; i < fill; i++)
-					*(*cpp)++ = tub_ascebc[' '];
-			} else {
-				*(*cpp)++ = TO_RA;
-				TUB_BUFADR(next, cpp);
-				*(*cpp)++ = tub_ascebc[' '];
-			}
 			tubp->tty_nextlogx = next;
 			tubp->tty_oucol = 0;
+			sba_needed = 1;
 			break;
-		case '\t':
+		case '\t':		/* 0x09 -- Tabulate */
 			fill = (tubp->tty_nextlogx % GEOM_COLS) % 8;
 			for (; fill < 8; fill++) {
 				if (tubp->tty_nextlogx >= lastx)
@@ -119,72 +125,116 @@
 				tubp->tty_oucol++;
 			}
 			break;
-		case '\a':
+		case '\a':		/* 0x07 -- Alarm */
 			tubp->flags |= TUB_ALARM;
 			break;
-		case '\f':
+		case '\f':		/* 0x0c -- Form Feed */
 			tty3270_clear_log_area(tubp, cpp);
 			break;
+		case 0xf:	/* SuSE "exit alternate mode" */
+			break;
 		}
 	}
+do_return:
 }
 
 #define NUMQUANT 8
-static void
-tty3270_update_log_area_esc(tub_t *tubp, char **cpp)
+static int
+tty3270_update_log_area_esc(tub_t *tubp, char **cpp, int *sba_needed)
 {
-	int lastx = GEOM_INPUT;
 	int c;
-	int i;
-	int start, next, fill;
+	int i, j;
+	int start, end, next;
 	int quant[NUMQUANT];
+	char *overrun = &(*tubp->ttyscreen)[tubp->ttyscreenl - TS_LENGTH];
+	char sabuf[NUMQUANT*3], *sap = sabuf, *cp;
 
-	if ((c = tty3270_next_char(tubp)) != '[') {
-		return;
+	/* If starting a sequence, stuff ESC at [0] */
+	if (tubp->tty_escx == 0)
+		tubp->tty_esca[tubp->tty_escx++] = 0x1b;
+
+	/* Now that sequence is started, see if room in buffer */
+	if (&(*cpp)[NUMQUANT * 3] >= overrun)
+		return tubp->tty_escx;
+
+	/* Gather the rest of the sequence's characters */
+	while (tubp->tty_escx < sizeof tubp->tty_esca) {
+		if ((c = tty3270_next_char(tubp)) == -1)
+			return tubp->tty_escx;
+		if (tubp->tty_escx == 1) {
+			switch(c) {
+			case '[':
+				tubp->tty_esca[tubp->tty_escx++] = c;
+				continue;
+			case '7':
+				tubp->tty_savecursor = tubp->tty_nextlogx;
+				goto done_return;
+			case '8':
+				next = tubp->tty_savecursor;
+				goto do_setcur;
+			default:
+				goto error_return;
+			}
+		}
+		tubp->tty_esca[tubp->tty_escx++] = c;
+		if (c != ';' && (c < '0' || c > '9'))
+			break;
 	}
 
-	/*
-	 * Parse potentially empty string "nn;nn;nn..."
-	 */
+	/* Check for overrun */
+	if (tubp->tty_escx == sizeof tubp->tty_esca)
+		goto error_return;
+
+	/* Parse potentially empty string "nn;nn;nn..." */
 	i = -1;
+	j = 2;		/* skip ESC, [ */
 	c = ';';
 	do {
 		if (c == ';') {
 			if (++i == NUMQUANT)
-				break;
+				goto error_return;
 			quant[i] = 0;
 		} else if (c < '0' || c > '9') {
 			break;
 		} else {
 			quant[i] = quant[i] * 10 + c - '0';
 		}
-	} while ((c = tty3270_next_char(tubp)) != -1);
-	if (c == -1) {
-		return;
-	}
-	if (i >= NUMQUANT) {
-		return;
-	}
+		c = tubp->tty_esca[j];
+	} while (j++ < tubp->tty_escx);
+
+	/* Add 3270 data stream output to execute the sequence */
 	switch(c) {
-	case -1:
-		return;
 	case 'm':		/* Set Attribute */
 		for (next = 0; next <= i; next++) {
 			int type = -1, value = 0;
 
-			if (tubp->tty_escx + 3 > MAX_TTY_ESCA)
-				break;
 			switch(quant[next]) {
 			case 0:		/* Reset */
-				tubp->tty_esca[tubp->tty_escx++] = TO_SA;
-				tubp->tty_esca[tubp->tty_escx++] = TAT_RESET;
-				tubp->tty_esca[tubp->tty_escx++] = TAR_RESET;
+				next = tubp->tty_nextlogx;
+				tty3270_set_bufadr(tubp, cpp, sba_needed);
+				*(*cpp)++ = TO_SA;
+				*(*cpp)++ = TAT_EXTHI;
+				*(*cpp)++ = TAX_RESET;
+				*(*cpp)++ = TO_SA;
+				*(*cpp)++ = TAT_COLOR;
+				*(*cpp)++ = TAC_RESET;
+				tubp->tty_nextlogx = next;
+				*sba_needed = 1;
+				sap = sabuf;
 				break;
 			case 1:		/* Bright */
+				break;
 			case 2:		/* Dim */
+				break;
 			case 4:		/* Underscore */
+				type = TAT_EXTHI; value = TAX_UNDER;
+				break;
 			case 5:		/* Blink */
+				type = TAT_EXTHI; value = TAX_BLINK;
+				break;
 			case 7:		/* Reverse */
+				type = TAT_EXTHI; value = TAX_REVER;
+				break;
 			case 8:		/* Hidden */
 				break;		/* For now ... */
 			/* Foreground Colors */
@@ -230,53 +280,110 @@
 				break;
 			}
 			if (type != -1) {
-				tubp->tty_esca[tubp->tty_escx++] = TO_SA;
-				tubp->tty_esca[tubp->tty_escx++] = type;
-				tubp->tty_esca[tubp->tty_escx++] = value;
+				tty3270_set_bufadr(tubp, cpp, sba_needed);
+				*(*cpp)++ = TO_SA;
+				*(*cpp)++ = type;
+				*(*cpp)++ = value;
+				*sap++ = TO_SA;
+				*sap++ = type;
+				*sap++ = value;
 			}
 		}
 		break;
+
 	case 'H':		/* Cursor Home */
 	case 'f':		/* Force Cursor Position */
-		return;
+		if (quant[0]) quant[0]--;
+		if (quant[1]) quant[1]--;
+		next = quant[0] * GEOM_COLS + quant[1];
+		goto do_setcur;
 	case 'A':		/* Cursor Up */
-		return;
+		if (quant[i] == 0) quant[i] = 1;
+		next = tubp->tty_nextlogx - GEOM_COLS * quant[i];
+		goto do_setcur;
 	case 'B':		/* Cursor Down */
-		return;
+		if (quant[i] == 0) quant[i] = 1;
+		next = tubp->tty_nextlogx + GEOM_COLS * quant[i];
+		goto do_setcur;
 	case 'C':		/* Cursor Forward */
+		if (quant[i] == 0) quant[i] = 1;
 		next = tubp->tty_nextlogx % GEOM_COLS;
 		start = tubp->tty_nextlogx - next;
 		next = start + MIN(next + quant[i], GEOM_COLS - 1);
-		next = MIN(next, lastx);
-do_fill:
-		fill = next - tubp->tty_nextlogx;
-		if (fill < 5) {
-			for (i = 0; i < fill; i++)
-				*(*cpp)++ = tub_ascebc[' '];
-		} else {
-			*(*cpp)++ = TO_RA;
-			TUB_BUFADR(next, cpp);
-			*(*cpp)++ = tub_ascebc[' '];
-		}
-		tubp->tty_nextlogx = next;
-		tubp->tty_oucol = tubp->tty_nextlogx % GEOM_COLS;
-		break;
+		goto do_setcur;
 	case 'D':		/* Cursor Backward */
+		if (quant[i] == 0) quant[i] = 1;
 		next = MIN(quant[i], tubp->tty_nextlogx % GEOM_COLS);
-		tubp->tty_nextlogx -= next;
+		next = tubp->tty_nextlogx - next;
+		goto do_setcur;
+	case 'G':
+		if (quant[0]) quant[0]--;
+		next = tubp->tty_nextlogx / GEOM_COLS * GEOM_COLS + quant[0];
+do_setcur:
+		if (next < 0)
+			break;
+		tubp->tty_nextlogx = next;
 		tubp->tty_oucol = tubp->tty_nextlogx % GEOM_COLS;
+		*sba_needed = 1;
+		break;
+
+	case 'r':		/* Define scroll area */
+		start = quant[0];
+		if (start <= 0) start = 1;
+		if (start > GEOM_ROWS - 2) start = GEOM_ROWS - 2;
+		tubp->tty_nextlogx = (start - 1) * GEOM_COLS;
+		tubp->tty_oucol = 0;
+		*sba_needed = 1;
+		break;
+
+	case 'X':		/* Erase for n chars from cursor */
+		start = tubp->tty_nextlogx;
+		end = start + (quant[0]?: 1);
+		goto do_fill;
+	case 'J':		/* Erase to screen end from cursor */
+		*(*cpp)++ = TO_SBA;
+		TUB_BUFADR(tubp->tty_nextlogx, cpp);
+		*(*cpp)++ = TO_RA;
+		TUB_BUFADR(GEOM_INPUT, cpp);
+		*(*cpp)++ = tub_ascebc[' '];
 		*(*cpp)++ = TO_SBA;
 		TUB_BUFADR(tubp->tty_nextlogx, cpp);
 		break;
-	case 'G':
-		start = tubp->tty_nextlogx / GEOM_COLS * GEOM_COLS;
-		next = MIN(quant[i], GEOM_COLS - 1) + start;
-		next = MIN(next, lastx);
-		goto do_fill;
+	case 'K':
+		start = tubp->tty_nextlogx;
+		end = (start + GEOM_COLS) / GEOM_COLS * GEOM_COLS;
+do_fill:
+		if (start >= GEOM_INPUT)
+			break;
+		if (end > GEOM_INPUT)
+			end = GEOM_INPUT;
+		if (end <= start)
+			break;
+		*(*cpp)++ = TO_SBA;
+		TUB_BUFADR(start, cpp);
+		if (end - start > 4) {
+			*(*cpp)++ = TO_RA;
+			TUB_BUFADR(end, cpp);
+			*(*cpp)++ = tub_ascebc[' '];
+		} else while (start++ < end) {
+			*(*cpp)++ = tub_ascebc[' '];
+		}
+		tubp->tty_nextlogx = end;
+		tubp->tty_oucol = tubp->tty_nextlogx % GEOM_COLS;
+		*sba_needed = 1;
+		break;
 	}
+done_return:
+	tubp->tty_escx = 0;
+	cp = sabuf;
+	while (cp != sap)
+		tubp->tty_esca[tubp->tty_escx++] = *cp++;
+	return 0;
+error_return:
+	tubp->tty_escx = 0;
+	return 0;
 }
 
-
 static int
 tty3270_next_char(tub_t *tubp)
 {
@@ -293,6 +400,18 @@
 	return c;
 }
 
+static void
+tty3270_unnext_char(tub_t *tubp, char c)
+{
+	bcb_t *ib;
+
+	ib = &tubp->tty_bcb;
+	if (ib->bc_rd == 0)
+		ib->bc_rd = ib->bc_len;
+	ib->bc_buf[--ib->bc_rd] = c;
+	ib->bc_cnt++;
+}
+
 
 static void
 tty3270_clear_input_area(tub_t *tubp, char **cpp)
@@ -452,3 +571,17 @@
 		*(*cpp)++ = tub_ebcgraf[adr & 0x3f];
 	}
 }
+
+static void
+tty3270_set_bufadr(tub_t *tubp, char **cpp, int *sba_needed)
+{
+	if (!*sba_needed)
+		return;
+	if (tubp->tty_nextlogx >= GEOM_INPUT) {
+		tubp->tty_nextlogx = GEOM_INPUT - 1;
+		tubp->tty_oucol = tubp->tty_nextlogx % GEOM_COLS;
+	}
+	*(*cpp)++ = TO_SBA;
+	TUB_BUFADR(tubp->tty_nextlogx, cpp);
+	*sba_needed = 0;
+}

