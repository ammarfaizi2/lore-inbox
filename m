Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWHPNSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWHPNSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWHPNSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:18:18 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:16536 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750746AbWHPNSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:18:17 -0400
Subject: Re: [RFC] [PATCH] file posix capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
In-Reply-To: <20060816024200.GD15241@sergelap.austin.ibm.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com>
	 <20060814220651.GA7726@sergelap.austin.ibm.com>
	 <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
	 <20060815020647.GB16220@sergelap.austin.ibm.com>
	 <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>
	 <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com>
	 <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil>
	 <20060816024200.GD15241@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 16 Aug 2006 09:20:01 -0400
Message-Id: <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 21:42 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Tue, 2006-08-15 at 06:49 -0500, Serge E. Hallyn wrote:
> > > Quoting Nicholas Miell (nmiell@comcast.net):
> > > > OTOH, everybody seems to have moved from capability-based security
> > > > models on to TE/RBAC-based security models, so maybe this isn't worth
> > > > the effort?
> > > 
> > > One day perhaps, but that day isn't here yet.  People are still using
> > > setuid (see /sbin/passwd), so obviously they're not sufficiently
> > > comfortable using *only* TE/RBAC.
> > 
> > The hard part of capabilities isn't the kernel mechanism - it is the
> 
> I didn't claim to be doing the hard part  :)

Yes, but the question is whether anyone will do the hard part.  And
whether it is worth doing.  And whether you make the system unsafe along
the way, particularly given the permissive nature of capabilities.

> But since file capabilities cannot survive an exec, analysis with a gui
> which walks the fs could be pretty simple.

Except that people actually want them to be inheritable (under certain
conditions), just in a way that avoids the problems encountered in the
past.  If you start on the path of making capabilities useful, you'll
have to tackle that as well.

> > On the kernel side, in addition to updating the bprm_secureexec logic,
> > you would need to consider whether the capability module needs to
> > implement capability comparisons for the other hooks, like task_kill.
> > At present, many operations only involve uid comparisons and SELinux
> > checks without explicitly comparing capability sets.  Properly isolating
> > and protecting processes with different capability sets but the same uid
> > is something SELinux already can do (based on domain), whereas the
> > existing capability module doesn't really provide that. 
> 
> Very good point.  Preventing communication channels i.e. through signals
> isn't a concern, but user hallyn ptracing himself running /bin/passwd
> certainly is.

Actually, ptrace already performs a capability comparison (cap_ptrace).
Wrt signals, it wasn't the communication channel that concerned me but
the ability to interfere with the operation of a process running in the
same uid but different capabilities, like stopping it at a critical
point.  Likewise with many other task hooks - you wouldn't want to be
able to depress the priority of a process running with greater
capabilities.

One other point to consider is Solaris seems to have diverged from their
own past approaches for privileges/capabilities,
http://blogs.sun.com/casper/20040722
http://www.opensolaris.org/os/community/security/library/howto/privbracket/

Doesn't sound like they are even using file capabilities at all.

Also, think about the real benefits of capabilities, at least as defined
in Linux.  The coarse granularity and the lack of any per-object support
is a fairly significant deficiency there that is much better handled via
TE.  At least some of the Linux capabilities lend themselves to easy
privilege escalation to gaining other capabilities or effectively
bypassing them.

-- 
Stephen Smalley
National Security Agency

