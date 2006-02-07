Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWBGJPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWBGJPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWBGJPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:15:41 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17088 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932204AbWBGJPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:15:40 -0500
Message-ID: <43E86520.9070504@fr.ibm.com>
Date: Tue, 07 Feb 2006 10:15:12 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <20060203140229.GA16266@ms2.inr.ac.ru> <43E38D40.3030003@fr.ibm.com> <20060206094843.GA6013@ms2.inr.ac.ru>
In-Reply-To: <20060206094843.GA6013@ms2.inr.ac.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bonjour!

Alexey Kuznetsov wrote:

> [...]
>
> We could force each process visiting container to daemonize and to setsid().
> But do not forget that pid space is just a little part of the whole engine,
> to force full isolation we have to close all the files opened
> in root container, to get rid of its memory space before entering container
> etc. But it makes not so much of sense, because in any case we have to keep
> at least some way to communicate to host. F.e. even when we allow to pass
> only an open pipe, we immediately encounter the situation when a file
> owned by one container could refer to processes of another container.
> 
> So that, the only way to enforce full isolation is to prohibit
> "vzctl exec/enter" as whole.

containers are useful, even without migration. No doubt on that.

But, at the end, long long term probably, if we want to have a mobile
container under linux, we need to address all the issues from the start and
take them into account in the design. So, if we need to add some
constraints on the container init process (child reaper) or the resource
isolation, pid for example, to make sure a container is migratable, I think
we should start to think about it now.

By the time we reach that state, openvz would be have been rewritten a few
times already like any good software. nope ? :)

>>We've been living with the vpid approach also for years and we found issues
>>that we haven't solve at restart. So we think we might do a better job with
>>another. But, this still needs to be confirmed :)
>  
> What are the issues?

The one above.

Having containers which are not migratable because their execution
environment was not contrained enough is a pity I think.

Containers are useful for isolation but being able to swsuspend them and
migrate them is even more interesting ! and fun.

> The only inconvenience which I encountered until now
> is a little problem with stray pids. F.e. this happens with flock().
> Corresponding kernel structure contains some useless (actually, illegal
> and contradicting to the nature of flock()) reference to pid.
> If the process took the lock and exited, stray pid remains forever and points
> to nowhere. In this case it is silly to prohibit checkpointing,
> but we have to restore the flock to a lock with pointing to the same point
> in the sky, i.e. to nowhere. With (container, pid) approach we would
> restore it pointing to exactly the same empty place in the sky, with
> vpids we have to choose a new place. Ugly, but not a real issue.

thanks for your insights ! I hope we will have plenty of these issues to
talk about.

c.

