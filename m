Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUJOHT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUJOHT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 03:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUJOHT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 03:19:57 -0400
Received: from boromix.nask.net.pl ([195.187.245.33]:36503 "EHLO
	boromix.nask.net.pl") by vger.kernel.org with ESMTP id S266366AbUJOHNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 03:13:17 -0400
Date: Fri, 15 Oct 2004 09:13:03 +0200 (CEST)
From: Mateusz.Blaszczyk@nask.pl
X-X-Sender: mat@boromir
Reply-To: Mateusz.Blaszczyk@nask.pl
To: mingo@elte.hu, rml@tech9.net
cc: linux-kernel@vger.kernel.org
Subject: Oops sched_setscheduler in 2.6.9-rc4-mm1
Message-ID: <Pine.GSO.4.58.0410150833330.9897@boromir>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
VirusProtection: checked - Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Running cdrecord caused oops in sched_setscheduler syscall (i think) so i
tested with my little setp.c program that follows.
It seems that it always oops - no matter what policy I request.
It runs ok on 2.6.9-rc2-mm1, same config. Rc3 not tested.
I run setp. 3  times. The first I decoded using ksymoops.
My .config follows at the end.

-------------------------------------------- CODE -----------------------------------------------
#include <sched.h>
#include <stdio.h>
#include <errno.h>

/*
int sched_setscheduler(pid_t pid, int policy, const struct sched_param *p);

int sched_getscheduler(pid_t pid);

struct sched_param {
    int sched_priority;
};
*/

int main () {

    int b = -1;
    int d = SCHED_RR;

    struct sched_param *s;

    s = (struct sched_param *) malloc (sizeof(struct sched_param));

    b = sched_get_priority_max(d);

    printf("Max priority for %d is %d\n", d, b);

    s->sched_priority = b;

    b = sched_getscheduler(0);
    printf("get = %d\n", b);

    if( (b = sched_setscheduler(0, d, s)) < 0) {

	free (s);
	switch (errno) {
	case ESRCH:
	    printf("Error: pid not found\n");
	    break;
	case EPERM:
	    printf("Error: No permision\n");
	    break;
	case EINVAL:
	    printf("Error: Bad policy\n");
	    break;
	}
    }
    else
    {
	free (s);
	printf("Success\n");

	b = 60;
	printf("Sleeping for %d seconds\n", b);

	sleep (b);
    }

    exit (0);

}

---------------------------------------- END OF CODE -----------------------------------------------




------------- OOPS #1 (uid > 0) ---------------------------------------------

Oct 14 22:07:36 localhost kernel: Unable to handle kernel paging request at virtual address 0000e5cc
Oct 14 22:07:36 localhost kernel:  printing eip:
Oct 14 22:07:36 localhost kernel: c0117e66
Oct 14 22:07:36 localhost kernel: *pde = 00000000
Oct 14 22:07:36 localhost kernel: Oops: 0002 [#1]
Oct 14 22:07:36 localhost kernel: PREEMPT
Oct 14 22:07:36 localhost kernel: Modules linked in: pktcdvd lp button processor ac battery ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables ipw2100 ieee80211 ieee80211_crypt 8139too mii crc32 hw_random intel_agp agpgart parport_pc parport pcspkr cpufreq_userspace irtty_sir sir_dev
Oct 14 22:07:36 localhost kernel: CPU:    0
Oct 14 22:07:36 localhost kernel: EIP:    0060:[profile_hit+33/36]    Not tainted VLI
Oct 14 22:07:36 localhost kernel: EFLAGS: 00010082   (2.6.9-rc4mm1)
Oct 14 22:07:36 localhost kernel: EIP is at profile_hit+0x21/0x24
Oct 14 22:07:36 localhost kernel: eax: 00000000   ebx: cedbca20   ecx: 00000000   edx: 0000e5cc
Oct 14 22:07:36 localhost kernel: esi: b7fdc1f0   edi: 00000002   ebp: cbf3dfbc   esp: cbf3df98
Oct 14 22:07:36 localhost kernel: ds: 007b   es: 007b   ss: 0068
Oct 14 22:07:36 localhost kernel: Process setp (pid: 5840, threadinfo=cbf3c000 task=cedbca20)
Oct 14 22:07:36 localhost kernel: Stack: c0114a32 c045a420 cbf3c000 ffffffea 00000082 00000063 00000000 b7fdc1f0
Oct 14 22:07:36 localhost kernel:        bffffb40 cbf3c000 c0103b9b 00000000 00000002 0804a008 b7fdc1f0 bffffb40
Oct 14 22:07:36 localhost kernel:        bffffb28 0000009c 0000007b 0000007b 0000009c b7f6a504 00000073 00000246
Oct 14 22:07:36 localhost kernel: Call Trace:
Oct 14 22:07:36 localhost kernel:  [setscheduler+171/475] setscheduler+0xab/0x1db
Oct 14 22:07:36 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 14 22:07:36 localhost kernel: Code: 74 01 aa 5b 89 f0 5e 5f 5d c3 8b 0d ac f6 45 c0 81 ea 28 02 10 c0 a1 a8 f6 45 c0 d3 ea 48 39 d0 0f 46 d0 a1 a4 f6 45 c0 8d 14 90 <ff> 02 c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 90 53 31 d2
Oct 14 22:07:36 localhost kernel:  <6>note: setp[5840] exited with preempt_count 2

------------------------------------- ksymoops decode of aboved oops -----------------------

ksymoops 2.4.9 on i686 2.6.9-rc4mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc4mm1/ (default)
     -m /boot/System.map-2.6.9-rc4mm1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oct 14 22:07:36 localhost kernel: Unable to handle kernel paging request at virtual address 0000e5cc
Oct 14 22:07:36 localhost kernel: c0117e66
Oct 14 22:07:36 localhost kernel: *pde = 00000000
Oct 14 22:07:36 localhost kernel: Oops: 0002 [#1]
Oct 14 22:07:36 localhost kernel: CPU:    0
Oct 14 22:07:36 localhost kernel: EIP:    0060:[profile_hit+33/36]    Not tainted VLI
Oct 14 22:07:36 localhost kernel: EFLAGS: 00010082   (2.6.9-rc4mm1)
Oct 14 22:07:36 localhost kernel: eax: 00000000   ebx: cedbca20   ecx: 00000000   edx: 0000e5cc
Oct 14 22:07:36 localhost kernel: esi: b7fdc1f0   edi: 00000002   ebp: cbf3dfbc   esp: cbf3df98
Oct 14 22:07:36 localhost kernel: ds: 007b   es: 007b   ss: 0068
Oct 14 22:07:36 localhost kernel: Stack: c0114a32 c045a420 cbf3c000 ffffffea 00000082 00000063 00000000 b7fdc1f0
Oct 14 22:07:36 localhost kernel:        bffffb40 cbf3c000 c0103b9b 00000000 00000002 0804a008 b7fdc1f0 bffffb40
Oct 14 22:07:36 localhost kernel:        bffffb28 0000009c 0000007b 0000007b 0000009c b7f6a504 00000073 00000246
Oct 14 22:07:36 localhost kernel: Call Trace:
Oct 14 22:07:36 localhost kernel: Code: 74 01 aa 5b 89 f0 5e 5f 5d c3 8b 0d ac f6 45 c0 81 ea 28 02 10 c0 a1 a8 f6 45 c0 d3 ea 48 39 d0 0f 46 d0 a1 a4 f6 45 c0 8d 14 90 <ff> 02 c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 90 53 31 d2
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; cedbca20 <pg0+e935a20/3fb77400>
>>ebp; cbf3dfbc <pg0+bab6fbc/3fb77400>
>>esp; cbf3df98 <pg0+bab6f98/3fb77400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 01                     je     3 <_EIP+0x3>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   aa                        stos   %al,%es:(%edi)
Code;  ffffffd8 <__kernel_rt_sigreturn+1b98/????>
   3:   5b                        pop    %ebx
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   89 f0                     mov    %esi,%eax
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   5e                        pop    %esi
Code;  ffffffdc <__kernel_rt_sigreturn+1b9c/????>
   7:   5f                        pop    %edi
Code;  ffffffdd <__kernel_rt_sigreturn+1b9d/????>
   8:   5d                        pop    %ebp
Code;  ffffffde <__kernel_rt_sigreturn+1b9e/????>
   9:   c3                        ret
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   8b 0d ac f6 45 c0         mov    0xc045f6ac,%ecx
Code;  ffffffe5 <__kernel_rt_sigreturn+1ba5/????>
  10:   81 ea 28 02 10 c0         sub    $0xc0100228,%edx
Code;  ffffffeb <__kernel_rt_sigreturn+1bab/????>
  16:   a1 a8 f6 45 c0            mov    0xc045f6a8,%eax
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   d3 ea                     shr    %cl,%edx
Code;  fffffff2 <__kernel_rt_sigreturn+1bb2/????>
  1d:   48                        dec    %eax
Code;  fffffff3 <__kernel_rt_sigreturn+1bb3/????>
  1e:   39 d0                     cmp    %edx,%eax
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   0f 46 d0                  cmovbe %eax,%edx
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   a1 a4 f6 45 c0            mov    0xc045f6a4,%eax
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8d 14 90                  lea    (%eax,%edx,4),%edx
Code;  00000000 Before first symbol
  2b:   ff 02                     incl   (%edx)
Code;  00000002 Before first symbol
  2d:   c3                        ret
Code;  00000003 Before first symbol
  2e:   b8 da ff ff ff            mov    $0xffffffda,%eax
Code;  00000008 Before first symbol
  33:   c3                        ret
Code;  00000009 Before first symbol
  34:   b8 da ff ff ff            mov    $0xffffffda,%eax
Code;  0000000e Before first symbol
  39:   c3                        ret
Code;  0000000f Before first symbol
  3a:   90                        nop
Code;  00000010 Before first symbol
  3b:   90                        nop
Code;  00000011 Before first symbol
  3c:   90                        nop
Code;  00000012 Before first symbol
  3d:   53                        push   %ebx
Code;  00000013 Before first symbol
  3e:   31 d2                     xor    %edx,%edx


1 warning and 1 error issued.  Results may not be reliable.
------------------------------- END OF DECODE ----------------------------------

------------------------------- OOOPS #2  -------------------------
Oct 14 22:08:19 localhost kernel: Unable to handle kernel paging request at virtual address 0000e5cc
Oct 14 22:08:19 localhost kernel:  printing eip:
Oct 14 22:08:19 localhost kernel: c0117e66
Oct 14 22:08:19 localhost kernel: *pde = 00000000
Oct 14 22:08:19 localhost kernel: Oops: 0002 [#2]
Oct 14 22:08:19 localhost kernel: PREEMPT
Oct 14 22:08:19 localhost kernel: Modules linked in: pktcdvd lp button processor ac battery ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables ipw2100 ieee80211 ieee80211_crypt 8139too mii crc32 hw_random intel_agp agpgart parport_pc parport pcspkr cpufreq_userspace irtty_sir sir_dev
Oct 14 22:08:19 localhost kernel: CPU:    0
Oct 14 22:08:19 localhost kernel: EIP:    0060:[profile_hit+33/36]    Not tainted VLI
Oct 14 22:08:19 localhost kernel: EFLAGS: 00010082   (2.6.9-rc4mm1)
Oct 14 22:08:19 localhost kernel: EIP is at profile_hit+0x21/0x24
Oct 14 22:08:19 localhost kernel: eax: 00000000   ebx: ce89f060   ecx: 00000000   edx: 0000e5cc
Oct 14 22:08:19 localhost kernel: esi: b7fdc1f0   edi: 00000002   ebp: ce54ffbc   esp: ce54ff98
Oct 14 22:08:19 localhost kernel: ds: 007b   es: 007b   ss: 0068
Oct 14 22:08:19 localhost kernel: Process setp (pid: 5892, threadinfo=ce54e000 task=ce89f060)
Oct 14 22:08:19 localhost kernel: Stack: c0114a32 c045a420 c0108bed ffffffea 00000086 00000063 00000000 b7fdc1f0
Oct 14 22:08:19 localhost kernel:        bffffb40 ce54e000 c0103b9b 00000000 00000002 0804a008 b7fdc1f0 bffffb40
Oct 14 22:08:19 localhost kernel:        bffffb28 0000009c 0000007b 0000007b 0000009c b7f6a504 00000073 00000246
Oct 14 22:08:19 localhost kernel: Call Trace:
Oct 14 22:08:19 localhost kernel:  [setscheduler+171/475] setscheduler+0xab/0x1db
Oct 14 22:08:19 localhost kernel:  [sys_mmap2+97/144] sys_mmap2+0x61/0x90
Oct 14 22:08:19 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 14 22:08:19 localhost kernel: Code: 74 01 aa 5b 89 f0 5e 5f 5d c3 8b 0d ac f6 45 c0 81 ea 28 02 10 c0 a1 a8 f6 45 c0 d3 ea 48 39 d0 0f 46 d0 a1 a4 f6 45 c0 8d 14 90 <ff> 02 c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 90 53 31 d2
Oct 14 22:08:19 localhost kernel:  <6>note: setp[5892] exited with preempt_count 2
Oct 14 22:08:19 localhost kernel: scheduling while atomic: setp/0x04000002/5892
Oct 14 22:08:19 localhost kernel:  [schedule+64/1126] schedule+0x40/0x466
Oct 14 22:08:19 localhost kernel:  [unmap_page_range+60/87] unmap_page_range+0x3c/0x57
Oct 14 22:08:19 localhost kernel:  [cond_resched+40/73] cond_resched+0x28/0x49
Oct 14 22:08:19 localhost kernel:  [unmap_vmas+396/504] unmap_vmas+0x18c/0x1f8
Oct 14 22:08:19 localhost kernel:  [exit_mmap+96/296] exit_mmap+0x60/0x128
Oct 14 22:08:19 localhost kernel:  [mmput+35/166] mmput+0x23/0xa6
Oct 14 22:08:19 localhost kernel:  [do_exit+375/940] do_exit+0x177/0x3ac
Oct 14 22:08:19 localhost kernel:  [do_divide_error+0/234] do_divide_error+0x0/0xea
Oct 14 22:08:19 localhost kernel:  [do_page_fault+927/1266] do_page_fault+0x39f/0x4f2
Oct 14 22:08:19 localhost kernel:  [profile_hit+33/36] profile_hit+0x21/0x24
Oct 14 22:08:19 localhost kernel:  [do_no_page+781/865] do_no_page+0x30d/0x361
Oct 14 22:08:19 localhost kernel:  [handle_mm_fault+113/314] handle_mm_fault+0x71/0x13a
Oct 14 22:08:19 localhost kernel:  [do_page_fault+429/1266] do_page_fault+0x1ad/0x4f2
Oct 14 22:08:19 localhost kernel:  [vma_merge+312/327] vma_merge+0x138/0x147
Oct 14 22:08:19 localhost kernel:  [do_page_fault+0/1266] do_page_fault+0x0/0x4f2
Oct 14 22:08:19 localhost kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 14 22:08:19 localhost kernel:  [profile_hit+33/36] profile_hit+0x21/0x24
Oct 14 22:08:19 localhost kernel:  [setscheduler+171/475] setscheduler+0xab/0x1db
Oct 14 22:08:19 localhost kernel:  [sys_mmap2+97/144] sys_mmap2+0x61/0x90
Oct 14 22:08:19 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


------------------------------- OOOPS #3 ----------------------------------------------
Oct 14 22:08:42 localhost kernel: Unable to handle kernel paging request at virtual address 0000e5cc
Oct 14 22:08:42 localhost kernel:  printing eip:
Oct 14 22:08:42 localhost kernel: c0117e66
Oct 14 22:08:42 localhost kernel: *pde = 00000000
Oct 14 22:08:42 localhost kernel: Oops: 0002 [#3]
Oct 14 22:08:42 localhost kernel: PREEMPT
Oct 14 22:08:42 localhost kernel: Modules linked in: pktcdvd lp button processor ac battery ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables ipw2100 ieee80211 ieee80211_crypt 8139too mii crc32 hw_random intel_agp agpgart parport_pc parport pcspkr cpufreq_userspace irtty_sir sir_dev
Oct 14 22:08:42 localhost kernel: CPU:    0
Oct 14 22:08:42 localhost kernel: EIP:    0060:[profile_hit+33/36]    Not tainted VLI
Oct 14 22:08:42 localhost kernel: EFLAGS: 00010082   (2.6.9-rc4mm1)
Oct 14 22:08:42 localhost kernel: EIP is at profile_hit+0x21/0x24
Oct 14 22:08:42 localhost kernel: eax: 00000000   ebx: cf46d5a0   ecx: 00000000   edx: 0000e5cc
Oct 14 22:08:42 localhost kernel: esi: b7fdc1f0   edi: 00000002   ebp: ce26ffbc   esp: ce26ff98
Oct 14 22:08:42 localhost kernel: ds: 007b   es: 007b   ss: 0068
Oct 14 22:08:42 localhost kernel: Process setp (pid: 5904, threadinfo=ce26e000 task=cf46d5a0)
Oct 14 22:08:42 localhost kernel: Stack: c0114a32 c045a420 c0108bed ffffffea 00000086 00000063 00000000 b7fdc1f0
Oct 14 22:08:42 localhost kernel:        bffffb40 ce26e000 c0103b9b 00000000 00000002 0804a008 b7fdc1f0 bffffb40
Oct 14 22:08:42 localhost kernel:        bffffb28 0000009c 0000007b 0000007b 0000009c b7f6a504 00000073 00000246
Oct 14 22:08:42 localhost kernel: Call Trace:
Oct 14 22:08:42 localhost kernel:  [setscheduler+171/475] setscheduler+0xab/0x1db
Oct 14 22:08:42 localhost kernel:  [sys_mmap2+97/144] sys_mmap2+0x61/0x90
Oct 14 22:08:42 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 14 22:08:42 localhost kernel: Code: 74 01 aa 5b 89 f0 5e 5f 5d c3 8b 0d ac f6 45 c0 81 ea 28 02 10 c0 a1 a8 f6 45 c0 d3 ea 48 39 d0 0f 46 d0 a1 a4 f6 45 c0 8d 14 90 <ff> 02 c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 90 53 31 d2
Oct 14 22:08:42 localhost kernel:  <6>note: setp[5904] exited with preempt_count 2
Oct 14 22:08:52 localhost kernel: Unable to handle kernel paging request at virtual address 0000e5cc
Oct 14 22:08:52 localhost kernel:  printing eip:
Oct 14 22:08:52 localhost kernel: c0117e66
Oct 14 22:08:52 localhost kernel: *pde = 00000000
Oct 14 22:08:52 localhost kernel: Oops: 0002 [#4]
Oct 14 22:08:52 localhost kernel: PREEMPT
Oct 14 22:08:52 localhost kernel: Modules linked in: pktcdvd lp button processor ac battery ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables ipw2100 ieee80211 ieee80211_crypt 8139too mii crc32 hw_random intel_agp agpgart parport_pc parport pcspkr cpufreq_userspace irtty_sir sir_dev
Oct 14 22:08:52 localhost kernel: CPU:    0
Oct 14 22:08:52 localhost kernel: EIP:    0060:[profile_hit+33/36]    Not tainted VLI
Oct 14 22:08:52 localhost kernel: EFLAGS: 00010082   (2.6.9-rc4mm1)
Oct 14 22:08:52 localhost kernel: EIP is at profile_hit+0x21/0x24
Oct 14 22:08:52 localhost kernel: eax: 00000000   ebx: ce833060   ecx: 00000000   edx: 0000e5cc
Oct 14 22:08:52 localhost kernel: esi: b7fdc1f0   edi: 00000002   ebp: ce26ffbc   esp: ce26ff98
Oct 14 22:08:52 localhost kernel: ds: 007b   es: 007b   ss: 0068
Oct 14 22:08:52 localhost kernel: Process setp (pid: 5911, threadinfo=ce26e000 task=ce833060)
Oct 14 22:08:52 localhost kernel: Stack: c0114a32 c045a420 ce26e000 ffffffea 00000086 00000063 00000000 b7fdc1f0
Oct 14 22:08:52 localhost kernel:        bffffb40 ce26e000 c0103b9b 00000000 00000002 0804a008 b7fdc1f0 bffffb40
Oct 14 22:08:52 localhost kernel:        bffffb28 0000009c 0000007b 0000007b 0000009c b7f6a504 00000073 00000246
Oct 14 22:08:52 localhost kernel: Call Trace:
Oct 14 22:08:52 localhost kernel:  [setscheduler+171/475] setscheduler+0xab/0x1db
Oct 14 22:08:52 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 14 22:08:52 localhost kernel: Code: 74 01 aa 5b 89 f0 5e 5f 5d c3 8b 0d ac f6 45 c0 81 ea 28 02 10 c0 a1 a8 f6 45 c0 d3 ea 48 39 d0 0f 46 d0 a1 a4 f6 45 c0 8d 14 90 <ff> 02 c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 90 53 31 d2
Oct 14 22:08:52 localhost kernel:  <6>note: setp[5911] exited with preempt_count 2
Oct 14 22:08:52 localhost kernel: scheduling while atomic: setp/0x04000002/5911
Oct 14 22:08:52 localhost kernel:  [schedule+64/1126] schedule+0x40/0x466
Oct 14 22:08:52 localhost kernel:  [unmap_page_range+60/87] unmap_page_range+0x3c/0x57
Oct 14 22:08:52 localhost kernel:  [cond_resched+40/73] cond_resched+0x28/0x49
Oct 14 22:08:52 localhost kernel:  [unmap_vmas+396/504] unmap_vmas+0x18c/0x1f8
Oct 14 22:08:52 localhost kernel:  [exit_mmap+96/296] exit_mmap+0x60/0x128
Oct 14 22:08:52 localhost kernel:  [mmput+35/166] mmput+0x23/0xa6
Oct 14 22:08:52 localhost kernel:  [do_exit+375/940] do_exit+0x177/0x3ac
Oct 14 22:08:52 localhost kernel:  [do_divide_error+0/234] do_divide_error+0x0/0xea
Oct 14 22:08:52 localhost kernel:  [do_page_fault+927/1266] do_page_fault+0x39f/0x4f2
Oct 14 22:08:52 localhost kernel:  [profile_hit+33/36] profile_hit+0x21/0x24
Oct 14 22:08:52 localhost kernel:  [release_console_sem+141/213] release_console_sem+0x8d/0xd5
Oct 14 22:08:52 localhost kernel:  [remove_wait_queue+82/106] remove_wait_queue+0x52/0x6a
Oct 14 22:08:52 localhost kernel:  [write_chan+437/462] write_chan+0x1b5/0x1ce
Oct 14 22:08:52 localhost kernel:  [__wake_up+48/96] __wake_up+0x30/0x60
Oct 14 22:08:52 localhost kernel:  [__wake_up+62/96] __wake_up+0x3e/0x60
Oct 14 22:08:52 localhost kernel:  [do_page_fault+0/1266] do_page_fault+0x0/0x4f2
Oct 14 22:08:52 localhost kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 14 22:08:52 localhost kernel:  [profile_hit+33/36] profile_hit+0x21/0x24
Oct 14 22:08:52 localhost kernel:  [setscheduler+171/475] setscheduler+0xab/0x1db
Oct 14 22:08:52 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
------------------------------------------------------------------------------------------------------

------------------------ .config --------------------------------------------------
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-rc4mm1
# Wed Oct 13 13:22:54 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

#
# Performance-monitoring counters support
#
CONFIG_PERFCTR=y
CONFIG_PERFCTR_INIT_TESTS=y
CONFIG_PERFCTR_VIRTUAL=y
CONFIG_PERFCTR_INTERRUPT_SUPPORT=y
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_THINKPAD is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_YENTA=y
CONFIG_CARDBUS=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=y

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=y
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
CONFIG_SMC_IRCC_FIR=m
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IEEE80211=m
CONFIG_IEEE80211_CRYPT=m
CONFIG_IEEE80211_WPA=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_IPW2100=m
CONFIG_IPW2100_PROMISC=y
# CONFIG_IPW2100_LEGACY_FW_LOAD is not set
CONFIG_IPW_DEBUG=y
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I8XX_TCO=m
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=m
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
CONFIG_SND_MPU401_UART=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=y

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_RW_DETECT=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
CONFIG_USB_EGALAX=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_PHIDGETSERVO=m
CONFIG_USB_TEST=m

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_SA1100 is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
# CONFIG_USB_GADGET_OMAP is not set
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ZERO=m
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_FILE_STORAGE=m
CONFIG_USB_FILE_STORAGE_TEST=y
CONFIG_USB_G_SERIAL=m

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISER4_FS=y
CONFIG_REISER4_LARGE_KEY=y
# CONFIG_REISER4_CHECK is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_FRAME_POINTER is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES_586=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_X86_BIOS_REBOOT=y

-mat

-- 
Pozdrowienia,Regards,Cheers,Grüße,A plus!,

