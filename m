Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUIPLdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUIPLdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267977AbUIPLdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:33:16 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:16141 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267968AbUIPL3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:29:03 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: top hogs CPU in 2.6: kallsyms_lookup is very slow
Date: Thu, 16 Sep 2004 14:28:26 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see 2.6.9-rc2 being slower than 2.4.27-rc3
on a Pentium 66, 80 MB RAM.

Specifically:
top on idle machine sucks ~40% CPU while in 2.4
it takes only ~6%

I recompiled 2.6 with HZ=100 and with slab debugging
off. This helped a bit (wget was slow too),
but top still hogs CPU.

I did 'strace -T -tt top b n 1' under both kernels,
postprocessed it a bit:

cat 24topbn1.strace | sed 's/(.* </ </' | sed 's/^[^ ]* //' >24
cat 26topbn1.strace | sed 's/(.* </ </' | sed 's/^[^ ]* //' >26
exec 24<24
exec 26<26
while true; do
    read -r l24 <&24 || exit
    read -r l26 <&26 || exit
    printf "%-30s %-30s\n" "$l24" "$l26"
done

and got the following result. Note that many syscalls
are taking 50-100% more time to execute under 2.6.
Why?

uname <0.000142>               uname <0.000217>
brk <0.000176>                 brk <0.000174>
open <0.000218>                open <0.000335>
open <0.000248>                open <0.000335>
fstat64 <0.000104>             fstat64 <0.000191>
old_mmap <0.000129>            old_mmap <0.000233>
close <0.000096>               close <0.000177>
open <0.000148>                open <0.000234>
stat64 <0.000139>              stat64 <0.000221>
open <0.000237>                open <0.000308>
read <0.000181>                read <0.000257>
fstat64 <0.000106>             fstat64 <0.000260>
old_mmap <0.000138>            old_mmap <0.000210>
mprotect <0.000140>            mprotect <0.000226>
old_mmap <0.000169>            old_mmap <0.000281>
old_mmap <0.000162>            old_mmap <0.000242>
close <0.000097>               close <0.000157>
open <0.000214>                open <0.000288>
read <0.000174>                read <0.000260>
fstat64 <0.000106>             fstat64 <0.000166>
old_mmap <0.000122>            old_mmap <0.000209>
old_mmap <0.000133>            old_mmap <0.000221>
mprotect <0.000137>            mprotect <0.000224>
old_mmap <0.000177>            old_mmap <0.000280>
old_mmap <0.000166>            old_mmap <0.000237>
close <0.000097>               close <0.000158>
open <0.000252>                open <0.000323>
read <0.000172>                read <0.000253>
fstat64 <0.000107>             fstat64 <0.000166>
old_mmap <0.000140>            old_mmap <0.000222>
mprotect <0.000134>            mprotect <0.000221>
old_mmap <0.000171>            old_mmap <0.000282>
old_mmap <0.000164>            old_mmap <0.000242>
close <0.000099>               close <0.000156>
open <0.000310>                open <0.000384>
read <0.000175>                read <0.000252>
fstat64 <0.000106>             fstat64 <0.000168>
old_mmap <0.000141>            old_mmap <0.000223>
mprotect <0.000136>            mprotect <0.000316>
old_mmap <0.000174>            old_mmap <0.000257>
close <0.000098>               close <0.000157>
munmap <0.000237>              munmap <0.000332>
uname <0.000335>               uname <0.000414>
brk <0.000097>                 brk <0.000155>
brk <0.000124>                 brk <0.000275>
brk <0.000111>                 open <0.000345>
...
(here straces start to diverge a bit and go out of sync.
unabridged straces and .configs are at
http://195.66.192.168/linux/slowtop/)

This slowdown worries me a bit, but this alone cannot explain
6% -> 40% CPU usage regression.

I ran kerneltop while running 'top b n 1' on a 2.6
in an endless loop:

...
Sampling_step: 4 | Address range: 0xc0100240 - 0xc045780e
address  function ..... 2004-09-16/13:41:30 ...... ticks
c0117b30 __might_sleep                                 1
c012fd00 kallsyms_lookup                             201
c0134c40 buffered_rmqueue                              1
c013d560 zap_pte_range                                 1
c013e2e0 do_wp_page                                    1
c013ea50 do_anonymous_page                            14
c014ab80 dentry_open                                   1
c014c260 get_empty_filp                                1
c0160230 dput                                          1
c0245a60 __copy_to_user_ll                            22
00000000 total                                       244
Sampling_step: 4 | Address range: 0xc0100240 - 0xc045780e
address  function ..... 2004-09-16/13:41:32 ...... ticks
c0104070 default_idle                                  1
c0111e50 do_page_fault                                 1
c012fd00 kallsyms_lookup                              98
c013d560 zap_pte_range                                 1
c013e2e0 do_wp_page                                    1
c013ea50 do_anonymous_page                            12
c0244860 vsnprintf                                     1
c0245a60 __copy_to_user_ll                            14
00000000 total                                       129
Sampling_step: 4 | Address range: 0xc0100240 - 0xc045780e
address  function ..... 2004-09-16/13:41:36 ...... ticks
c0104af0 get_wchan                                     1
c0111e50 do_page_fault                                 1
c0117b30 __might_sleep                                 1
c011a0b0 acquire_console_sem                           1
c012fd00 kallsyms_lookup                             192
c0134b20 free_hot_cold_page                            1
c0134c40 buffered_rmqueue                              2
c013a620 __pagevec_lru_add_active                      1
c013e2e0 do_wp_page                                    2
c013ea50 do_anonymous_page                            18
c013ee50 handle_mm_fault                               1
c014c570 file_kill                                     1
c02445f0 number                                        2
c0245a60 __copy_to_user_ll                            18
c027a860 opost_block                                   1
c02816d0 conv_uni_to_pc                                1
c0287100 do_con_write                                  1
00000000 total                                       245
...

kallsyms_lookup visibly stands out. What's that?

2.4 does not even have kallsym_lookup,
kerneltop run looks like this in 2.4:

Sampling_step: 4 | Address range: 0xc0105000 - 0xc032f491
address  function ..... 2004-09-16/14:15:50 ...... ticks
c0106e04 default_idle                                 54
c0122744 do_anonymous_page                            10
c03257c0 __generic_copy_to_user                       10
c014dc3c statm_pgd_range                               4
c013a7f4 link_path_walk                                2
c0142938 d_alloc                                       2
c014c914 proc_pid_lookup                               2
c0325ea4 number                                        2
c01221bc do_wp_page                                    1
c012286c do_no_page                                    1
c012bcac rmqueue                                       1
c013264c get_empty_filp                                1
c01327bc fput                                          1
c013a3a8 getname                                       1
c013a450 vfs_permission                                1
c013a550 permission                                    1
c01433bc alloc_inode                                   1
00000000 total                                       102
--
vda

