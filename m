Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTLCPPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTLCPPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:15:10 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:25220 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S264608AbTLCPPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:15:00 -0500
Date: Wed, 3 Dec 2003 15:15:09 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: linux-kernel@vger.kernel.org
Subject: bug in 2.4.22:  process left in 'T' state.
Message-ID: <Pine.LNX.4.44.0312031505520.1772-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed a very interesting behaviour which I haven't seen before.
I think it's a bug and very easily reproducible one too.

I was running in one session:

# tcpdump -i lo icmp

and in another session:

# strace -p 2117 -v

(2117 being the pid of tcpdump).

and in yet another session:

# ping -c 1 localhost

Now, after tcpdump captured the two icmp packets I waited until strace 
showed it blocked in the next recvfrom() system call and pressed ^C to 
terminate strace. It did terminate, but it left tcpdump in the 'traced' 
state and I couldn't do anything to kill tcpdump from within (i.e. all 
SIGINTs were blocked).

Re-running strace -p 2117 -c caused this:

~# strace -p 2117 -v
--- SIGINT (Interrupt) ---

and in the tcpdump session:

~# tcpdump -i lo icmp
tcpdump: listening on lo
15:07:09.442309 localhost.localdomain > localhost.localdomain: icmp: echo request (DF)
15:07:09.442372 localhost.localdomain > localhost.localdomain: icmp: echo reply


[1]+  Stopped                 tcpdump -i lo icmp
~# fg
tcpdump -i lo icmp

2 packets received by filter
0 packets dropped by kernel

The two empty lines are my attempts to ^C which were ignored. Then, after 
I re-run strace tcpdump was stopped and then bringing it to foreground 
caused the SIGINT to be delivered and terminated as expected with the 
packet count/loss reported as normal.

Kind regards
Tigran




