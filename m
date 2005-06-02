Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVFBARj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVFBARj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVFBAOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:14:33 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:25053 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261558AbVFBALB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:11:01 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: How to replace an executing file on an embedded system?
Date: Thu, 2 Jun 2005 00:11:00 +0000 (UTC)
Organization: Cistron
Message-ID: <d7liqk$mc7$1@news.cistron.nl>
References: <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1117671060 22919 194.109.0.112 (2 Jun 2005 00:11:00 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com>,
Richard B. Johnson <linux-os@analogic.com> wrote:
>The newer linux kernels have this problem:
>
>Suppose I do this:
>
>cp /sbin/init foo	# Make a copy of 'init'
>mv foo /sbin/init	# Rename it back (emulate install)
>chmod +x /sbin/init	# Make sure we can boot.
>
>When I try to umount() the file-system, it now fails with
>EBUSY (16).
>
>I have tried fsync(), sync(), fsync() on /sbin, etc. I can't
>get rid of the busy inodes.
>
>This reared its ugly head with field software upgrades. We
>used to be able to upload new software for every executable
>on an embedded system using the network or a serial link.
>
>This would replace every file. We would then kill all the
>tasks except 'init', unmount the file-system and then reboot.
>The upgrade was finished. Every lived happily ever after.
>But, with newer kernels, we can't.

AFAIK, this has been the cases for basically ever. The inode
has been unlinked (st_nlink == 0) but the data blocks are
still there on disk, so the file will be deleted once you
close it, not earlier - things like that are not remembered
over an unmount/mount so the kernel doesn't let you unmount
the filesystem, it's really "busy" at that time.

If earlier kernels did let you do that, you basically ended
up with a slightly corrupted filesystems (a file present
on the fs without a directory entry) and a fsck would probably
let it show up again in /lost+found

>What am I missing?  How am I supposed to replace files that
>are being executed? Do I have to `mv` them to /tmp and
>delete them on the next boot? (not easy, we don't have
>a shell, I would have to write code to search /tmp). Also
>'init' isn't SYS-V 'init'. It's just the startup program
>for a system that keeps growing so I need to be able to
>upgrade it.

Change init so that if you send it a signal (SIGHUP, whatever)
it re-executes itself. That's what /sbin/init in sysvinit
does to make it upgradable in-place without reboot, and in
fact to make it possible to actually reboot cleanly. Sysvinit
goes through great pains to send its internal state from
the old to the new init, your init is probably way way
simpler and you can manage with command line switches
( execl("/sbin/init", "init", "--restart", NULL) or something )

Mike.

