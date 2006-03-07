Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752480AbWCGCJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbWCGCJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbWCGCJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:09:41 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54465 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752480AbWCGCJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:09:40 -0500
Subject: Re: [RFC][PATCH 2/6] sysvmsg: containerize
From: Dave Hansen <haveblue@us.ibm.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
In-Reply-To: <20060307015745.GG27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain>
	 <20060306235250.35676515@localhost.localdomain>
	 <20060307015745.GG27645@sorel.sous-sol.org>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 18:08:43 -0800
Message-Id: <1141697323.9274.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 17:57 -0800, Chris Wright wrote:
> * Dave Hansen (haveblue@us.ibm.com) wrote:
> > --- work/include/linux/init_task.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> > +++ work-dave/include/linux/init_task.h	2006-03-06 15:41:56.000000000 -0800
> > @@ -2,6 +2,7 @@
> >  #define _LINUX__INIT_TASK_H
> >  
> >  #include <linux/file.h>
> > +#include <linux/ipc.h>
> >  #include <linux/rcupdate.h>
> >  
> >  #define INIT_FDTABLE \
> 
> missing INIT_IPC_CONTEXT type of macro?

Yeah, I was doing something like that at first.  But, I decided to
dynamically allocate it, much like it will have to be done when we have
_real_ namespaces for it.  That means that we can't actually initialize
it at init_task.h time.  

> > diff -puN include/linux/sched.h~sysvmsg-container include/linux/sched.h
> > --- work/include/linux/sched.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> > +++ work-dave/include/linux/sched.h	2006-03-06 15:41:56.000000000 -0800
> > @@ -793,6 +793,7 @@ struct task_struct {
> >  	int link_count, total_link_count;
> >  /* ipc stuff */
> >  	struct sysv_sem sysvsem;
> > +	struct ipc_context *ipc_context;
> 
> how does this propagate on clone (presently it's just side-effect of
> dup_task_struct starting from init_task, with no dynamic lifetime),
> how is it meant to be changed?

Some interface later down the road.  You caught me a bit early in the
cycle.

> > -void __init msg_init (void)
> > +void __init msg_init (struct ipc_msg_context *context)
> >  {
> > -	ipc_init_ids(&msg_ids,msg_ctlmni);
> > +	ipc_init_ids(&context->ids,msg_ctlmni);
> >  	ipc_init_proc_interface("sysvipc/msg",
> >  				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
> > -				&msg_ids,
> > +				&context->ids,
> >  				sysvipc_msg_proc_show);
> 
> Does that mean /proc interface only gets init_task context?
> Along those lines, I think now ipcs -a is incomplete from admin
> perspective.  Suppose that's a feature from the container/vserver
> POV.

It will get context from the current task, which means the current
container.  We haven't quite decided how these things will be (or if
they need to be) aggregated on a a system-wide basis.

> > --- work/ipc/util.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> > +++ work-dave/ipc/util.h	2006-03-06 15:41:56.000000000 -0800
> > @@ -12,7 +12,7 @@
> >  #define SEQ_MULTIPLIER	(IPCMNI)
> >  
> >  void sem_init (void);
> > -void msg_init (void);
> > +void msg_init (struct ipc_msg_context *context);
> >  void shm_init (void);
> >  
> >  struct ipc_id_ary {
> > @@ -30,6 +30,18 @@ struct ipc_ids {
> >  	struct ipc_id_ary* entries;
> >  };
> >  
> > +struct ipc_msg_context {
> > +	atomic_t bytes;
> > +	atomic_t hdrs;
> > +
> > +	struct ipc_ids ids;
> > +	struct kref count;
> > +};
> > +
> > +struct ipc_context {
> > +	struct ipc_msg_context msg;
> > +};
> 
> This looks a little suspect.  ref count embedded in embedded object.
> My first thought was, sem and shared memory would introduce same, and
> now we'd have 3 independent refounts for top level object.  However,
> it's not used, and doesn't appear to be mirrored in the sem and shared
> mem contexts.  Perhaps it is just a leftover?

Yeah, I have the feeling that it used to be an atomic_t, and got
converted over to a kref a bit needlessly.  I'll investigate more when I
spin the patches again.

-- Dave

