Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWBZFb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWBZFb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 00:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWBZFb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 00:31:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:21394 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750766AbWBZFbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 00:31:55 -0500
Date: Sun, 26 Feb 2006 05:31:38 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
Message-ID: <20060226053138.GM27946@ftp.linux.org.uk>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org> <1140930888.3279.4.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140930888.3279.4.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 11:14:48PM -0600, James Bottomley wrote:
> On Sat, 2006-02-25 at 16:01 -0800, Linus Torvalds wrote:
> > Perhaps equally importantly, let's get them into mainline if they are so 
> > important. Which means that I want sign-offs and acks from the appropriate 
> > people (scsi and original author, which is apparently Al).
> 
> Yes, I've been thinking about this.  The problem is that it's a change
> to sd and a change to scsi_lib in a fairly critical routine.  While I'm
> reasonably certain the change is safe, I'd prefer to make sure by
> incubating in -mm for a while.
> 
> The title, by the way, is misleading; it's not a memory corruption in sd
> at all really.  It's the initio bridge which produces a totally
> standards non conformant return to a mode sense which produces the
> problem.  And so, it's only the single initio bridge which is currently
> affected; hence the caution.

No.  It's sd.c assuming that mode page header is sane, without any
checks.  And yes, it does give memory corruption if it's not.

Initio-related part is in scsi_lib.c (and in recovery part of sd.c
changes).  That one is about how we can handle gracefully a broken
device that gives no header at all.

Checks for ->block_descriptors_length are just making sure we won't try
to do any access past the end of buffer, no matter what crap we got from
device.
