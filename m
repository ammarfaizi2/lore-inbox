Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUAUGjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 01:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUAUGjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 01:39:12 -0500
Received: from h80ad25e2.async.vt.edu ([128.173.37.226]:2688 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261928AbUAUGjB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 01:39:01 -0500
Message-Id: <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: 2.6.1-mm5 - oops during network initialization
In-Reply-To: Message from Andrew Morton <akpm@osdl.org> 
   of "Tue, 20 Jan 2004 00:05:35 PST." <20040120000535.7fb8e683.akpm@osdl.org> 
References: <20040120000535.7fb8e683.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1486477894P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jan 2004 01:38:50 -0500
From: Valdis Kletnieks <valdis@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1486477894P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <3040.1074667119.1@turing-police.cc.vt.edu>

(linux-net people, please cc: on replies, am only on lkml)

Under 2.6.1-mm4, at boot I'd get the following:

Jan 20 10:00:46 turing-police kernel: Initializing IPsec netlink socket
Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 1
Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 10
Jan 20 10:00:46 turing-police kernel: IPv6 over IPv4 tunneling driver
Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 17
Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 15
Jan 20 10:00:46 turing-police kernel: RAMDISK: Compressed image found at block 0

and the initrd would kick off and we'd be happy.

Under 2.6.1-mm5, I get this: (hand-copied..

NET: Registered protocol family 10
Unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
c01186f9
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU: 0
EIP: 0060:[<c01180f9>]  Not tainted VLI
EFLAGS: 0010217
EIP is at do_page_fault+0x53/0x4b2
eax: cfe84000 ebx: cfe86000 ecx: 0000007b edx: 00000000
esi: 00000000 edi: 00000000 ebp: cfe84048 esp: cfe8405c
ds: 007b es: 007b ss: 0068
process ksoftirqd/0 (pid:2, threadinfo=cfe82000 task=cff81310
stack: 00000000 00000068 00000000 00000000 00000000 00030001 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
call trace:

(I had to stick a 'for (;;);' into the code at this point to keep it from scrolling off the
screen - was do_page_fault and 2 other routines in a loop over and over again).

So it's choking somewhere in IPv6 init.  Only change I can spot in -mm5 in that
area is ipv6-sysctl-oops-fix.patch but I'm not seeing how that one can *cause* this oops.

For the record, built *without* regparm-3, with the Fedora gcc-3.3.2-5 compiler.

IPv6-related .config:

CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y

I'll play binary-search on the IPv6 config options, see if one of them is
involved, but that will have to wait for morning....

--==_Exmh_1486477894P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADh56cC3lWbTT17ARAhLxAJ43BcaA/2gQutk6opzQMHphQU7BwQCg27oj
bXNZMn58dIIcc4Bf51KtZB4=
=6ZbG
-----END PGP SIGNATURE-----

--==_Exmh_1486477894P--
