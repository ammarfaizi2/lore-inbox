Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTK2NRU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 08:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTK2NRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 08:17:20 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:41996 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263650AbTK2NRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 08:17:16 -0500
Message-ID: <3FC89C59.8020304@malguy.net>
Date: Sat, 29 Nov 2003 14:17:13 +0100
From: Baptiste Malguy <baptiste@malguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VT driver/char/console.c, kernel 2.4.22
References: <3FC7DF1E.3090807@malguy.net> <20031129072447.GA17722@alpha.home.local>
In-Reply-To: <20031129072447.GA17722@alpha.home.local>
Content-Type: multipart/mixed;
 boundary="------------000305010200080105060204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000305010200080105060204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Willy Tarreau a écrit :

>On Sat, Nov 29, 2003 at 12:49:50AM +0100, Baptiste Malguy wrote:
> 
>  
>
>>In relation to this patch, I want to say that many many websites, FAQs, 
>>... say that you must
>>have something like console="/dev/ttyX CONSOLE=/dev/ttyN" to redirect 
>>the kernel and init
>>messages.
>>
>>About 'CONSOLE=', that's true because this is a environment variable 
>>that /sbin/init obtains.
>>About 'console=', it's completly wrong ! 'console=' expects a driver 
>>name (example: "tty",
>>"tty1", "ttyS0"), not device file name. Only the Linux source code 
>>reading and a few websites
>>says the right usage of 'console='.
>>    
>>
>
>If there really are FAQ reporting this, it might be simpler to make the
>kernel accept /dev/XXX than to try to fix all FAQs, and it would be more
>intuitive to people who type on lilo command line.
>  
>
I guess you are right. However, all I've done (and again, essentially, 
using someone else
code) is to fix of bug. Changing the way the 'console=' argument works 
is more a
design stuff.

If all the console drivers' names are based on the device file name 
(that is "tty" for "/dev/tty1",
ort "/dev/tty2", ...) it can be easily done by dropping "/dev/" from the 
'console=' argument value, in
one C file. However, a device file name can be anything you want. So the 
"/dev/" wouldn't work.

I don't know if that's the good way to do it. Maybe a more complete 
work, like looking at the device file,
its major and minor and the corresponding driver, would be a better idea.

>You'd better send an "unified diff" (diff -u) which includes one level of
>kernel directory. You diff then starts like this :
>--- linux-2.4.22/drivers/char/console
>+++ linux-2.4.22-bm1/drivers/char/console
>  
>
Yes, sure, I read that before and did not even do that .... I'd better 
sleep more at night :)
Here it comes now.

I have tested with 'vga=normal' and 'vga=792'. That's fine for me. 
However, I may have not taken in
consideration some locks required. I let interested people test for a 
few days before sending to Marcello.

Thank you for your comments.

-- 
Baptiste Malguy - http://baptiste.malguy.net
Ingénieur en informatique libre


--------------000305010200080105060204
Content-Type: text/plain;
 name="console-kmsg2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="console-kmsg2.diff"

--- linux-2.4.22/drivers/char/console.c	2002-11-29 00:53:12.000000000 +0100
+++ work/linux-2.4.22-bm1/drivers/char/console.c	2003-11-28 17:12:47.000000000 +0100
@@ -144,6 +144,7 @@
 static int con_open(struct tty_struct *, struct file *);
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
+static void con_setup_vt(unsigned int currcons);
 static void blank_screen(unsigned long dummy);
 static void gotoxy(int currcons, int new_x, int new_y);
 static void save_cur(int currcons);
@@ -2178,10 +2179,25 @@
 	return MKDEV(TTY_MAJOR, c->index ? c->index : fg_console + 1);
 }
 
+int vt_console_setup(struct console *co, char *options)
+{
+	if (co == NULL)
+		return -1;
+	
+	if (co->index > 0 &&
+	    co->index < MAX_NR_CONSOLES) {
+		con_setup_vt(co->index - 1);
+		kmsg_redirect = co->index;
+	}
+
+	return 0;
+}
+
 struct console vt_console_driver = {
 	name:		"tty",
 	write:		vt_console_print,
 	device:		vt_console_device,
+	setup:		vt_console_setup,
 	unblank:	unblank_screen,
 	flags:		CON_PRINTBUFFER,
 	index:		-1,
@@ -2432,6 +2448,24 @@
 }
 
 /*
+ * Setup a new VT
+ */
+static void __init con_setup_vt(unsigned int currcons)
+{
+	if (vc_cons[currcons].d) return;
+	
+	vc_cons[currcons].d = (struct vc_data *)
+		alloc_bootmem(sizeof(struct vc_data));
+	vt_cons[currcons] = (struct vt_struct *)
+		alloc_bootmem(sizeof(struct vt_struct));
+	visual_init(currcons, 1);
+	screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
+	kmalloced = 0;
+	vc_init(currcons, video_num_lines, video_num_columns, 
+		currcons || !sw->con_save_screen);
+}
+
+/*
  * This routine initializes console interrupts, and does nothing
  * else. If you want the screen to clear, call tty_write with
  * the appropriate escape-sequence.
@@ -2498,15 +2532,7 @@
 	 * kmalloc is not running yet - we use the bootmem allocator.
 	 */
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
-		vc_cons[currcons].d = (struct vc_data *)
-				alloc_bootmem(sizeof(struct vc_data));
-		vt_cons[currcons] = (struct vt_struct *)
-				alloc_bootmem(sizeof(struct vt_struct));
-		visual_init(currcons, 1);
-		screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
-		kmalloced = 0;
-		vc_init(currcons, video_num_lines, video_num_columns, 
-			currcons || !sw->con_save_screen);
+		con_setup_vt(currcons); 
 	}
 	currcons = fg_console = 0;
 	master_display_fg = vc_cons[currcons].d;

--------------000305010200080105060204--

