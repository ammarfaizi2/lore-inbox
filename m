Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbULZQlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbULZQlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbULZQlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:41:24 -0500
Received: from duempel.org ([81.209.165.42]:49297 "HELO swift.roonstrasse.net")
	by vger.kernel.org with SMTP id S261703AbULZQlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:41:19 -0500
Date: Sun, 26 Dec 2004 17:40:22 +0100
From: Max Kellermann <max@duempel.org>
To: linux-kernel@vger.kernel.org
Subject: problem with 2.6.10 + ipsec/tunnel + netfilter
Message-ID: <20041226164022.GA2631@roonstrasse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I upgraded my router today to 2.6.10, from 2.6.9-rc3. It has three
network adapters: ppp0(eth0) for Internet, eth2 is WLAN and eth0 is
ethernet. My notebooks connected on eth2 use ipsec (tunnel mode,
172.28.1.x/32 - 0.0.0.0/32) to secure the wireless connection.

Since I upgraded to 2.6.10, the router won't route packets which come
from the tunnel. It used to receive ESP packets, decrypted them, got
the new destination IP address, and routed them like normal incoming
packets. Downgrading to 2.6.9-rc3 makes the problem disappear.

It seems like the decrypted packets don't get the routing table
applied to them: tcpdump shows them on eth2 (but not on eth0 or ppp0);
they go through mangle/PREROUTING and nat/PREROUTING (I added LOG
lines to my netfilter config), and disappear afterwards. My theory is
that the ESP went through the routing before, and the decrypted packet
still holds this routing information, which is not updated - the
router drops the packet because it's marked as INPUT packet but with a
non-matching destination IP for device eth2.

I tried a hack: I used the experimental ROUTE target to force the
incoming packet from eth2 to be routed over eth0; tcpdump output from
172.28.0.7:

17:01:03.519720 IP 172.28.1.8.33025 > 172.28.0.7.22: S 505307695:505307695(0) win 5840 <mss 1460,sackOK,timestamp 14143937 0,nop,wscale 2>

17:01:03.519763 IP 172.28.0.7.22 > 172.28.1.8.33025: S 29430865:29430865(0) ack 505307696 win 5792 <mss 1460,sackOK,timestamp 5854568 14143937,nop,wscale 2>

17:01:03.520168 IP 172.28.0.1 > 172.28.0.7: icmp 68: 172.28.1.8 tcp port 33025 unreachable

The last packet in this dump is a REJECT rule on the router for "state
INVALID" packets (i.e. connection tracking is broken here). After I
removed the INVALID/REJECT rule, it works. To work around this
problem, I can build a copy of the routing table as ROUTE rules and
remove all FORWARD/INVALID rules.

More information about my router:
- kernel: http://max.kellermann.name/~max/linux/squirrel.config
- ipsec (the keys are removed, of course):
  http://max.kellermann.name/~max/linux/ipsec.conf
- dual pentium III-800, gcc 
- Linux version 2.6.10 (root@squirrel) (gcc version 3.3.4 (Debian
  1:3.3.4-13)) #1 SMP Sun Dec 26 16:53:40 CET 2004

Regards,
Max Kellermann
