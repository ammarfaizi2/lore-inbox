Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVFEKCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVFEKCg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 06:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFEKCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 06:02:36 -0400
Received: from ms.iem.uni-duisburg-essen.de ([132.252.150.1]:43683 "EHLO
	pilz.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id S261544AbVFEKCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 06:02:31 -0400
Subject: IRQ exception upon networking with many vifs/bridges (using Xen)
From: Birger =?ISO-8859-1?Q?T=F6dtmann?= <btoedtmann@iem.uni-due.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Date: Sun, 05 Jun 2005 11:38:43 +0200
Message-Id: <1117964324.2494.15.camel@lomin>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

(- this is sort of crossposting from Xen mailing lists, because I do
   not know whether this is very Xen specific as the domain0 linux
   kernel is crashing with a 'fatal exception in interrupt' - see
   below for details.)


I try to build experimental networks with Linux and Xen and stumbled
over the problem that for many bridge/vif devices, there are not as much
NR_IRQS available as needed (relevant posting on Xen mailling lists
here:
http://lists.xensource.com/archives/html/xen-users/2005-04/msg00447.html)


Fortunately, Xen-3.0-devel increased NR_PIRQS and NR_DYNIRQS. It is now
possible to get a virtual test network up and running with 20 nodes and
approx. 120 interfaces, without problems at first. The vifs are wired to
~60 bridge interfaces, 2 vifs each.  Kernel version is 2.6.11, Xen
version is xen-unstable (a.k.a 3.0-devel) as of May 31.


The problem: when allowing free packet delivery within the network by
issueing a

  sysctl -w net.bridge.bridge-nf-call-iptables=0

(which was until then set to 1 and my iptables rules blocked all
traffic), the whole machine freezes after a very short time (immediately
to 2-3 seconds), apparently when the first packet is
traveling through the network.  No output, kernel oops, nothing to see,
and magic sysrq gone as well(!).  This behaviour is deterministic.  I
had quite some difficulties getting more information - what I finally
did was to set the sysctl *before* starting the domUs.  Funnily, nothing
happend after starting the first 10-12 nodes, but after "xm create"ing
one or two more nodes, the system oopsed with at least some info, but
sysrq gone as well.  So I wrote it down on a peace of paper ;-) ,
hopefully someone can make sense of it.  I'd happily debug this further
but need some hints on where to begin...


Stack: 
 00000000 d06cea20 2f001020 c8b04780 c0403f1c c028cbfa 0002f001 0000000d
 ffffffff 08b78020 00000052 00000001 00000028 0000005e 00008b85 d21fe000
 00000006 c0457824 0000011d c0453240 00283d58 e01c3a6e c0403cec da6bccd0

Call Trace:
 [<c0109c51>] show_stack+0x80/0x96
 [<c0100de1>] show_registers+0x15a/0x1d1
 [<c010a001>] die+0x106/0x1c4
 [<c010a4aa>] do_invalid_op+0xb5/0xbf
 [<c010985b>] error_code+0x2b/0x30
 [<c028cbfa>] net_rx_action+0x484/0x4df
 [<c01239a9>] tasklet_action+0x7b/0xe0
 [<c0123533>] __do_softirq+0x6f/0xef
 [<c0123632>] do_softirq+0x7f/0x97
 [<c0123706>] irq_exit+0x3a/0x3c
 [<c010d819>] do_IRQ+0x25/0x2c
 [<c0105efe>] evtchn_do_upcall+0x62/0x82
 [<c010988c>] hypervisor_callback+0x2c/0x34
 [<c0107673>] cpu_idle+0x33/0x41
 [<c04047a9>] start_kernel+0x196/0x1e8
 [<c010006c>] 0xc010006c

Code:  08 a8 75 30 83 c4 5b 5e 5f 5d c3 bb 01 00 00 00 31 f6 b8 0c 00 00
00 bf  f0 7f 00 00 8d 4d 08 89 da cd 82 83 e8 01 2e 74 8e <0f> 0b 66 00
2c 7a 35 c0 eb 84 e8 f8 b1 09 00 eb c9 e8 f6 98 e7

<0>Kernel panic - not syncing: Fatal exception in interrupt



System data:
  * gcc-Version 3.4.3-20050110 (Gentoo Linux 3.4.3.20050110-r2, 
    ssp-3.4.3.20050110-0, pie-8.7.7)
  * Pentium 4 Mobile CPU 1.60GHz GenuineIntel GNU/Linux 
    (Dell Inspiron 8200)



Thanks for some suggestions & regards,
-- 
Birger Tödtmann
Technik der Rechnernetze, Institut für Experimentelle Mathematik
Universität Duisburg-Essen, Campus Essen email:btoedtmann@iem.uni-due.de
skype:birger.toedtmann pgp:0x6FB166C9
