Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVFWLzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVFWLzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 07:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVFWLzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 07:55:37 -0400
Received: from main.uucpssh.org ([212.27.33.224]:22480 "EHLO main.uucpssh.org")
	by vger.kernel.org with ESMTP id S262095AbVFWLzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 07:55:13 -0400
To: dipankar@in.ibm.com
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.6.12-mm1: BUG() in fd_install, RCU related?
References: <20050621083424.GA2076@elf.ucw.cz>
	<20050621090721.GA7976@in.ibm.com>
From: syrius.ml@no-log.org
Message-ID: <874qbpwbae.873br9wbae@871x6twbae.message.id>
Date: Thu, 23 Jun 2005 13:50:11 +0200
In-Reply-To: <20050621090721.GA7976@in.ibm.com> (Dipankar Sarma's message of "Tue, 21 Jun 2005 14:37:21 +0530")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> writes:

Hi

> This has been reported by several other people.
> I am looking at it except that I can't reproduce it with the config
> files in one of those bug reports. Probably whatever userland triggers
> this bug isn't in my lab machine. Besides I am running really old
> userland anyway. I am going to find a box with  newer userland
> and try.
>
> Some things are common - always with fcntl() or fcntl64() and with
> a daemon. Does your box come up at all ? If so, can you get me an
> strace on the process that triggers this ? If I can narrow it
> down to a small testcase, it would be a lot easier. Also, does
> switching off CONFIG_PREEMPT fix this problem ?

I haven't read about this thread. I hope u'll find a way to reproduce
it. here debian/sid i386 (.config sent in an earlier message), it 100%
reproducible when restarting bind9. (it also happens on its own on
different occasion)


end of a strace -f /etc/init.d/bind9 stop:
2290  rt_sigaction(SIGHUP, {0xb7d02570, ~[RTMIN], 0}, NULL, 8) = 0
2290  rt_sigsuspend([] <unfinished ...>
2291  select(4, [3], [], NULL, NULL <unfinished ...>
2292  gettimeofday({1119470144, 436008}, NULL) = 0
2292  rt_sigprocmask(SIG_UNBLOCK, [INT TERM], NULL, 8) = 0
2292  socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 5
2292  close(5)                          = 0
2292  socket(PF_INET6, SOCK_STREAM, IPPROTO_IP) = 5
2292  getsockname(5, {sa_family=AF_INET6, sin6_port=htons(0),
inet_pton(AF_INET6, "::", &sin6_addr), s
in6_flowinfo=0, sin6_scope_id=0}, [28]) = 0
2292  close(5)                          = 0
2292  futex(0xb7d1bb80, FUTEX_WAKE, 2147483647) = 0
2292  rt_sigprocmask(SIG_BLOCK, [INT TERM], NULL, 8) = 0
2292  socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 5
2292  fcntl64(5, F_DUPFD, 20)           = 20
2292  close(5)                          = 0
2292  fcntl64(20, F_GETFL)              = 0x2 (flags O_RDWR)
2292  fcntl64(20, F_SETFL, O_RDWR|O_NONBLOCK) = 0
2292  connect(20, {sa_family=AF_INET, sin_port=htons(953),
sin_addr=inet_addr("127.0.0.1")}, 16) = -1 
EINPROGRESS (Operation now in progress)
2292  write(4, "\24\0\0\0\374\377\377\377", 8) = 8
2291  <... select resumed> )            = 1 (in [3])
2292  futex(0x80534fc, FUTEX_WAIT, 0, NULL <unfinished ...>
2291  read(3, "\24\0\0\0\374\377\377\377", 8) = 8
2291  read(3, 0xb7b82848, 8)            = -1 EAGAIN (Resource
temporarily unavailable)
2291  select(21, [3], [20], NULL, NULL) = 1 (out [20])
2291  futex(0x80534fc, FUTEX_WAKE, 1)   = 1
2292  <... futex resumed> )             = 0
2291  select(21, [3], [], NULL, NULL <unfinished ...>
2292  futex(0x80534b8, FUTEX_WAKE, 1)   = 0
2292  gettimeofday({1119470144, 441408}, NULL) = 0
2292  getsockopt(20, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
2292  gettimeofday({1119470144, 441603}, NULL) = 0
2292  recvmsg(20, 0xb73828b0, 0)        = -1 EAGAIN (Resource
temporarily unavailable)
2292  write(4, "\24\0\0\0\375\377\377\377", 8) = 8
2291  <... select resumed> )            = 1 (in [3])
2292  sendmsg(20, {msg_name(0)=NULL,
msg_iov(1)=[{"\0\0\0\217\0\0\0\1\5_auth\2\0\0\0 \4hmd5\1\0\0\0\02
66y"..., 147}], msg_controllen=0, msg_flags=0}, 0 <unfinished ...>
2291  read(3,  <unfinished ...>
2292  <... sendmsg resumed> )           = 147
2291  <... read resumed> "\24\0\0\0\375\377\377\377", 8) = 8
2292  futex(0x80534fc, FUTEX_WAIT, 1, NULL <unfinished ...>
2291  read(3, 0xb7b82848, 8)            = -1 EAGAIN (Resource
temporarily unavailable)
2291  select(21, [3 20], [], NULL, NULL

the rdnc freeze here.

then i restart the daemon:

end of a strace -f /etc/init.d/bind9 start
6541  rt_sigaction(SIGPIPE, {0xb7ca2a70, [], 0}, {SIG_IGN}, 8) = 0
6541  send(3, "<30>Jun 23 00:51:35 named[6540]:"..., 82, 0) = 82
6541  rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
6541  socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 10
6541  fcntl64(10, F_DUPFD, 20)          = 32
6541  close(10)                         = 0
6541  fcntl64(32, F_GETFL)              = 0x2 (flags O_RDWR)
6541  fcntl64(32, F_SETFL, O_RDWR|O_NONBLOCK) = 0
6541  setsockopt(32, SOL_SOCKET, SO_TIMESTAMP, [1], 4) = 0
6541  setsockopt(32, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
6541  bind(32, {sa_family=AF_INET, sin_port=htons(53),
sin_addr=inet_addr("172.16.254.1")}, 16) = 0
6541  socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 10
6541  fcntl64(10, F_DUPFD, 20

and the oops appears:
------------[ cut here ]------------
kernel BUG at fs/open.c:935!
invalid operand: 0000 [#1]
Modules linked in: ip6t_owner tun ip6t_length ip6t_MARK ip6t_IMQ
ip6t_REJECT ip6t_LOG ip6t_limit ip6ta
ble_mangle ip6table_filter ip6_tables cls_fw sch_sfq sch_hfsc imq
ipt_CLASSIFY ipt_length ipt_multipor
t ipt_helper ipt_tos ipt_MARK ipt_CONNMARK ipt_IMQ ipt_MASQUERADE
ipt_TCPMSS ipt_REJECT ipt_LOG ipt_li
mit iptable_mangle ipt_connmark ipt_state ip_nat_mms ip_nat_h323
ip_nat_irc ip_nat_ftp ip_conntrack_qu
ake3 ip_conntrack_mms ip_conntrack_h323 ip_conntrack_irc
ip_conntrack_ftp iptable_nat ip_conntrack ipt
able_filter ip_tables nfsd exportfs pppoe pppox ppp_synctty ppp_async
crc_ccitt genrtc nfs lockd sunrp
c ppp_generic slhc i2c_piix4 i2c_isa lm75 lm78 i2c_sensor i2c_core
e100 ipv6 dm_mod
CPU:    0
EIP:    0060:[<c015822b>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-mm1) 
EIP is at fd_install+0x2b/0x40
eax: cbcc1ba0   ebx: 00000020   ecx: c8bf8a60   edx: cbcc11a0
esi: cbcc11a0   edi: c8bf8a60   ebp: c7887f58   esp: c7887f54
ds: 007b   es: 007b   ss: 0068
Process named (pid: 6541, threadinfo=c7886000 task=c7890040)
Stack: 00000020 c7887f78 c016a842 c782dc80 cbcc11a0 00000014 ffffffea
fffffff7 
       00000000 c7887f90 c016abcf cbcc11a0 00000014 fffffff7 cbcc11a0
       c7887fb4 
       c016adc2 0000000a 00000000 00000014 cbcc11a0 0000000a 00000014
       b7d0fb7c 
Call Trace:
 [<c0103def>] show_stack+0x7f/0xa0
 [<c0103f97>] show_registers+0x157/0x1c0
 [<c0104188>] die+0xc8/0x140
 [<c01042b5>] do_trap+0xb5/0xc0
 [<c01045fc>] do_invalid_op+0xbc/0xd0
 [<c0103a33>] error_code+0x4f/0x54
 [<c016a842>] dupfd+0x52/0x70
 [<c016abcf>] do_fcntl+0x7f/0x190
 [<c016adc2>] sys_fcntl64+0x82/0xa0
 [<c0102f89>] syscall_call+0x7/0xb
Code: 55 89 e5 53 89 c3 b8 00 e0 ff ff 21 e0 8b 00 8b 80 54 04 00 00
8b 48 04 8b 41 0c 8b 04 98 85 c0 
75 09 8b 41 0c 89 14 98 5b 5d c3 <0f> 0b a7 03 dc 24 30 c0 eb ed 8d 74
26 00 8d bc 27 00 00 00 00 


-- 
