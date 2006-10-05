Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWJEQe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWJEQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWJEQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:34:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:19376 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750768AbWJEQe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:34:26 -0400
Date: Thu, 5 Oct 2006 12:33:47 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Horms <horms@verge.net.au>, Magnus Damm <magnus@valinux.co.jp>,
       Andi Kleen <ak@muc.de>, Ian.Campbell@XenSource.com
Subject: Re: 2.6.19-rc1: kexec broken on x86_64
Message-ID: <20061005163347.GD20551@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <aec7e5c30610050328i2bf9e3b6qcacc1873231ece28@mail.gmail.com> <20061005134522.GB20551@in.ibm.com> <aec7e5c30610050656u6d287752pc9d1bcbb807442d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30610050656u6d287752pc9d1bcbb807442d3@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 10:56:51PM +0900, Magnus Damm wrote:
> Hi Vivek,
> 
> On 10/5/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >On Thu, Oct 05, 2006 at 07:28:35PM +0900, Magnus Damm wrote:
> >> Kexec is broken on x86_64 under 2.6.19-rc1.
> >>
> >> Or rather - kexec works ok under 2.6.19-rc1, but something related to
> >> the vmlinux format has probably changed and kexec-tools fails to load
> >> a vmlinux from 2.6.19-rc1.
> >>
> >> Loading bzImage works as usual, but vmlinux does not load properly.
> >>
> >> The kexec binary fails with the following message:
> >>
> >> Overlapping memory segments at 0x351000
> >> sort_segments failed
> >> / #
> >>
> >
> >Hi Magnus,
> >
> >Can you please post the readelf -l output of the vmlinux you are trying
> >to load. That's will give some indication if the segments are really
> >overlapping in vmlinux or is it some processing bug at kexec-tools part.
> 
> Elf file type is EXEC (Executable file)
> Entry point 0x100100
> There are 4 program headers, starting at offset 64
> 
> Program Headers:
>  Type           Offset             VirtAddr           PhysAddr
>                 FileSiz            MemSiz              Flags  Align
>  LOAD           0x0000000000100000 0xffffffff80100000 0x0000000000100000
>                 0x00000000001a4888 0x00000000001a4888  R E    100000
>  LOAD           0x00000000002a5000 0xffffffff802a5000 0x00000000002a5000
>                 0x000000000008e086 0x00000000000c1504  RWE    100000
>  LOAD           0x0000000000400000 0xffffffffff600000 0x00000000002fd000
>                 0x0000000000000c08 0x0000000000000c08  RWE    100000
>  NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                 0x0000000000000000 0x0000000000000000  R      8
> 
> Section to Segment mapping:
>  Segment Sections...
>   00     .text __ex_table .rodata .pci_fixup __ksymtab __ksymtab_gpl
> __ksymtab_unused __ksymtab_strings __param
>   01     .data .data.cacheline_aligned .data.read_mostly
> .data.init_task .data.page_aligned .init.text .init.data .init.setup
> .initcall.init .con_initcall.init .altinstructions
> .altinstr_replacement .exit.text .init.ramfs .bss
>   02     .vsyscall_0 .xtime_lock .vxtime .vgetcpu_mode .sys_tz
> .sysctl_vsyscall .xtime .jiffies .vsyscall_1 .vsyscall_2 .vsyscall_3
>   03
>

Hi Magnus,

I think this got introduced because of Ian Cambell's patch for creating
PT_NOTE headers. Can you please try attached patch. I think it should
fix the issue.

Thanks
Vivek
 


o A recent change to vmlinux.ld.S file broke kexec as now resulting vmlinux
  program headers are overlapping in physical address space.

o Now all the vsyscall related sections are placed after data and after
  that mostly init data sections are placed. To avoid physical overlap
  among phdrs, there are three possible solutions.	
	- Place vsyscall sections also in data phdrs instead of user
	- move vsyscal sections after init data in bss.
	- create another phdrs say data.init and move all the sections
	  after vsyscall into this new phdr.

o This patch implements the third solution. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/vmlinux.lds.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64-physical-addr-space-overlap-in-phdrs-fix arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.19-rc1-1M/arch/x86_64/kernel/vmlinux.lds.S~x86_64-physical-addr-space-overlap-in-phdrs-fix	2006-10-05 12:15:00.000000000 -0400
+++ linux-2.6.19-rc1-1M-root/arch/x86_64/kernel/vmlinux.lds.S	2006-10-05 12:15:00.000000000 -0400
@@ -17,6 +17,7 @@ PHDRS {
 	text PT_LOAD FLAGS(5);	/* R_E */
 	data PT_LOAD FLAGS(7);	/* RWE */
 	user PT_LOAD FLAGS(7);	/* RWE */
+	data.init PT_LOAD FLAGS(7);	/* RWE */
 	note PT_NOTE FLAGS(4);	/* R__ */
 }
 SECTIONS
@@ -131,7 +132,7 @@ SECTIONS
   . = ALIGN(8192);		/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 	*(.data.init_task)
-  } :data
+  }:data.init
 
   . = ALIGN(4096);
   .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
_
