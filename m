Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130890AbQKHJdC>; Wed, 8 Nov 2000 04:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130881AbQKHJcm>; Wed, 8 Nov 2000 04:32:42 -0500
Received: from widukind.bi.teuto.net ([212.8.197.28]:58379 "EHLO
	widukind.bi.teuto.net") by vger.kernel.org with ESMTP
	id <S130700AbQKHJck>; Wed, 8 Nov 2000 04:32:40 -0500
Date: Wed, 8 Nov 2000 10:32:03 +0100
From: Michael Westermann <mw@microdata-pos.de>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i386 PC Keyboad Patch, for very exotic Keyboads
Message-ID: <20001108103203.B26847@microdata-pos.de>
Mail-Followup-To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20001108102456.A26847@microdata-pos.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001108102456.A26847@microdata-pos.de>; from mw@microdata-pos.de on Wed, Nov 08, 2000 at 10:24:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii

Hello,


On Wed, Nov 08, 2000 at 10:24:56AM +0100, Michael Westermann wrote:
> Hallo,
> 
> ich have wrote a Patch, for all the PS2-Keyboards what
> use exotic Scancodes and Functions. Teh backgroud is 

Sorry i have the Patch forget. 


Michael Westermann

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pc_keyb.patch.v0.2"

--- linux.old/drivers/char/pc_keyb.c	Thu Jul  6 22:21:31 2000
+++ linux/drivers/char/pc_keyb.c	Thu Nov  2 08:15:29 2000
@@ -13,10 +13,12 @@
  * Code fixes to handle mouse ACKs properly.
  * C. Scott Ananian <cananian@alumni.princeton.edu> 1999-01-29.
  *
+ * Include a interface for pc keyboard's with extentions
+ * M.Westermann <mw@microdata-pos.de> Tue, 10 Oct 2000
  */
 
 #include <linux/config.h>
-
+#include <linux/module.h>
 #include <asm/spinlock.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
@@ -41,6 +43,9 @@
 
 #include <linux/pc_keyb.h>
 
+EXPORT_SYMBOL(unregister_kbd_ex);
+EXPORT_SYMBOL(register_kbd_ex);
+
 /* Simple translation table for the SysRq keys */
 
 #ifdef CONFIG_MAGIC_SYSRQ
@@ -64,10 +69,9 @@
 static unsigned char handle_kbd_event(void);
 
 /* used only by send_data - set by keyboard_interrupt */
-static volatile unsigned char reply_expected = 0;
-static volatile unsigned char acknowledge = 0;
-static volatile unsigned char resend = 0;
-
+static volatile pc_keyb_t   kbd_ex_mem;    
+static volatile pc_keyb_t * kbd_ex;
+static volatile pc_keyb_t * kbd_store;
 
 #if defined CONFIG_PSMOUSE
 /*
@@ -260,19 +264,19 @@
 
 static int do_acknowledge(unsigned char scancode)
 {
-	if (reply_expected) {
+	if (kbd_ex->reply_expected) {
 	  /* Unfortunately, we must recognise these codes only if we know they
 	   * are known to be valid (i.e., after sending a command), because there
 	   * are some brain-damaged keyboards (yes, FOCUS 9000 again) which have
 	   * keys with such codes :(
 	   */
 		if (scancode == KBD_REPLY_ACK) {
-			acknowledge = 1;
-			reply_expected = 0;
+			kbd_ex->acknowledge = 1;
+			kbd_ex->reply_expected = 0;
 			return 0;
 		} else if (scancode == KBD_REPLY_RESEND) {
-			resend = 1;
-			reply_expected = 0;
+			kbd_ex->resend = 1;
+			kbd_ex->reply_expected = 0;
 			return 0;
 		}
 		/* Should not happen... */
@@ -448,11 +452,16 @@
 #  ifdef CHECK_RECONNECT_SCANCODE
     printk(KERN_INFO "-=db=-: kbd_read_input() : scancode == %d\n",scancode);
 #  endif
+    // printk("scancode = %02x\n",scancode);
 		if (status & KBD_STAT_MOUSE_OBF) {
 			handle_mouse_event(scancode);
 		} else {
-			if (do_acknowledge(scancode))
-				handle_scancode(scancode, !(scancode & 0x80));
+			if (kbd_ex->do_acknowledge(scancode)) {
+			    if (!kbd_ex->kbd_check_event || 
+			            (kbd_ex->kbd_check_event && 
+			                kbd_ex->kbd_check_event(&scancode)))  
+			    handle_scancode(scancode, !(scancode & 0x80));
+			}    
 			mark_bh(KEYBOARD_BH);
 		}
 
@@ -495,14 +504,14 @@
 	do {
 		unsigned long timeout = KBD_TIMEOUT;
 
-		acknowledge = 0; /* Set by interrupt routine on receipt of ACK. */
-		resend = 0;
-		reply_expected = 1;
+		kbd_ex->acknowledge = 0; /* Set by interrupt routine on receipt of ACK. */
+		kbd_ex->resend = 0;
+		kbd_ex->reply_expected = 1;
 		kbd_write_output_w(data);
 		for (;;) {
-			if (acknowledge)
+			if (kbd_ex->acknowledge)
 				return 1;
-			if (resend)
+			if (kbd_ex->resend)
 				break;
 			mdelay(1);
 			if (!--timeout) {
@@ -721,8 +730,66 @@
 	return NULL;
 }
 
+int register_kbd_ex (pc_keyb_t * kb)
+{
+    unsigned long flags;
+
+    save_flags(flags);
+    if (kbd_store)
+       return -1;
+    else {
+	cli();    
+        if (!kb->do_acknowledge)      /* we can ovlerload this function */
+	   kb->do_acknowledge = kbd_ex->do_acknowledge;    
+	kb->kbd_write_command_w = kbd_write_command_w; 
+    	kb->kbd_write_output_w  = kbd_write_output_w;
+    	kb->send_data           = send_data;
+	kb->reply_expected      = kbd_ex->reply_expected;
+        kb->acknowledge         = kbd_ex->acknowledge;
+        kb->resend	        = kbd_ex->resend;
+        kbd_store 	        = kbd_ex;
+	kbd_ex  	        = kb;
+        restore_flags(flags);    
+    }
+    return  0;
+}
+
+int unregister_kbd_ex (pc_keyb_t * kb)
+{
+    unsigned long flags;
+
+    save_flags(flags);
+    if (!kbd_store)
+	return -1;
+    else {
+	cli();
+	kbd_ex    	   	= kbd_store;
+	kbd_store  	   	= NULL;
+	kbd_ex->reply_expected  = kb->reply_expected;
+        kbd_ex->acknowledge     = kb->acknowledge;
+        kbd_ex->resend	   	= kb->resend;
+        restore_flags(flags);	
+    }
+    return 0;	    
+}
+
+void __init kbd_ex_init(void)
+{
+    kbd_ex = &kbd_ex_mem;    		/* later as malloc */
+    kbd_ex->kbd_write_command_w = kbd_write_command_w;
+    kbd_ex->kbd_write_output_w = kbd_write_output_w; 
+    kbd_ex->do_acknowledge = do_acknowledge;
+    kbd_ex->send_data = send_data;
+    kbd_ex->kbd_check_event = NULL;    
+    kbd_ex->reply_expected=0;
+    kbd_ex->acknowledge=0;
+    kbd_ex->resend=0;
+    kbd_store = NULL;
+}
+
 void __init pckbd_init_hw(void)
 {
+	kbd_ex_init();
 	kbd_request_region();
 
 	/* Flush any pending input. */
--- linux.old/include/linux/pc_keyb.h	Mon Aug  9 21:04:41 1999
+++ linux/include/linux/pc_keyb.h	Tue Oct 31 10:20:10 2000
@@ -128,3 +128,18 @@
 	struct fasync_struct *fasync;
 	unsigned char buf[AUX_BUF_SIZE];
 };
+ 
+typedef struct {
+    void (*kbd_write_command_w)(int data);
+    void (*kbd_write_output_w) (int data);
+    int  (*do_acknowledge)  (unsigned char scancode);
+    int  (*kbd_check_event) (unsigned char * scancode); 
+    int  (*send_data) (unsigned char data);
+    volatile unsigned char reply_expected;
+    volatile unsigned char acknowledge;
+    volatile unsigned char resend;
+} pc_keyb_t;
+
+int   register_kbd_ex (pc_keyb_t * kb);
+int unregister_kbd_ex (pc_keyb_t * kb);
+

--UugvWAfsgieZRqgk--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
