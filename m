Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131710AbRCORIH>; Thu, 15 Mar 2001 12:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131708AbRCORHs>; Thu, 15 Mar 2001 12:07:48 -0500
Received: from poppa.wi.securepipe.com ([205.254.211.146]:28724 "HELO
	poppa.wi.securepipe.com") by vger.kernel.org with SMTP
	id <S131707AbRCORHm>; Thu, 15 Mar 2001 12:07:42 -0500
Date: Thu, 15 Mar 2001 11:07:22 -0600 (CST)
From: Matthew Callaway <matt@kindjal.net>
X-X-Sender: <matt@gummy.wi.securepipe.com>
To: <becker@scyld.com>, <linux-kernel@vger.kernel.org>
Subject: Network init script causes 2.2.18 kernel oops (tulip driver)
Message-ID: <Pine.LNX.4.32.0103151045490.31295-100000@gummy.wi.securepipe.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This is a reproducible oops, and my guess is that it's related to
the tulip driver included in the 2.2.18 source tree.  We're using
a D-Link 4 port NIC, and it appears that it doesn't work well with
IPV6 interfaces.

Keywords:  linux kernel-2.2.18 tulip D-Link 4-port NIC DFE-570 TX

Relevant Software
-----------------
kernel 2.2.18 i686
modutils-2.3.21
glibc-2.1.3-22
ipv6 enabled
net-tools 1.54
ifconfig 1.39 (1999-03-18)
tulip module (static const char version[] = "tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov\n";) from the kernel src.rpm.
initscripts-5.00-1.i386.rpm (with the addition below)

Relevant Hardware
-----------------
NIC: D-Link DFE-570 TX 4-port

Cause of the Oops
-----------------
I had included IPV6 support into the kernel without really wanting
it, so my intention was to turn off the IPV6 interfaces until I could
replace the kernel.  I created the following script to be called by
ifup-post.  The inclusion of the script cause the oops every time.
Note that simply issuing the "ifconfig" command line would not always
cause the oops.  It seemed to happen 100% of the time only if it
was immediately called by ifup-post, as if timing had something to
do with the problem.

It is also odd to me that the IPV6 interfaces came up automatically,
even though the init scripts do not specify an IP address for them,
or bring them up specifically.  /sbin/ifconfig just makes a guess and
does it.

/etc/sysconfig/network-scripts/ifup-local:
#! /bin/sh

DEVICE=$1

# turn off inet6 IFs
if [ ! -z "${DEVICE}" ]; then
  INET6ADDR=$( ifconfig ${DEVICE} |grep inet6 |awk '{print $3}' )
  if [ ! -z "${INET6ADDR}" ]; then
    ifconfig ${DEVICE} del ${INET6ADDR}
  fi
fi


Oops Info (copied by hand, klogd didn't catch it)
---------
Call Trace: [<c0109f4d>] [<c0117ca1>] [<c010a2a3>]
[<c0109f70>] [<c010796d>] [<c0106000>]
[<c0107990>] [<c01090ec>] [<c0106000>]
[<c010607b>] [<c0106000>] [<c0100175>]
Code: 8b 40 34 89 42 04 8b 86 88 00 00 00 2b 86 84 00 00 00 83 f8

ksymoops output
---------------
ksymoops -m /boot/System.map -v vmlinux oops.txt
ksymoops 0.7c on i686 2.2.18.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map-spc-2.2.18-6 (specified)

Call Trace: [<c0109f4d>] [<c0117ca1>] [<c010a2a3>]
[<c0109f70>] [<c010796d>] [<c0106000>]
[<c0107990>] [<c01090ec>] [<c0106000>]
[<c010607b>] [<c0106000>] [<c0100175>]
Code: 8b 40 34 89 42 04 8b 86 88 00 00 00 2b 86 84 00 00 00 83 f8
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c0109f4d <do_8259A_IRQ+9d/a8>
Trace; c0117ca1 <do_bottom_half+45/64>
Trace; c010a2a3 <do_IRQ+3b/40>
Trace; c0109f70 <common_interrupt+18/20>
Trace; c010796d <cpu_idle+5d/6c>
Trace; c0106000 <get_options+0/74>
Trace; c0107990 <sys_idle+14/24>
Trace; c01090ec <system_call+34/38>
Trace; c0106000 <get_options+0/74>
Trace; c010607b <cpu_idle+7/18>
Trace; c0106000 <get_options+0/74>
Trace; c0100175 <L6+0/2>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 34                  mov    0x34(%eax),%eax
Code;  00000003 Before first symbol
   3:   89 42 04                  mov    %eax,0x4(%edx)
Code;  00000006 Before first symbol
   6:   8b 86 88 00 00 00         mov    0x88(%esi),%eax
Code;  0000000c Before first symbol
   c:   2b 86 84 00 00 00         sub    0x84(%esi),%eax
Code;  00000012 Before first symbol
  12:   83 f8 00                  cmp    $0x0,%eax


I hope this is enough to find the problem.  I can reproduce it at will,
so if you need more information, contact me and I will be glad to help.


Matthew Callaway

