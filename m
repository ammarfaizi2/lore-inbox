Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965240AbWIRM6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbWIRM6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWIRM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:58:15 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:14815 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S965237AbWIRM6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:58:14 -0400
Subject: Re: capabilities patch: trying a more "consensual" approach
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <20060915225213.GA15173@clipper.ens.fr>
References: <20060911212826.GA9606@clipper.ens.fr>
	 <20060915225213.GA15173@clipper.ens.fr>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 18 Sep 2006 08:59:31 -0400
Message-Id: <1158584371.18951.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 00:52 +0200, David Madore wrote:
> Hi, Linux and LSM experts,
> 
> I would like to request some advice on how best to create an LSM for
> creating underprivileged processes in a way that will seem acceptable
> also to those Linux users and kernel hackers who don't want to hear
> about it (i.e., my patch should not mess more than necessary with the
> rest of the kernel).
> 
> In a nutshell, the goal is to do this: when the module is loaded, each
> task should have a "cuppabilities" variable, which is initially blank
> and, when certain bits are added to it (or removed, depending on your
> point of view), prevents certain system calls from succeeding.  This
> variable should be inherited across fork() and exec(), and some
> interface should be provided to add more cuppabilities (i.e., make a
> process less-than-normally privileged).
> 
> Now, if I understand correctly, the various alloc_security() LSM hooks
> do not stack well: if I want my module to be stackable after SElinux
> (and I do), I can't hook task_alloc_security() to create my variable,
> so I need to store these "cuppabilities" in a globally visible task
> field.  Do I understand correctly?  How acceptable is this?  (We can
> assume that 32 bits will be wide enough, so I'm not talking about
> adding huge amounts of data to the task struct.)

No, I think that is a losing strategy, and it defeats the purpose of
having LSM in the first place.  For now, I'd suggest just _not_
supporting stacking with SELinux until such a time as you've
successfully gotten your module merged, then later you can take up the
best way to support such stacking (whether via direct modification of
SELinux to enable chaining off of its security structures, or via the
"stacker" module previously implemented by Serge that lacks a real
motivating user, although that is contentious).

> Second, what would be the cleanest and most acceptable way to provide
> an interface to these new "cuppabilities"?  For example, should I add
> a new, dedicated, system call?  If so, should I provide new hooks to
> it in struct security_operations?  Or is, perhaps, prctl() a better
> path (then I would have to request a hook on that in SElinux)?  How
> can I best avoid breaking causing any disruption to the rest of the
> kernel?

For SELinux, we had to drop our syscall and re-implement the API via:
- /proc/pid/attr for process attributes (getprocattr and setprocattr
hooks)
- xattr API for file attributes,
- selinuxfs (pseudo filesystem) for control and other operations.  These
days you would use securityfs (it didn't exist at the time selinuxfs was
created).

-- 
Stephen Smalley
National Security Agency

