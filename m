Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132061AbQLZVLe>; Tue, 26 Dec 2000 16:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbQLZVLZ>; Tue, 26 Dec 2000 16:11:25 -0500
Received: from [194.213.32.137] ([194.213.32.137]:22789 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132061AbQLZVLJ>;
	Tue, 26 Dec 2000 16:11:09 -0500
Message-ID: <20001226213833.A628@bug.ucw.cz>
Date: Tue, 26 Dec 2000 21:38:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <7sSHLPCmw-B@khms.westfalen.de> <kaih@khms.westfalen.de> <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com> <7sSHLPCmw-B@khms.westfalen.de> <20001224125023.A1900@scutter.internal.splhi.com> <7sX4YyEmw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <7sX4YyEmw-B@khms.westfalen.de>; from Kai Henningsen on Mon, Dec 25, 2000 at 01:12:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Sun, Dec 24, 2000 at 11:36:00AM +0200, Kai Henningsen wrote:
> 
> > There was a similar thread to this recently. The issue is that if you
> > choose the wrong processor type, you may not even be able to complain.
> 
> Hmm ... I think I can see ways around that (essentially similar to the 16  
> bit bootstrap code), but it may indeed be more trouble than it's worth.

Actually we are doing cpu detection during "uncompress" stage on
x86-64.

Here's how we do it: You might consider something similar.
								Pavel

--- arch/i386/boot/compressed/misc.c	Mon Nov 20 23:50:36 2000
+++ arch/x86_64/boot/compressed/misc.c	Mon Nov 13 21:10:26 2000
@@ -8,6 +8,7 @@
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
+asm(".code32"); 
 
 #include <linux/vmalloc.h>
 #include <asm/io.h>
@@ -340,6 +341,75 @@
 	}
 }
 
+void check_cpu(void)
+{
+	int res = 0;
+	asm volatile( " \n\
+	movl $3,%%edx		# at least 386 \n\
+	pushfl			# push EFLAGS \n\
+	popl %%eax		# get EFLAGS \n\
+	movl %%eax,%%ecx		# save original EFLAGS \n\
+	xorl $0x40000,%%eax	# flip AC bit in EFLAGS \n\
+	pushl %%eax		# copy to EFLAGS \n\
+	popfl			# set EFLAGS \n\
+	pushfl			# get new EFLAGS \n\
+	popl %%eax		# put it in eax \n\
+	xorl %%ecx,%%eax		# change in flags \n\
+	andl $0x40000,%%eax	# check if AC bit changed \n\
+	je 1f \n\
+\n\
+	movl $4,%%edx		# at least 486 \n\
+	movl %%ecx,%%eax \n\
+	xorl $0x200000,%%eax	# check ID flag \n\
+	pushl %%eax \n\
+	popfl			# if we are on a straight 486DX, SX, or \n\
+	pushfl			# 487SX we can't change it \n\
+	popl %%eax \n\
+	xorl %%ecx,%%eax \n\
+	pushl %%ecx		# restore original EFLAGS \n\
+	popfl \n\
+	andl $0x200000,%%eax \n\
+	je 1f \n\
+\n\
+	/* get vendor info */ \n\
+#	xorl %%eax,%%eax			# call CPUID with 0 -> return vendor ID \n\
+#	cpuid \n\
+#	movl $5, %%edx \n\
+#	cmpl $0x41757468,%%ebx		# check thats amd \n\
+#	jne 1f \n\
+\n\
+	mov $0x80000000,%%eax\n\	# Is extended cpuid supported?
+	cpuid\n\
+	test %%eax,0x80000000\n\
+	movl $5, %%edx \n\
+	jz 1f\n\
+\n\
+	movl $0x80000001,%%eax \n\
+	cpuid \n\
+	andl $0x20000000,%%edx \n\
+	movl $6, %%edx \n\
+	jz 1f \n\
+\n\
+	movl $7, %%edx \n\
+1:" : "=d" (res) : : "eax", "ebx", "ecx" );
+
+	switch (res) {
+	case 3: puts( "386" );
+		break;
+	case 4: puts( "486" );
+		break;
+	case 5: puts( "no extended cpuid" );
+		break;
+	case 6: puts( "non-64bit 586+" );
+		break;
+	case 7: puts( "64bit" );
+		break;
+	default:puts( "internal error" );
+		break;
+	}
+	if (res !=7)
+		error( "Sorry, your CPU is not capable of running 64-bit kernel." );
+}
 
 int decompress_kernel(struct moveparams *mv, void *rmode)
 {
@@ -360,7 +430,9 @@
 	else setup_output_buffer_if_we_run_high(mv);
 
 	makecrc();
-	puts("Uncompressing Linux... ");
+	puts("Checking CPU type... ");
+	check_cpu();
+	puts(", uncompressing Linux... ");
 	gunzip();
 	puts("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);



-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
