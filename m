Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWJHQro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWJHQro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 12:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWJHQrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 12:47:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:7835 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750813AbWJHQrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 12:47:42 -0400
Date: Sun, 8 Oct 2006 12:47:13 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com, kraxel@suse.de
Subject: Re: [PATCH 1/12] i386: Distinguish absolute symbols
Message-ID: <20061008164713.GA7149@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003170413.GA3164@in.ibm.com> <20061006233547.43888a48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006233547.43888a48.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 11:35:47PM -0700, Andrew Morton wrote:
> On Tue, 3 Oct 2006 13:04:13 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > Ld knows about 2 kinds of symbols,  absolute and section
> > relative.  Section relative symbols symbols change value
> > when a section is moved and absolute symbols do not.
> > 
> > Currently in the linker script we have several labels
> > marking the beginning and ending of sections that
> > are outside of sections, making them absolute symbols.
> > Having a mixture of absolute and section relative
> > symbols refereing to the same data is currently harmless
> > but it is confusing.
> > 
> > This must be done carefully as newer revs of ld do not place
> > symbols that appear in sections without data and instead
> > ld makes those symbols global :(
> > 
> > My ultimate goal is to build a relocatable kernel.  The
> > safest and least intrusive technique is to generate
> > relocation entries so the kernel can be relocated at load
> > time.  The only penalty would be an increase in the size
> > of the kernel binary.  The problem is that if absolute and
> > relocatable symbols are not properly specified absolute symbols
> > will be relocated or section relative symbols won't be, which
> > is fatal.
> > 
> > The practical motivation is that when generating kernels that
> > will run from a reserved area for analyzing what caused
> > a kernel panic, it is simpler if you don't need to hard code
> > the physical memory location they will run at, especially
> > for the distributions.
> 
> This patch causes the following warnings:
> 
> /opt/crosstool/gcc-4.1.0-glibc-2.3.6/i686-unknown-linux-gnu/bin/i686-unknown-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section `.smp_altinstr_replacement' not in segment
> /opt/crosstool/gcc-4.1.0-glibc-2.3.6/i686-unknown-linux-gnu/bin/i686-unknown-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section `.smp_altinstr_replacement' not in segment
> /opt/crosstool/gcc-4.1.0-glibc-2.3.6/i686-unknown-linux-gnu/bin/i686-unknown-linux-gnu-ld: vmlinux: warning: allocated section `.smp_altinstr_replacement' not in segment
> 
> The patch
> i386-force-section-size-to-be-non-zero-to-prevent-a-symbol-becoming-absolute.patch
> makes those warnings go away again, but we decided to drop that.
> 
> This:
> 
>   .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
> 	*(.smp_altinstr_replacement)
> 	. = ALIGN(4096);
> 	__smp_alt_end = .;
>   }
> 
> looks odd.  What's the point in putting a gap before __smp_alt_end?  Moving
> __smp_alt_end to before the ALIGN doesn't prevent the warning.
> 

Actually this ALIGN(4096) was already present present before symbol
__smp_alt_end that's why we kept it even when we moved __smp_alt_end
inside the section.

But now thinking about it, it looks like this ALIGN(4096) might not be
required. There is already one ALIGN(4086) present after this section
which should take care of protecting other data while this page is freed.

Please find attached a patch for the same. I am also copying Gerd Hoffmann,
who introduced this ALIGN. Gerd, can you please confirm that above ALIGN()
is not required and the patch attached should be fine.

As a side effect, above warning also disappears. Looks like there is no
data in the section .smp_altinstr_replacement but above ALIGN() forced
the linker to create a non-empty allocatable section. The type of the
section is NOBITS and probably that's why linker is emitting the warning.
I will write a separate mail to linker folks to find more about it.

Thanks
Vivek
  

o There seems to be one extra ALIGN(4096) before symbol __smp_alt_end. The
  only usage of __smp_alt_end is to mark the end of smp alternative
  sections so that this memory can be freed. As a physical page is freed
  one has to just make sure that there is no other data on the same page
  where __smp_alt_end is pointing. There is already a ALIGN(4096) after
  this section which should take care of the above issue. Hence it looks
  like the ALIGN(4096) before __smp_alt_end is redundant and not required.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.19-rc1-vivek/arch/i386/kernel/vmlinux.lds.S |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/i386/kernel/vmlinux.lds.S~i386-remove-unnecessary-align-option arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.19-rc1/arch/i386/kernel/vmlinux.lds.S~i386-remove-unnecessary-align-option	2006-10-08 12:33:05.000000000 -0400
+++ linux-2.6.19-rc1-vivek/arch/i386/kernel/vmlinux.lds.S	2006-10-08 12:33:05.000000000 -0400
@@ -112,7 +112,6 @@ SECTIONS
   }
   .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
 	*(.smp_altinstr_replacement)
-	. = ALIGN(4096);
 	__smp_alt_end = .;
   }
 
_
