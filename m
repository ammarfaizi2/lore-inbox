Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTHTLcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTHTLcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:32:15 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37084 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261889AbTHTLcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:32:11 -0400
Date: Wed, 20 Aug 2003 13:32:08 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.kernel.org
Subject: [2.4.2X] "Undeletable" ARP entries?
Message-ID: <20030820113208.GA11163@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have strange ARP behaviour here, that I can reproduce. Might be a
kernel bug.

SHORT: I can use the "arp" tool to set an ARP entry that the "arp" tool
cannot delete and that hides from "ip"'s view. I know a workaround (at
the very end of the mail).

LONG:

Use either of:

   SuSE 2.4.20 kernel for 8.2 (k_athlon-2.4.20-96)
or 2.4.22-rc2-ac1
   (I haven't tried any other version)

Use this tool:

$ arp -V
net-tools 1.60
arp 1.88 (2001-04-04)
+I18N
AF: (inet) +UNIX +INET +INET6 +IPX +AX25 +NETROM +X25 +ATALK -ECONET -ROSE
HW: (ether) +ETHER +ARC +SLIP +PPP +TUNNEL +TR +AX25 +NETROM +X25 +FR -ROSE -ASH +SIT +FDDI +HIPPI -HDLC/LAPB 

Now type (192.168.4.4 isn't available, I would like to use it as SNAT
source):

$ arp -Ds 192.168.4.4 eth1 pub

This entry cannot be deleted:

$ arp -d 192.168.4.4
SIOCDARP(priv): Network is unreachable
(even if a route for 192.168.4.4 is set, the entry isn't removed)
$ arp -d 192.168.4.4 pub
SIOCDARP(pub): No such file or directory

The interesting part is: The address doesn't show up in netlink, 

$ ip -s neigh show nud all | grep 4.4
$
(no output)

/proc/net/arp excerpt:
IP address       HW type     Flags       HW address            Mask     Device
192.168.4.4      0x1         0xc         00:00:00:00:00:00     *        eth1

This doesn't work either:

$ ip neigh d 192.168.4.4 dev eth1
RTNETLINK answers: Invalid argument
$ ip neigh flush dev eth1
Nothing to flush.

This appears to be a kernel bug, unless I missed documentation on how to
remove such an ARP entry.

WORKAROUND:

$ ip addr add 192.168.4.4 dev eth1
$ ip addr del 192.168.4.4 dev eth1

Now the arp entry is gone, probably as a side effect of taking down
resources related to 192.168.4.4.
HOWEVER: the ARP entry was supposed to be permanent, so it may be
another bug that the entry is gone after removing an IP alias.

Anyone got ideas or patches to try?

-- 
Matthias Andree
