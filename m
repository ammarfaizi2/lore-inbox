Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWFZSjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWFZSjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWFZSjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:39:43 -0400
Received: from silver.veritas.com ([143.127.12.111]:47790 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932636AbWFZSjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:39:42 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,177,1149490800"; 
   d="scan'208"; a="39545672:sNHT21585548"
Date: Mon, 26 Jun 2006 19:39:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: please revert kthread from loop.c
Message-ID: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Jun 2006 18:39:41.0859 (UTC) FILETIME=[E31F6730:01C6994F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please revert c7b2eff059fcc2d1b7085ee3d84b79fd657a537b
[PATCH] kthread: update loop.c to use kthread

It seems too little tested: "losetup -d /dev/loop0" fails with
EINVAL because nothing sets lo_thread; but even when you patch
loop_thread() to set lo->lo_thread = current, it can't survive
more than a few dozen iterations of the loop below (with a tmpfs
mounted on /tst): collapses with failed ioctl then BUG_ON(!bio).
I think the original lo_done completion was more subtle and safe
than the kthread conversion has allowed for.

j=0
cp /dev/zero /tst
while :
do
	let j=j+1
	echo "Doing pass $j"
	losetup /dev/loop0 /tst/zero
	mkfs -t ext2 -b 1024 /dev/loop0 >/dev/null 2>&1
	mount -t ext2 /dev/loop0 /mnt
	umount /mnt
	losetup -d /dev/loop0
done
