Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUC3X4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUC3X4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:56:30 -0500
Received: from ida.rowland.org ([192.131.102.52]:20996 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262014AbUC3X42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:56:28 -0500
Date: Tue, 30 Mar 2004 18:56:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, <maneesh@in.ibm.com>, <david-b@pacbell.net>,
       <viro@math.psu.edu>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Unregistering interfaces
In-Reply-To: <20040330151637.6f5a688b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0403301844410.6478-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Andrew Morton wrote:

> Greg KH <greg@kroah.com> wrote:
> >
> > I think we need to do this now, as it is not a correct fix, and causes
> > more problems than good at this time.
> 
> But the patch was correct.  sysfs retains a pointer to the kobject, it
> should take a ref on it?
> 
> >  I suggest you try to fix the oops
> > you were seeing in either another way, or in a way that does not break
> > other things :)
> 
> Didn't we demonstrate that the code which broke was already broken?  And
> that it has other problems regardless of the kobject pinning fix, such as the
> userpace-holding-a-file-open-wedges-khubd problem?
> 
> Worried that this is all heading in the wrong direction...

There are two problems to consider:

    (1) sysfs retains pointers to kobjects long after they have been
	unregistered because of the negative dentrys.

    (2) khubd blocks when removing configurations.

Maneesh's change caused (1) because it grabbed a reference to protect an
existing pointer.  The way to repair the damage is to delete the pointer
ASAP so the reference can be dropped.  That will require changing several
other sysfs routines that assume the pointer is valid.

Such a change is needed because otherwise module unloading can be delayed 
indefinitely, until the system decides it needs to reuse the negative 
dentry.


(2) has been repaired temporarily.  We're still discussing the right way
to fix it permanently, though.  The underlying cause for the reason that
khubd blocked is an odd feature of sysfs: it's willing to delete
directories that contain subdirectories, while leaving the subdirectories
in existence.  (The connection to khubd is slightly obscure but it can be
traced.)

Greg has proposed using an awkward scheme for repeatedly parsing and
creating dynamic data structures from USB configuration descriptors to fix
(2).  I'm in favor of changing the behavior of sysfs, so that either it
refuses to delete directories that contain subdirectories or else it
recursively deletes the subdirectories first.  At this point nothing has
been settled.

Alan Stern

