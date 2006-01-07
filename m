Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWAGHkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWAGHkq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWAGHkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:40:46 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:59281 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932298AbWAGHkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:40:45 -0500
Message-ID: <43BF7075.3060703@cosmosbay.com>
Date: Sat, 07 Jan 2006 08:40:37 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/4] Series to allow a "const" file_operations struct
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>	<1136584539.2940.105.camel@laptopd505.fenrus.org>	<43BEF338.3010403@cosmosbay.com> <20060106162913.7621895c.akpm@osdl.org>
In-Reply-To: <20060106162913.7621895c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> On my x86_64 machine, I managed to reduce by 10% .data section by moving all 
>> file_operations, but also 'address_space_operations', 'inode_operations, 
>> super_operations, dentry_operations, seq_operations, ... to rodata section.
>>
>> size vmlinux*
>>     text    data     bss     dec     hex filename
>> 2476156  522236  244868 3243260  317cfc vmlinux
>> 2588685  571348  246692 3406725  33fb85 vmlinux.old
>>
> 
> Confused.   Why should this result in an aggregate reduction in vmlinux size?
> 
> 

Sorry, vmlinux.old was with CONFIG_FRAME_POINTER and CONFIG_MODULES, not 'vmlinux'

If I add back CONFIG_FRAME_POINTER / CONFIG_MODULES on my config I get :

# size vmlinux
    text    data     bss     dec     hex filename
2627717  523988  244868 3396573  33d3dd vmlinux


Aggregate reduction might be possible because of 'const' : Compiler (gcc-3.4.4 
here) is free to make further optimizations ?

# size -A vmlinux
vmlinux  :
section                      size                   addr
.text                     2128492   18446744071563116544
__ex_table                  15408   18446744071565245040
.rodata                    256486   18446744071565260448
.pci_fixup                   2112   18446744071565516944
__ksymtab                   34336   18446744071565519056
__ksymtab_gpl                5488   18446744071565553392
__kcrctab                       0   18446744071565558880
__kcrctab_gpl                   0   18446744071565558880
__ksymtab_strings           54978   18446744071565558880
__param                      2560   18446744071565613864
.data                      408392   18446744071565616448
.bss                       244868   18446744071566024896
.data.cacheline_aligned     23936   18446744071566270464
.data.read_mostly            7296   18446744071566294400
.vsyscall_0                   319   18446744073699065856
.xtime_lock                     8   18446744073699066176
.vxtime                        48   18446744073699066192
.wall_jiffies                   8   18446744073699066240
.sys_tz                         8   18446744073699066256
.sysctl_vsyscall                4   18446744073699066272
.xtime                         16   18446744073699066288
.jiffies                        8   18446744073699066304
.vsyscall_1                    47   18446744073699066880
.vsyscall_2                    13   18446744073699067904
.vsyscall_3                    13   18446744073699068928
.data.init_task              8192   18446744071566311424
.init.text                 124192   18446744071566319616
.init.data                  42584   18446744071566443808
.init.setup                  2184   18446744071566486400
.initcall.init               1240   18446744071566488584
.con_initcall.init             24   18446744071566489824
.security_initcall.init         0   18446744071566489848
.altinstructions              139   18446744071566489848
.altinstr_replacement          93   18446744071566489987
.exit.text                   2907   18446744071566490080
.init.ramfs                   134   18446744071566495744
.data.percpu                30040   18446744071566495936
.comment                    11808                      0
.note.GNU-stack                 0                      0
Total                     3408381


# size -A vmlinux.old
vmlinux.4  :
section                      size                   addr
.text                     2131420   18446744071563116544
__ex_table                  15408   18446744071565247968
.rodata                    214318   18446744071565263392
.pci_fixup                   2112   18446744071565477712
__ksymtab                   34368   18446744071565479824
__ksymtab_gpl                5488   18446744071565514192
__kcrctab                       0   18446744071565519680
__kcrctab_gpl                   0   18446744071565519680
__ksymtab_strings           55010   18446744071565519680
__param                      2560   18446744071565574696
.data                      451848   18446744071565577280
.bss                       246692   18446744071566029184
.data.cacheline_aligned     23744   18446744071566278656
.data.read_mostly           11328   18446744071566302400
.vsyscall_0                   319   18446744073699065856
.xtime_lock                     8   18446744073699066176
.vxtime                        48   18446744073699066192
.wall_jiffies                   8   18446744073699066240
.sys_tz                         8   18446744073699066256
.sysctl_vsyscall                4   18446744073699066272
.xtime                         16   18446744073699066288
.jiffies                        8   18446744073699066304
.vsyscall_1                    47   18446744073699066880
.vsyscall_2                    13   18446744073699067904
.vsyscall_3                    13   18446744073699068928
.data.init_task              8192   18446744071566319616
.init.text                 124352   18446744071566327808
.init.data                  42616   18446744071566452160
.init.setup                  2208   18446744071566494784
.initcall.init               1248   18446744071566496992
.con_initcall.init             24   18446744071566498240
.security_initcall.init         0   18446744071566498264
.altinstructions              139   18446744071566498264
.altinstr_replacement          93   18446744071566498403
.exit.text                   2891   18446744071566498496
.init.ramfs                   134   18446744071566503936
.data.percpu                30040   18446744071566504128
.comment                    11844                      0
.note.GNU-stack                 0                      0
Total                     3418569



Eric

