Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270182AbRHGLDC>; Tue, 7 Aug 2001 07:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270184AbRHGLCw>; Tue, 7 Aug 2001 07:02:52 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:15604 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S270182AbRHGLCn>; Tue, 7 Aug 2001 07:02:43 -0400
Date: Tue, 7 Aug 2001 12:02:34 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC] using writepage to start io
Message-ID: <20010807120234.D4036@redhat.com>
In-Reply-To: <755760000.997128720@tiny> <01080623182601.01864@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080623182601.01864@starship>; from phillips@bonn-fries.net on Mon, Aug 06, 2001 at 11:18:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 06, 2001 at 11:18:26PM +0200, Daniel Phillips wrote:
> > On Monday, August 06, 2001 09:45:12 PM +0200 Daniel Phillips
> >
> > Grin, we're talking in circles.  My point is that by having two
> > threads, bdflush is allowed to skip over older buffers in favor of
> > younger ones because somebody else is responsible for writing the
> > older ones out.
> 
> Yes, and you can't imagine an algorithm that could do that with *one* 
> thread?

FWIW, we've seen big performance degradations in the past when testing
different ext3 checkpointing modes.  You can't reuse a disk block in
the journal without making sure that the data in it has been flushed
to disk, so ext3 does regular checkpointing to flush journaled blocks
out.  That can interact very badly with normal VM writeback if you're
not careful: having two threads doing the same thing at the same time
can just thrash the disk.

Parallel sync() calls from multiple processes has shown up the same
behaviour on ext2 in the past.  I'd definitely like to see at most one
thread of writeback per disk to avoid that.

Cheers,
 Stephen
