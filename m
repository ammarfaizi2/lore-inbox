Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUGLVVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUGLVVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGLVVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:21:16 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:27015 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263626AbUGLVVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:21:13 -0400
Date: Mon, 12 Jul 2004 14:20:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: Jan Knutar <jk-lkml@sci.fi>, L A Walsh <lkml@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040712212020.GA22372@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <20040710191914.GA5471@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710191914.GA5471@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 12:19:14PM -0700, Chris Wedgwood wrote:

> It would be nice for some people to prevent log-replay zeroing files
> but then something would have to be able to determine whether or not
> these blocks were newly allocated (and this might contain
> confidential data and need to be zeroed) or previously part of the
> file in which case we probably would like them left alone.

I told lies.

> I don't know any of the code well enough to know how easy this is or
> even if I'm telling the truth :) Hopefully someone who does can
> speak up on this.

I knew I was completely full of shit.


XFS does *not* zero files, it simply returns zeros for unwritten
extents.  If you open an existing file and scribble all over it, you
might see the old data during a crash, or the new data if it was
flushed.  You shouldn't see zero's though.

What does happen though, is that dotfiles are truncated and rewritten,
if the data blocks aren't flushed you will get zeros back because the
extents were unwritten.  This is really the only sensible thing to do
given the circumstances.

My guess is that with other fs' (when journaling metadata only) the
blocks allocated for the newly written data are *usually* the same as
the recently freed blocks from the truncate so things appear to work
but in reality it's probably mostly luck.  XFS could behave the same
way, but sooner or later you will still loose when you get crap back
instead of old data.

Some applications just need to be fixed.


   --cw
