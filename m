Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUILI7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUILI7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 04:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUILI7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 04:59:21 -0400
Received: from ozlabs.org ([203.10.76.45]:45450 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268535AbUILI7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 04:59:07 -0400
Date: Sun, 12 Sep 2004 18:56:09 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, viro@parcelfarce.linux.theplanet.co.uk, wli@holomorphy.com
Subject: /proc/sys/kernel/pid_max issues
Message-ID: <20040912085609.GK32755@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I tried creating 100,000 threads just for the hell of it. I was
surprised that it appears to have worked even with pid_max set at 32k.

It seems if we are above pid_max we wrap back to RESERVED_PIDS at the
start of alloc_pidmap but do not enforce this upper limit. I guess every
call of alloc_pidmap above 32k was wrapping back to RESERVED_PIDS,
walking the allocated space then allocating off the end.

Just as an aside, does it make sense to remove the pidmap allocator and
use the IDR allocator now its there?

Now once I had managed to allocate those 100,000 threads, I noticed
this:

18446744071725383682 dr-xr-xr-x   3 root root   0 Sep 12 08:10 100796

Strange huh. Turns out we allocate inodes in proc via:

#define fake_ino(pid,ino) (((pid)<<16)|(ino))

With 32bit inodes we are screwed once pids go over 64k arent we?

Anton
