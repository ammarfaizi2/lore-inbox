Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVCVNnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVCVNnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVCVNnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:43:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:37075 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261208AbVCVNnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:43:15 -0500
Subject: Re: [CHECKER] writes not always synchronous on JFS with O_SYNC?
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: blp@cs.stanford.edu
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, mc@cs.stanford.edu
In-Reply-To: <87vf7kr9gs.fsf@benpfaff.org>
References: <87vf7kr9gs.fsf@benpfaff.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 07:43:12 -0600
Message-Id: <1111498992.8107.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 13:10 -0800, Ben Pfaff wrote:
> Hi.  We've been running some tests on JFS and other file systems
> and believe we've found an issue whereby O_SYNC does not always
> cause data to be committed synchronously.  On Linux 2.6.11, we
> found that the program appended below causes
> /mnt/sbd0/0006/0010/0029/0033 to contain all zeros, despite the
> use of O_SYNC on the write calls and the fsyncs on the
> directories.  It seems to be pretty sensitive to the existence of
> the rmdir calls: if I omit one of them, the data does get
> written.

I can reproduce this behavior, but what I'm seeing is a little more
alarming than the data being written asynchronously.  After fsck replays
the journal, the xtree for the file is corrupt, which is why it appears
to contain zeros.  The syslog is showing that a corrupted xtree has been
found.  I am still investigating.

> Note that /dev/sbd0 is essentially a ramdisk that we've developed
> for testing this kind of thing: it allows a snapshot of a disk's
> momentary contents to be copied out, so that we don't have to do
> a reboot.

I'm getting similar results writing to a regular disk partition and
rebooting.

> Can you confirm this?

Confirmed.

> 	ret = test_creat("/mnt/sbd0/0006/0028", 511);

test_creat is type void.

> 	CHECK(ret);
> 	ret = test_write("/mnt/sbd0/0006/0028", 0);
> 	CHECK(ret);
> 	ret = mkdir("/mnt/sbd0/0006/0010/0029", 511);
> 	CHECK(ret);
> 	ret = test_creat("/mnt/sbd0/0006/0010/0029/0033", 511);
> 	CHECK(ret);
> 	ret = test_write("/mnt/sbd0/0006/0010/0029/0033", 0);
> 	CHECK(ret);
> 	ret = test_fsync("/mnt/sbd0/0006/0010/0029");

so is test_fsync

> 	CHECK(ret);

-- 
David Kleikamp
IBM Linux Technology Center

