Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273182AbRIJDXN>; Sun, 9 Sep 2001 23:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273181AbRIJDXD>; Sun, 9 Sep 2001 23:23:03 -0400
Received: from member.michigannet.com ([207.158.188.18]:13834 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S273180AbRIJDWs>; Sun, 9 Sep 2001 23:22:48 -0400
Date: Sun, 9 Sep 2001 23:21:52 -0400
From: Paul <set@pobox.com>
To: Benjamin Reed <breed@almaden.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG/PATCH:  Unable to specify console=ttyX where X != 0
Message-ID: <20010909232152.A225@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Benjamin Reed <breed@almaden.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <3B8441A7.63D721B@almaden.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B8441A7.63D721B@almaden.ibm.com>; from breed@almaden.ibm.com on Wed, Aug 22, 2001 at 04:35:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Reed <breed@almaden.ibm.com>, on Wed Aug 22, 2001 [04:35:03 PM] said:
> The serial_console.txt file implies that you can specify other vt's
> beside tty0 to use as a console using the console= kernel parameter. 
> However, if you specify any ttyX it always goes to tty0.  Closer
> examination shows that when the console is registered it is ignoring the
> specified tty.
> 
> Basically, I want all the kernel messages to go to tty2 so that I can
> have a nice clean user interaction on tty1, but still allow access to
> kernel messages on tty2.
> 
> The following patch sets up the correct tty to send the messages to
> based on the console= parameter and initializes the virtual terminal.
> 
> enjoy
> 
> ben

	Hello.

	Ben seems to be correct. Without this patch, the console=
boot param doesnt work as expected.
	eg. I use 'console=tty1 console=ttyS1,9600n8'
	Without the patch, printks go to the current vt
(tty0) instead of where they should. [they do go to the serial
console, propperly however] This is annoying, as I run
some X sessions on vt9/10 and wanted the logs to go to vt1 even
when I am in X. In fact, the default behaviour of having tty0 be
the console seems broken; if you _are_ using just vt's, you can't
leave the logging behind. (eg. this is a pain when verbose or
spurious logging is going on and you want to switch back and
forth between the logging vt and a working vt)
	I cannot vouch that this is the correct fix, but I
would like to see this fixed, or learn why it should not be.
	Here is Ben's patch vs. 2.4.9-ac10. It seems to work good
for me so far.

Paul
set@pobox.com

--- 2.4.9-ac10/drivers/char/console.c	Sun Sep  9 16:55:06 2001
+++ 2.4.9-ac10-cons/drivers/char/console.c	Sun Sep  9 22:57:22 2001
@@ -2425,6 +2425,21 @@
 struct tty_driver console_driver;
 static int console_refcount;
 
+void __init con_setup_vt(unsigned int currcons)
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
 void __init con_init(void)
 {
 	const char *display_desc = NULL;
@@ -2483,15 +2498,7 @@
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
@@ -2508,6 +2515,12 @@
 
 #ifdef CONFIG_VT_CONSOLE
 	register_console(&vt_console_driver);
+        if (vt_console_driver.index > 0 &&
+	    vt_console_driver.index < MAX_NR_CONSOLES) {
+		con_setup_vt(vt_console_driver.index-1);
+		kmsg_redirect = vt_console_driver.index;
+	}
+
 #endif
 }
 
