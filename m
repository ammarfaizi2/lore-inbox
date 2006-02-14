Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWBNF5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWBNF5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWBNF5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:57:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48365 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932347AbWBNF5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:57:21 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
 process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
	<m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 13 Feb 2006 22:54:14 -0700
In-Reply-To: <43F04FD6.5090603@sw.ru> (Kirill Korotaev's message of "Mon, 13
 Feb 2006 12:22:30 +0300")
Message-ID: <m1wtfytri1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>1.
>>>flags are neither atomic nor protected with any lock.
>> flags are atomic as they are a machine word.  So they do not
>> require a read/modify write so they will either be written
>> or not written.  Plus this allows write-sharing of the appropriate
>> cache line which is very polite (assuming the line is not shared with
>> something else)
> Eric I'm familiar with SMP, thanks :)
> Why do you write all this if you agreed below that have problems with it?

To establish a baseline of understanding and because you made an assertion
that is counter to my understanding.

>>>2. due to 1) you code is buggy. in this respect do_exit() is not serialized
> with
>>>copy_process().
>> Yes. I may need a memory barrier in there.  I need to think
>> about that a little more.
> memory barrier doesn't help. you really need to think about.

Except for instances where you need an atomic read/modify/write the
only primitives you have are reads, writes and barriers. 

I have all of the correct reads and writes therefore the only thing
that could help are barriers if the logic is otherwise sane.

A write barrier to ensure the write of flags is visible before I write
the kill signal will ensure the write of flags is globally visible
first.  Although I am having a hard time convincing myself even that
matters.

>>>3. due to the same 1) reason
>>> > +		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
>>>can miss a task being forked. Bang!!!
>>
>> Well the only bad thing that can happen is that I get a process that
>> can run and observe pid == 1 has exited.  So Bang!! is not too
>> painful.
> And what about references to pspace->child_reaper which was freed already?

The assumes that release_task() is called synchronously with do_exit
which is not the case.  Looking at the code I do think release_task()
for the pspace leader can be called too soon.  But that is really
has nothing to do with whether or not all of it's children got sent
SIGKILL.

That is a significant issue, that needs to be fixed before I submit
this piece of code for inclusion into the kernel.

The issue is depending on the context is that a process actively running
in kernel space could proceed for a long time before it returns to user
space and receives a signal.  In that span of time it could execute just
about any code in the kernel.

Kirill thank you for spotting this.  

This exchange seems to have a hostile and not a cooperative tone so
I will finish the investigation and bug fixing elsewhere.


I expect that there might be a few more issues like this.  My only
expectation was that the code was complete enough to discuss semantics
and kernel mechanisms for creating a namespaces, and the code has
successfully served that purpose.

Eric








