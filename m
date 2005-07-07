Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVGGSLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVGGSLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVGGSLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:11:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:48566 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261363AbVGGSLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:11:09 -0400
Date: Thu, 7 Jul 2005 11:10:55 -0700
From: Greg KH <greg@kroah.com>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050707181055.GA21072@kroah.com>
References: <1120668881.8328.1.camel@localhost> <200507061523.11468.tinytim@us.ibm.com> <20050706235008.GA9985@kroah.com> <200507071126.52375.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071126.52375.tinytim@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:26:51AM -0500, Timothy R. Chavez wrote:
> On Wednesday 06 July 2005 18:50, Greg KH wrote:
> > On Wed, Jul 06, 2005 at 03:23:10PM -0500, Timothy R. Chavez wrote:
> > > This is similar to Inotify in that the audit subsystem watches for file
> > > system activity and collects information about inodes its interested 
> > > in, but this is where the similarities stop.  Despite the fact that the
> > > Inotify requirements only dictate a subset of the activity the audit
> > > subsystem is interested in, there is a more fundamental divergence 
> > > between the two projects.  Like audit, Inotify takes paths and resolves 
> > > them to a single inode.  But, unlike audit, Inotify does not find the path 
> > > itself interesting.
> > 
> > Huh?  inotify users find that path interesting, as they use it to act
> > apon.
> 
> I really didn't want to go back and forth on this (my fingers are still sore from
> our convo on ltc-interlock :-)), but I might as well oblige.

I'm sorry, but discussions on internal mailing lists mean nothing here
on lkml.  How would we know what you all discussed, or if it was even
correct?

> > > Much like the (device,inode)-based system call filters 
> > > currently available in the audit subsystem, Inotify targets only individual 
> > > inodes.  Thus, if the underlying inode associated with the file /etc/shadow 
> > > was changed, and /etc/shadow was being "watched", we'd lose auditability 
> > > on /etc/shadow across transactions.
> > 
> > That's why you watch /etc/ instead, which catches that rename.  That
> > being said, why would not inotify also want this functionality if you
> > think it is important?
> 
> Sure, by watching a directory with Inotify, you receive notification upon rename() 
> events.  Now, as far as Inotify is concerned, how this is finally interpreted is up to 
> the user space programs it's feeding.

Which should be the same as audit, right?  audit is just reporting what
happens.

> In terms of audit, there must never be a chance for subversion.

"never" is a tough thing to prove :)

> If this feature were implemented in terms of Inotify as it stands now,
> the processing we do in fs/dcache.c would need to be shifted to a user
> space app which is obviously out of the question.

Why "obviously"?  It isn't obvious to me.

> One alternative, the one I believe you're in favor of, is to augment
> Inotify itself.

Yes.

> But, AFAICT, nothing in Inotify's documentation leads me to believe
> that this adds anything to Inotify itself (with the exception of
> complication and obfuscation), especially in terms of event
> notification.

It would allow inotify to work for you also.  That's a good enough
reason.

> IMO, by tieing our logic to Inotify we'd inadvertently be dooming it
> to the dreaded Second-system syndrome:
> 
> http://en.wikipedia.org/wiki/Second-system_effect

I fail to see how that has any relevance on this discussion.

> > > More so, Inotify cannot watch inodes that do not yet exist (because
> > > the file does not yet exist).  To do this, the audit subsystem must
> > > hook deeper than Inotify (in fs/dcache.c) to adapt with the file
> > > system as it changes.  Where it makes sense, the small set of
> > > notification hooks in the VFS that Inotify and audit could share
> > > should be consolidated.
> > 
> > As inotify works off of open file descriptors, yes, this is true.  But,
> > again, if you think this is really important, then why not just work
> > with inotify to provide that kind of support to it?
> 
> I've yet to be convinced that merging these two projects or implementing 
> one in terms of the other has any real benefit to either project in terms of
> their individual goals and requirements.

You have common hooks in the kernel.  You do almost the same thing
(report fs changes to userspace.)  Seems a natural thing to me.

> The only real similarty between the two projects from my POV is that they 
> are both interested in reporting a subset of file system activity and could 
> benefit from a set of common hooks (ie: fsnotify) where it makes sense.

Exactly.  What else is there?

> > I suggest you work together with the inotify developers to hash out your
> > differences, as it sounds like you are duplicating a lot of the same
> > functionality.
> 
> Where functionality is the same or similar, we can address that, but surely 
> in the interim the inclusion of this patch into -mm would be beneficial to the 
> 98% of dissimilar functionality :)

I don't see such a huge dissimilar functionality, but hey, feel free to
prove me wrong :)

> > Also, inotify handles the namespace issues of processes by working off
> > of a file descriptor.  How do you handle this?
> 
> Well I guess this boils down to what you consider an issue.

Namespaces are an issue.

> In terms of audit and this patch, tagging audit info to the inode
> ensures that it's auditable from any namespace.

Agreed.  But how do you report that inode info to userspace when you
don't know the namespace it was accessed under?  Or am I missing
something here?

> When a location and name is audited, the administrator does so from
> what they consider a meaningful namespace and device (ie: for most,
> the path /etc/shadow is meaningful, so by "watching" it, you've made a
> file containing security secrets auditable and not your favorite LOTR
> ascii art) .

Yes, and then I change namespaces to put /etc/shadow at
/foo/baz/etc/shadow and then access it that way?  Will the current audit
system fail to catch that access?

thanks,

greg k-h
