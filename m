Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUB1RJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 12:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUB1RJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 12:09:25 -0500
Received: from netrider.rowland.org ([192.131.102.5]:6672 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S261888AbUB1RJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 12:09:04 -0500
Date: Sat, 28 Feb 2004 12:09:00 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Michael Frank <mhf@linuxmail.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Question about (or bug in?) the kobject implementation
In-Reply-To: <opr32kuku54evsfm@smtp.pacific.net.th>
Message-ID: <Pine.LNX.4.44L0.0402281201260.15169-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Feb 2004, Michael Frank wrote:

> On Fri, 27 Feb 2004 23:02:34 -0500 (EST), Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > This really is a programming error.  It means that kobject_get() has been
> > passed a possibly stale pointer.  Ipso facto, the call to kobject_put()
> > that decremented the refcount to 0 was made too early, while there were
> > still active pointers to the kobject floating around.
> >
> > It's impossible to prevent people from making programming errors or
> > dereferencing stale pointers.  It doesn't matter _what_ code you put in
> > kobject_get() -- it will crash when given a pointer to a kobject whose
> > cleanup routine has already run and deallocated the storage.
> >
> > The best you can do is call people's attention to such errors and fail the
> > operation gracefully whenever possible (i.e., when it doesn't generate an
> > addressing error).  My personal choice would be to change kobject_get() as
> > follows:
> >
> > struct kobject * kobject_get(struct kobject * kobj)
> > {
> > 	if (kobj) {
> > 		if (atomic_read(&kobj->refcount) == 0) {
> > 			WARN_ON(1);
> > 			return NULL;
> > 		}
> > 		atomic_inc(&kobj->refcount);
> > 	}
> > 	return kobj;
> > }
> >
> > I think that's about the best you can do.
> 
> This is too ugly :-(

It's cleaner than your proposal below.  It's not so different from the
code that's there now.  And it does what that code _ought_ to do, namely, 
return a NULL pointer when the kobject is no longer available.

> > And what's the answer to A'?
> 
> The weakness is really in that the refcount is stored dynamically.
> 
> What about a new struct to hold the pointer to the kobj and it's refcount:
> 
> struct kobjectref {
> 	struct kobject *kobj;
> 	int refcount;
> };
> ...
> 
> struct kobjectref rkobj;

Since kobjects are allocated dynamically, you will have to allocate 
kobjectrefs dynamically as well.

> Using refkobj eliminates all problems as the pointer to the refcount can't
> be invalid.

Only until you deallocate the kobjectref.  And when you do, you then face
exactly the same set of problems: pointers to the kobjectref will become
stale.  If you don't ever deallocate kobjectrefs then you have a memory
leak.  So this proposal doesn't solve anything, it just adds an extra
layer of indirection.

Alan Stern

