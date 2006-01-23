Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWAWVRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWAWVRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWAWVRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:17:37 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:8354 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030195AbWAWVRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:17:37 -0500
Message-ID: <43D5484A.8040502@us.ibm.com>
Date: Mon, 23 Jan 2006 15:19:06 -0600
From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH]-jsm driver fix for linux-2.6.16-rc1
References: <43D1099E.3050509@us.ibm.com> <1137781399.24161.30.camel@localhost.localdomain> <43D52023.4090607@us.ibm.com> <20060123184621.GA6744@suse.de>
In-Reply-To: <20060123184621.GA6744@suse.de>
Content-Type: multipart/mixed;
 boundary="------------070107090704050802010505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107090704050802010505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg, Thanks for the white space info.  Cleaned up version is attached 
below.

Thanks,
V.Ananda Krishnan

Greg KH wrote:
> On Mon, Jan 23, 2006 at 12:27:47PM -0600, V. Ananda Krishnan wrote:
>> I am submitting the revised patch. We removed the use of jsm-rawreadok 
>> feature. Greg's suggestions are also taken care of.  Let me have the 
>> feed-back.
> 
> No, you are still using spaces instead of tabs in places.  Please fix
> that.
> 
> thanks,
> 
> greg k-h
> 


--------------070107090704050802010505
Content-Type: text/plain;
 name="patch_jsm_012306.2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_jsm_012306.2.txt"

diff -Naupr linux-2.6.16-rc1/drivers/serial/Kconfig linux-2.6.16-rc1-mod/drivers/serial/Kconfig
--- linux-2.6.16-rc1/drivers/serial/Kconfig	2006-01-23 11:08:19.000000000 -0600
+++ linux-2.6.16-rc1-mod/drivers/serial/Kconfig	2006-01-23 11:06:41.000000000 -0600
@@ -893,7 +893,7 @@ config SERIAL_VR41XX_CONSOLE

 config SERIAL_JSM
         tristate "Digi International NEO PCI Support"
-	depends on PCI && BROKEN
+	depends on PCI
         select SERIAL_CORE
         help
           This is a driver for Digi International's Neo series
