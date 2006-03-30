Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWC3Spg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWC3Spg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWC3Spg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:45:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17335 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750713AbWC3Spf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:45:35 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, David Lang <dlang@digitalinsight.com>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44294BE4.2030409@yahoo.com.au>
	<m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net>
	<20060329182027.GB14724@sorel.sous-sol.org>
	<442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<20060330013618.GS15997@sorel.sous-sol.org>
	<Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz>
	<20060330020445.GT15997@sorel.sous-sol.org>
	<20060330143224.GC6933@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Mar 2006 11:44:06 -0700
In-Reply-To: <20060330143224.GC6933@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Thu, 30 Mar 2006 08:32:24 -0600")
Message-ID: <m1bqvndb7t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Frankly I thought, and am still not unconvinced, that containers owned
> by someone other than the system owner would/should never want to load
> their own LSMs, so that this wasn't a problem.  Isolation, as Chris has
> mentioned, would be taken care of by the very nature of namespaces.

Up to uids I agree.  Once we hit uids things get very ugly.
And since security modules already seem to touch all of the places
we need to touch to make a UID namespace work I think using security
modules to implement the strange things we need with uid.

To ensure uid isolation we would need a different copy of every other
namespace.  The pid space would need to be completely isolated,
and we couldn't share any filesystem mounts with any other namespace.
This especially includes /proc and sysfs.

> There are of course two alternatives...  First, we might want to allow the
> machine admin to insert per-container/per-namespace LSMs.    To support
> this case, we would need a way for the admin to tag a container some way
> identifying it as being subject to a particular set of security_ops.  
>
> Second, we might want container admins to insert LSMs.  In addition to
> a straightforward way of tagging subjects/objects with their container,
> we'd need to implement at least permissions for "may insert global LSM",
> "may insert container LSM", and "may not insert any LSM."  This might be
> sufficient if we trust userspace to always create full containers.
> Otherwise we might want to support meta-policy along the lines of "may
> authorize ptrace and mount hooks only", or even "not subject to the
> global inode_permission hook, and may create its own."  (yuck)

Security modules that are stackable call mod_reg_security.
Currently in the current we have: root_plug, seclvl, capability modules
that implement this. selinux currently only supports running
as the global security policy.

Allowing a different administrator to load modules is out of
the question, if we actually care about security.

However it is possible to build the capacity to multiplex 
compiled in or already loaded security modules, and allowed which
security modules are in effect to be controlled by securityfs.

With appropriate care we should be able to allow the container
administrator to use this capability to select which security
policies, and mechanisms they want. 

That is something we probably want to consider anyway as
currently the security modules break the basic rule that
compiling code in should not affect how the kernel operates
by default.

Until we get to that point simply specifying the name of a security
module in the static configuration of a container that the container
creation program can use should be enough.

> But so much of this depends on how the namespaces/containers end up
> being implemented...

Agreed.  But if I hand wave and say an upper level security module will
decide when to call it then only the details of that upper level
security module are in question.  The stacked module will likely just
work.

So I guess I am leaning towards a security namespace implemented with
an appropriate security module.

Eric
