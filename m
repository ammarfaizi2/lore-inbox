Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUJBW0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUJBW0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 18:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUJBW0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 18:26:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:24043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267565AbUJBW0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 18:26:05 -0400
Date: Sat, 2 Oct 2004 15:23:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: jeffm@novell.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race with iput and umount
Message-Id: <20041002152338.0beb6680.akpm@osdl.org>
In-Reply-To: <20041002095254.GH23987@parcelfarce.linux.theplanet.co.uk>
References: <415E5EE6.3010800@novell.com>
	<20041002095254.GH23987@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> the goal of that kludge was to postpone the final
>  iput() past the unlocking the parent for the sake of contention if a wunch
>  of bankers is doing parallel unlink() on files in the same directory

The problematic workloads are much simpler than that: simply a kernel
compile when there's a lot of writeout happening to the same disk.

Truncation of files in /tmp takes a long time because it has to wait for
in-flight writeout.  If we do that synchronous I/O while holding i_sem,
nobody else can get at /tmp.

"When there is a continuous streaming write to the same disk, this patch
reduces the time for `make -j4 bzImage' from 370 seconds to 220."

Yeah, the tweak is not pretty, but that's a significant speedup.
