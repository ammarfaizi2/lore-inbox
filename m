Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTK1Xtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 18:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTK1Xtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 18:49:52 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:34573 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263568AbTK1Xts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 18:49:48 -0500
Message-ID: <3FC7DF1E.3090807@malguy.net>
Date: Sat, 29 Nov 2003 00:49:50 +0100
From: Baptiste Malguy <baptiste@malguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Sebastian Schmidt <yath@yath.eu.org>,
       Benjamin Reed <breed@almaden.ibm.com>
Subject: [PATCH] VT driver/char/console.c, kernel 2.4.22
Content-Type: multipart/mixed;
 boundary="------------050907030708010203090507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050907030708010203090507
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Abstract:
-----------

This patch makes effective the ability to redirect kernel messages to a 
specific VT through
the 'console=' argument. It is already supposed to work (that is, kernel 
messages only appear
on /dev/tty1 or /dev/tty2 or ...)  but actually does not (messages are 
always sent to the
foreground console, that is /dev/tty or /dev/tty0).

Sebastian Schmidt <yath -at- yath.eu.org> already noticed the problem in 
March 2003.
Benjamin Reed <breed -at- almaden.ibm.com> wrote a patch two years ago 
to correct this.
Here is a link to his post: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0108.2/1455.html
It seems have never been taken in account.

The patch I made is almost based on Benjamin's patch, completing its 
effectiveness via
vt_console_setup().

Relative comment:
---------------------

In relation to this patch, I want to say that many many websites, FAQs, 
... say that you must
have something like console="/dev/ttyX CONSOLE=/dev/ttyN" to redirect 
the kernel and init
messages.

About 'CONSOLE=', that's true because this is a environment variable 
that /sbin/init obtains.
About 'console=', it's completly wrong ! 'console=' expects a driver 
name (example: "tty",
"tty1", "ttyS0"), not device file name. Only the Linux source code 
reading and a few websites
says the right usage of 'console='.

Question
-----------
Is the way I attached the patch "correct"  ? Must I Cc: it to Marcello 
or someone else ? I didn't
find the ideal maintainer in linux/MAINTAINERS.

Bye.

-- 
Baptiste Malguy - http://baptiste.malguy.net
Ingénieur en informatique libre


--------------050907030708010203090507
Content-Type: text/plain;
 name="console-kmsg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="console-kmsg.diff"

*** linux-2.4.22/drivers/char/console.c	2002-11-29 00:53:12.000000000 +0100
--- work/linux-2.4.22-bm1/drivers/char/console.c	2003-11-28 16:45:58.000000000 +0100
***************
*** 144,149 ****
--- 144,150 ----
  static int con_open(struct tty_struct *, struct file *);
  static void vc_init(unsigned int console, unsigned int rows,
  		    unsigned int cols, int do_clear);
+ static void con_setup_vt(unsigned int currcons);
  static void blank_screen(unsigned long dummy);
  static void gotoxy(int currcons, int new_x, int new_y);
  static void save_cur(int currcons);
***************
*** 2178,2187 ****
--- 2179,2203 ----
  	return MKDEV(TTY_MAJOR, c->index ? c->index : fg_console + 1);
  }
  
+ int vt_console_setup(struct console *co, char *options)
+ {
+ 	if (co == NULL)
+ 		return -1;
+ 	
+ 	if (co->index > 0 &&
+ 	    co->index < MAX_NR_CONSOLES) {
+ 		con_setup_vt(co->index - 1);
+ 		kmsg_redirect = co->index;
+ 	}
+ 
+ 	return 0;
+ }
+ 
  struct console vt_console_driver = {
  	name:		"tty",
  	write:		vt_console_print,
  	device:		vt_console_device,
+ 	setup:		vt_console_setup,
  	unblank:	unblank_screen,
  	flags:		CON_PRINTBUFFER,
  	index:		-1,
***************
*** 2432,2437 ****
--- 2448,2471 ----
  }
  
  /*
+  * Setup a new VT
+  */
+ static void __init con_setup_vt(unsigned int currcons)
+ {
+ 	if (vc_cons[currcons].d) return;
+ 	
+ 	vc_cons[currcons].d = (struct vc_data *)
+ 		alloc_bootmem(sizeof(struct vc_data));
+ 	vt_cons[currcons] = (struct vt_struct *)
+ 		alloc_bootmem(sizeof(struct vt_struct));
+ 	visual_init(currcons, 1);
+ 	screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
+ 	kmalloced = 0;
+ 	vc_init(currcons, video_num_lines, video_num_columns, 
+ 		currcons || !sw->con_save_screen);
+ }
+ 
+ /*
   * This routine initializes console interrupts, and does nothing
   * else. If you want the screen to clear, call tty_write with
   * the appropriate escape-sequence.
***************
*** 2498,2512 ****
  	 * kmalloc is not running yet - we use the bootmem allocator.
  	 */
  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
! 		vc_cons[currcons].d = (struct vc_data *)
! 				alloc_bootmem(sizeof(struct vc_data));
! 		vt_cons[currcons] = (struct vt_struct *)
! 				alloc_bootmem(sizeof(struct vt_struct));
! 		visual_init(currcons, 1);
! 		screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
! 		kmalloced = 0;
! 		vc_init(currcons, video_num_lines, video_num_columns, 
! 			currcons || !sw->con_save_screen);
  	}
  	currcons = fg_console = 0;
  	master_display_fg = vc_cons[currcons].d;
--- 2532,2538 ----
  	 * kmalloc is not running yet - we use the bootmem allocator.
  	 */
  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
! 		con_setup_vt(currcons); 
  	}
  	currcons = fg_console = 0;
  	master_display_fg = vc_cons[currcons].d;

--------------050907030708010203090507--

