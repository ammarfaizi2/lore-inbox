Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVBUKdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVBUKdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBUKdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:33:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:48550 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261914AbVBUKdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:33:06 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>,
       Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050221014728.6106c7e1.pj@sgi.com>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	 <1108655454.14089.105.camel@uganda>
	 <1108969656.8418.59.camel@frecb000711.frec.bull.fr>
	 <20050221014728.6106c7e1.pj@sgi.com>
Date: Mon, 21 Feb 2005 11:33:01 +0100
Message-Id: <1108981982.8418.120.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 11:41:53,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 11:41:55,
	Serialize complete at 21/02/2005 11:41:55
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-21 at 01:47 -0800, Paul Jackson wrote:
> Guillaume wrote:
> > The problem is the following: I have a user space daemon that manages
> > group of processes. The main idea is, if a parent belongs to a group
> > then its child belongs to the same group.  To achieve this I need to know
> > when a fork occurs and which processes are involved. I don't see how to
> > do this without a hook in the do_fork() routine...
> 
> How is what you need, for process grouping, any more complex than
> another sort of {bank, job, aggregate, session, group, ...} integer id
> field in the task struct, that is copied on fork, and can be queried and
> manipulated from user space, in accordance with whatever rules you
> implement?

If a process belongs to several group of processes, an new integer in
the task_struct is not enough, you need a list or something like this.
If you're using a list you need to add function to manage this list in
the kernel but we don't want to add this kind of management inside the
kernel because with the fork connector we can keep it outside.
 
> When I look at the elsacct_process_copy() routine, which is called from
> fork, in your patch-2.6.8.1-elsa, I'm not sure what it does, but it sure
> looks like it could cause scaling and performance problems.  

This patch is an old one with many kernel modifications that impacts the
Linux performance. That's why we thought about another solution where
all management is done by a user space daemon. Currently we're using the
fork connector.

> Does your user space daemon require to know about each task as it is
> forked, in near real time? Is it trying to do something with this
> accounting information while the tasks being accounted for are
> necessarily still alive?  

I don't need real time. I just need to know which process forks during
the accounting period. The user space daemon provided by ELSA just keeps
a trace of parents and its children during a given period (generally
it's the accounting period). The analysis will be done later by another
application (also provided by ELSA) by using the trace of parents and
children plus the accounting trace. 

> The main problems I was aware of with that classic accounting (which
> is probably what is now known as BSD accounting) are:
> ... [cut here] ...
>   2) An additional bank/job/aggregate/session/group/... id seems desired.
>      I have yet to understand why this need be anything fancier than
>      another integer field in the task struct.

We're trying to solve this one. I think that I answer to the integer
field problem. For the necessity of the per-group accounting, it can be
interesting to do accounting on a specific "task". For example if you
want to have accounting data for a compilation you can add the
corresponding shell in a group of processes and commands involved in the
compilation like gcc, cc, as, collect2, ... will be automatically added
in the same group and you will be able to get statistics about this
compilation.

>   3) Probably some more data items are worth collecting -- which could
>      be placed in the outgoing compressed data stream, along with the
>      existing records written on task exit.  Over time, appropriate
>      hooks should be proposed to collect such data as seems needed.

There is a discussion about this with Jay Lan to merge the CSA and BSD
accounting framework. 

I don't know if there is some work around 1) and 4). 

Regards,
Guillaume