diff -Naupr linux-2.6.16-rc1/drivers/serial/jsm/jsm_tty.c linux-2.6.16-rc1-mod/drivers/serial/jsm/jsm_tty.c
--- linux-2.6.16-rc1/drivers/serial/jsm/jsm_tty.c	2006-01-23 11:03:24.000000000 -0600
+++ linux-2.6.16-rc1-mod/drivers/serial/jsm/jsm_tty.c	2006-01-23 14:02:08.000000000 -0600
@@ -20,8 +20,10 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
- *
+ * Ananda Venkatarman <mansarov@us.ibm.com>
+ * Modifications:
+ * 01/19/06:	changed jsm_input routine to use the dynamically allocated
+ *		tty_buffer changes. Contributors: Scott Kilau and Ananda V.
  ***********************************************************************/
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -497,16 +499,16 @@ void jsm_input(struct jsm_channel *ch)
 {
	struct jsm_board *bd;
	struct tty_struct *tp;
+	struct tty_ldisc *ld;
	u32 rmask;
	u16 head;
	u16 tail;
	int data_len;
	unsigned long lock_flags;
-	int flip_len;
+	int flip_len = 0;
	int len = 0;
	int n = 0;
	char *buf = NULL;
-	char *buf2 = NULL;
	int s = 0;
	int i = 0;

@@ -574,59 +576,54 @@ void jsm_input(struct jsm_channel *ch)

	/*
	 * If the rxbuf is empty and we are not throttled, put as much
-	 * as we can directly into the linux TTY flip buffer.
-	 * The jsm_rawreadok case takes advantage of carnal knowledge that
-	 * the char_buf and the flag_buf are next to each other and
-	 * are each of (2 * TTY_FLIPBUF_SIZE) size.
+	 * as we can directly into the linux TTY buffer.
	 *
-	 * NOTE: if(!tty->real_raw), the call to ldisc.receive_buf
-	 *actually still uses the flag buffer, so you can't
-	 *use it for input data
-	 */
-	if (jsm_rawreadok) {
-		if (tp->real_raw)
-			flip_len = MYFLIPLEN;
-		else
-			flip_len = 2 * TTY_FLIPBUF_SIZE;
-	} else
-		flip_len = TTY_FLIPBUF_SIZE - tp->flip.count;
+	 */
+	flip_len = TTY_FLIPBUF_SIZE;

	len = min(data_len, flip_len);
	len = min(len, (N_TTY_BUF_SIZE - 1) - tp->read_cnt);
+	ld = tty_ldisc_ref(tp);
+
+        /*
+         * If the DONT_FLIP flag is on, don't flush our buffer, and act
+         * like the ld doesn't have any space to put the data right now.
+         */
+        if (test_bit(TTY_DONT_FLIP, &tp->flags))
+		len = 0;
+
+	/*
+	 * If we were unable to get a reference to the ld,
+	 * don't flush our buffer, and act like the ld doesn't
+	 * have any space to put the data right now.
+	 */
+	if (!ld) {
+		len = 0;
+	} else {
+		/*
+		 * If ld doesn't have a pointer to a receive_buf function,
+		 * flush the data, then act like the ld doesn't have any
+		 * space to put the data right now.
+		 */
+			if (!ld->receive_buf) {
+				ch->ch_r_head = ch->ch_r_tail;
+				len = 0;
+		}
+	}
+

	if (len <= 0) {
		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
		jsm_printk(READ, INFO, &ch->ch_bd->pci_dev, "jsm_input 1\n");
+		if (ld)
+			tty_ldisc_deref(ld);
		return;
	}

-	/*
-	 * If we're bypassing flip buffers on rx, we can blast it
-	 * right into the beginning of the buffer.
-	 */
-	if (jsm_rawreadok) {
-		if (tp->real_raw) {
-			if (ch->ch_flags & CH_FLIPBUF_IN_USE) {
-				jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
-					"JSM - FLIPBUF in use. delaying input\n");
-				spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
-				return;
-			}
-			ch->ch_flags |= CH_FLIPBUF_IN_USE;
-			buf = ch->ch_bd->flipbuf;
-			buf2 = NULL;
-		} else {
-			buf = tp->flip.char_buf;
-			buf2 = tp->flip.flag_buf;
-		}
-	} else {
-		buf = tp->flip.char_buf_ptr;
-		buf2 = tp->flip.flag_buf_ptr;
-	}
-
+	len = tty_buffer_request_room(tp, len);
	n = len;

-	/*
+        /*
	 * n now contains the most amount of data we can copy,
	 * bounded either by the flip buffer size or the amount
	 * of data the card actually has pending...
@@ -638,121 +635,47 @@ void jsm_input(struct jsm_channel *ch)
		if (s <= 0)
			break;

-		memcpy(buf, ch->ch_rqueue + tail, s);
-
-		/* buf2 is only set when port isn't raw */
-		if (buf2)
-			memcpy(buf2, ch->ch_equeue + tail, s);
-
-		tail += s;
-		buf += s;
-		if (buf2)
-			buf2 += s;
-		n -= s;
-		/* Flip queue if needed */
-		tail &= rmask;
-	}
+			/*
+			 * If conditions are such that ld needs to see all
+			 * UART errors, we will have to walk each character
+			 * and error byte and send them to the buffer one at
+			 * a time.
+			 */

