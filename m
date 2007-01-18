Return-Path: <linux-kernel-owner+w=401wt.eu-S1751930AbXARErz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbXARErz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 23:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbXARErz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 23:47:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45195 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbXAREry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 23:47:54 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Cedric Le Goater <clg@fr.ibm.com>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, akpm@osdl.org, trond.myklebust@fys.uio.no,
       Linux Containers <containers@lists.osdl.org>
Subject: Re: NFS causing oops when freeing namespace
References: <57238.192.168.101.6.1169029688.squirrel@intranet>
	<m18xg1akmd.fsf@ebiederm.dsl.xmission.com>
	<51072.192.168.101.6.1169039633.squirrel@intranet>
	<20070117185823.GA878@tv-sign.ru> <45AE7705.4040603@fr.ibm.com>
	<20070117194632.GA1071@tv-sign.ru> <45AE87BC.4030404@fr.ibm.com>
	<m1d55d8ex3.fsf@ebiederm.dsl.xmission.com>
	<20070117225524.GA1572@tv-sign.ru>
Date: Wed, 17 Jan 2007 21:46:15 -0700
In-Reply-To: <20070117225524.GA1572@tv-sign.ru> (Oleg Nesterov's message of
	"Thu, 18 Jan 2007 01:55:24 +0300")
Message-ID: <m164b57xig.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 01/17, Eric W. Biederman wrote:
>>
>> Cedric Le Goater <clg@fr.ibm.com> writes:
>> >
>> > your first analysis was correct : exit_task_namespaces() should be moved 
>> > above exit_notify(tsk). It will require some extra fixes for nsproxy 
>> > though.
>> 
>> I think the only issue is the child_reaper and currently we only have one of
>> those.  When we really do the pid namespace we are going to have to revisit
>> this.  My gut feel says that we won't be able to exit our pid namespace until
>> the process is waited on.  So we may need to break up exit_task_namespace into
>> individual components.
>
> I agree, but please note that the child_reaper is not the only issue.

To be clear I believe the only issue keeping us from moving exit_namespaces
back where it used to be is the child reaper as that is the only part of
the pid namespace that has been implemented.  

There is more when we revisit this.
> Think
> about sub-thread which auto-reaps itself. I'd suggest to add the comment in
> do_exit() after exit_notify() to remind that the task is really dead now, it
> has no ->signal, it can't be seen in /proc/, we can't send a signal to it, etc.

A very interesting case is what happens when we reparent a zombie.  I think
that needs the child reaper and it happens well after exit_namespaces is currently
being called.

In the very stupid test we need our struct pid that identifies the process until
we are reaped.  Therefore our pid namespace must continue to exist, even if we
don't keep a pointer to it in struct nsproxy.

A comment after exit_notify would certainly be useful.

Eric
