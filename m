Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWBLTss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWBLTss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWBLTsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:48:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28336 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751419AbWBLTsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:48:47 -0500
Date: Sun, 12 Feb 2006 19:48:40 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linda Walsh <lkml@tlinx.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060212194840.GV27946@ftp.linux.org.uk>
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <20060212193637.GI12822@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212193637.GI12822@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 12:36:37PM -0700, Matthew Wilcox wrote:
> On Sun, Feb 12, 2006 at 06:06:01PM +0000, Al Viro wrote:
> > On Fri, Feb 10, 2006 at 07:31:07PM -0800, Linda Walsh wrote:
> > > The maximum number of followed symlinks seems to be set to 5.
> > > 
> > > This seems small when compared to other filesystem limits.
> > > Is there some objection to it being raised?  Should it be
> > > something like Glib's '20' or '255'?
> 
> Just a note (which Al probably considered too obvious to point out), but
> MAX_NESTED_LINKS isn't the maximum number of followed symlinks.  It's
> the number of recursions we're limited to.  The maximum number of
> symlinks followed is 40 (see fs/namei.c:do_follow_link).
> 
> Al, would it be worth making 40 an enumerated constant in the same
> enumeration as MAX_NESTED_LINKS?  Something like this:

Umm...  Maybe.  Note that this 40 is to kill very long iterations in
symlinks that are not too deeply nested, but resolving them would
traverse a lot (symlink can have a _lot_ of components - easily as much
as 2048, which leads to 2^55 lookups with depth limited to 5; since
process is unkillable during lookup and it's easy to do a setup where it
wouldn't block on IO...)

IOW, this limit doesn't come from stack overflow concerns - it's just an
arbitrary cutoff point to stop a DoS.  We can easily lift it to e.g.
256 if there's any real need.  Or make it sysctl-controlled; whatever...

The real hard limit is on nested symlinks.
