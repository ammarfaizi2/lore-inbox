Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbTG3Txh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTG3Txh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:53:37 -0400
Received: from mail.netilla.com ([63.97.64.130]:3898 "EHLO mail.netilla.com")
	by vger.kernel.org with ESMTP id S269661AbTG3Txc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:53:32 -0400
Message-ID: <3F2823CD.2010009@netilla.com>
Date: Wed, 30 Jul 2003 16:00:13 -0400
From: Paul Douglas <paul_douglas@netilla.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel deadlock
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2003 19:53:31.0429 (UTC) FILETIME=[40A7A550:01C356D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I'm not sure is this issue have been identified and dealt with... I've been
searching through the mailing list archives with no luck.
I'm a neophyte when it comes to the linux kernel as a result I don't 
subscribe
to the kernel mailing list so please cc me on any responses...

I'm load testing my PPP based server and it deadlocks when I stress it out.
The way the server is architected each new incoming connection causes 
the server
to spawn a child process to handle that session. This child process then 
spawns a pppd process
and opens a pty to connect it to the pppd process. When I run my load 
test I have 300 sessions
up and am pinging with 1500 byte packets over each session.
It looks like due to the load on the system ppp keep alive echo requests 
timeout for the some of the sessions
and as they do the pppd process terminates.  This is turn causes child 
process to close it's end of the pty. After
a while, generally a few minutes, as one of the sessions terminates  the 
machine locks up and all logging stops.

Here's an example of a *.debug syslog... notice that there is no 
activity in the log after 17:45:59 until the
system is power cycled.

Jul 25 17:45:50 gondor pppd[2554]: LCP terminated by peer (Peer not 
responding)
Jul 25 17:45:55 gondor pppd[2554]: Connection terminated.
Jul 25 17:45:55 gondor pppd[2554]: Connect time 94.7 minutes.
Jul 25 17:45:55 gondor pppd[2554]: Sent 5205988 bytes, received 5277223 
bytes.
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: Select Error: 0
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: Read error
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: ^I^ICALLING QUEUE CLOSE
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: Shutting down socket
Jul 25 17:45:59 gondor pppd[2554]: Hangup (SIGHUP)
Jul 25 17:45:59 gondor pppd[2554]: ioctl(TIOCSETD, N_TTY): Interrupted 
system call
Jul 25 17:45:59 gondor pppd[2554]: Exit.
Jul 25 17:45:59 gondor svr: SVR: A child has died:; psvpns_chld_reap: 1
Jul 25 17:45:59 gondor svr: SVR: Received a disconnect message id:1142
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: Select Error: 0
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: Read error
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: ^I^ICALLING QUEUE CLOSE
Jul 25 17:45:59 gondor svr-chld: SVRC: 2553: Shutting down socket
Jul 25 17:45:59 gondor pppd[2554]: Hangup (SIGHUP)
Jul 25 17:45:59 gondor pppd[2554]: ioctl(TIOCSETD, N_TTY): Interrupted 
system call
Jul 25 17:45:59 gondor pppd[2554]: Exit.
Jul 25 18:02:39 gondor syslogd 1.4-0: restart.
Jul 25 18:02:39 gondor kernel: klogd 1.4-0, log source = /proc/kmsg 
started.
Jul 25 18:02:39 gondor kernel: Inspecting /boot/System.map
Jul 25 18:02:39 gondor kernel: Loaded 15287 symbols from /boot/System.map.


By enabling the NMI I'm able to get some information on the console when 
the nmi_watchdog breaks the
deadlock.. Here's what I get...

NMI Watchdog detected LOCKUP on CPU0, eip c01090ca, registers:
CPU: 0
EIP: 0010:[<c01090ca>] Not tainted
EFLAGS: 00000002
eax: 00000001 ebx: df998b80 ecx: cc7f8000 edx: 00000000
esi: 00000014 edi: 00000000 ebp: cc7f9e0c esp: cc7f9dc8
ds: 0018 es: 0018 ss: 0018
Process svr-chld (pid: 2957, stackpage=cc7f9000)
Stack: d1ec62a0 c01ac3eb ce3e8000 c0315a80 00000014 df998b80 00000280 
c0109318
00000014 cc7f9e0c df998b80 00000000 00000002 c03195e0 fffffffd 00000000
c010bea8 00000002 cc7f8000 00000000 c03195e0 fffffffd 00000000 00000000
Call Trace: [<c01ac3eb>] [<c0109318>] [<c010bea8>] [<c01e0018>] 
[<c011dee3>]
[<c01e9a8c>] [<c01eb3ee>] [<c01ac290>] [<c01a82b2>] [<c01a8363>] 
[<c01ac640>]
[<c01a4f94>] [<c01a615c>] [<c0238288>] [<c0207690>] [<c01090f9>] 
[<c0242e66>]
[<c0153943>] [<c01a65f2>] [<c013ce88>] [<c013b19e>] [<c013b246>] 
[<c010771f>]

Code: 75 f4 8b 43 04 be 01 00 00 00 a9 00 00 00 20 75 08 fb 8d 74
console shuts up ...

After passing this through ksymoops...

ksymoops 2.4.9 on i686 2.4.21_0pre5.6. Options used
-V (default)
-k /proc/ksyms (default)
-l /proc/modules (default)
-o /lib/modules/2.4.21_0pre5.6/ (default)
-m /boot/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
NMI Watchdog detected LOCKUP on CPU0, eip c01090ca, registers:
CPU: 0
EIP: 0010:[<c01090ca>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000002
eax: 00000001 ebx: df998b80 ecx: cc7f8000 edx: 00000000
esi: 00000014 edi: 00000000 ebp: cc7f9e0c esp: cc7f9dc8
ds: 0018 es: 0018 ss: 0018
Process svr-chld (pid: 2957, stackpage=cc7f9000)
Stack: d1ec62a0 c01ac3eb ce3e8000 c0315a80 00000014 df998b80 00000280 
c0109318
00000014 cc7f9e0c df998b80 00000000 00000002 c03195e0 fffffffd 00000000
c010bea8 00000002 cc7f8000 00000000 c03195e0 fffffffd 00000000 00000000
Call Trace: [<c01ac3eb>] [<c0109318>] [<c010bea8>] [<c01e0018>] 
[<c011dee3>]
[<c01e9a8c>] [<c01eb3ee>] [<c01ac290>] [<c01a82b2>] [<c01a8363>] 
[<c01ac640>]
[<c01a4f94>] [<c01a615c>] [<c0238288>] [<c0207690>] [<c01090f9>] 
[<c0242e66>]
[<c0153943>] [<c01a65f2>] [<c013ce88>] [<c013b19e>] [<c013b246>] 
[<c010771f>]
Code: 75 f4 8b 43 04 be 01 00 00 00 a9 00 00 00 20 75 08 fb 8d 74


 >>EIP; c01090ca <handle_IRQ_event+3a/a0> <=====

Trace; c01ac3eb <pty_write+14b/150>
Trace; c0109318 <do_IRQ+98/f0>
Trace; c010bea8 <call_do_IRQ+5/d>
Trace; c01e0018 <tg3_interrupt+f8/160>
Trace; c011dee3 <do_softirq+63/e0>
Trace; c01e9a8c <.text.lock.ppp_generic+181/4e5>
Trace; c01eb3ee <ppp_asynctty_wakeup+5e/70>
Trace; c01ac290 <pty_unthrottle+60/70>
Trace; c01a82b2 <check_unthrottle+32/40>
Trace; c01a8363 <n_tty_flush_buffer+13/60>
Trace; c01ac640 <pty_flush_buffer+70/80>
Trace; c01a4f94 <do_tty_hangup+324/380>
Trace; c01a615c <release_dev+60c/660>
Trace; c0238288 <tcp_close+108/7e0>
Trace; c0207690 <ide_dma_intr+0/c0>
Trace; c01090f9 <handle_IRQ_event+69/a0>
Trace; c0242e66 <tcp_send_fin+146/200>
Trace; c0153943 <clear_inode+13/c0>
Trace; c01a65f2 <tty_release+32/70>
Trace; c013ce88 <fput+118/140>
Trace; c013b19e <filp_close+8e/d0>
Trace; c013b246 <sys_close+66/80>
Trace; c010771f <system_call+33/38>

Code; c01090ca <handle_IRQ_event+3a/a0>
00000000 <_EIP>:
Code; c01090ca <handle_IRQ_event+3a/a0> <=====
0: 75 f4 jne fffffff6 <_EIP+0xfffffff6> c01090c0 
<handle_IRQ_event+30/a0> <=====
Code; c01090cc <handle_IRQ_event+3c/a0>
2: 8b 43 04 mov 0x4(%ebx),%eax
Code; c01090cf <handle_IRQ_event+3f/a0>
5: be 01 00 00 00 mov $0x1,%esi
Code; c01090d4 <handle_IRQ_event+44/a0>
a: a9 00 00 00 20 test $0x20000000,%eax
Code; c01090d9 <handle_IRQ_event+49/a0>
f: 75 08 jne 19 <_EIP+0x19> c01090e3 <handle_IRQ_event+53/a0>
Code; c01090db <handle_IRQ_event+4b/a0>
11: fb sti
Code; c01090dc <handle_IRQ_event+4c/a0>
12: 8d 74 00 00 lea 0x0(%eax,%eax,1),%esi


The version of the kernel is Linux 2.4.21_0pre5.6 #1 SMP
It's running on a single P3 machine.
The PPP version is 2.4.1-6mdk.

Any help or insight into this problem would be really apprecaited...
Thanks much,
Paul


