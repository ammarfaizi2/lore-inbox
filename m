Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWCSPhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWCSPhp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWCSPhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:37:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19609 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932113AbWCSPho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:37:44 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 2/6] sysvmsg: containerize
References: <20060306235248.20842700@localhost.localdomain>
	<20060306235250.35676515@localhost.localdomain>
	<20060307015745.GG27645@sorel.sous-sol.org>
	<1141697323.9274.64.camel@localhost.localdomain>
	<20060307023445.GI27645@sorel.sous-sol.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 08:36:42 -0700
In-Reply-To: <20060307023445.GI27645@sorel.sous-sol.org> (Chris Wright's
 message of "Mon, 6 Mar 2006 18:34:45 -0800")
Message-ID: <m1r74ywinp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

> * Dave Hansen (haveblue@us.ibm.com) wrote:
>> On Mon, 2006-03-06 at 17:57 -0800, Chris Wright wrote:
>> > * Dave Hansen (haveblue@us.ibm.com) wrote:
>> > > -void __init msg_init (void)
>> > > +void __init msg_init (struct ipc_msg_context *context)
>> > >  {
>> > > -	ipc_init_ids(&msg_ids,msg_ctlmni);
>> > > +	ipc_init_ids(&context->ids,msg_ctlmni);
>> > >  	ipc_init_proc_interface("sysvipc/msg",
>> > > " key msqid perms cbytes qnum lspid lrpid uid gid cuid cgid stime rtime
> ctime\n",
>> > > -				&msg_ids,
>> > > +				&context->ids,
>> > >  				sysvipc_msg_proc_show);
>> > 
>> > Does that mean /proc interface only gets init_task context?
>> > Along those lines, I think now ipcs -a is incomplete from admin
>> > perspective.  Suppose that's a feature from the container/vserver
>> > POV.
>> 
>> It will get context from the current task, which means the current
>> container.  We haven't quite decided how these things will be (or if
>> they need to be) aggregated on a a system-wide basis.
>
> The /proc interface is registering with &context->ids of init_task.  So,
> all other contexts using that interface will be looking at the wrong
> info, AFAICT.

We need to make this per process in /proc to get it right.
So /proc/sysvipc becomes a symlink to /proc/<pid>/sysvipc.

> As you can tell my concerns are in resource consumption.  If a user can
> create contexts which it can hide from sysadmin, and they aren't subject
> to sysadmin mandated resource limits, it's effectively a leak, esp. since
> these resources don't die with exit(2).

I haven't spotted it yet in Dave's series but this is something that should
happen when all of the tasks using the ipc_context in this case exit.

Eric
