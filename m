Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUGLWye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUGLWye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUGLWye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:54:34 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:21194 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264085AbUGLWyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:54:31 -0400
Date: Mon, 12 Jul 2004 15:53:38 -0700
From: Chris Wedgwood <cw@f00f.org>
To: L A Walsh <lkml@tlinx.org>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       Jan Knutar <jk-lkml@sci.fi>, linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040712225338.GD23623@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <20040710191914.GA5471@taniwha.stupidest.org> <20040712212020.GA22372@taniwha.stupidest.org> <40F31348.70807@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F31348.70807@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 03:40:08PM -0700, L A Walsh wrote:

> If it is of any help (I doubt it, it perplexes me)...the files I've
> written out with vim and have returned "nulls" have been files that
> were written out 2-3 _DAYS_ earlier -- often with more recent write
> having been saved fine.

I've heard this before and you're not the only person to claim this.
For a period of time the buffer-flushing code was broken and this was
probably possible then, even sync/fsync failed to write stuff out.

But that was a long time ago (last year) and I'm not sure that is
still the case.  It could be, the flushing code is quite complicated
and I don't understand it fully, but testing seems to indicate it does
work.

To be quite honest I've never seen nulls in files that a days old, and
I have scripts which checksum (md5) my files (hundreds of gigabytes)
which would notice this, so knowing how to reproduce it would be nice.

> I've also seen sections in log files where blocks would return zero
> in the middle of a log.

Log was being appended, system crashed, you get nulls at the end when
rebootd, the logger opens the file append and starts writing stuff,
the nulls end up in the middle.  Arguably this is expected.

> Obviously blocks before and after successfully made it to disk, but
> in _RARE_ circumstances (crashes and unplanned shutdowns are already
> rare enough, so it's a rare bug that only shows up on a 'rare'
> occasion... :-)

It can't be blocks before and after, if that was the case you wouldn't
see the nulls.  I'm pretty sure for you the nulls are not really
on-disk, looking at the raw device you won't see them.  They nulls are
returns for unwritten extents just as nulls are returned for holes in
sparse files.

> Almost (shot in the dark), like some code that was supposed to zero
> unused but allocated datablocks got pointed at the wrong blocks,
> since these files are readable as having been written (yes may all
> be out of membuffs) and are often recoverable from the day's backup.

I cant see how.  It seems to me that if block pointers got all messed
up, xfs_repair would scream bloody murder and this explode and die on
a live fs.  I don't see reports that look like this.

> If it was a file I just edited and then it crashed, that I could
> understand more than having files I haven't touched for a few days
> be zapped.

My gut feeling is these files really are being changed.  Stat should
show if this is the case.


  --cw
