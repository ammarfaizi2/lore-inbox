Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTEVPrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTEVPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:47:41 -0400
Received: from holomorphy.com ([66.224.33.161]:35212 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262319AbTEVPre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:47:34 -0400
Date: Thu, 22 May 2003 09:00:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: keyboard.c/kd.h field width fixes
Message-ID: <20030522160029.GS29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jsimmons@infradead.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These guys get massive numbers of warnings about comparisons always true
or false due to limited ranges of data types. This appears to kill off
the warnings.


-- wli

diff -prauN mm8-2.5.69-1/drivers/char/keyboard.c mm8-2.5.69-2/drivers/char/keyboard.c
--- mm8-2.5.69-1/drivers/char/keyboard.c	2003-05-22 04:54:50.000000000 -0700
+++ mm8-2.5.69-2/drivers/char/keyboard.c	2003-05-22 08:02:02.000000000 -0700
@@ -76,7 +76,7 @@ void compute_shiftstate(void);
 	k_meta,		k_ascii,	k_lock,		k_lowercase,\
 	k_slock,	k_dead2,	k_ignore,	k_ignore
 
-typedef void (k_handler_fn)(struct vc_data *vc, unsigned char value, 
+typedef void (k_handler_fn)(struct vc_data *vc, unsigned short value, 
 			    char up_flag, struct pt_regs *regs);
 static k_handler_fn K_HANDLERS;
 static k_handler_fn *k_handler[16] = { K_HANDLERS };
@@ -589,11 +589,11 @@ static void fn_null(struct vc_data *vc, 
 /*
  * Special key handlers
  */
-static void k_ignore(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_ignore(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 }
 
-static void k_spec(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_spec(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -606,12 +606,12 @@ static void k_spec(struct vc_data *vc, u
 	fn_handler[value](vc, regs);
 }
 
-static void k_lowercase(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_lowercase(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	printk(KERN_ERR "keyboard.c: k_lowercase was called - impossible\n");
 }
 
-static void k_self(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_self(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;		/* no action, if this is a key release */
@@ -632,7 +632,7 @@ static void k_self(struct vc_data *vc, u
  * dead keys modifying the same character. Very useful
  * for Vietnamese.
  */
-static void k_dead2(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_dead2(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -642,21 +642,21 @@ static void k_dead2(struct vc_data *vc, 
 /*
  * Obsolete - for backwards compatibility only
  */
-static void k_dead(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_dead(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	static unsigned char ret_diacr[NR_DEAD] = {'`', '\'', '^', '~', '"', ',' };
 	value = ret_diacr[value];
 	k_dead2(vc, value, up_flag, regs);
 }
 
-static void k_cons(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_cons(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
 	set_console(value);
 }
 
-static void k_fn(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_fn(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -667,7 +667,7 @@ static void k_fn(struct vc_data *vc, uns
 		printk(KERN_ERR "k_fn called with value=%d\n", value);
 }
 
-static void k_cur(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_cur(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	static const char *cur_chars = "BDCA";
 
@@ -676,7 +676,7 @@ static void k_cur(struct vc_data *vc, un
 	applkey(vc, cur_chars[value], vc_kbd_mode(kbd, VC_CKMODE));
 }
 
-static void k_pad(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_pad(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	static const char *pad_chars = "0123456789+-*/\015,.?()#";
 	static const char *app_map = "pqrstuvwxylSRQMnnmPQS";
@@ -733,7 +733,7 @@ static void k_pad(struct vc_data *vc, un
 		put_queue(vc, 10);
 }
 
-static void k_shift(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_shift(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	int old_state = shift_state;
 
@@ -774,7 +774,7 @@ static void k_shift(struct vc_data *vc, 
 	}
 }
 
-static void k_meta(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_meta(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -786,7 +786,7 @@ static void k_meta(struct vc_data *vc, u
 		put_queue(vc, value | 0x80);
 }
 
-static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_ascii(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	int base;
 
@@ -808,14 +808,14 @@ static void k_ascii(struct vc_data *vc, 
 		npadch = npadch * base + value;
 }
 
-static void k_lock(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_lock(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag || rep)
 		return;
 	chg_vc_kbd_lock(kbd, value);
 }
 
-static void k_slock(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
+static void k_slock(struct vc_data *vc, unsigned short value, char up_flag, struct pt_regs *regs)
 {
 	k_shift(vc, value, up_flag, regs);
 	if (up_flag || rep)
diff -prauN mm8-2.5.69-1/include/linux/kd.h mm8-2.5.69-2/include/linux/kd.h
--- mm8-2.5.69-1/include/linux/kd.h	2003-05-04 16:53:37.000000000 -0700
+++ mm8-2.5.69-2/include/linux/kd.h	2003-05-22 07:57:24.000000000 -0700
@@ -95,8 +95,8 @@ struct unimapinit {
 #define	KDSKBLED	0x4B65	/* set led flags (not lights) */
 
 struct kbentry {
-	unsigned char kb_table;
-	unsigned char kb_index;
+	unsigned short kb_table;
+	unsigned short kb_index;
 	unsigned short kb_value;
 };
 #define		K_NORMTAB	0x00
@@ -108,7 +108,7 @@ struct kbentry {
 #define KDSKBENT	0x4B47	/* sets one entry in translation table */
 
 struct kbsentry {
-	unsigned char kb_func;
+	unsigned short kb_func;
 	unsigned char kb_string[512];
 };
 #define KDGKBSENT	0x4B48	/* gets one function key string entry */
