Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268841AbUHLWj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268841AbUHLWj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268843AbUHLWj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:39:27 -0400
Received: from thunk.org ([140.239.227.29]:55018 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S268841AbUHLWjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:39:13 -0400
Date: Thu, 12 Aug 2004 18:39:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Otto Wyss <otto.wyss@orpatec.ch>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: New concept of ext3 disk checks
Message-ID: <20040812223907.GA7720@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Otto Wyss <otto.wyss@orpatec.ch>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <411BAFCA.92217D16@orpatec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BAFCA.92217D16@orpatec.ch>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 07:58:33PM +0200, Otto Wyss wrote:
> - Instead of checks forced during startup checks are done during runtime
> (at low priority). It has to be determined if these checks are _only_
> checks or if they also include possible fixes. Possible solution might
> distinct between the severity of any discovered problem.

This is something that doesn't require any kernel patches, or any
other C coding for that matter, so it would be a great first project
for someone who wanted to learn how to use the device-mapper snapshot
feature.  Basically, what you do is the following in a shell script
which is fired off by cron once a week at 3am (or some other
appropriate time):

1) Create a clean, read-only snapshot of an ext3 filesystem using
device mapper.

2) Run e2fsck -f on the snapshot, and check to see if there are any
error on the filesystem.  Assuming a non-buggy kernel and properly
functioning hardware, there should be none.  Afterwards, release the
read-only snapshot.

3) If there are any errors, e-mail the output of e2fsck to the system
administrator.

4) If there were no errors detecting by the fsck run, run the command
"tune2fs -C 0 -T now /dev/XXX" on the live filesystem.  This sets the
mount count and last filesystem checked time to the appropriate values
in the superblock.

Tell you what --- if someone is willing to put the time into
developing such a script, I'll include it in the contrib section of
e2fsprogs.  I've put all the hooks to do this in e2fsprogs, and I've
wanted this for quite some time, but the last time I looked at it, the
command-line EVMS tools were truly gruesome to behold/use.  I believe
things have gotten much better since then, so this shouldn't be too
hard to do now.

					- Ted
