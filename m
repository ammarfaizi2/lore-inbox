Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUIOTeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUIOTeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUIOTeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:34:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21470 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266505AbUIOTeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:34:01 -0400
Message-ID: <4148991B.9050200@pobox.com>
Date: Wed, 15 Sep 2004 15:33:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Reply-To: Netdev <netdev@oss.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: The ultimate TOE design
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(reply-to set to netdev)

Every now and then people ask on the lists about TOE, TCP assist, and 
that sort of thing.  Ignoring the issue of TCP hardware assist, I wanted 
to describe what I feel is an optimal method to _fully offload_ the 
Linux TCP stack.


Put simply, the "ultimate TOE card" would be a card with network ports, 
a generic CPU (arm, mips, whatever.), some RAM, and some flash.  This 
card's "firmware" is the Linux kernel, configured to run as a _totally 
indepenent network node_, with IP address(es) all its own.

Then, your host system OS will communicate with the Linux kernel running 
on the card across the PCI bus, using IP packets (64K fixed MTU).

This effectively:

1) fragment processing, IPsec, and other services onto the card.

2) You can use huge card<->host MTUs, which makes sendfile(2) faster 
with _zero_ kernel changes

3) You can let the PCI card do 100% of the checksum 
processing/generation, and treat the network connection connection 
across the PCI bus as CHECKSUM_UNNECESSARY.

2) With enough RAM and cpu cycles, you can even offload complex services 
like Web services:  the PCI card runs Apache, and fetches files across 
the network (your PCI bus!) from the host system.

3) Does not require _any_ modification of Linux network stack. 
Interfacing with the card merely requires a simple DMA interface to copy 
IP (not ethernet) packets across the PCI bus, and that fits within the 
existing Linux net driver API.

4) ensures that the TOE "firmware" [the Linux kernel] can be easily 
updated in the event of new features or (more importantly) security 
problems.

5) Linux is the most RFC-compliant net stack in the world.  Why 
re-create (or license) an inferior one?

6) Long-term maintenance of TOE firmware is a BIG problem with existing 
full-TOE systems.  Under this design, sysadmins would update and patch 
their PCI card with security updates just like any other system on their 
network.  This is added work, yes, but it's a known quantity and a task 
they are already doing for other systems.

7) The design is both portable [tons of embedded CPUs, with and without 
MMUs, can run Linux] and scalable.



My dream is that some vendor will come along and implement such a 
design, and sell it in enough volume that it's US$100 or less.  There 
are a few cards on the market already where implementing this design 
_may_ be possible, but they are all fairly expensive.  Just need enough 
resources on the PCI to be able to Linux as a 
router/firewall/iSCSI/web-proxy gadget.

And I'm not aware of anybody doing a direct IP-over-PCI thing, either.

But I'll keep on dreaming...  ;-)

	Jeff



