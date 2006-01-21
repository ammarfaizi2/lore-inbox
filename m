Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWAUKFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWAUKFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWAUKFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:05:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48084 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750997AbWAUKFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:05:14 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       "Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" 
	<haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC: Multiple instances of kernel namespaces.
References: <43CD18FF.4070006@FreeBSD.org>
	<1137517698.8091.29.camel@localhost.localdomain>
	<43CD32F0.9010506@FreeBSD.org>
	<1137521557.5526.18.camel@localhost.localdomain>
	<1137522550.14135.76.camel@localhost.localdomain>
	<1137610912.24321.50.camel@localhost.localdomain>
	<1137612537.3005.116.camel@laptopd505.fenrus.org>
	<1137613088.24321.60.camel@localhost.localdomain>
	<1137624867.1760.1.camel@localhost.localdomain>
	<m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com>
	<20060120201353.GA13265@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 21 Jan 2006 03:04:16 -0700
In-Reply-To: <20060120201353.GA13265@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Fri, 20 Jan 2006 14:13:53 -0600")
Message-ID: <m13bjhoq1r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> 
>> At this point I have to confess I have been working on something
>> similar, to IBM's pid virtualization work.  But I have what is at
>> least for me a unifying concept, that makes things easier to think
>> about.
>> 
>> The idea is to think about things in terms of namespaces.  Currently
>> in the kernel we have the fs/mount namespace already implemented.
>> 
>> Partly this helps on what the interface for creating a new namespace
>> instance should be.  'clone(CLONE_NEW<NAMESPACE_TYPE>)', and how
>> it should be managed from the kernel data structures.
>> 
>> Partly thinking of things as namespaces helps me scope the problem.
>> 
>> Does this sound like a sane approach?
>
> And a bonus of this is that for security and vserver-type applications,
> the CLONE_NEWPID and CLONE_NEWFS will often happen at the same time.
>
> How do you (or do you?) address naming namespaces?  This would be
> necessary for transitioning into an existing namespace, performing
> actions on existing namespaces (i.e. checkpoint, migrate to another
> machine, enter the namespace and kill pid 521), and would just be
> useful for accounting purposes, i.e. how else do you have a
> "ps --all-namespaces" specify a process' namespace?

So I address naming indirectly.  The last thing I want to have
is to add yet another namespace to the kernel for naming namespaces.
We have enough namespaces already.

In any sane context for a pid-namespace we need a pid that
we can call waitpid on, so we don't break the process tree.
Which means at least the init process has 2 pids, one
that it's parent sees, and another (1) that it and it's
children see.

So I name pidspaces like we do sessions of process groups
and sessions by the pid of the leader.

So in the simple case I have names like:
1178/1632

> Doubt we want to add an argument to clone(), so do we just add a new
> proc, sysfs, or syscall for setting a pid-namespace name?

That shouldn't be necessary.

> Do we need a new syscall for transitioning into an existing namespace?

That is a good question.  The FS namespaces that we already have
has much the same problem.  A completely different solution to
this problem seems to have been implemented but I don't grasp it
yet.

Inherently transitioning to an existing namespace is something
that is straight forward to implement, so it is worth thinking
about.

If I want a guest that can keep secrets from the host sysadmin I don't
want transitioning into a guest namespace to come too easily.

Currently I can always just create an extra child of pid 1
that I will be my slave.  The problem is that this is an extra
process laying around.

Eric
