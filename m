Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVLVHIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVLVHIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVLVHIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:08:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:21214 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932365AbVLVHIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:08:06 -0500
Date: Thu, 22 Dec 2005 12:35:23 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Neil Brown <neilb@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - 2.6.15-rc5-mm3] Allow sysfs attribute files to be pollable.
Message-ID: <20051222070523.GB3711@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <17320.36949.269788.520946@cse.unsw.edu.au> <20051221134901.GA19746@in.ibm.com> <17322.8400.727405.522183@cse.unsw.edu.au> <20051222054742.GA3711@in.ibm.com> <17322.16730.75851.638863@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17322.16730.75851.638863@cse.unsw.edu.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 05:02:02PM +1100, Neil Brown wrote:
> On Thursday December 22, maneesh@in.ibm.com wrote:
> > On Thu, Dec 22, 2005 at 02:43:12PM +1100, Neil Brown wrote:
> > > You don't have to read the contents unless you want to know what is in
> > > the file.  You could just open the file and call 'poll' and wait for
> > > it to tell you something has happened.  However this isn't likely to
> > > be really useful.
> > > It isn't the 'something has happened' event that is particularly
> > > interesting.  It is the 'the state is now X' information that is
> > > interesting. 
> > > So you read the file to find out what the state is.  If that isn't the
> > > state you were looking for (or if you have finished responding to that
> > > state), you poll/select, and then try again.
> > > 
> > 
> > ok.. that makes sense. But in this case [open() and then poll()], should
> > buffer->event() be initialized in sysfs_open()-->check_perm(), instead
> > of fill_read_buffer() ? I think this scheme should work for [open(), read()
> > and then poll()] also. 
> 
> We are definitely using poll in a non-standard way as it is generally
> for "you can read now" or "you can write now", and we are (ab)using it
> to say "there is new information".  Note that this is essentially
> copying the semantics of 'poll' on /proc/mounts.
> 
> I would see poll returning as meaning "there is state information that
> you haven't read".
> 
> When you first open the file, you haven't read anything, so poll
> should return immediately - which it currently does.

If the current patch already follows the semantics you just 
described (ie if polled right after open, return immediately)
then no problem.

> After you read something, poll won't return again until there is
> something new to be read.
> 
> I think this is probably the best semantics, but if you try hard you
> might be able to convince me otherwise...
> 
> > 
> > But how about the other rule, ie once woken-up the user has to close,
> > re-open and re-read the file. Can this also be avoided, as probably this is also
> > not poll semantics?
> 
> This semantic is part of sysfs.  The way sysfs currently works, you
> open a file, and read it, and that is the only value you see.  If you
> rewind and read again, you still get the old value, even if it
> "should" have changed.  The value is cached and the cache is never
> refreshed. 
> 
> sysfs could be changed to flush the cache on rewind, but I don't know
> that it is worth it.  If it was changed, the poll functionality would
> automatically do the right thing.
> 

IMHO, it is worthy enough if it can allow "poll" to have usual semantics.


Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
