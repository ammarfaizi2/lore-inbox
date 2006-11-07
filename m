Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754074AbWKGGgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbWKGGgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbWKGGgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:36:43 -0500
Received: from mail.suse.de ([195.135.220.2]:49072 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754074AbWKGGgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:36:43 -0500
From: Neil Brown <neilb@suse.de>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 7 Nov 2006 17:36:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17744.10620.389409.136737@cse.unsw.edu.au>
Subject: TCP stack sometimes loses ACKs ... or something
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I upgraded my notebook from 2.6.16 to 2.6.18 recently and noticed that
I couldn't talk to my VOIP device (which has a WEB interface).
Watching traffic I see the three-way-handshake working perfectly, and
then the first data packet is sent (a partial HTTP request: 
GET / HTTP/1.1 ....) and an ACK comes back from the device.
Then the next data packet (remainder of the HTTP request) is sent, but
tcpdump never sees the ACK, nor does the TCP stack.  So the data gets
recent repeatedly.  No ack. Ever.

With 2.6.16, The ack comes back just fine and the connection proceeds
as you would expect.

As it was a very reproducible problem I decided to try "git bisect"
and found 

 bad: [7b4f4b5ebceab67ce440a61081a69f0265e17c2a] [TCP]: Set default max buffers from memory pool size

I double checked as this seemed a fairly unlikely patch to cause the
problem, but this definitely is it.
The net effect of this patch is to change the last of the three
numbers in 
    cat /proc/sys/net/ipv4/tcp_[rw]mem 
from well below 2^20 to well above. 2^20 seems to be a significant
number. I set tcp_wmem to that and the ACK was lost.  I set it to
one less and the first ACK (at least) was accepted.
I ended up setting both r and w to 100000 and everything is fine.

Exploring more deeply, and comparing:
  - a failing connection (to VIOP box, [rw]mem large)
  - a working connection to VOIP box ([rw]mem small)
  - a working connection to another machine ([rw]mem irrelevant).
I find:

  The VIOP returns MSS=1360 in the SYN/ACK packet.  Other machine
    returns MSS=1460

  The ack that is getting lost contains data as well as the
  ACK. i.e. the same packet that ACKs at the TCP level includes the
  HTTP level reply.
  The matching ACK from the other machine (some Linux 2.6.8 I think)
   is a data-less ACK followed very quickly by the HTTP reply in
   a separate packet.

  The 'Timestamps' option coming back from the VOIP box is a little
  odd.  The Timestamp in the SYN/ACK is the same as the timestamp in
  the next ACK (the ack for the first partial HTTP request).
  The Timestamp in the next packet which is the one that gets lost has
  exactly the same TSval as previous packets, and TSecr is one more
  than in the previous packet.

I assume that one (or more) of these differences combined with the
large tcp_[rw]mem value cause the packet loss, but I have no idea
which.

Help?

I can make the tcp traces available if needed, but these are really
the only non-trivial differences.

I'm willing to test patches.

NeilBrown
