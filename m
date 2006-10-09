Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932879AbWJIOeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbWJIOeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWJIOeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:34:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:16839 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932879AbWJIOeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:34:17 -0400
Date: Mon, 9 Oct 2006 10:33:45 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061009143345.GB17572@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061004214403.e7d9f23b.akpm@osdl.org> <m1ejtnb893.fsf@ebiederm.dsl.xmission.com> <20061004233137.97451b73.akpm@osdl.org> <m14pui4w7t.fsf@ebiederm.dsl.xmission.com> <20061005235909.75178c09.akpm@osdl.org> <m1bqop38nw.fsf@ebiederm.dsl.xmission.com> <20061006183846.GF19756@in.ibm.com> <4526A66B.4030805@zytor.com> <m1ac49z2fl.fsf@ebiederm.dsl.xmission.com> <4526D084.1030700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4526D084.1030700@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 02:54:12PM -0700, H. Peter Anvin wrote:
> Eric W. Biederman wrote:
> >"H. Peter Anvin" <hpa@zytor.com> writes:
> >
> >>Vivek Goyal wrote:
> >>>Hi Eric,
> >>>I have added cld in the regenerated patch below.
> >>No, the cld needs to be earlier.  It turns out this isn't the first use of
> >>string instructions.
> >
> >Can we rely on the int calls not setting df?  Otherwise we need to clear
> >df at each use as we do with all of the later uses.
> >
> 
> Yes, we can, with a few exceptions.  INT saves the flags and IRET 
> restores them.
>

Ok. I have added the "cld" early in the setup code. I am still retaining
the call to "cld" just before string instruction to be on the safer side.

Please find attached the regenerated patch.



In the lazy programmer school of fixes.

I haven't really tested this in any configuration.
But reading video.S it does use variable in the bootsector.
It does seem to initialize the variables before use.
But obviously something is missed.

By zeroing the uninteresting parts of the bootsector just after we
have determined we are loaded ok.  We should ensure we are
always in a known state the entire time. 

Andrew if I am right about the cause of your video not working
when you set an enhanced video mode this should fix your boot
problem.

Singed-off-by: Eric Biederman <ebiederm@xmission.com>

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.19-rc1-vivek/arch/i386/boot/setup.S |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN arch/i386/boot/setup.S~i386-set-bootset-to-zero-fix arch/i386/boot/setup.S
--- linux-2.6.19-rc1/arch/i386/boot/setup.S~i386-set-bootset-to-zero-fix	2006-10-09 10:11:58.000000000 -0400
+++ linux-2.6.19-rc1-vivek/arch/i386/boot/setup.S	2006-10-09 10:27:42.000000000 -0400
@@ -167,6 +167,7 @@ trampoline:	call	start_of_setup
 # End of setup header #####################################################
 
 start_of_setup:
+	cld 				# set DF=0
 # Bootlin depends on this being done early
 	movw	$0x01500, %ax
 	movb	$0x81, %dl
@@ -287,6 +288,17 @@ good_sig:
 loader_panic_mess: .string "Wrong loader, giving up..."
 
 loader_ok:
+# Zero initialize the variables we keep in the bootsector
+	movw	%cs, %ax			# aka SETUPSEG
+	subw	$DELTA_INITSEG, %ax		# aka INITSEG
+	movw	%ax, %es
+	xorw	%di, %di
+	xorb	%al, %al
+	movw	$497, %cx
+	cld
+	rep
+	stosb
+
 # Get memory size (extended mem, kB)
 
 	xorl	%eax, %eax
_
