Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270995AbTHOVpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271032AbTHOVpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:45:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:7091 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270995AbTHOVpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:45:43 -0400
Date: Fri, 15 Aug 2003 14:13:30 -0700
From: Greg KH <greg@kroah.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       sensors@Stimpy.netroedge.com, vsu@altlinux.ru
Subject: Re: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-ID: <20030815211329.GB4920@kroah.com>
References: <20030803192312.68762d3c.khali@linux-fr.org> <20030804193212.11786d06.vsu@altlinux.ru> <20030805103240.02221bed.khali@linux-fr.org> <20030805210704.GA5452@kroah.com> <20030806100702.78298ffe.khali@linux-fr.org> <1060886657.1006.7121.camel@dooby.cs.berkeley.edu> <20030814190954.GA2492@kroah.com> <1060912895.1006.7160.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060912895.1006.7160.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 07:01:34PM -0700, Robert T. Johnson wrote:
> On Thu, 2003-08-14 at 12:09, Greg KH wrote:
> > Hm, much like Linus's sparse does already?  :)
> 
> Yes, but cqual needs fewer annotations (see below).
> 
> > His checker missed the 2.6 version of this, for some reason, I haven't
> > taken the time to figure out why.
> 
> Currently, sparse silently ignores missing annotations.  Since i2c-dev.c
> is not extensively annotated, it missed this bug.

i2c-dev.c is annotated in 2.6.  Did I miss anything that needs to be
marked as such?

> Also, cqual is more flexible than sparse.  For example, i2c-dev.c wants
> to use some i2c_msg structures to hold user bufs, and some to hold
> kernel bufs.  cqual handles this automatically, but sparse cannot at
> all.  To get i2c-dev.c to work with sparse, you'd need to declare two
> new types, "struct kernel_i2c_msg" and "struct user_i2c_msg", and change
> every instance of i2c_msg to be one or the other.

That's something that will be necessary anyway, if we want to get this
to ever work on a 64 bit processor running with a 32 bit userspace
(amd64, ppc64, sparc64, etc.)

> > How is cqual going to handle all of the tty drivers which can have a
> > pointer be either a userspace pointer, or a kernel pointer depending on
> > the value of another paramater in a function?
> 
> I think all these functions should be changed to take two pointers, only
> one of which is allowed to be non-NULL.  Then the flag can go away.  I
> hope to submit a patch to this effect in the future.  I think sparse
> can't check these either, unless you insert casts between user/kernel. 
> But inserting casts loses the benefits of the automatic verification,
> since the casts could be wrong.

Hm, how about just fixing the tty core to always pass in kernel buffers?
That would fix the "problem" in one place :)

Anyway, that's a 2.7 change that has been on my list of things to do for
a while...

> Ok.  Here's a patch against 2.6.0-test3.  I didn't add the md
> substructure to i2c_msg, since it would require changing lots of files
> throughout the kernel.  If you think that's an important change, I'll do
> it.  Otherwise, the patch is the same idea as before.
> 
> Oh, yeah.  This patch also fixes the mem leak, and includes the
> single-copy_from_user optimization you guys talked about earlier, since
> those haven't been merged into mainline linux yet.

Hm, I had already applied your patch, so this one doesn't apply.  Care
to re-do it against 2.6.0-test4 whenever that comes out?

thanks,

greg k-h
