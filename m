Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUGMICL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUGMICL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUGMICL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:02:11 -0400
Received: from a4.complang.tuwien.ac.at ([128.130.173.65]:7875 "EHLO
	a4.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S264373AbUGMICE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:02:04 -0400
X-mailer: xrn 9.03-beta-14
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: Re: XFS: how to NOT null files on fsck?
To: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <2hgxc-5x9-9@gated-at.bofh.it>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <20040710191914.GA5471@taniwha.stupidest.org> <2hgxc-5x9-9@gated-at.bofh.it>
Cc: Chris Wedgwood <cw@f00f.org>, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
Date: Tue, 13 Jul 2004 07:25:29 GMT
Message-ID: <2004Jul13.092529@mips.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> writes:
>XFS does *not* zero files, it simply returns zeros for unwritten
>extents.  If you open an existing file and scribble all over it, you
>might see the old data during a crash, or the new data if it was
>flushed.  You shouldn't see zero's though.
>
>What does happen though, is that dotfiles are truncated and rewritten,
>if the data blocks aren't flushed you will get zeros back because the
>extents were unwritten.  This is really the only sensible thing to do
>given the circumstances.
>
>My guess is that with other fs' (when journaling metadata only) the
>blocks allocated for the newly written data are *usually* the same as
>the recently freed blocks from the truncate so things appear to work
>but in reality it's probably mostly luck.

A secure FS must ensure that other people's deleted data does not end
up in the file.  AFAIK FSs don't record owners for free blocks, so
they can only ensure this by zeroing the blocks.  So I doubt that you
will see any different behaviour from an FS that keeps only meta-data
consistent and writes meta-data before data.

>Some applications just need to be fixed.

It's too hard to fix the applications, since there is no easy way to
test that they are really fixed.  Also, the number of applications is
much higher than the number of file systems.

The way to go is to fix the file system (well, often it means a new
FS).

The file system should provide something that I call in-order
semantics, i.e., that the disk state always represents an existing
(possibly old) logical state of the FS, not some state that never
existed, or some existing state with missing data.

My favourite approach to achieve these semantics is based on
log-structured file systems (see
<http://www.complang.tuwien.ac.at/anton/lfs/> for some ideas and also
a longer description of in-order semantics), but there are also other
approaches: I believe that Soft Updates, when implemented correctly,
provide in-order semantics, and Reiser4 may provide them, too.

- anton
-- 
M. Anton Ertl                    Some things have to be seen to be believed
anton@mips.complang.tuwien.ac.at Most things have to be believed to be seen
http://www.complang.tuwien.ac.at/anton/home.html
