Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVGGTyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVGGTyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVGGTwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:52:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:47813 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262028AbVGGTtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:49:51 -0400
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Thu, 7 Jul 2005 14:49:15 -0500
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
References: <1120668881.8328.1.camel@localhost> <200507071126.52375.tinytim@us.ibm.com> <20050707181055.GA21072@kroah.com>
In-Reply-To: <20050707181055.GA21072@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071449.16280.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 13:10, Greg KH wrote:
> On Thu, Jul 07, 2005 at 11:26:51AM -0500, Timothy R. Chavez wrote:
> > On Wednesday 06 July 2005 18:50, Greg KH wrote:
> > > On Wed, Jul 06, 2005 at 03:23:10PM -0500, Timothy R. Chavez wrote:
> > > > This is similar to Inotify in that the audit subsystem watches for file
> > > > system activity and collects information about inodes its interested 
> > > > in, but this is where the similarities stop.  Despite the fact that the
> > > > Inotify requirements only dictate a subset of the activity the audit
> > > > subsystem is interested in, there is a more fundamental divergence 
> > > > between the two projects.  Like audit, Inotify takes paths and resolves 
> > > > them to a single inode.  But, unlike audit, Inotify does not find the path 
> > > > itself interesting.
> > > 
> > > Huh?  inotify users find that path interesting, as they use it to act
> > > apon.
> > 
> > I really didn't want to go back and forth on this (my fingers are still sore from
> > our convo on ltc-interlock :-)), but I might as well oblige.
> 
> I'm sorry, but discussions on internal mailing lists mean nothing here
> on lkml.  How would we know what you all discussed, or if it was even
> correct?

Oh I was only playfully commenting on the discussion between you and I half a 
year or so ago :).

> 
> > > > Much like the (device,inode)-based system call filters 
> > > > currently available in the audit subsystem, Inotify targets only individual 
> > > > inodes.  Thus, if the underlying inode associated with the file /etc/shadow 
> > > > was changed, and /etc/shadow was being "watched", we'd lose auditability 
> > > > on /etc/shadow across transactions.
> > > 
> > > That's why you watch /etc/ instead, which catches that rename.  That
> > > being said, why would not inotify also want this functionality if you
> > > think it is important?
> > 
> > Sure, by watching a directory with Inotify, you receive notification upon rename() 
> > events.  Now, as far as Inotify is concerned, how this is finally interpreted is up to 
> > the user space programs it's feeding.
> 
> Which should be the same as audit, right?  audit is just reporting what
> happens.
> 
> > In terms of audit, there must never be a chance for subversion.
> 
> "never" is a tough thing to prove :)

You're right, a bit bold, but ideally it is what we're striving for.  Where we can 
prevent subversion or where it's reasonable to prevent subversion we should 
make the effort to do so.

> 
> > If this feature were implemented in terms of Inotify as it stands now,
> > the processing we do in fs/dcache.c would need to be shifted to a user
> > space app which is obviously out of the question.
> 
> Why "obviously"?  It isn't obvious to me.

Even if access control prohibits us from actually seeing the content of 
/etc/shadow, if we're auditing /etc/shadow, attempts should be logged 
and not gone unnoticed.

watch /etc/shadow
passwd
<inode changes before execution ends>
cat /etc/shadow (goes unaudited)
<send event to user space>
ln /etc/shadow /home/foo/evil_shadow (goes unaudited)
<process in user space>
cat /home/foo/evil_shadow (goes unaudited)
<send back instructions to kernel to watch the new /etc/shadow>
cat /etc/shadow (audited)

Hmmm...

