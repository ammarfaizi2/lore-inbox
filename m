Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUHERxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUHERxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUHERxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:53:13 -0400
Received: from mail.mplayerhq.hu ([192.190.173.45]:59018 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP id S267846AbUHERwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:52:05 -0400
From: Arpi <arpi@thot.banki.hu>
To: linux-kernel@vger.kernel.org
Subject: how to read /proc/net/arp properly?
X-Mailer: GyikSoft Mailer for UNIX v3.99pre2 by Arpi/ESP-team (http://esp-team.scene.hu)
Message-Id: <20040805175204.EFE2E38BAB@mail.mplayerhq.hu>
Date: Thu,  5 Aug 2004 19:52:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm developing a daemon to watch new hosts by the new arp entries,
verify them in a database, and set up various firewall rules based
on the results. I don't want won't discuss here how good or bad
stretagy is doing such decisions based on mac address though.

The problem, i'm writting here about, is that /proc/net/arp is
dynamicaly generated, and according to kernelsrc/net/ipv4/arp.c's
arp_get_info(), it's done by byte offset.
Ie, when you read the next block of this psuedo-file, the whole
text file is re-generated in memory, but only the part given by an
byte file offset & buffer size is returned to the caller.
If i have huge tables, it sometimes may (and actually does!!!) happen
that arp cache changes while i'm reading /proc/net/arp.
It results few byte shifting so some character is disappearing.
Example:

# while read line ; do echo "$line";sleep 1;done < /proc/net/arp &
# nmap -sP 193.225.225.0-255 &>/dev/null

...
193.225.225.16   0x1         0x0         00:00:00:00:00:00     *        eth1.10
.10
193.225.225.126  0x1         0x0         00:00:00:00:00:00     *        eth1.10
193.225.224.57   0x1         0x0         00:00:00:00:00:00     *        eth1.2
...
193.225.224.57   0x1         0x0         00:00:00:00:00:00     *        eth1.2
192.190.173.43   0x1         0x0         00:00:00:00:00:00     *        eth1.3
0x1         0x2         00:20:18:58:0A:F2     *        eth1.10
193.225.225.14   0x1         0x2         00:20:18:58:0A:F2     *        eth1.10
...


I think it would even work well, if the lines would have same length
(ie each ethernet interface have same width name, or lines being padded
by spaces to same length)  but i can still imagine broken data reported,
due to arp cache shift/change in the middle of reading out a line...

Possible solutions:
- read arp table somehow directly from kernel, in some binary form through
  ioctls() - i don't know if it's already possible/implemented, and if so, how.
  anyway i guess it isn't, as the "arp -a" command suffers from the same issue,
  it also gives broken lines sometimes at heavy arp table changes.
  So if there is a proper way of reading arp table, the "arp" utility also
  should be fixed to use that method!
- fix arp.c to generate the whole arp table in a single pass, and don't
  destroy that data until the /proc/net/arp "file" is closed.
  problems: too long arp trables may consume too much memory. also what
  happens if arp file is opened 10000 times? DoS?
- ugly hack: pad lines to same width (add some spaces after interface name),
  and fix arp_get_info() to always stop "generating" blocks at line boundary.
  it's still possible that some arp entries will be missed, but if your
  arp table keeps changing so quickly, it can be accepted...

comments? ideas?

please note, that i'm not subsribed, so please cc: me too. thanks!


A'rpi / MPlayer, Astral & ESP-team

--
MPlayer's new image: happiness & peace & cosmetics & vmiklos
