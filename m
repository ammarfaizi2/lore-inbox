Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbUC3PkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbUC3PkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:40:01 -0500
Received: from ida.rowland.org ([192.131.102.52]:3588 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263729AbUC3Pi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:38:59 -0500
Date: Tue, 30 Mar 2004 10:38:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>,
       <viro@math.psu.edu>, <maneesh@in.ibm.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Unregistering interfaces
In-Reply-To: <20040330000129.GA31667@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0403301013460.1072-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Greg KH wrote:

> On Mon, Mar 29, 2004 at 03:31:17PM -0800, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > > The module should remain in memory, "unhashed", until the final kobject
> > > > reference falls to zero.  Destruction of that kobject causes the refcount
> > > > on the module to fall to zero which causes the entire module to be
> > > > released.
> > > > 
> > > > (hmm, the existence of a kobject doesn't appear to contribute to its
> > > > module's refcount.  Why not?)
> > > 
> > > It does, if a file for that kobject is opened.  In this case, there was
> > > no file opened, so the module refcount isn't incremented.
> > 
> > hm, surprised.  Shouldn't the existence of a kobject contribute to its
> > module's refcount?
> 
> No, a kobject by itself knows nothing about a module.  Only the
> attribute files do (and they are the things that contain the struct
> module *), as they are what user space can grab references to.

There's another reason.  Practically every module has kobjects registered
all the time; they are not unregistered until the module's unload
procedure runs.  If these kobjects contributed to the modules refcount
then it would be impossible ever to rmmod the module without using the -f
flag.

Furthermore, all the excess usage counts from those kobjects would swamp
and hide the genuine usage counts (the ones that are displayed now).  The
user would have no way to know whether rmmod -f would work or would hang.

Alan Stern


