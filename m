Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWDTRnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWDTRnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWDTRnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:43:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:51942 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751094AbWDTRny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:43:54 -0400
Date: Thu, 20 Apr 2006 10:39:32 -0700
From: Tony Jones <tonyj@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
Message-ID: <20060420173932.GA31281@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com> <1145470230.3085.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145470230.3085.84.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 08:10:30PM +0200, Arjan van de Ven wrote:
> On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
> > +/**
> > + * _aa_perm_dentry
> > + * @active: profile to check against
> > + * @dentry: requested dentry
> > + * @mask: mask of requested operations
> > + * @pname: pointer to hold matched pathname (if any)
> > + *
> > + * Helper function.  Obtain pathname for specified dentry. 
> 
> which namespace will this be in?

We perform validation relative to the current tasks namespace

> > Verify if profile
> > + * authorizes mask operations on pathname (due to lack of vfsmnt it is sadly
> > + * necessary to search mountpoints in namespace -- when nameidata is passed
> > + * more fully, this code can go away).  If more than one mountpoint matches
> > + * but none satisfy the profile, only the first pathname (mountpoint) is
> > + * returned for subsequent logging.
> 
> that sounds too bad ;) 
> If I manage to mount /etc/passwd as /tmp/passwd, you'll only find the
> later and your entire security system seems to be down the drain.

Well first off, as addressed elsewhere, a confined task cannot mount.

Also, if you do bind mount as above, we will find both but we only report
the first.  The path reported in this event will be used to generate policy.
Clearly if the ordering of which entry is found first varies, then for a
subsequent iteration, the policy may not be sufficient to grant the task 
access and it will likely fail. This is important, a failure to specify a 
path in a profile results in a failure of access not a allowal of access. 
Solution, include all paths in the profile confining the task.

I do grant that a situation of very temporal mounts can make the generation 
of a sane profile difficult. I've not used namespaces in such a manner so
I've not seen exactly how bad it is.  One of my hopes from this thread was
that people would post real life in the trenches with namespaces examples,
both to aid us and maybe to illustrate where our approach is broken. Likewise 
if you generate policy in an environment with a large number of mounts which 
will not esist when the task runs under policy enforcement, you could run into 
issues.

> > +	filename = aa_get_name(filp->f_dentry, filp->f_vfsmnt);
> 
> what if filp->f_dentry is NULL ?
> like when the file got unlinked under you?

I believe there is a misunderstanding about the value of a unhashed dentry 
when a file is unlinked from under a task. I responded to a more detailed 
version of the same question posted by Valdis Kletniek. 

Thanks for the post.

Tony
