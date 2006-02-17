Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWBQNkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWBQNkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWBQNkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:40:03 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:15322 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964912AbWBQNkB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:40:01 -0500
Message-ID: <43F5D227.8020105@watson.ibm.com>
Date: Fri, 17 Feb 2006 08:39:51 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
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
References: <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com> <20060216175326.GA11974@sergelap.austin.ibm.com> <m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com> <20060216184407.GC11974@sergelap.austin.ibm.com> <1140115979.21383.11.camel@localhost.localdomain> <m1bqx6p815.fsf@ebiederm.dsl.xmission.com> <20060217114441.GA17940@MAIL.13thfloor.at> <m1vevenptl.fsf@ebiederm.dsl.xmission.com> <20060217124411.GB17940@MAIL.13thfloor.at>
In-Reply-To: <20060217124411.GB17940@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> On Fri, Feb 17, 2006 at 05:16:06AM -0700, Eric W. Biederman wrote:
> 
>>Herbert Poetzl <herbert@13thfloor.at> writes:
>>
>>
>>>On Fri, Feb 17, 2006 at 03:57:26AM -0700, Eric W. Biederman wrote:
>>>
>>>>As for that.  When I mad that suggestion to Herbert Poetzl 
>>>>his only concern was that a smart init might be too heavy weight 
>>>>for lightweight vserver.  Generally I like the idea.
>>>
>>>well, may I remind that this solution would require _two_
>>>init processes for each guest, which could easily make up
>>>300-400 unnecessary processes in a lightweight server
>>>setup?
>>
>>I take it seriously enough that I remembered the concern,
>>and I think it is legitimate.  Figuring out how to safely
>>set the policy is a challenge.  That is something a
>>user space daemon trivially gets right.  
>>
>>The kernel side of a process is about 10K if the user space
>>side was also lightweight we could have the entire
>>per process cost in the 30K range.  30K*400 = 12000K = 12M.
> 
> 
> that's something I'm not so worried about, but a statically
> compiled userspace process with 20K sounds unusual in the
> time of 2M *libcs :)
> 
> 
>>That is significant but we are still cheap enough that it
>>isn't necessarily a show stopper.
>>
>>I think the cost was only one extra process, for the case where you
>>have fakeinit now it would be init, for other cases it would be a
>>daemon that gets setup when you initialize the vserver.
> 

Eric, Herbert.. why do we need an extra process in each and every
pspace.

Why not have single global pspace-init daemon that acts as the reaper
for all pspace-top processes.
Its only at the boundaries of pspaces and with signals were we
seem to have trouble.

The "pspace-init" reaps the signal of all its sub-pspace's top processes
and then "forwards" the signal to processes actually waiting.
Kind of an interposer.
Same way from the other side.

You allocate a pid on behalf of the process you spawn in your pidspace.
You mark in the pid hash of the lookup that this is merely a proxy
and you forward that to the pspace-init where you have a separate lookup
with <pspace-caller,pspace,pid>.

Same with signals, once the signal is reaped by pspace-init and its looked
up who is the parent pspace and the pid in there, we forward it..

Is something like that workable, idiotic (be kind), too intrusive ?

-- Hubertus


> 
> well, depends, currently we do not need a parent to handle
> the guest, so there is _no_ waiting process in the light-
> weight case either, which makes that two processes for each
> guest, no?
> 
> anyway, I'm not strictly against having an init process
> inside a guest, as long as it is not an essential part
> of the overall design, because that would make it much
> harder to rip it out later :)
> 
> best,
> Herbert
> 
> 

