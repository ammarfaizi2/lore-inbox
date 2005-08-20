Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVHTFki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVHTFki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 01:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVHTFkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 01:40:37 -0400
Received: from smtp.istop.com ([66.11.167.126]:5013 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751076AbVHTFkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 01:40:37 -0400
From: Daniel Phillips <phillips@istop.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Date: Sat, 20 Aug 2005 15:41:35 +1000
User-Agent: KMail/1.7.2
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
References: <200508201050.51982.phillips@istop.com> <200508201323.29355.phillips@istop.com> <20050820033337.GA1173@kroah.com>
In-Reply-To: <20050820033337.GA1173@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508201541.36101.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 August 2005 13:33, Greg KH wrote:
> On Sat, Aug 20, 2005 at 01:23:29PM +1000, Daniel Phillips wrote:
> > On Saturday 20 August 2005 13:01, Greg KH wrote:
> > > On Sat, Aug 20, 2005 at 10:50:51AM +1000, Daniel Phillips wrote:
> > > > So: Integrate with sysfs.
> > >
> > > No, don't.  Do you think that Joel would not have already worked with
> > > the sysfs people prior to submitting this?  No, he did, and we all
> > > agreed that it should be kept separate.
> >
> > Would you care to recap the reasoning, please?
>
> They do two different things, and people interact with them in two
> different ways.

There is only one essential difference: the user can create nodes in configfs.  
Otherwise, the user does the same with both: display things and tweak things.  
The big difference is in your mind, not the user's mind.  And look above, 
you're saying "don't patch configfs, copy sysfs instead" and in the next 
breath you're saying "but oh they're completely different".

> > > > Terminology skew.  It is a very bad idea to call your configfs files
> > > > "attributes".
> > >
> > > That's what sysfs calls its files.  They used the same naming scheme
> > > there.  This is nothing that a user ever cares about or sees.
> >
> > It's wrrrrronnnggg.  The best you can defend this with is "it's
> > entrenched".
>
> Will a user ever see the word "attribute"?

For example:

   http://linuxcommand.org/man_pages/udev8.html

> Also, these files represent 
> attributes of the main object in which they are attached to.  Hence the
> name.

Yes, regrettable.  "Properties" would be tasteful and avoid the collision.

> > > > Memory requirements.  ConfigFS pins way too much kernel memory for
> > > > inodes and dentries.
> > >
> > > configfs is not going to have that many nodes at all in memory
> > > (compared to sysfs), so I don't think this is a big problem.
> >
> > The current bloat is unconscionable, for the amount of data that is
> > carried. Are you arguing against fixing it?  And what makes you think
> > configfs will never have lots of nodes?
>
> Doesn't it currently work the same way as sysfs with the backing store
> being created on the fly?

I haven't look at sysfs yet, but the backing store, which is just a tree of 
configfs_dirents that point at the corresponding dentries, is created on the 
fly.  Currently, directories are all pinned while only files are transient.  
There is no good reason for this as far as I can see, directories can be 
transient too.

What I did notice is that my fix for permissions is wrong.  I plugged the 
updated permissions back into the descriptor for all attributes of a config 
item - not what we want, the update needs to be restricted to just one 
attribute.  The right fix is to store the updated permissions in the 
configfs_dirent, which already has the field, it is just not used 
consistently.  See, the code is trying to say something to us, I think the 
message is "read me!"

> If not, it should be pretty simple to convert 
> over if people are really worried about memory consumption, but again,
> why don't we see how many nodes are really used on most systems (don't
> want to add more complexity and kernel code if you never really need
> it.)

It will not be hard to fix, the framework seems to be there already.  As far 
as complexity goes, it is trivial and the payoff is significant.  Cleaning up 
a bunch of little stylistic things will have a bigger effect on readability.

Regards,

Daniel
