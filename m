Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934214AbWKTOvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934214AbWKTOvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934215AbWKTOvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:51:54 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:38066 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S934214AbWKTOvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:51:53 -0500
Date: Mon, 20 Nov 2006 15:51:48 +0100
To: linux-kernel@vger.kernel.org
Subject: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I got not even a beep as answer, I'm trying again
to get this through to someone who cares:

The problem, I'm writing about is really a major nuissance
to whom it hits, because due to this problem the system turns
off dma for the harddisks, which makes the machine painfully slow.

However it seems to show up only for a limited set of 
harddisks, one of which happens to be in one of my machines.

Here is the complete previous attempt at submitting it
(with all the details I was able to come up with):

----- Forwarded message from Andreas Leitgeb <avl@logic.at> -----
From: Andreas Leitgeb <avl@logic.at>
Subject: possible bug in ide-disk.c (2.6.17.13 but also older)
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org
Delivery-date: Tue, 19 Sep 2006 10:01:40 +0200
Reply-To: avl@logic.at

I noticed the bug only recently, but checking with older Knoppix
boot-cds, it seems to date back to about 2.6.9, where disk-access
was generally slower, and hpa probably not detected at all)

The symptom of the bug is, that an HPA is believed (by the kernel)
to exist, and the capacity is believed to be one sector larger.
When accessing that one last sector, the harddisk (rightly) reports
an error, which causes the kernel to retry a few times (getting
the same error each time) and finally the kernel switches off dma.

The problem is in  idedisk_read_native_max_address()
and equivalently in idedisk_read_native_max_address_ext()
in a line like this (near the end):
  addr++; /* since the return value is (maxlba - 1), we add 1 */

I believe that this is wrong, in so far as it is device-specific.
My belief is, that what might need to be added instead is drive->sect0
or perhaps something completely different.

This belief is based on that the  addr++; works fine with some other
harddisks in my reach (so obviously, adding one isn't always wrong),
and that other people shared my problem as described in a newsgroup,
found at: <http://tinyurl.com/ee7me> which redirects to

<http://groups.google.com/group/linux.debian.user.german/browse_thread/thread/ab8980cb5ea0a9fb/7f475d3ce8f34211?tvc=2&q=linux+hpa+seagate+0x10>

(german-language, but the dmesg-excerpts and patches speak for themselves)
They suggest to comment out the "addr++;" altogether, which I don't think
is good, but at least doesn't hurt, because a too-small value is
ignored anyway lateron in idedisk_check_hpa(), so in worst case
the hpa is disabled only partially (up to one sector).

Please let me know what you think of it.
People on the list: please Cc: avl@logic.at in this thread.
----- End forwarded message -----
