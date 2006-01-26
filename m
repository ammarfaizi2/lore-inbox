Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWAZCfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWAZCfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWAZCfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:35:43 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:58822 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750716AbWAZCfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:35:42 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Ashok Raj <ashok.raj@intel.com>
cc: akpm@osdl.org, ak@muc.de, linux-kernel@vger.kernel.org,
       randy.d.dunlap@intel.com
Subject: Re: wrongly marked __init/__initdata for CPU hotplug 
In-reply-to: Your message of "Wed, 25 Jan 2006 12:02:53 -0800."
             <20060125120253.A30999@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 Jan 2006 13:35:17 +1100
Message-ID: <4496.1138242917@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj (on Wed, 25 Jan 2006 12:02:53 -0800) wrote:
>There is 
>one another about init/main.c that i cant exactly zero in. (partly 
>because i dont know how to interpret the data thats spewed out of the tool).
>
>If there is a small example on how to co-related the data and find the culprit
>would be real handy. 
>
>Maybe Keith could help parse/give an example for me.

# reference_init.pl
Error: init/main.o .text refers to 00000000000001dc R_X86_64_PC32     .init.data+0x000000000000015b

Grep for the combination of the offset (1dc) and the target section
type (.init.data), also list the function names.

# objdump -Sr init/main.o | egrep   '1dc: .*init.data|<.*>:'
0000000000000000 <rest_init>:
000000000000002a <run_init_process>:
0000000000000044 <init>:
                        1dc: R_X86_64_PC32      .init.data+0x15b
0000000000000000 <nosmp>:
0000000000000010 <maxcpus>:
000000000000002b <debug_kernel>:
000000000000003f <quiet_kernel>:
0000000000000053 <loglevel>:
000000000000006f <unknown_bootoption>:
0000000000000278 <init_setup>:
000000000000029f <rdinit_setup>:
00000000000002c6 <do_early_param>:
000000000000031d <parse_early_param>:
0000000000000369 <start_kernel>:
000000000000054f <initcall_debug_setup>:

So the reference is coming from the init function.

Next dump the symbols of the .init.data section.

# objdump -d -j .init.data init/main.o | fgrep '>:'

0000000000000000 <__setup_str_initcall_debug_setup>:
000000000000000f <__setup_str_rdinit_setup>:
0000000000000017 <__setup_str_init_setup>:
000000000000001d <__setup_str_loglevel>:
0000000000000027 <__setup_str_quiet_kernel>:
000000000000002d <__setup_str_debug_kernel>:
0000000000000033 <__setup_str_maxcpus>:
000000000000003c <__setup_str_nosmp>:
0000000000000060 <tmp_cmdline.23394>:
0000000000000160 <done.23393>:
0000000000000164 <initcall_debug>:

That would normally list the name of the offending variable, but
sometimes (like now), it does not.  There is no symbol listed for
.init.data+15b.  Very strange.

Try disassembling the code around the offending reference.

# objdump -Sr init/main.o | grep -B10 -A10   '1dc: .*init.data'
                        1b3: R_X86_64_PC32      sysctl_init+0xfffffffffffffffc
 1b7:   65 48 8b 04 25 10 00    mov    %gs:0x10,%rax
 1be:   00 00
 1c0:   8b a8 44 e0 ff ff       mov    0xffffffffffffe044(%rax),%ebp
 1c6:   48 c7 c3 00 00 00 00    mov    $0x0,%rbx
                        1c9: R_X86_64_32S       __initcall_start
 1cd:   48 81 fb 00 00 00 00    cmp    $0x0,%rbx
                        1d0: R_X86_64_32S       __initcall_end
 1d4:   0f 83 96 00 00 00       jae    270 <init+0x22c>
 1da:   83 3d 00 00 00 00 00    cmpl   $0x0,0(%rip)        # 1e1 <init+0x19d>
                        1dc: R_X86_64_PC32      .init.data+0x15b			<===
 1e1:   74 2e                   je     211 <init+0x1cd>
 1e3:   48 8b 33                mov    (%rbx),%rsi
 1e6:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        1e9: R_X86_64_32S       .rodata.str1.1+0x17b
 1ed:   31 c0                   xor    %eax,%eax
 1ef:   e8 00 00 00 00          callq  1f4 <init+0x1b0>
                        1f0: R_X86_64_PC32      printk+0xfffffffffffffffc
 1f4:   48 8b 33                mov    (%rbx),%rsi
 1f7:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        1fa: R_X86_64_32S       .rodata.str1.1+0x194

So the reference is after the use of __initcall_start/__initcall_end
and before the printk().  Get the cpp generated code.

# make init/main.i

View init/main.i, find __initcall_start/__initcall_end.  The only
references are in do_initcalls() which is defined as .init.text.  But
the objdump that listed function names showed the reference was from
init(), not from do_initcalls().

This is nasty.  init() calls do_basic_setup() which calls
do_initcalls().  init is normal text.  do_basic_setup and do_initcalls
are .init.text.  gcc has inlined do_basic_setup and do_initcalls into
init, even though they have different section attributes.  Naughty gcc.

This was using GCC: (GNU) 4.0.2 20050901 (prerelease) (SUSE Linux).
Log a gcc bug.  Not a good omen for the idea of letting gcc decide when
to inline!

Looking at the C code for do_initcalls(), the reference is obviously to
initcall_debug.  I am puzzled about why the objdump lists
.init.data+0x15b when initcall_debug is really at .init.data+0x164.

BTW, does anybody know why init() is not defined as __init?

