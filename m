Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTGHRxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbTGHRxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:53:47 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:55310 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264792AbTGHRwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:52:44 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74 - BUG in kfree during sys_close from netstat
Date: Tue, 8 Jul 2003 22:06:23 +0400
User-Agent: KMail/1.5
References: <200307082155.49404.arvidjaar@mail.ru>
In-Reply-To: <200307082155.49404.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307082206.23810.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 July 2003 21:59, Andrey Borzenkov wrote:
> Just tried and when connection is done while kmail is not started it works.
> I am not sure what kmail does - except that it actually is the only
> application to actively use IP here most of the time.
>

forget it - with or without kmail, with or without connection established 
netstat bugs out every time:

pts/1}% ifconfig -a
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:177 errors:0 dropped:0 overruns:0 frame:0
          TX packets:177 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:12238 (11.9 Kb)  TX bytes:12238 (11.9 Kb)

{pts/1}% netstat -an
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.1:32768         0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:587             0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:10000           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:6000            0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:631             0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:25              0.0.0.0:*               LISTEN
udp        0      0 0.0.0.0:514             0.0.0.0:*
udp        0      0 0.0.0.0:10000           0.0.0.0:*
udp        0      0 127.0.0.1:53            0.0.0.0:*
udp        0      0 224.0.0.251:5353        0.0.0.0:*
udp        0      0 127.0.0.1:5353          0.0.0.0:*
udp        0      0 0.0.0.0:111             0.0.0.0:*
udp        0      0 0.0.0.0:631             0.0.0.0:*
zsh: segmentation fault  netstat -an

dmesg -> 
------------[ cut here ]------------
kernel BUG at mm/slab.c:1537!
invalid operand: 0000 [#6]
CPU:    0
EIP:    0060:[<c014c530>]    Tainted: P
EFLAGS: 00010002
EIP is at kfree+0x2e0/0x2f0
eax: 0000002c   ebx: 00040000   ecx: cf1fe670   edx: 00000001
esi: c02b9ee0   edi: 00000100   ebp: ced77f34   esp: ced77f14
ds: 007b   es: 007b   ss: 0068
Process netstat (pid: 10529, threadinfo=ced76000 task=c1b100e0)
Stack: ced77f28 c02752fe cacdcad0 00000001 00000206 cacdcad0 cfab5a04 c245537c
       ced77f4c c01881b8 00000100 cfab5a04 cfab5a04 cffdf8e4 ced77f70 c0165089
       c245537c cfab5a04 c245537c c996fa98 cfab5a04 c61c2c54 00000000 ced77f98
Call Trace:
 [<c02752fe>] raw_seq_start+0x4e/0x60
 [<c01881b8>] seq_release_private+0x18/0x32
 [<c0165089>] __fput+0x129/0x130
 [<c0163703>] filp_close+0xc3/0x110
 [<c01637e2>] sys_close+0x92/0x120
 [<c010b527>] syscall_call+0x7/0xb

Code: 0f 0b 01 06 d1 93 2b c0 e9 44 fd ff ff 8d 76 00 55 89 e5 57


