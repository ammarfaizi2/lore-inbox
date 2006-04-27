Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWD0KSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWD0KSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWD0KSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:18:00 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5506 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S965076AbWD0KR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:17:59 -0400
Date: Thu, 27 Apr 2006 03:17:34 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060427101734.GH3026@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17487.61698.879132.891619@cse.unsw.edu.au> <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com> <200604270615.20554.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604270615.20554.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> > > 3/ Is AppArmour's approach of using d_path to get a filename from a
> > >    dentry valid and acceptable? 
> 
> I suppose it needs at least to use the proper vfsmounts instead of
> walking the global list. That would need better hooks. And probably 
> some caching (trying to match dentries directly?) to get better performance.

Yes, walking the list is ugly.  I think you'd wind up having to pin
those dentries in memory (or do what DTE tried with a shadow tree).

> Regarding the basic use of pathnames I don't see a big problem. After
> all the kernel uses dentries for everything too and dentries are
> just a special form of path name too.

The biggest issue with pathnames is they are non-determinstic,
esp. when recreated after the fact using d_path.  So the pathname as
object argument makes sense when talking about objects (vfsmont/dentry),
not strings (d_path).  Also, when mediating solely on pathname it's very
difficult to reason about the contents of the inode that's pointed to by
the pathname.  This means that policy which allows a subject the ability
to write to the object whose handle is /tmp/my_unimportant_tmpfile may be
a security problem if somebody in the system was tricked into a simple 'ln
/etc/shadow /tmp/my_unimportant_tmpfile.'  In this case it's surprising
that the same inode can have different permissions (esp. given traditional
DAC uid/gid and mode bits are kept in inode) depending upon path taken.

The AA stance is that the policy will protect the confined process from
doing such namespace manipulations eliminating the possibiilty of the
confined process and giving itself a mechanism to privilege escalation.
This is reasonable with the caveat that the channels available to the
confined process to collude with (or coerce) an unconfined process are
still pretty high-bandwidth.  One could argue that having unconfined
processes is ill-advised.  SELinux targeted policy has the same basic
issue (channel richness notwithstanding), which is why I'd expect truely
security sensitive environments would use a strict policy.

I guess it's worth noting the AA atack is stopped by SELinux, while the
opposite is also true.  A 'cp /etc/shadow /tmp; mv /tmp/shadow /etc' done
by an unconfined process doesn't effect AA, while it kills the type
label on /etc/shadow and could be an effective policy breach.  In each
case somewhat subtle (i.e. not explicit relabel or policy change) can
have holes.

thanks,
-chris
