Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUGWPiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUGWPiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267801AbUGWPiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:38:06 -0400
Received: from web50610.mail.yahoo.com ([206.190.38.249]:18524 "HELO
	web50610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267799AbUGWPhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:37:18 -0400
Message-ID: <20040723153715.81677.qmail@web50610.mail.yahoo.com>
Date: Fri, 23 Jul 2004 08:37:15 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Ext3 problems in dual booting machine with SE Linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have run across a problem while testing a SMP system based somewhat on Red
Hat's current rawhide. My machine does dual booting between rawhide and RH 9. In
Red Hat 9, I do the build and install to a test partition: /dev/sda3. I reboot
the machine into rawhide and log in, run 'fixfiles relabel', reboot back into RH
9.

At this point, 'umount /dev/sda3' is impossible. Its reported as busy. The only
way I can get that partition back is to rm -rf enough of it to cause corruption
to be detected upon reboot which drops me into a shell that I can run mke2fs on
it. This seems kind of extreme. I've also seen it impossible to umount loopback
mounted files. (mount -o loop). but that's another story...

The RH 9 system is 2.4.20 SMP kernel and rawhide is 2.6.7-1.437.

Something seems wrong in either 2.4.20's handling of Ext3 or 2.6.7-1.437's use of
Ext3. Here's a sample session:

[root@linux root]# ssh buildhost
root@buildhost's password:
Last login: Fri Jul 23 09:46:41 2004 from 192.168.3.3
[root@buildhost root]# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
/dev/sda1 /boot ext3 rw 0 0
none /dev/pts devpts rw 0 0
/dev/sda3 /mnt/target ext3 rw 0 0
none /dev/shm tmpfs rw 0 0
[root@buildhost root]# umount /dev/sda3
umount: /mnt/target: device is busy
[root@buildhost root]# rm -rf /mnt/target/tmp/
[root@buildhost root]# rm -rf /mnt/target/usr/
Segmentation fault
[root@buildhost root]#
Message from syslogd@buildhost at Fri Jul 23 10:50:53 2004 ...
buildhost kernel: Assertion failure in journal_revoke_Rsmp_9762279c() at
revoke.c:329: "!(__builtin_constant_p(BH_Revoked) ?
constant_test_bit((BH_Revoked),(&bh->b_state)) :
variable_test_bit((BH_Revoked),(&bh->b_state)))"

At this point the system is non-functional since it oops'ed. Here's the Oops
info:

Jul 23 10:50:53 buildhost kernel: kernel BUG at revoke.c:329!
Jul 23 10:50:53 buildhost kernel: invalid operand: 0000
Jul 23 10:50:53 buildhost kernel: e100 ide-scsi ide-cd cdrom ext3 jbd aic7xxx
sd_mod scsi_mod
Jul 23 10:50:53 buildhost kernel: CPU:    0
Jul 23 10:50:53 buildhost kernel: EIP:    0060:[<f885ce4c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 23 10:50:53 buildhost kernel: EFLAGS: 00010286
Jul 23 10:50:53 buildhost kernel: eax: 000000d0   ebx: f60e2d98   ecx: 00000001
Jul 23 10:50:53 buildhost kernel: esi: c35d8000   edi: f60e2d98   ebp: f7bac8c0
Jul 23 10:50:53 buildhost kernel: ds: 0068   es: 0068   ss: 0068
Jul 23 10:50:53 buildhost kernel: Process rm (pid: 1113, stackpage=f4f7b000)
Jul 23 10:50:53 buildhost kernel: Stack: f8861440 f885fee7 f885fe4a 00000149
f8861480 00030068 f4b37480 f7bac8c0
Jul 23 10:50:53 buildhost kernel:        f7bac8c0 f8869b14 f7bac8c0 00030068
f60e2d98 f7bac8c0 f46d65e0 00000001
Jul 23 10:50:53 buildhost kernel:        f7bac8c0 00030068 00030068 f435d494
f4f7a000 f886c2c9 f7bac8c0 00000000
Jul 23 10:50:53 buildhost kernel: Call Trace:   [<f8861440>] .rodata.str1.32
[jbd] 0x12c0 (0xf4f7bcc8))
Jul 23 10:50:53 buildhost kernel: [<f885fee7>] .rodata.str1.1 [jbd] 0x4c7
(0xf4f7bccc))
Jul 23 10:50:53 buildhost kernel: [<f885fe4a>] .rodata.str1.1 [jbd] 0x42a
(0xf4f7bcd0))
Jul 23 10:50:53 buildhost kernel: [<f8861480>] .rodata.str1.32 [jbd] 0x1300
(0xf4f7bcd8))
Jul 23 10:50:53 buildhost kernel: [<f8869b14>] ext3_forget [ext3] 0x94
(0xf4f7bcec))
Jul 23 10:50:53 buildhost kernel: [<f886c2c9>] ext3_clear_blocks [ext3] 0x119
(0xf4f7bd1c))
Jul 23 10:50:53 buildhost kernel: [<f885802c>]
journal_get_write_access_Rsmp_2b583cf6 [jbd] 0x5c (0xf4f7bd44))
Jul 23 10:50:53 buildhost kernel: [<f886c427>] ext3_free_data [ext3] 0xa7
(0xf4f7bd64))
Jul 23 10:50:53 buildhost kernel: [<c011e3ef>] schedule [kernel] 0x19f
(0xf4f7bd9c))
Jul 23 10:50:53 buildhost kernel: [<f886c7a5>] ext3_free_branches [ext3] 0x275
(0xf4f7bdbc))
Jul 23 10:50:53 buildhost kernel: [<c01559dc>] bread [kernel] 0x7c
(0xf4f7bdf8))Jul 23 10:50:54 buildhost kernel: [<f886c5f3>] ext3_free_branches
[ext3] 0xc3 (0xf4f7be0c))
Jul 23 10:50:54 buildhost kernel: [<c01559dc>] bread [kernel] 0x7c
(0xf4f7be48))Jul 23 10:50:54 buildhost kernel: [<f886c5f3>] ext3_free_branches
[ext3] 0xc3 (0xf4f7be5c))
Jul 23 10:50:54 buildhost kernel: [<c0158166>] try_to_free_buffers [kernel] 0xc6
(0xf4f7be7c))
Jul 23 10:50:54 buildhost kernel: [<f8869c6c>] start_transaction [ext3] 0x8c
(0xf4f7be94))
Jul 23 10:50:54 buildhost kernel: [<f886cb5a>] ext3_truncate [ext3] 0x39a
(0xf4f7beac))
Jul 23 10:50:54 buildhost kernel: [<f885724a>] start_this_handle [jbd] 0xaa
(0xf4f7bec8))
Jul 23 10:50:54 buildhost kernel: [<f8857445>] journal_start_Rsmp_3f1fe309 [jbd]
0xa5 (0xf4f7bef4))
Jul 23 10:50:54 buildhost kernel: [<f8869c6c>] start_transaction [ext3] 0x8c
(0xf4f7bf18))
Jul 23 10:50:54 buildhost kernel: [<f8869e59>] ext3_delete_inode [ext3] 0x159
(0xf4f7bf30))
Jul 23 10:50:54 buildhost kernel: [<f8869d00>] ext3_delete_inode [ext3] 0x0
(0xf4f7bf44))
Jul 23 10:50:54 buildhost kernel: [<c016d8d0>] iput [kernel] 0x150
(0xf4f7bf4c))Jul 23 10:50:54 buildhost kernel: [<c0162295>] vfs_unlink [kernel]
0x185 (0xf4f7bf68))
Jul 23 10:50:54 buildhost kernel: [<c0162509>] sys_unlink [kernel] 0x119
(0xf4f7bf84))
Jul 23 10:50:54 buildhost kernel: [<c01098cf>] system_call [kernel] 0x33
(0xf4f7bfc0))
Jul 23 10:50:54 buildhost kernel: Code: 0f 0b 49 01 4a fe 85 f8 e9 54 ff ff ff 8b
86 c0 00 00 00 89
                                                                                
                                                                                
>>EIP; f885ce4c <[jbd]journal_revoke+13c/180>   <=====
                                                                                
