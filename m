Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVKETBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVKETBc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVKETBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:01:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:493 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S932175AbVKETBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:01:31 -0500
Date: Sat, 5 Nov 2005 19:01:30 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: jonathan@jonmasters.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Message-ID: <20051105190130.GP7992@ftp.linux.org.uk>
References: <20051105182728.GB27767@apogee.jonmasters.org> <20051105103358.2e61687f.akpm@osdl.org> <20051105184028.GD27767@apogee.jonmasters.org> <20051105184408.GO7992@ftp.linux.org.uk> <35fb2e590511051051o16e3e763x821f12555261c4cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590511051051o16e3e763x821f12555261c4cc@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 06:51:39PM +0000, Jon Masters wrote:
> On 11/5/05, Al Viro <viro@ftp.linux.org.uk> wrote:
> > On Sat, Nov 05, 2005 at 06:40:28PM +0000, Jon Masters wrote:
> > > And as I said, the situation as it stands leads to potential data
> > > corruption but I agree with you - we need a VFS callback to handle
> > > readwrite/readonly change on remount I think. Comments?
> 
> > It's not that simple.  Filesystem side of ro/rw transitions is
> > messy as hell
> 
> Agreed.
> 
> > "VFS callback" won't be enough.
> 
> Although strangely enough other similar stuff in the remount path
> works just fine. I can already request that a filesystem gets
> remounted read-only - what's so wrong with forcing that behaviour when
> I ask for an impossible combination?

->remount_fs() certainly can refuse to go r/w - you don't need anything
new for that, just don't leave MS_RDONLY in *flags.  The real trouble
starts when fs wants to go r/o on its own, e.g. when it sees an error
bad enough to warrant that.  And that, BTW, is very likely to require
more than just one bit in ->policy - we want all IO on that device
to fail until after we actually close it during umount.  As it is,
we can get anything, including block allocations (e.g. if we have
a dirty mapping and it gets written to disk).  OTOH, we don't want
it to be the same thing as genuine hardware readonly - when buggered
fs is umounted, we are very likely to do fsck on it, after all.
