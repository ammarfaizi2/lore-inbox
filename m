Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUDNQZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbUDNQZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:25:17 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:57094 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264270AbUDNQZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:25:05 -0400
Date: Thu, 15 Apr 2004 00:29:28 +0800 (WST)
From: raven@themaw.net
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount after bad chdir
In-Reply-To: <20040414152420.GE31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0404142352590.1480@donald.themaw.net>
References: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain>
 <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net>
 <20040414121026.GD31500@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404142023460.1537@donald.themaw.net>
 <Pine.LNX.4.58.0404142308260.20568@donald.themaw.net>
 <20040414152420.GE31500@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Apr 14, 2004 at 11:13:13PM +0800, raven@themaw.net wrote:
> > On Wed, 14 Apr 2004 raven@themaw.net wrote:
> > 
> > > > Mind you, chdir() patch in -mm is broken in a lot of other ways - e.g.
> > > > it assumes that another thread sharing ->fs with us won't call chdir()
> > > > in the wrong moment...
> > > 
> > > Thanks for your interest Al.
> > > 
> > > I see your point (I think).
> > > 
> > > If I understand you correctly (please explain if I don't) I need to lock 
> > > the ->fs struct.
> > 
> > Mmm ... doesn't look much good in the light of Als comment.
> > 
> > Looks like it's not possible to take the lock for long enough even if I 
> > could.
> > 
> > Lets have some comments, criticisms or suggestions please.
> 
> Why do you need to assign pwd before revalidation?
> 

Good question.

I'm talking about lazy mounting in autofs version 4 (suprise, suprise).

I think this should be done in the call backs during the path_walk 
but I couldn't work out how. But see below...

The basic problem this is meant to solve is that I can't tell when a 
chdir or chroot is to be done from within the revalidate or lookup. To 
delay mounting until (or correctly trigger a mount at) the proper 
time I must know if the service request is a chdir or chroot, in which 
case an automount needs to be done. The chdir and chroot are the only 
problematic services that I'm aware of atm.

But looking further I see that a LOOKUP_DIRECTORY flag is used only for 
these two routines (excluding pivot_root) and when a trailing slash is 
present in the path. I think that the if this flag is present then the 
request will always want to look into the directory anyway, so if it's 
an autofs4 mount point it should be mounted then. If this is the case I 
can get this stuff into the fs module where it belongs.

I'll think about it some more and look around further before I do 
anything.

Thoughts?

Ian

