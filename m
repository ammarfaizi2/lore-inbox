Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWC3BfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWC3BfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWC3BfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:35:22 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54913 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751265AbWC3BfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:35:21 -0500
Date: Wed, 29 Mar 2006 17:36:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330013618.GS15997@sorel.sous-sol.org>
References: <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> Chris Wright <chrisw@sous-sol.org> writes:
> 
> > * Sam Vilain (sam@vilain.net) wrote:
> >> extern struct security_operations *security_ops; in
> >> include/linux/security.h is the global I refer to.
> >
> > OK, I figured that's what you meant.  The top-level ops are similar in
> > nature to inode_ops in that there's not a real compelling reason to make
> > them per process.  The process context is (usually) available, and more
> > importantly, the object whose access is being mediated is readily
> > available with its security label.
> >
> >> There is likely to be some contention there between the security folk
> >> who probably won't like the idea that your security module can be
> >> different for different processes, and the people who want to provide
> >> access to security modules on the systems they want to host or consolidate.
> >
> > I think the current setup would work fine.  It's less likely that we'd
> > want a separate security module for each container than simply policy
> > that is container aware.
> 
> I think what we really want are stacked security modules.

I'm not convinced we need a new module for each container.  The module
is a policy enforcement engine, so give it a container aware policy and
you shouldn't need another module.

> I have not yet fully digested all of the requirements for multiple servers
> on the same machine but increasingly the security aspects look
> like a job for a security module.

There's two primary security areas here.  One is container level
isolation, which is the job of the container itself.  Security modules
can effectively introduce containers, but w/out any notion of a virtual
environment (easy example, uts).  With namespaces you get isolation w/out
any formal access control check, you simply can't find objects that aren't
in your namespace.  The second is object level isolation (objects such
as files, processes, etc), standard access control checks that should
happen within a container.  This can be handled quite naturally by the
security module.

> Enforcing policies like container A cannot send signals to processes
> in container B or something like that.

This is a question of visibility.  One method of containment is via
LSM.  This checks all object access against a label that's aware of
container ids to disallow inter-container, well, anything.  However,
if a namespace would mean you simply can't find those other processes,
then there's no need for the LSM side except for intra-container.

> Then inside of each container we could have the code that implements
> a containers internal security policy.

Right, and that's doable as a single top-level policy.  It's a bit
interesting when you want to be able to specifiy policy from within a
container (e.g. virtual hosting), granted.

> At least one implementation Linux Jails by Serge E. Hallyn was done completely
> with security modules, and the code was pretty minimal.

Yes, although the networking area was something that looked better done
via namespaces (at least that's my recollection of my conversations with
Serge on that one a few years back).

thanks,
-chris
