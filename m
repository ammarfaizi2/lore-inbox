Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVBUOoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVBUOoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVBUOoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:44:10 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:8893 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261746AbVBUOn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:43:58 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>,
       Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050221035808.48401cd2.pj@sgi.com>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	 <1108655454.14089.105.camel@uganda>
	 <1108969656.8418.59.camel@frecb000711.frec.bull.fr>
	 <20050221014728.6106c7e1.pj@sgi.com>
	 <1108981982.8418.120.camel@frecb000711.frec.bull.fr>
	 <20050221035808.48401cd2.pj@sgi.com>
Date: Mon, 21 Feb 2005 15:43:53 +0100
Message-Id: <1108997033.8418.193.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 15:52:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 15:52:48,
	Serialize complete at 21/02/2005 15:52:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-21 at 03:58 -0800, Paul Jackson wrote: 
> >     It's a new patch that implements a fork connector in the
> > kernel/fork.c:do_fork() routine. The connector sends information about
> > parent PID and child PID over a netlink interface. It allows to several
> > user space applications to be alerted when a fork occurs in the kernel.
> 
> Whoaa ... you're saying that because you might have several groups a
> task could belong to at once, you'll use netlink to avoid managing lists
> in the kernel.  Seems that you're spending thousands of instructions to
> save dozens.  This is not a good trade off.

  I understand your point of view but I'm using netlink interface
because it's already in the kernel so my choice is to use something that
is already in the kernel instead of adding dozens of new instructions
and also to do things in user space. The fork connector is here to move
the management in the user space. Otherwise there is PAGG that manages
group of processes in the kernel. To test performances, I tried to
compile a kernel several times with and without the fork connector and
here are the resource usage computed with the following command:
        
time /bin/sh -c 'make O=/home/guill/build/k2610 oldconfig   \
                 && make O=/home/guill/build/k2610 bzImage  \
                 && make O=/home/guill/build/k2610 modules'

between each test, the directory that contains object files was
destroyed and a 'sync' was done. 

Results are:

  kernel without fork connector
    real : 8m17.042s 8m10.113s 8m08.597s 8m10.068s 8m08.930s
    user : 7m32.376s 7m35.985s 7m34.424s 7m34.221s 7m34.835s
    sys  : 0m50.730s 0m51.139s 0m51.159s 0m51.406s 0m51.020s    

  kernel with the fork connector
    real : 8m14.492s 8m08.656s 8m07.754s 8m08.002s 8m07.854s
    user : 7m31.664s 7m33.528s 7m33.625s 7m33.500s 7m33.822s
    sys  : 0m50.651s 0m51.222s 0m51.102s 0m51.367s 0m50.894s
   
  kernel with the fork connector + application listens
    real : 8m08.596s 8m08.950s 8m08.899s 8m08.678s 8m08.987s
    user : 7m33.312s 7m33.898s 7m34.004s 7m33.285s 7m33.628s
    sys  : 0m52.222s 0m52.013s 0m51.809s 0m52.361s 0m52.036s


  I also choose this implementation because Erich Focht wrote in the
email http://lkml.org/lkml/2004/12/17/99 that keeps the historic about
the creation of processes "sounds very useful for a lot of interesting
stuff". So I thought about something that can be used by other
application and with netlink, information is available to everyone. 

> I can imagine several way cheaper ways to handle this.
> 
> If the number of groups to which a task could belong has some small
> finite upper limit, like at most 5 groups, you could have 5 integer id's
> in the task struct instead of 1.  If the number of elements in a
> particular group has a small upper bound, you could even replace the
> ints with bit fields.
> 
> Or you could enumerate the different combinations of groups to which a
> task might belong, assign each such combination a unique integer, and
> keep that integer in the task struct.  The enumeration could be done
> dynamically, only counting the particular combinations of group
> memberships that actually had use.  This has the disadvantage that a
> particular combination, once enumerated, would have to stay around until
> the next boot - a potential memory leak.  Probably not acceptable,
> unless the cost of storing a no longer used combination is nearly zero.

  The problem with those solutions is that we suppose that a process can
belong to a finite number of task. I suppose that it can be true in
practice.

> Or you could have a little 'jobids' struct that held a list and a
> reference counter, where the list held a particular combination of ids,
> and the reference counter tracked how many tasks referenced that jobids
> struct. Put a single pointer in the task struct to a jobids struct, and
> increment and decrement the reference counter in the jobids struct on
> fork and exit.  Free it if the count goes to zero on exit.  This solves
> the memory leak of the previous, with increased cost to the fork.  Since
> we really do design these systems to stay up 'forever', this is perhaps
> the winner.  Any time a particular task is added to, or removed from, a
> group, if the ref count of its jobids struct is one, then modify the id
> list attached to that jobids struct in place.  If the ref count is more
> than one, copy the jobids struct and list to a new one, decrement the
> count in the old one, and modify the new one in place.  Such list and
> counter manipulations are the daily stuff of kernel code.  No need to
> avoid such.

  This solution is interesting. The problem is to know if a fork
connector is useful for some other projects. As I said, one of my goal
was to provide a way to alert user space application when a fork occurs
in the kernel because I think that other applications need this kind of
information. But if it is needed only by ELSA, you're right, a solution
specific to our problem is clearly more efficient.

> Just because you have more than one id doesn't mean each task has to be
> connected directly into its own custom list, and even if you needed
> that, I don't see that it's a win to avoid such a list by using netlink.

  The advantages with the fork connector is that it can be used by other
application and modification in the current kernel is minimal. The main
drawbacks is maybe the performance...

So nobody needs such hook (Erich?)

Thank Paul for your comments,
Guillaume