>>ebx; f60e2d98 <_end+35c64498/3838e760>
>>esi; c35d8000 <_end+3159700/3838e760>
>>edi; f60e2d98 <_end+35c64498/3838e760>
>>ebp; f7bac8c0 <_end+3772dfc0/3838e760>
                                                                                
Trace; f8861440 <[jbd]__kstrtab_journal_force_commit+1498/4ca0>
Trace; f885fee7 <[jbd]__kstrtab_journal_wipe+20/21>
Trace; f885fe4a <[jbd]__kstrtab_journal_ack_err+2/20>
Trace; f8861480 <[jbd]__kstrtab_journal_force_commit+14d8/4ca0>
Trace; f8869b14 <[ext3].text.start+3ab4/d5ed>
Trace; f886c2c9 <[ext3].text.start+6269/d5ed>
Trace; f885802c <[jbd]journal_get_write_access+5c/90>
Trace; f886c427 <[ext3].text.start+63c7/d5ed>
Trace; c011e3ef <schedule+19f/320>
Trace; f886c7a5 <[ext3].text.start+6745/d5ed>
Trace; c01559dc <bread+7c/90>
Trace; c01559dc <bread+7c/90>
Trace; c0158166 <try_to_free_buffers+c6/160>
Trace; f8869c6c <[ext3].text.start+3c0c/d5ed>
Trace; f886cb5a <[ext3].text.start+6afa/d5ed>
Trace; f885724a <[jbd]start_this_handle+aa/190>
Trace; f8857445 <[jbd]journal_start+a5/c0>
Trace; f8869c6c <[ext3].text.start+3c0c/d5ed>
Trace; f8869e59 <[ext3].text.start+3df9/d5ed>
Trace; f8869d00 <[ext3].text.start+3ca0/d5ed>
Trace; c016d8d0 <iput+150/310>
Trace; c0162509 <sys_unlink+119/120>
Trace; c01098cf <system_call+33/38>
                                                                                
Code;  f885ce4c <[jbd]journal_revoke+13c/180>
00000000 <_EIP>:
Code;  f885ce4c <[jbd]journal_revoke+13c/180>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f885ce4e <[jbd]journal_revoke+13e/180>
   2:   49                        dec    %ecx
Code;  f885ce4f <[jbd]journal_revoke+13f/180>
   3:   01 4a fe                  add    %ecx,0xfffffffe(%edx)
Code;  f885ce52 <[jbd]journal_revoke+142/180>
   6:   85 f8                     test   %edi,%eax
Code;  f885ce54 <[jbd]journal_revoke+144/180>
   8:   e9 54 ff ff ff            jmp    ffffff61 <_EIP+0xffffff61>
Code;  f885ce59 <[jbd]journal_revoke+149/180>
   d:   8b 86 c0 00 00 00         mov    0xc0(%esi),%eax
Code;  f885ce5f <[jbd]journal_revoke+14f/180>
  13:   89 00                     mov    %eax,(%eax)


My concern is that someone can create a CD with ext3 relabel'ed with SE Linux and
kill people's machines. I bet you could even do it with USB flash drives. Notice
also that 'rm' segfaulted. I have not tracked that down to see if the bug is
exploitable. (If it were, it would have to do something real quick since the
kernel is about to oops.)

Any comments?

-Steve Grubb


	
		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/
