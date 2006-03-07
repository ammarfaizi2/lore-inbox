Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWCGCa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWCGCa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWCGCa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:30:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14211 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932619AbWCGCa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:30:28 -0500
Date: Mon, 6 Mar 2006 18:34:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 2/6] sysvmsg: containerize
Message-ID: <20060307023445.GI27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain> <20060306235250.35676515@localhost.localdomain> <20060307015745.GG27645@sorel.sous-sol.org> <1141697323.9274.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141697323.9274.64.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen (haveblue@us.ibm.com) wrote:
> On Mon, 2006-03-06 at 17:57 -0800, Chris Wright wrote:
> > * Dave Hansen (haveblue@us.ibm.com) wrote:
> > > -void __init msg_init (void)
> > > +void __init msg_init (struct ipc_msg_context *context)
> > >  {
> > > -	ipc_init_ids(&msg_ids,msg_ctlmni);
> > > +	ipc_init_ids(&context->ids,msg_ctlmni);
> > >  	ipc_init_proc_interface("sysvipc/msg",
> > >  				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
> > > -				&msg_ids,
> > > +				&context->ids,
> > >  				sysvipc_msg_proc_show);
> > 
> > Does that mean /proc interface only gets init_task context?
> > Along those lines, I think now ipcs -a is incomplete from admin
> > perspective.  Suppose that's a feature from the container/vserver
> > POV.
> 
> It will get context from the current task, which means the current
> container.  We haven't quite decided how these things will be (or if
> they need to be) aggregated on a a system-wide basis.

The /proc interface is registering with &context->ids of init_task.  So,
all other contexts using that interface will be looking at the wrong
info, AFAICT.

As you can tell my concerns are in resource consumption.  If a user can
create contexts which it can hide from sysadmin, and they aren't subject
to sysadmin mandated resource limits, it's effectively a leak, esp. since
these resources don't die with exit(2).

thanks,
-chris
