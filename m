Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318111AbSGROzF>; Thu, 18 Jul 2002 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318112AbSGROzE>; Thu, 18 Jul 2002 10:55:04 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:13944 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S318111AbSGROzC>; Thu, 18 Jul 2002 10:55:02 -0400
Date: Thu, 18 Jul 2002 09:57:53 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207181457.JAA28291@tomcat.admin.navo.hpc.mil>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Groups beyond 32
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Followup to:  <1026936556.25347.48.camel@UberGeek>
> By author:    Austin Gonyou <austin@digitalroadkill.net>
> In newsgroup: linux.dev.kernel
> > 
> > The problem now is more one of maintenance. Most distributions do not
> > support groups > 32 AFAIK. So, it's lead me to ask the following
> > questions:
> > 
> > 1. Why, in general, is the limit so low? 
> >    For specific application, mainly auditing and such, this would be    
> >    advantageous I think.
> > 
> 
> Mostly to cap the amount of storage to maintain in kernel space, and
> for historical reasons.

a. NFS v2 allows a maximum of 16 groups
b. NFS v3 allows 32.

Other distributed file systems have limits of one or the other.

> > 2. What is required to limit the dependence on groups to just GLIBC or
> > just the kernel? Is that even possible?
> 
> The main problem is programs who do things like:
> 
> gid_t mygroups[NGROUPS];
> 
> Other than that, it should all be in kernel space.  According to
> POSIX, the NGROUPS above really should be sysconf(_SC_NGROUPS_MAX) --
> NGROUPS_MAX is defined as a *guaranteed minimum* of
> sysconf(_SC_NGROUPS_MAX).  Obviously there needs to be a kernel ->
> libc interface for the sysconf.
> 
> FWIW, POSIX specifies:
> 
>       Application writers should note that {NGROUPS_MAX} is not
>       necessarily a constant on all implementations.

The application is "supposed" to ask for the number of groups before
getting the array - something like the following:

	size_t	len = 0;
	gid_t	*list = NULL;
	len = getgroups(0, list);
	list = (gid_t *)calloc(sizeof(gid_t),len);
	len = getgroups(len,list);

This still doesn't address the problem with network filesystems where
access control depends on the list of groups being passed to the server.
 
> (glibc has #define NGROUPS NGROUPS_MAX).
> 
> > 3. Is there any true advantage to supporting more than 32 groups, or
> > creating "meta-groups" to get around the problem? 
> 
> There probably is.

Not to my knowlege - there ARE several disadvantages:

1. kernel table size would most likely have to be dynamic instead of static
2. searching the table is n/2 operation. The larger the table, the longer
   the time spent searching.
3. distributed file system limitations.
4. Groups were not designed for general purpose access control. They were
   supposed to support "project" level access. Most HR research had/has
   shown that a person can't really keep track of more than about 5 projects
   (tasks?) at a time. More than that tends to cause accidents in group
   ownership of files (and hence information leaks from one project to
   another).

ACLs would work much better for access control. "meta-groups" are normally
called "compartments", and are part of a mandatory access control. And,
unfortunately, not yet supported by distributed file system RFC specifications

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
