Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWAVQY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWAVQY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 11:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWAVQY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 11:24:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45286 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751286AbWAVQY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 11:24:56 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	<CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com>
	<m18xt8mffq.fsf@ebiederm.dsl.xmission.com>
	<1137945325.3328.17.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 22 Jan 2006 09:24:27 -0700
In-Reply-To: <1137945325.3328.17.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Sun, 22 Jan 2006 16:55:25 +0100")
Message-ID: <m14q3wmds4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

>> 
>> A pointer to a task_struct while it kind of sort of works.  Is not
>> a good solution.  The problem is that in a lot of cases we register
>> a pid to get a signal or something similar and then we never unregister
>> it.  So by using a pointer to a trask_struct you effectively hold the
>> process in memory forever.
>
> this is not right. Both the PID and the task struct have the exact same
> lifetime rules, they HAVE to, to guard against pid reuse problems.

Yes PIDs reserved for the lifetime of the task_struct (baring minor
details).  There are actually a few races in /proc where it can
see the task_struct after the pid has been freed (see the pid_alive macro
in sched.h)

However when used as a reference the number can live as long as you
want.  The classic example is a pid file that can exist even after
you reboot a machine.

So currently a use of a PID as a reference to processes or process
groups can last forever.  An example of this is the kernel is
the result of fcntl(fd, F_SETOWN).  The session of a tty is similar.

Since the in kernel references have a lifetime that is completely
different than the lifetime of a process or a PID.  It is
not safe to simply replace such references with a direct reference
to a task_struct (besides being technically impossible).  Adding
those references could potentially increase the lifespan of a task_struct
for to the life of the kernel depending on the reference.

Eric
