Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135505AbRA1KNV>; Sun, 28 Jan 2001 05:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRA1KNM>; Sun, 28 Jan 2001 05:13:12 -0500
Received: from 13dyn128.delft.casema.net ([212.64.76.128]:60940 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135505AbRA1KM6>; Sun, 28 Jan 2001 05:12:58 -0500
Message-Id: <200101281012.LAA04278@cave.bitwizard.nl>
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A733CA0.C05D8BBC@transmeta.com> from "H. Peter Anvin" at "Jan
 27, 2001 01:24:48 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Sun, 28 Jan 2001 11:12:08 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> > All that I can think of right now is:
> >  - Find a register that can be written without side effects in
> >   "standard" hardware like a keyboard controller, or interrupt
> >    controller. Especially good are ones that already require us to keep
> >    a shadow value. Write the shadow variable to the register.
> >   (Tricky: not interrupt safe!)
> >  - Find a scratch register (like the one in the 16450).
> > 
> >  - Is port 0x81 possibly "quite often" free?
> > 
> 
> Who knows?  That's the thing you're going to have to find out if you want
> to push this.  Again, the only way anyone is ever going to find out is by
> doing *lots* of research (look at things like Ralf Brown's Interrupt
> List), *then* followed by lots and lots of testing to smoke out boxes
> that don't work for this.


> Again, such bumping entails:
> 
> 	- Modify the code
> 	- Test the hell out of it
> 	- Submit the patch

Ok. I've thought about it some more, but I don't care enough about
this issue to do the painstaking legwork: I don't have one of those
POST-code indicators on port 0x80.

I've made the "pause" in outb_p just a few (*) ns slower, because it
now loads a variable before outputting the value to port 0x80. As the
whole idea about this is "pausing", making it a bit slower shouldn't
matter too much.  I've tested it: It compiles, it boots. 

I'm not too familar with the syntax of the "asm" statement. So I may
illegally be modifying the AX register. I don't care enough about this
to figure it out right now.

I expect the post_val not to do anything useful at the moment. That is
trivial to add, and not my problem. You can put the load in there
while the system runs. And/or output one byte of data when the system
Ooopses. And/or put values there during the boot process. This will
allow you for instance to see wether the system crashes because you
compiled it for the wrong processor.

Below is the patch. Feel free to test. Someone please jump in and try
to motivate more people to test and submit to Linus once convinced it
always works.

		Roger. 


(*) About 100 when the value is not in the cache.


-------------------------------------------------------------------------

diff -ur linux-2.4.0.clean/arch/i386/boot/compressed/misc.c linux-2.4.0.post/arch/i386/boot/compressed/misc.c
--- linux-2.4.0.clean/arch/i386/boot/compressed/misc.c	Mon Jul 31 19:48:17 2000
+++ linux-2.4.0.post/arch/i386/boot/compressed/misc.c	Sun Jan 28 11:02:26 2001
@@ -113,6 +113,8 @@
 static int vidport;
 static int lines, cols;
 
+int post_val;
+
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
diff -ur linux-2.4.0.clean/include/asm-i386/io.h linux-2.4.0.post/include/asm-i386/io.h
--- linux-2.4.0.clean/include/asm-i386/io.h	Fri Jan 26 10:27:44 2001
+++ linux-2.4.0.post/include/asm-i386/io.h	Sun Jan 28 10:53:23 2001
@@ -37,7 +37,7 @@
 #ifdef SLOW_IO_BY_JUMPING
 #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
 #else
-#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
+#define __SLOW_DOWN_IO "\nmovb post_val,%%al\noutb %%al,$0x80"
 #endif
 
 #ifdef REALLY_SLOW_IO
@@ -45,6 +45,8 @@
 #else
 #define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
 #endif
+
+extern int post_val; 
 
 /*
  * Talk about misusing macros..
diff -ur linux-2.4.0.clean/init/main.c linux-2.4.0.post/init/main.c
--- linux-2.4.0.clean/init/main.c	Thu Jan  4 05:45:26 2001
+++ linux-2.4.0.post/init/main.c	Sun Jan 28 10:50:31 2001
@@ -130,6 +130,8 @@
 char *execute_command;
 char root_device_name[64];
 
+int post_val;
+
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 static char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
