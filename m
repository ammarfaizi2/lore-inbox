Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWB0Wnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWB0Wnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWB0WnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:43:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:44677 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932091AbWB0WnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:43:00 -0500
From: Neil Brown <neilb@suse.de>
To: Jens Axboe <axboe@suse.de>
Date: Tue, 28 Feb 2006 09:42:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17411.32833.539325.449001@cse.unsw.edu.au>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
In-Reply-To: message from Jens Axboe on Monday February 27
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060227072844.GA15638@redhat.com>
	<20060227112022.GK12886@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 27, axboe@suse.de wrote:
> On Mon, Feb 27 2006, Dave Jones wrote:
> > On Sun, Feb 26, 2006 at 09:27:28PM -0800, Linus Torvalds wrote:
> > 
> >  > Have I missed anything? Holler. And please keep reminding about any 
> >  > regressions since 2.6.15.
> > 
> > We seem to have a nasty bio slab leak.
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183017
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182970
> > 
> > Two seperate reports, both using raid1, sata_via and firewire
> > Curiously, they're both on x86-64 too.
> > 
> > Will keep an eye open for other reports of this as they come in.
> > 
> > (The kernels they mention in those reports are fairly recent.
> >  2.6.15-1.1977_FC5 is ctually based on 2.6.16rc4-git6)
> 
> This smells very much like a raid1 bio leak, I thought Neil had
> diagnosed and fixed that already though - Neil?

It certainly does smell like a raid1 bio leak, and we have had those
before, but I've looked over the relevant code several time and cannot
find one.  And my test machine doesn't show a leak.

There are some different code paths depending on whether the
underlying devices support BIO_RW_BARRIER or not, so my testing isn't
conclusive - I think my devices do support BIO_RW_BARRIER so it could
just happen where BIO_RW_BARRIER isn't supported .... but the code
still looks good.

There are new code paths to handle auto-correcting read errors, and
they probably haven't been exercises as much as I would like (some,
but not lots and lots) so maybe there is an issue there, but nobody is
reporting disk errors along with the bio leak, and given the size of
the leak, it would need to be lots of errors.

I think we need to narrow down where the problem was introduced.  The
current:

  2.6.14.7  works,
  2.6.16-rc4  doesn't

is too broad.

NeilBrown

