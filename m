Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422826AbWJFSj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWJFSj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422831AbWJFSj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:39:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:11144 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422826AbWJFSj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:39:27 -0400
Date: Fri, 6 Oct 2006 14:38:46 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061006183846.GF19756@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <m1vemzbe4c.fsf@ebiederm.dsl.xmission.com> <20061004214403.e7d9f23b.akpm@osdl.org> <m1ejtnb893.fsf@ebiederm.dsl.xmission.com> <20061004233137.97451b73.akpm@osdl.org> <m14pui4w7t.fsf@ebiederm.dsl.xmission.com> <20061005235909.75178c09.akpm@osdl.org> <m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 06:56:03AM -0600, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Thu, 05 Oct 2006 09:29:42 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >> 
> >> In the lazy programmer school of fixes.
> >> 
> >> I haven't really tested this in any configuration.
> >> But reading video.S it does use variable in the bootsector.
> >> It does seem to initialize the variables before use.
> >> But obviously something is missed.
> >> 
> >> By zeroing the uninteresting parts of the bootsector just after we
> >> have determined we are loaded ok.  We should ensure we are
> >> always in a known state the entire time. 
> >> 
> >> Andrew if I am right about the cause of your video not working
> >> when you set an enhanced video mode this should fix your boot
> >> problem.
> >> 
> >> Singed-off-by: Eric Biederman <ebiederm@xmission.com>
> >> 
> >> diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
> >> index 53903a4..246ac88 100644
> >> --- a/arch/i386/boot/setup.S
> >> +++ b/arch/i386/boot/setup.S
> >> @@ -287,6 +287,13 @@ # Check if an old loader tries to load a
> >>  loader_panic_mess: .string "Wrong loader, giving up..."
> >>  
> >>  loader_ok:
> >> +# Zero initialize the variables we keep in the bootsector
> >> +	xorw	%di, %di
> >> +	xorb	%al, %al
> >> +	movw	$497, %cx
> >> +	rep
> >> +	stosb
> >> +
> >>  # Get memory size (extended mem, kB)
> >>  
> >>  	xorl	%eax, %eax
> >
> > That fixed the vga=0x263 crash.
> 
> Good.  We still have to be paranoid and address HPA's missing cld issues,
> But otherwise it looks like we are in good shape.
> 
Hi Eric,

I have added cld in the regenerated patch below. 

Also one more minor nit. stosb relies on being %es set properly. By the
time control reaches loader_ok, i could not find %es being set explicitly
hence I am assuming we are relying on bootloader to set it up for us. 

Maybe we can be little more paranoid and setup the %es before stosb. I
have done this change too in the attached patch. Pleaese have a look.
I know little about assembly code.


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

 arch/i386/boot/setup.S |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff -puN arch/i386/boot/setup.S~i386-set-bootset-to-zero-fix arch/i386/boot/setup.S
--- linux-2.6.18-git17/arch/i386/boot/setup.S~i386-set-bootset-to-zero-fix	2006-10-06 12:42:19.000000000 -0400
+++ linux-2.6.18-git17-root/arch/i386/boot/setup.S	2006-10-06 12:49:37.000000000 -0400
@@ -287,6 +287,17 @@ good_sig:
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
