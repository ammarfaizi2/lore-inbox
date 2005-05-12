Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVELRwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVELRwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 13:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVELRwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 13:52:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42153 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262086AbVELRv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 13:51:57 -0400
Date: Thu, 12 May 2005 07:51:15 -0500
From: serue@us.ibm.com
To: Jamie Lokier <jamie@shareable.org>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, Ram <linuxram@us.ibm.com>,
       Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512125115.GA12439@sergelap.austin.ibm.com>
References: <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost> <a4e6962a0505111558337dd903@mail.gmail.com> <20050512010215.GB8457@mail.shareable.org> <a4e6962a05051119181e53634e@mail.gmail.com> <20050512064514.GA12315@mail.shareable.org> <a4e6962a0505120623645c0947@mail.gmail.com> <20050512151631.GA16310@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512151631.GA16310@mail.shareable.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jamie Lokier (jamie@shareable.org):
> Eric Van Hensbergen wrote:
> > c) Get the unshare system call adopted as it seems to be generally useful
> 
> I'm not convinced the functionality is all that useful.  It doesn't
> address the need which arose in this thread, which is roughly
> equivalent to per-user namespaces (the precise meaning determined by
> userspace policy).  So what applicatins is it useful for?  Do we have
> examples, or is it just a nice idea?

[my last reply appears to have disappeared, apologies if two show up]

It is useful for polyinstantiated filesystems.  For instance, user u1
opens two sessions, one at clearance L1:C1, one at clearance L3:C1,C2.
He starts some software which expects to open tempfiles under /tmp by a
particular name.  He later (or simultaneously) opens it also under the
lower clearance.  The software now fails because it can't access the
higher clearance file.

This is typically solved by creating /tmp/subdir-CLEARANCE for each
clearance which needs it.  Now on login, the user gets a new namespace,
and /tmp/subidr-CLEARANCE is bind mounted over /tmp.  (Traditionally,
in other operating systems, instead of bind mounting, lookups under /tmp
are just redirected to the appropriate subdir)

This is also used for other dirs, this is just one example.  Note that
MAC is used to actually enforce the clearances, so this is more to
provide a nicer user experience.  Note also that I haven't worked on
such a system, so I'm just telling you what I'm told  :)

Unshare is useful here because we can use it from pam.  I haven't yet
found how we could use clone() from inside a pam library in a meaningful
way to create a new namespace for the resulting login process, so near
as I can tell the alternative is to hack each login program (ssh, login,
etc) separately.

Unshare should also useful for apps which want to change clearance
without needing to clone.  There is clearly a desire for this since the
ability to transition without exec was already added to SELinux.

thanks,
-serge
