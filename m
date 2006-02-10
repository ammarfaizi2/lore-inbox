Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWBJUMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWBJUMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWBJUMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:12:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751370AbWBJUMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:12:24 -0500
Date: Fri, 10 Feb 2006 12:11:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: oliver@neukum.org, nickpiggin@yahoo.com.au, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060210121130.57db39bc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101152150.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
	<43ECDD9B.7090709@yahoo.com.au>
	<Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
	<200602102034.07531.oliver@neukum.org>
	<Pine.LNX.4.64.0602101152150.19172@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Fri, 10 Feb 2006, Oliver Neukum wrote:
> >
> > Am Freitag, 10. Februar 2006 20:05 schrieb Linus Torvalds:
> > > So we may have different expectations, because we've seen different 
> > > patterns. Me, I've seen the "events are huge, and you stagger them", so 
> > > that the previous event has time to flow out to disk while you generate 
> > > the next one. There, MS_ASYNC starting IO is _wrong_, because the scale of 
> > > the event is just huge, so trying to push it through the IO subsystem asap 
> > > just makes everything suck.
> > 
> > Isn't the benefit of starting writing immediately greater the smaller
> > the area in question? If so, couldn't a heuristic be found to decide whether
> > to initiate IO at once?
> 
> Quite possibly. I suspect you could/should take other issues into account 
> too (like whether the queue to the device is busy or bdflush is already 
> working).
> 

Yes, it would make sense to run balance_dirty_pages_ratelimited() inside
msync_pte_range().  So pdflush will get poked if we hit
background_dirty_ratio threshold, or we go into caller-initiated writeout
if we hit dirty_ratio.

But it's not completely trivial, because I don't think we want to be doing
blocking writeback with mmap_sem held.

The code under balance_dirty_pages() does pay attention to queue congestion
states, already-under-writeback pages and such things, but it could be
better, I guess.  Starting some writeback earlier if the queue is deemed to
be idle could work.

(Hi, Stephen)
