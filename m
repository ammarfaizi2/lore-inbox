Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWFSQpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWFSQpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWFSQpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:45:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:31440 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964794AbWFSQpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:45:39 -0400
Subject: Re: [RFC][PATCH 20/20] honor r/w changes at do_remount() time
From: Dave Hansen <haveblue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at
In-Reply-To: <20060618183616.GA27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain>
	 <20060616231228.2107A2EE@localhost.localdomain>
	 <20060618183616.GA27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 09:45:18 -0700
Message-Id: <1150735518.10515.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 19:36 +0100, Al Viro wrote:
> On Fri, Jun 16, 2006 at 04:12:28PM -0700, Dave Hansen wrote:
> > 
> > Originally from: Herbert Poetzl <herbert@13thfloor.at>
> > 
> > This is the core of the read-only bind mount patch set.
> > 
> > Note that this does _not_ add a "ro" option directly to
> > the bind mount operation.  If you require such a mount,
> > you must first do the bind, then follow it up with a
> > 'mount -o remount,ro' operation.
> 
> Hrm...  So you want r/o status of vfsmount completely independent from
> that of superblock?  I.e. allow writable vfsmount over r/o filesystem?
> I realize that we have double checks, but...

I think it does make sense to keep them separate.  I think of the
superblock flag is really there to describe the state of the filesystem.
Are we even _able_ to write to this thing now?

The vfsmount flag, on the other hand, spells out the intentions of the
person who _did_ the mount.  Do I _want_ this to be writable?  

Let's say that we eliminate the superblock r/o flag.  There's a
filesystem with one regular vfsmount, one r/o bind vfsmount, and one r/w
bind vfsmount.  It encounters an error.  Not having a superblock flag,
we must go find each vfsmount and mark it r/o (this also enlarges the
window during which the f/s might be written).

Now, the administrator decides that the fs is OK, and remounts it r/w.
The vfsmounts should obviously regain their original permissions, any
other behavior is pretty screwy.  To accomplish this, we need both a
"current write state" and a "previous write state", which probably means
a new flag in the vfsmount.

So, we've fanned out this "current state" information from the
superblock, increased the window of fs damage, and added some complexity
when we do the transitions between the states.  I think I like the way
it is now. :)

-- Dave

