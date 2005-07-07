Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVGGQ2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVGGQ2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVGGQ1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:27:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:28911 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261363AbVGGQ11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:27:27 -0400
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Thu, 7 Jul 2005 11:26:51 -0500
User-Agent: KMail/1.8
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
References: <1120668881.8328.1.camel@localhost> <200507061523.11468.tinytim@us.ibm.com> <20050706235008.GA9985@kroah.com>
In-Reply-To: <20050706235008.GA9985@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071126.52375.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2005 18:50, Greg KH wrote:
> On Wed, Jul 06, 2005 at 03:23:10PM -0500, Timothy R. Chavez wrote:
> > This is similar to Inotify in that the audit subsystem watches for file
> > system activity and collects information about inodes its interested 
> > in, but this is where the similarities stop.  Despite the fact that the
> > Inotify requirements only dictate a subset of the activity the audit
> > subsystem is interested in, there is a more fundamental divergence 
> > between the two projects.  Like audit, Inotify takes paths and resolves 
> > them to a single inode.  But, unlike audit, Inotify does not find the path 
> > itself interesting.
> 
> Huh?  inotify users find that path interesting, as they use it to act
> apon.

I really didn't want to go back and forth on this (my fingers are still sore from
our convo on ltc-interlock :-)), but I might as well oblige.

> 
> > Much like the (device,inode)-based system call filters 
> > currently available in the audit subsystem, Inotify targets only individual 
> > inodes.  Thus, if the underlying inode associated with the file /etc/shadow 
> > was changed, and /etc/shadow was being "watched", we'd lose auditability 
> > on /etc/shadow across transactions.
> 
> That's why you watch /etc/ instead, which catches that rename.  That
> being said, why would not inotify also want this functionality if you
> think it is important?

Sure, by watching a directory with Inotify, you receive notification upon rename() 
events.  Now, as far as Inotify is concerned, how this is finally interpreted is up to 
the user space programs it's feeding.  In terms of audit, there must never be a
chance for subversion.  If this feature were implemented in terms of Inotify as it 
stands now, the processing we do in fs/dcache.c would need to be shifted to a
user space app which is obviously out of the question.  One alternative, the one 
I believe you're in favor of, is to augment Inotify itself.  But, AFAICT, nothing in 
Inotify's documentation leads me to believe that this adds anything to Inotify itself 
(with the exception of complication and obfuscation), especially in terms of event 
notification.  IMO, by tieing our logic to Inotify we'd inadvertently be dooming it to 
the dreaded Second-system syndrome:

http://en.wikipedia.org/wiki/Second-system_effect

> 
> > More so, Inotify cannot watch inodes that do not yet exist (because
> > the file does not yet exist).  To do this, the audit subsystem must
> > hook deeper than Inotify (in fs/dcache.c) to adapt with the file
> > system as it changes.  Where it makes sense, the small set of
> > notification hooks in the VFS that Inotify and audit could share
> > should be consolidated.
> 
> As inotify works off of open file descriptors, yes, this is true.  But,
> again, if you think this is really important, then why not just work
> with inotify to provide that kind of support to it?

I've yet to be convinced that merging these two projects or implementing 
one in terms of the other has any real benefit to either project in terms of
their individual goals and requirements.

The only real similarty between the two projects from my POV is that they 
are both interested in reporting a subset of file system activity and could 
benefit from a set of common hooks (ie: fsnotify) where it makes sense.

> 
> I suggest you work together with the inotify developers to hash out your
> differences, as it sounds like you are duplicating a lot of the same
> functionality.

Where functionality is the same or similar, we can address that, but surely 
in the interim the inclusion of this patch into -mm would be beneficial to the 
98% of dissimilar functionality :)

> 
> Also, inotify handles the namespace issues of processes by working off
> of a file descriptor.  How do you handle this?

Well I guess this boils down to what you consider an issue.  In terms of audit 
and this patch, tagging audit info to the inode ensures that it's auditable from 
any namespace.  When a location and name is audited, the administrator does 
so from what they consider a meaningful namespace and device (ie: for most, 
the path /etc/shadow is meaningful, so by "watching" it, you've made a file 
containing security secrets auditable and not your favorite LOTR ascii art) .

-tim

> 
> Do you have any documetation or example userspace code that shows how to
> use this auditfs interface you have created?

> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
