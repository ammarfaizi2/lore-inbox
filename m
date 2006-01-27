Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWA0NR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWA0NR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWA0NQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:16:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1222 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750883AbWA0NQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:16:57 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       Arjan van de Ven <arjan@infradead.org>,
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
	<m1d5ieghyi.fsf@ebiederm.dsl.xmission.com>
	<64FD72B7-91BF-4FEF-A595-0978F361A581@mac.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 27 Jan 2006 06:15:50 -0700
In-Reply-To: <64FD72B7-91BF-4FEF-A595-0978F361A581@mac.com> (Kyle Moffett's
 message of "Fri, 27 Jan 2006 07:27:43 -0500")
Message-ID: <m18xt1hkvt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Jan 27, 2006, at 04:04, Eric W. Biederman wrote:
>> Basically my concern is that by using task structs internally the kernel will
>> start collecting invisible zombies.
>
> So come up with a task_struct weakref system.  Maintain an (RCU?)  linked list
> of struct task_weakref in the struct task_struct, and  when the task struct is
> about to go away, run around all of the  weakrefs and change their pointers to
> NULL.  The user of the weakref  should check if the pointer is NULL and handle
> accordingly.  Sure, it  would be tricky to get the locking right, but a couple
> extra bytes for a struct task_weakref would be a lot better than a whole pinned
> struct task_struct.

Right.

I'm working on it.

Somehow it was lodged in my mind that a task_struct cannot represent
a process group, but it can obviously be the first in a link list.
Because of that I so far I have been approaching the weak reference
problem from the pid hash table side.  While using pid hash tables
can come out fairly clean, my best solution so far doubled the size
of the pid hash table.

I have two things that still concern me.
- The size of the linked list in pathological cases.
- Consistently picking a leader for a process group.

But I don't know if either one of them will actually be a problem,
so I think I will walk down that implementation path and see where
it takes me.

Eric
