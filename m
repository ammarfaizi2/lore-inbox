Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSDNNJM>; Sun, 14 Apr 2002 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312269AbSDNNJM>; Sun, 14 Apr 2002 09:09:12 -0400
Received: from pc-62-31-74-83-ed.blueyonder.co.uk ([62.31.74.83]:12416 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S293722AbSDNNJL>; Sun, 14 Apr 2002 09:09:11 -0400
Date: Sun, 14 Apr 2002 14:08:37 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: aliasing bug in blockdev-in-pagecache?
Message-ID: <20020414140837.A2119@redhat.com>
In-Reply-To: <20020413235948.E4937@redhat.com> <Pine.GSO.4.21.0204140857190.394-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 14, 2002 at 08:59:15AM -0400, Alexander Viro wrote:
 
> On Sat, 13 Apr 2002, Stephen C. Tweedie wrote:
> 
> > To solve this, we really do need to have block_read_full_page() test
> > the uptodate state under protection of the buffer_head lock.  We
> > already go through 3 stages in block_read_full_page(): gather the
> > buffers needing IO, then lock them, then submit the IO.  To be safe,
> > we need a final test for buffer_uptodate() *after* we have locked the
> > required buffers.
> 
> Ouch.
> 
> I suspect that correct fix is to do that test in submit_bh() itself
> (and remove it from ll_rw_block()).  IMO it's cleaner than messing
> with all callers out there...  Linus?

Actually, if we move the test to submit_bh(), we _do_ need to mess
with all callers.  

submit_bh() is currently an unconditional demand to perform a given IO
regardless of buffer state, so lots of callers (ext3 journal writes,
soft raid mirror writes etc) call it with private buffer_heads which
just don't have any persistent dirty / uptodate state.  Changing
submit_bh() still means we need to audit all callers to make sure that
they set up those state flags correctly even for private bh'es.

Cheers,
 Stephen
