Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWBQLMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWBQLMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBQLMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:12:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38572 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751080AbWBQLMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:12:15 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
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
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	<m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	<20060216142928.GA22358@sergelap.austin.ibm.com>
	<m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
	<20060216175326.GA11974@sergelap.austin.ibm.com>
	<m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com>
	<20060216184407.GC11974@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 17 Feb 2006 04:04:20 -0700
In-Reply-To: <20060216184407.GC11974@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Thu, 16 Feb 2006 12:44:07 -0600")
Message-ID: <m17j7up7pn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> >> What happens when you migrate pspace 3 into a different pspace
>> >> on a different machine?
>> >
>> > Nothing special.  "Migrate" was just a checkpoint (from pspace 1)
>> > and a resume (from pspace N on some machine).  So now pspace N on
>> > the new machine has created a new pspace - which happens to be
>> > immediately populated with the contents of the old pspace 3 - and
>> > see the pid of the init process of this new pspace.
>> >
>> >> Is there a sane implementation for this?
>> >
>> > IMO, definately yes.
>> >
>> > But I haven't tried it, so my opinion is just that.
>> 
>> If you are just talking the pid of the init process the problem seems
>> tractable.
>> 
>> Where I see real problems with migration is and nested pid spaces
>> is when you expose all of your pids to your parent, and perhaps
>> there was some miscommunication on this point.
>> 
>> To try and give an example.
>> 
>> pspace 1        pspace 2      pspace 3      pspace 4
>>      pid 234 ->      pid 1    
>>      pid 235 ->      pid 2 ->      pid 1
>>      pid 236 ->      pid 3 ->      pid 2 ->      pid 1
>> 
>> Hopefully this clearly shows what I was trying to avoid, by
>> only allow pid 1 of any pspace to be visible in the parent.
>
> Yes, I saw it more like:
>
>> pspace 1        pspace 2      pspace 3      pspace 4
>>      pid 234 ->      pid 1    
>>                      pid 2 ->      pid 1
>>                                    pid 2 ->      pid 1
>>                      pid 3

I kind of figured.  I just wanted it to be clear why I have
a problem with the semantics of the current VPID implementation.
Especially as the tone of the post from the last day or two
was:  Can't we satisfy everyone?

The picture you drew is all that is required for my implementation
and it doesn't run into problems because you only need one PID in
your parent pspace.

Eric
