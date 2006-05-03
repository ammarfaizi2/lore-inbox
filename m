Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWECVcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWECVcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWECVcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:32:19 -0400
Received: from cpc1-cmbg4-0-0-cust914.cmbg.cable.ntl.com ([81.98.247.147]:5903
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S1751357AbWECVcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:32:19 -0400
Message-ID: <44592177.5080801@thekelleys.org.uk>
Date: Wed, 03 May 2006 22:32:39 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: netlink+ARP+CLIP == broken,
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both net/ipv4/arp.c and net/arm/clip.c create neighbour tables with
family == AF_INET. For most purposes this is fine, since the two modules
 each hold a pointer to their table and pass it into the neigh_* functions.

A problem arises in neigh_add, which is called by the rtnetlink code and
which iterates through all the neighbour tables looking for the first
one with the correct family. Since there are two different tables with
family == AF_INET, sometimes it picks the wrong one.

This leads to the situation where sending a RTM_NEWNEIGH message via
netlink can generate an ignored and useless entry in the clip table,
whilst the not affecting another entry in the ARP table, both entries
for the same IP.

Viz:
sid:~# ip neigh
192.168.3.40 dev eth0 lladdr 52:54:00:12:34:59 REACHABLE
192.168.3.40 dev eth0  FAILED


It's not immediately obvious how to fix this in a conceptually clean
manner: neighbour tables are not associated with single netdevices, and
they don't carry an address-type field. Given a {IP,lladdr,device}
triple, its easy to determine if the device is ether-like or CLIP, but
then the update call would have to go via the ARP and CLIP modules,
instead of direct to the neighbour module in an address independent way.
New address types would need further additions to the netlink/neighbour
code.

OTOH there are several obvious hacks that will fix the immediate
problem. I'm happy to provide a patch implementing one if that's desired.

Looking again, I think this is also a security hole, since the CLIP code
keeps a whole struct including pointers in the neighbour table entry
where ARP has the MAC address. So this might provide a way to poke
arbitrary pointers into the kernel via RTM_NEWNEIGH. Only for root, though.

Cheers,

Simon.


