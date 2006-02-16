Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWBPRQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWBPRQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWBPRQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:16:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28578 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751385AbWBPRQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:16:54 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Hansen <haveblue@us.ibm.com>,
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
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	<m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	<20060216143030.GA27585@MAIL.13thfloor.at>
	<20060216153729.GB22358@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Feb 2006 10:13:43 -0700
In-Reply-To: <20060216153729.GB22358@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Thu, 16 Feb 2006 09:37:29 -0600")
Message-ID: <m1wtfvp6pk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Herbert Poetzl (herbert@13thfloor.at):
>> > - Should a process have some sort of global (on the machine identifier)?
>> 
>> this is mandatory, as it is required to kill any process
>> from the host (admin) context, without entering the pid
>> space (which would lead to all kind of security issues)
>
> Just to be clear: you think there should be cases where pspace x can
> kill processes in pspace y, but can't enter it?
>
> I'm not convinced that grounded in reasonable assumptions...

Actually I think it is.  The admin should control what is running
on their box.

>> > - Should we be able to monitor a pid space from the outside?
>> 
>> yes, definitely, but it could happen via some special
>> interfaces, i.e. no need to make it compatible
>
> What sort of interfaces do you envision for these two?  If we
> can lay them out well enough, maybe the result will satisfy the
> openvz folks?
>
> For instance, perhaps we just use a proc interface, where in the
> current pspace, if we've created a new pspace which in our pspace
> is known as process 567, then we might see
>
> /proc
> /proc/567
> /proc/567/pspace
> /proc/567/pspace/1 -> link to /proc/567
> /proc/567/pspace/2
>
> Now we also might be able to interact with the pspace by doing
> something like
>
> 	echo -9 > /proc/567/pspace/2/kill
>
> and of course do things like
>
> 	cd /proc/567/pspace/1/root

Actually I think this is the model we need to investigate if we
need to extend the interface to handle new things.

By using the filesystem it allows things to be cobbled together with
scripts so new C programs are not required.  

It happens that Plan9 does it this way successfully, so there is some
precedent.

Actually increasingly I like this notion, as it also allows us to
export the ability to kill a process with a network filesystem.
Which means multiple machine management in a cluster could easily
reduce to the same set of tools as multiple pid space management.

>> > - After migration what identifiers should the tasks have?
>> 
>> doesn't matter, as long as they are unique, so
>>  ppid1/ppid2/ppid3/pid would work ...
>
> And where are we talking about?  Is this an identifier for userspace
> tools?  Or just in kernelspace?

The point seems to be that the identifiers don't matter just
so long as there is one.

Eric
