Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVICUx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVICUx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 16:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVICUx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 16:53:26 -0400
Received: from ms-smtp-04-lbl.southeast.rr.com ([24.25.9.103]:63712 "EHLO
	ms-smtp-04-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S1750934AbVICUxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 16:53:25 -0400
Message-Id: <200509032053.j83KrE1u028307@ms-smtp-04-eri0.southeast.rr.com>
From: "Matt LaPlante" <laplam@rpi.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Potential IPSec DoS/Kernel Panic with 2.6.13
Date: Sat, 3 Sep 2005 16:53:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWwyX7aTsVpdzW1SP22ZPvotEI/Lg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found what I believe is a potential DoS condition in IPSec using Debian
but I need help isolating the culprit.  First my system:
Debian 3.1 stable with all updates as of 9/2. 
Custom Linux kernel 2.6.13 (no patches)
IPTables 1.3.3 (no patches)
Shorewall 2.4.3

I use my system as a multipurpose firewall/DHCP/DNS gateway on my broadband
home connection.  I have another system with the same specs on a remote
network. 
Just recently I installed the racoon debian package on both machines and
established an IPSec VPN tunnel between the two routers.  All has worked
generally as expected and I have connectivity between my local and remote
LAN while having regular internet service running alongside.  Here is my
racoon-tool
config:
#
# Configuration file for racoon-tool
#
# See racoon-tool.conf(5) for details
#

global:
        log: notify

connection(test):
        src_range: 192.168.4.0/24
        dst_range: 192.168.1.0/24
        src_ip: A.B.C.D
        dst_ip: W.X.Y.Z
        authentication_algorithm: hmac_sha1
        admin_status: yes

peer(A.B.C.D):
        passive: off
        verify_identifier: on
        lifetime: time 30 min
        hash_algorithm[0]: sha1
        encryption_algorithm[0]: aes
        my_identifier: address A.B.C.D
        peers_identifier: address W.X.Y.Z ####

Now with this config, I can ping the remote LAN from my Win XP machine
successfully using "ping -t -l 1024 192.168.1.2".

I was just randomly messing around with some settings when I ran the
following:
"ping -t -l 2048 192.168.1.2"

Now I'm well aware that this command won't likely succeed due to the
excessive size of the packet (2048 bytes).  What I wasn't expecting was that
I would be totally and completely unable to access my router via SSH or have
any internet connectivity.  Yes, the oversize ping packet took down all the
network connectivity on my router.  Upon further inspection I noticed the
packet had actually caused a kernel panic (visible only on the monitor, now
also unresponsive).

I shut down with a hard power down, rebooted, and tried again...with the
dead same result.  This oversize ping packet seems to repeatedly crash the
system. 

I tried while booting the current Debian stock kernel (2.6.8-2-686), and
this problem was NOT present.  I think due to this, it is unlikely related
to any supporting software on my system.

I'm not sure where to proceed from here.  I'd be glad to send in the kernel
traces, but I don't know how to capture them...they aren't being logged
anywhere that I can find, so I need to know how to capture them and submit
them if they're necessary.

I want to emphasize that this is somehow related to IPSec, as I tested the
exact same command but substituted www.google.com for my remote LAN IP
address and there were NO crashes/problems whatsoever.

This bug seems to be a high threat because:
-It occurs reproducibly.
-It occurs in the latest kernel with *no* patches.
-It did not occur with a previous kernel.
-It causes a complete system failure.
-It is extremely simple to exploit.

I will gladly provide more details upon request.  I'm not experienced enough
at the low level system aspects to provide detailed debugging info from
scratch, but I do have extensive experience with administering these systems
so I can give any information necessary with a little guidance.

Note: I'm trying posting this under a 2nd email address.  I tried posting
with my subscribed email address, but the post has not appeared on the list
in 24 hours, even though I'm receiving posts normally.  If it results in
double posts I apologize.

-
Matt LaPlante