> 
> > One alternative, the one I believe you're in favor of, is to augment
> > Inotify itself.
> 
> Yes.
> 
> > But, AFAICT, nothing in Inotify's documentation leads me to believe
> > that this adds anything to Inotify itself (with the exception of
> > complication and obfuscation), especially in terms of event
> > notification.
> 
> It would allow inotify to work for you also.  That's a good enough
> reason.
> 
> > IMO, by tieing our logic to Inotify we'd inadvertently be dooming it
> > to the dreaded Second-system syndrome:
> > 
> > http://en.wikipedia.org/wiki/Second-system_effect
> 
> I fail to see how that has any relevance on this discussion.
> 
> > > > More so, Inotify cannot watch inodes that do not yet exist (because
> > > > the file does not yet exist).  To do this, the audit subsystem must
> > > > hook deeper than Inotify (in fs/dcache.c) to adapt with the file
> > > > system as it changes.  Where it makes sense, the small set of
> > > > notification hooks in the VFS that Inotify and audit could share
> > > > should be consolidated.
> > > 
> > > As inotify works off of open file descriptors, yes, this is true.  But,
> > > again, if you think this is really important, then why not just work
> > > with inotify to provide that kind of support to it?
> > 
> > I've yet to be convinced that merging these two projects or implementing 
> > one in terms of the other has any real benefit to either project in terms of
> > their individual goals and requirements.
> 
> You have common hooks in the kernel.  You do almost the same thing
> (report fs changes to userspace.)  Seems a natural thing to me.

This patch reports "fs changes" to the audit subsystem which then adds them 
to the audit_context of the current task.  Then, at system call exit, the audit_context 
is sent to user space, effectively logging not only the "fs change", but information 
regarding the process, system call, path, etc, to give the complete account.

Here's some sample output in human-readable format (I didn't include a filterkey)

[root@liltux ~]# /sbin/ausearch -i
----
type=PATH msg=audit(07/07/11 01:32:59.484:116357) : name=/audit/foo flags=follow,open inode=3074232 dev=fd:00 mode=file,644 ouid=root ogid=root rdev=00:00
type=CWD msg=audit(07/07/11 01:32:59.484:116357) :  cwd=/root
type=FS_INODE msg=audit(07/07/11 01:32:59.484:116357) : inode=3074232 inode_uid=root inode_gid=root inode_dev=fd:00 inode_rdev=00:00
type=FS_WATCH msg=audit(07/07/11 01:32:59.484:116357) : watch_inode=3074232 watch=foo filterkey= perm= perm_mask=read
type=SYSCALL msg=audit(07/07/11 01:32:59.484:116357) : arch=i386 syscall=open per=400000 success=yes exit=3 a0=bffffbfc a1=8000 a2=0 a3=8000 items=1 pid=12670 auid=unknown(4294967295) uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root comm=cat exe=/bin/cat

> 
> > The only real similarty between the two projects from my POV is that they 
> > are both interested in reporting a subset of file system activity and could 
> > benefit from a set of common hooks (ie: fsnotify) where it makes sense.
> 
> Exactly.  What else is there?

The fact that audit is interested in more activity then Inotify (like permission()),
must strive to never lose events, interacts with the audit subsystem directly, 
must conform to security requirements placed on it by various Protection Profiles 
(for the time being, CAPP), defers sending the event record to user space until 
system call exit, the inode is relevant only if it's associated with the last 
component of an audited path (not just the inode targetted initially)... And I'm 
sure Robert could point out things that Inotify does that audit doesn't do (and 
isn't very interested in doing).

> 
> > > I suggest you work together with the inotify developers to hash out your
> > > differences, as it sounds like you are duplicating a lot of the same
> > > functionality.
> > 
> > Where functionality is the same or similar, we can address that, but surely 
> > in the interim the inclusion of this patch into -mm would be beneficial to the 
> > 98% of dissimilar functionality :)
> 
> I don't see such a huge dissimilar functionality, but hey, feel free to
> prove me wrong :)

Maybe after you play with auditctl some, you'll see it? :)

-tim

> 
> > > Also, inotify handles the namespace issues of processes by working off
> > > of a file descriptor.  How do you handle this?
> > 
> > Well I guess this boils down to what you consider an issue.
> 
> Namespaces are an issue.
> 
> > In terms of audit and this patch, tagging audit info to the inode
> > ensures that it's auditable from any namespace.
> 
> Agreed.  But how do you report that inode info to userspace when you
> don't know the namespace it was accessed under?  Or am I missing
> something here?
> 
> > When a location and name is audited, the administrator does so from
> > what they consider a meaningful namespace and device (ie: for most,
> > the path /etc/shadow is meaningful, so by "watching" it, you've made a
> > file containing security secrets auditable and not your favorite LOTR
> > ascii art) .
> 
> Yes, and then I change namespaces to put /etc/shadow at
> /foo/baz/etc/shadow and then access it that way?  Will the current audit
> system fail to catch that access?
> 
> thanks,
> 
> greg k-h
