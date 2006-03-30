Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWC3Saz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWC3Saz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWC3Saz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:30:55 -0500
Received: from [66.162.30.226] ([66.162.30.226]:56037 "EHLO chaos.chaos.ao.net")
	by vger.kernel.org with ESMTP id S1751362AbWC3Say convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:30:54 -0500
Date: Thu, 30 Mar 2006 13:30:30 -0500
From: Dan Merillat <dmerillat@sequiam.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ISO9660 2GB/4GB limit? + UDF/loop conflict
Message-ID: <20060330183028.GK3255@chaos.ao.net>
References: <c0c067900603300207v162908a9n1795f4dd41896cac@mail.gmail.com> <c0c067900603301021k3f3a4e70g68225d2900cf6e8b@mail.gmail.com> <c0c067900603301022h3328d550y4a228368631a8adf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <c0c067900603301021k3f3a4e70g68225d2900cf6e8b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holy crap, I didn't realize GMail auto-formatted mail in plain mode,
that was neigh unreadable.  Reformatted for legibility.

My appologies for the double-mail.

On Thu, 30 Mar 2006, Dan Merillat wrote:

---------- Forwarded message ----------
From: Dan Merillat <harik.attar@gmail.com>
Date: Mar 30, 2006 1:21 PM
Subject: ISO9660 2GB/4GB limit? + UDF/loop conflict
To: linux-kernel@vger.kernel.org


I'm trying to use ISO9660 to make large file backups (4.3 or 8.1gb on
DVD/DVD-DL) but I'm hitting the 32bit limit.

A quick tweak to mkisofs will make it write 4gb-1 files, which are
apparently readable under linux.  That's something  I need to test.
I'm posting because I'm curious about the ISO spec, does it support
32bit files in any interchange level?  It looks like the limitation is
purely in the directory structure, as the single extent limt is 512mb.
It looks like the indirection supports 128tb, though I could be wrong,
it was a cursory look through the source.


If not, (and this isn't a kernel question) has anyone looked into
patching mkisofs to make pure UDF?   file->UDF mounted loopback->burn is
exceedingly slow and awkward, especially when backing up <2gb files goes
straight to DVD.

As a side note, udf -> loop -> reiser3 -> linux software raid5 is
obnoxiously slow, with vmstat showing 2-3x the block traffic it should.

dd bs=256k if=/dev/zero of=test
reiserfs->raid5:                  32MB/sec
reiserfs->loop->reiserfs->raid5   32MB/sec
udf -> loop -> reiserfs -> raid5   6MB/sec

1  2  19884   9332  26608 742880    0    0 13732   244 3855 17627  1 21  0 78
0  1  19884   9092  26600 740692    0    0  5962 47056 2138 12102  0 20  0 80
0  2  19884   9864  26620 739996    0    0   572 19584  987  8122  0  8  0 92
0  2  19884  10156  26628 740716    0    0 13112   188 3703 16754  1 13  0 86
0  2  19884   9232  26644 742936    0    0 14828   120 4126 18921  0 15  0 85
1  1  19884   9816  26648 741996    0    0  4120 24088 1773 11268  0 14 16 70
0  2  19884   9268  26644 740936    0    0   634 38220 1047  7597  6 15 10 69
0  3  19884   9968  26672 741076    0    0 13744   180 3988 17700  1 18  0 81

That 2k blocksize isn't being handled intelligently AT ALL, no
buffering whatsoever. Reiserfs and raw dump to disk didn't show this
behavior.

UDF on raid5 directly has nearly no reads, and pulls a decent 15MB/sec.
I had to test that on a seperate raid array, so the initial results are
not directly comparable, but the lack of block-in does make me guess
that loop can't handle 2k blocksize, and is either doing 4k read + 4k
write, or is  breaking up the writes into 2k chunks that the raid5 is
barfing on.

