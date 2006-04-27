Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWD0OoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWD0OoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWD0OoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:44:05 -0400
Received: from tresys.irides.com ([216.250.243.126]:42911 "EHLO
	exchange.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S965047AbWD0OoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:44:03 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Karl MacMillan <kmacmillan@tresys.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@suse.de>, Ken Brush <kbrush@gmail.com>,
       Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060427101734.GH3026@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
	 <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
	 <200604270615.20554.ak@suse.de>  <20060427101734.GH3026@sorel.sous-sol.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Apr 2006 10:42:04 -0400
Message-Id: <1146148924.2759.49.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 03:17 -0700, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > > > 3/ Is AppArmour's approach of using d_path to get a filename from a
> > > >    dentry valid and acceptable? 
> > 
> > I suppose it needs at least to use the proper vfsmounts instead of
> > walking the global list. That would need better hooks. And probably 
> > some caching (trying to match dentries directly?) to get better performance.
> 
> Yes, walking the list is ugly.  I think you'd wind up having to pin
> those dentries in memory (or do what DTE tried with a shadow tree).
> 
> > Regarding the basic use of pathnames I don't see a big problem. After
> > all the kernel uses dentries for everything too and dentries are
> > just a special form of path name too.
> 
> The biggest issue with pathnames is they are non-determinstic,
> esp. when recreated after the fact using d_path.  So the pathname as
> object argument makes sense when talking about objects (vfsmont/dentry),
> not strings (d_path).  Also, when mediating solely on pathname it's very
> difficult to reason about the contents of the inode that's pointed to by
> the pathname.  This means that policy which allows a subject the ability
> to write to the object whose handle is /tmp/my_unimportant_tmpfile may be
> a security problem if somebody in the system was tricked into a simple 'ln
> /etc/shadow /tmp/my_unimportant_tmpfile.'  In this case it's surprising
> that the same inode can have different permissions (esp. given traditional
> DAC uid/gid and mode bits are kept in inode) depending upon path taken.
> 
> The AA stance is that the policy will protect the confined process from
> doing such namespace manipulations eliminating the possibiilty of the
> confined process and giving itself a mechanism to privilege escalation.
> This is reasonable with the caveat that the channels available to the
> confined process to collude with (or coerce) an unconfined process are
> still pretty high-bandwidth.  One could argue that having unconfined
> processes is ill-advised.  SELinux targeted policy has the same basic
> issue (channel richness notwithstanding), which is why I'd expect truely
> security sensitive environments would use a strict policy.
> 
> I guess it's worth noting the AA atack is stopped by SELinux, while the
> opposite is also true.  A 'cp /etc/shadow /tmp; mv /tmp/shadow /etc' done
> by an unconfined process doesn't effect AA, while it kills the type
> label on /etc/shadow and could be an effective policy breach.  In each
> case somewhat subtle (i.e. not explicit relabel or policy change) can
> have holes.
> 

While this is example of labeling issues with SELinux is correct for a
standard targeted policy, it does not represent an intrinsic problem
with the SELinux mechanism. A policy that has the appropriate
specialized domains for reading /etc/shadow and corresponding
type_transition rules can prevent this mislabeling. The solution may not
be very satisfying because of the changes it makes to how systems are
typically administered, but at least it does exist within the SELinux
model. The same cannot be said of the problems introduced by path-based
mechanisms.

Thanks,

Karl

> thanks,
> -chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
