Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422886AbWHYURK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422886AbWHYURK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422887AbWHYURK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:17:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10431 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932245AbWHYURI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:17:08 -0400
Date: Fri, 25 Aug 2006 16:16:17 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Horms <horms@verge.net.au>,
       Linda Wang <lwang@redhat.com>, linux-kernel@vger.kernel.org,
       "H. Peter Anvin" <hpa@zytor.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060825201617.GC8909@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060705222448.GC992@in.ibm.com> <aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com> <20060706081520.GB28225@host0.dyn.jankratochvil.net> <aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com> <20060707133518.GA15810@in.ibm.com> <20060707143519.GB13097@host0.dyn.jankratochvil.net> <20060710233219.GF16215@in.ibm.com> <20060711010815.GB1021@host0.dyn.jankratochvil.net> <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 10:19:04AM -0600, Eric W. Biederman wrote:
> 
> I have spent some time and have gotten my relocatable kernel patches
> working against the latest kernels.  I intend to push this upstream
> shortly.
> 
> Could all of the people who care take a look and test this out
> to make certain that it doesn't just work on my test box?
> 
> My approach is to extend bzImage so that it is an ET_DYN ELF executable
> (we have what used to be a bootsector where we can put the header).
> Boot loaders are explicitly not expected to process relocations.
> 
> The x86_64 kernel is simply built to live at a fixed virtual address
> and the boot page tables are relocated.  The i386 kernel is built
> to process relocates generated with --embedded-relocs (after vmlinux.lds.S)
> has been fixed up to sort out static and dynamic relocations.
> 
> Currently there are 33 patches in my tree to do this.
> 
> The weirdest symptom I have had so far is that page faults did not
> trigger the early exception handler on x86_64 (instead I got a reboot).
> 
> The code should be available shortly at:
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/linux-2.6-reloc.git#reloc-v2.6.18-rc3
> 
> If all goes well with the testing I will push the patches to Andrew in the next couple 
> of days.

It breaks powerpc build as poewrpc does not seem to be defining symbol
_text which is used by arch independent kallsyms.c. Attached is the one
line fix.

Thanks
Vivek


o ppc64 does not seem to be defining symbol _text  which is used by
  kernel/kallsyms.c for relocatable kernel patches. Instead of absolute
  symbol addresses now it is stored as offset from symbol _text
  (_text + offset) so that relocations entries for this section are
  generated, if need be. (currently i386 will be the only user once
  the relocatable kernel patches are merged).

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/powerpc/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/powerpc/kernel/vmlinux.lds.S~ppc64-compilation-fix arch/powerpc/kernel/vmlinux.lds.S
--- linux-2.6.18-rc3-1M/arch/powerpc/kernel/vmlinux.lds.S~ppc64-compilation-fix	2006-08-24 16:16:17.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/powerpc/kernel/vmlinux.lds.S	2006-08-24 16:26:33.000000000 -0400
@@ -33,6 +33,7 @@ SECTIONS
 
 	/* Text and gots */
 	.text : {
+		_text = .;
 		*(.text .text.*)
 		SCHED_TEXT
 		LOCK_TEXT
_
