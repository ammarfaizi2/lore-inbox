Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVLVGCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVLVGCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLVGCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:02:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:29058 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932393AbVLVGCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:02:12 -0500
From: Neil Brown <neilb@suse.de>
To: maneesh@in.ibm.com
Date: Thu, 22 Dec 2005 17:02:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17322.16730.75851.638863@cse.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - 2.6.15-rc5-mm3] Allow sysfs attribute files to be pollable.
In-Reply-To: message from Maneesh Soni on Thursday December 22
References: <17320.36949.269788.520946@cse.unsw.edu.au>
	<20051221134901.GA19746@in.ibm.com>
	<17322.8400.727405.522183@cse.unsw.edu.au>
	<20051222054742.GA3711@in.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 22, maneesh@in.ibm.com wrote:
> On Thu, Dec 22, 2005 at 02:43:12PM +1100, Neil Brown wrote:
> > You don't have to read the contents unless you want to know what is in
> > the file.  You could just open the file and call 'poll' and wait for
> > it to tell you something has happened.  However this isn't likely to
> > be really useful.
> > It isn't the 'something has happened' event that is particularly
> > interesting.  It is the 'the state is now X' information that is
> > interesting. 
> > So you read the file to find out what the state is.  If that isn't the
> > state you were looking for (or if you have finished responding to that
> > state), you poll/select, and then try again.
> > 
> 
> ok.. that makes sense. But in this case [open() and then poll()], should
> buffer->event() be initialized in sysfs_open()-->check_perm(), instead
> of fill_read_buffer() ? I think this scheme should work for [open(), read()
> and then poll()] also. 

We are definitely using poll in a non-standard way as it is generally
for "you can read now" or "you can write now", and we are (ab)using it
to say "there is new information".  Note that this is essentially
copying the semantics of 'poll' on /proc/mounts.

I would see poll returning as meaning "there is state information that
you haven't read".

When you first open the file, you haven't read anything, so poll
should return immediately - which it currently does.
After you read something, poll won't return again until there is
something new to be read.

I think this is probably the best semantics, but if you try hard you
might be able to convince me otherwise...


> 
> But how about the other rule, ie once woken-up the user has to close,
> re-open and re-read the file. Can this also be avoided, as probably this is also
> not poll semantics?

This semantic is part of sysfs.  The way sysfs currently works, you
open a file, and read it, and that is the only value you see.  If you
rewind and read again, you still get the old value, even if it
"should" have changed.  The value is cached and the cache is never
refreshed. 

sysfs could be changed to flush the cache on rewind, but I don't know
that it is worth it.  If it was changed, the poll functionality would
automatically do the right thing.


Thanks again,

NeilBrown