-	/*
-	 * In high performance mode, we don't have to update
-	 * flag_buf or any of the counts or pointers into flip buf.
-	 */
-	if (!jsm_rawreadok) {
		if (I_PARMRK(tp) || I_BRKINT(tp) || I_INPCK(tp)) {
-			for (i = 0; i < len; i++) {
+			for (i = 0; i < s; i++) {
				/*
				 * Give the Linux ld the flags in the
				 * format it likes.
				 */
-				if (tp->flip.flag_buf_ptr[i] & UART_LSR_BI)
-					tp->flip.flag_buf_ptr[i] = TTY_BREAK;
-				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_PE)
-					tp->flip.flag_buf_ptr[i] = TTY_PARITY;
-				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_FE)
-					tp->flip.flag_buf_ptr[i] = TTY_FRAME;
+				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
+					tty_insert_flip_char(tp, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
+				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
+					tty_insert_flip_char(tp, *(ch->ch_rqueue +tail +i), TTY_PARITY);
+				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
+					tty_insert_flip_char(tp, *(ch->ch_rqueue +tail +i), TTY_FRAME);
				else
-					tp->flip.flag_buf_ptr[i] = TTY_NORMAL;
+				tty_insert_flip_char(tp, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
			}
		} else {
-			memset(tp->flip.flag_buf_ptr, 0, len);
+			tty_insert_flip_string(tp, ch->ch_rqueue + tail, s) ;
		}
-
-		tp->flip.char_buf_ptr += len;
-		tp->flip.flag_buf_ptr += len;
-		tp->flip.count += len;
-	}
-	else if (!tp->real_raw) {
-		if (I_PARMRK(tp) || I_BRKINT(tp) || I_INPCK(tp)) {
-			for (i = 0; i < len; i++) {
-				/*
-				 * Give the Linux ld the flags in the
-				 * format it likes.
-				 */
-				if (tp->flip.flag_buf_ptr[i] & UART_LSR_BI)
-					tp->flip.flag_buf_ptr[i] = TTY_BREAK;
-				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_PE)
-					tp->flip.flag_buf_ptr[i] = TTY_PARITY;
-				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_FE)
-					tp->flip.flag_buf_ptr[i] = TTY_FRAME;
-				else
-					tp->flip.flag_buf_ptr[i] = TTY_NORMAL;
-			}
-		} else
-			memset(tp->flip.flag_buf, 0, len);
+		tail += s;
+		n -= s;
+		/* Flip queue if needed */
+                tail &= rmask;
	}

-	/*
-	 * If we're doing raw reads, jam it right into the
-	 * line disc bypassing the flip buffers.
-	 */
-	if (jsm_rawreadok) {
-		if (tp->real_raw) {
-			ch->ch_r_tail = tail & rmask;
-			ch->ch_e_tail = tail & rmask;
-
-			jsm_check_queue_flow_control(ch);
-
-			/* !!! WE *MUST* LET GO OF ALL LOCKS BEFORE CALLING RECEIVE BUF !!! */
-
-			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+	ch->ch_r_tail = tail & rmask;
+	ch->ch_e_tail = tail & rmask;
+	jsm_check_queue_flow_control(ch);
+	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);

-			jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
-				"jsm_input. %d real_raw len:%d calling receive_buf for board %d\n",
-				__LINE__, len, ch->ch_bd->boardnum);
-			tp->ldisc.receive_buf(tp, ch->ch_bd->flipbuf, NULL, len);
+	/* Tell the tty layer its okay to "eat" the data now */
+	tty_flip_buffer_push(tp);

-			/* Allow use of channel flip buffer again */
-			spin_lock_irqsave(&ch->ch_lock, lock_flags);
-			ch->ch_flags &= ~CH_FLIPBUF_IN_USE;
-			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
-
-		} else {
-			ch->ch_r_tail = tail & rmask;
-			ch->ch_e_tail = tail & rmask;
-
-			jsm_check_queue_flow_control(ch);
-
-			/* !!! WE *MUST* LET GO OF ALL LOCKS BEFORE CALLING RECEIVE BUF !!! */
-			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
-
-			jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
-				"jsm_input. %d not real_raw len:%d calling receive_buf for board %d\n",
-				__LINE__, len, ch->ch_bd->boardnum);
-
-			tp->ldisc.receive_buf(tp, tp->flip.char_buf, tp->flip.flag_buf, len);
-		}
-	} else {
-		ch->ch_r_tail = tail & rmask;
-		ch->ch_e_tail = tail & rmask;
-
-		jsm_check_queue_flow_control(ch);
-
-		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
-
-		jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
-			"jsm_input. %d not jsm_read raw okay scheduling flip\n", __LINE__);
-		tty_schedule_flip(tp);
-	}
+	if (ld)
+		tty_ldisc_deref(ld);

	jsm_printk(IOCTL, INFO, &ch->ch_bd->pci_dev, "finish\n");
 }

--------------070107090704050802010505--
