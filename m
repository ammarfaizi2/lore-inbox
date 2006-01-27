Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWA0JGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWA0JGW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWA0JGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:06:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47554 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932430AbWA0JGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:06:20 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Arjan van de Ven <arjan@infradead.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	<CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com>
	<m18xt8mffq.fsf@ebiederm.dsl.xmission.com>
	<1137945325.3328.17.camel@laptopd505.fenrus.org>
	<m14q3wmds4.fsf@ebiederm.dsl.xmission.com>
	<20060126200142.GB20473@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 27 Jan 2006 02:04:21 -0700
In-Reply-To: <20060126200142.GB20473@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Thu, 26 Jan 2006 21:01:42 +0100")
Message-ID: <m1d5ieghyi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> well, yes, but wouldn't that be the RightThing(tm) 
> anway? because 'referencing' something via a pid, then
> letting the task holding the pid go away and even be
> replaced by a new one (with the same pid) which then
> will get suddenly signaled from somewhere, just because
> the pid matches seems very broken to me ...

Agreed, but that describes the current state of the kernel.

Using a task_struct for referencing kernel threads where there
is tight collaboration seems sane.  However using a task_struct
is impossible when referring to process groups, and it feels
like a bad idea to reference user space processes.

Basically my concern is that by using task structs internally
the kernel will start collecting invisible zombies.  And
with a case like struct fown_struct we could force RLIMIT_NOFILE task
structs into memory, per hostile process.  Usually this is much more
than RLIMIT_NPROC which limits the total number of live processes
and zombies a single user may create.

So assuming RLIMIT_NPROC == 100 and RLIMIT_NOFILE == 1024

Which means something like 100*1024*sizeof(struct task_struct) bytes
sizeof(struct task_struct) is somewhere between 512 and 1K bytes,
on a 32bit platform.

So 100*1024*512 to 100*1024*1024 = 50 to 100MB.
Being able to pin 100MB with modest ulimits does not sound like an
obvious fix to me.

Given what a hostile user can potentially accomplish I think anything that
approaches using struct task_struct pointers as a replacements for pids
should be approached carefully.

Eric

