Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbUAODJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 22:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUAODJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 22:09:23 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:25530 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S264575AbUAODJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 22:09:12 -0500
Message-Id: <5.1.1.5.2.20040115140133.02df3908@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 15 Jan 2004 14:06:18 +1100
To: Robin Holt <holt@sgi.com>
From: auntvini <auntvini@sedal.usyd.edu.au>
Subject: Re: uid-Another Problem in writing to /proc/loadavg file
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040114114900.GB14674@lnx-holt>
References: <40050883.30000@sedal.usyd.edu.au>
 <400406CB.50607@sedal.usyd.edu.au>
 <20040113120727.GB7506@lnx-holt>
 <40050883.30000@sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

That is done and the name of the new file is /proc/loadavgus. I hope that 
does not sound like usa.

Never mind the data is being collected without any problem.

Thanks
Sena Seneviratne
Computer Engineering Lab
Sydney University

At 05:49 AM 1/14/2004 -0600, you wrote:
>On Wed, Jan 14, 2004 at 08:14:43PM +1100, sena wrote:
> > Hi Robin,
> >
> > Thanks for the reply and for your time.
> >
> > My previous observation about hanging on is not correct. There is no
> > hanging on whatsoever.
> >
> > I had put some printks in my kernel code and according to them the load
> > averages per user are being calculated correctly.
> >
> > I found the values in /var/log/messages
> >
> > This means my calculation code every 5 seconds do their part.
> >
> >
> > I find the problem with the writing to /proc/loadavg file.
>
>Did you specify your read handler in the create_proc_read_entry() call?
>If you didn't use create_proc_read_entry, you need to point the resulting
>file structures read handler to your read routine.
>
>You should probably not use /proc/loadavg.  It is an already existing
>file.  Try using your own directory with seperate read handler(s).
>Maybe something like /proc/loadavg_per_user/<uid> which gives the
>load averages per user.
>
>Good Luck,
>Robin
> >
> > My loadavg file is empty. ?
> > (I experienced this situation only with this compilation.)
> >
> >
> > Thanks
> >
> > Sena Seneviratne
> > Computer Engineering Lab
> > Sydney University
> >
> >
> > Robin Holt wrote:
> >
> > >Sena,
> > >
> > >Let's keep this off the lkml.  This is _NOT_ the type of chatter that
> > >should be going on at that list.  That forum is for kernel developers
> > >to discuss features that relate to the kernel proper.  This will never
> > >go in without some serious discussion about _WHAT_ is being accomplished
> > >and _WHY_.  The what is weak at best since this is limited to a certain
> > >number of users.  The why is completely vague to me.
> > >
> > >On Wed, Jan 14, 2004 at 01:55:07AM +1100, sena wrote:
> > >
> > >
> > >>Hi Robin,
> > >>
> > >>Though I was able to run my code and get good results  as a kernel
> > >>module (This was everytime only one set of results per loading of  the
> > >>module).
> > >>
> > >>
> > >
> > >You should write your routine to calculate load averages as a timer
> > >service routine.
> > >
> > >Look at struct timer_list.  That might give you some ideas of how to use
> > >it:
> > >
> > >I guess I would write something like:
> > >
> > >static struct timer_list loadavg_per_user_timer;
> > >
> > >...
> > >
> > >     /* during module init, register the timer */
> > >     loadavg_per_user_timer.function = loadavg_per_user_calc;
> > >     loadavg_per_user_calc(0);
> > >
> > >...
> > >
> > >static void
> > >loadavg_per_user_calc(unsigned long _dummy)
> > >{
> > >     loadavg_per_user_timer.expires = (5 * HZ) + jiffies;
> > >     /* Body of calculating loadavg_per_user goes here */
> > >}
> > >
> > >This type of timer would run every 5 seconds and calculate your load
> > >averages.
> > >
> > >One thing we haven't talked about doing is using an extremely simple
> > >lookup instead of searching a list for the uid.  Since the uids you
> > >are concerned with are always in the range of 500-504, Why don't you
> > >just do something like:
> > >
> > >     int loadavg_bucket;
> > >
> > >     loadavg_bucket = p->uid - 499;
> > >     if ((loadavg_bucket < 0) || (loadavg_bucket > 5)) {
> > >             loadavg_bucket = 0;
> > >     }
> > >
> > >With this, any process that has a uid in the range of 500-504 gets
> > >mapped to entries 1-5 in your array and entry 0 is used for everyone
> > >else.  Certainly simpler than the looping lookup you are doing.
> > >
> > >
> > >
> > >>Anyway I felt that it was hanging on a bit while values being
> > >>calculated. (It looks like the host computer sends some messages to the
> > >>users)
> > >>
> > >>
> > >
> > >Describe what you think you felt.  There are all types of hangs.  Did it
> > >feel like the kernel wasn't starting new processes or did it feel like
> > >interrupts were not being serviced?  I sort of need to know which way
> > >it responded to help further.
> > >
> > >
> > >
> > >>Thinking everything was well,  I then integrated it to the kernel code
> > >>with those extra loops of mine,  this time there was nothing written to
> > >>/proc/loadavg file.
> > >>
> > >>
> > >
> > >You should probably consider creating your own /proc file since the 
> loadavg
> > >is really meant for the proc_ps stuff to consume.  You might consider
> > >creating a /proc/loadavg_per_user/<pid> type directory.
> > >
> > >
> > >
> > >>First I thought that this was because the long list(5) of USER's UIDs I
> > >>am saving in that file. (only 5)
> > >>
> > >>
> > >
> > >I doubt that anyone would consider 5 too long.
> > >
> > >
> > >
> > >>Anyway it looks like that is not the real problem as I do calculate
> > >>every 5 seconds and that seems to be enough time.
> > >>
> > >>
> > >>Robin for further Real testing I thought of first running it as  a
> > >>kernel module. Then this code has to be called every 5 seconds and will
> > >>have to be scheduled as a task.?
> > >>
> > >>
> > >
> > >You should be able to use a timer for this.
> > >
> > >
> > >
> > >>I made the following attempt.
> > >>
> > >>I have 2 questions for you.
> > >>
> > >>What is this error about?    THE ERROR WAS sched.o: unresolved symbol
> > >>proc_unregister
> > >>
> > >>
> > >
> > >proc_register and proc_unregister have been going away for some time.
> > >You should be using create_proc_entry and remove_proc_entry.  These
> > >are pointed out in the Documentation/DocBook/procfs_example.c file.
> > >
> > >
> > >
> > >>Thanks
> > >>Sena Seneviratene
> > >>Computer Engineering Lab
> > >>Sydney University
> > >>
> > >>
> > >>sched.c
> > >>/* The necessary header files */
> > >>
> > >>/* Standard in kernel modules */
> > >>#include <linux/kernel.h>   /* We're doing kernel work */
> > >>#include <linux/module.h>   /* Specifically, a module */
> > >>
> > >>/* Deal with CONFIG_MODVERSIONS */
> > >>#if CONFIG_MODVERSIONS==1
> > >>#define MODVERSIONS
> > >>#include <linux/modversions.h>
> > >>#endif
> > >>
> > >>/* Necessary because we use the proc fs */
> > >>#include <linux/proc_fs.h>
> > >>
> > >>/* We scheduale tasks here */
> > >>#include <linux/tqueue.h>
> > >>
> > >>/* We also need the ability to put ourselves to sleep
> > >>* and wake up later */
> > >>#include <linux/sched.h>
> > >>
> > >>/* In 2.2.3 /usr/include/linux/version.h includes a
> > >>* macro for this, but 2.0.35 doesn't - so I add it
> > >>* here if necessary. */
> > >>#ifndef KERNEL_VERSION
> > >>#define KERNEL_VERSION(a,b,c) ((a)*65536+(b)*256+(c))
> > >>#endif
> > >>
> > >>
> > >>
> > >>/* The number of times the timer interrupt has been
> > >>* called so far */
> > >>static int TimerIntrpt = 0;
> > >>
> > >>
> > >>/* This is used by cleanup, to prevent the module from
> > >>* being unloaded while intrpt_routine is still in
> > >>* the task queue */
> > >>static struct wait_queue *WaitQ = NULL;
> > >>
> > >>static void intrpt_routine(void *);
> > >>
> > >>
> > >>/* The task queue structure for this task, from tqueue.h */
> > >>static struct tq_struct Task = {
> > >>NULL,   /* Next item in list - queue_task will do
> > >>         * this for us */
> > >>0,      /* A flag meaning we haven't been inserted
> > >>         * into a task queue yet */
> > >>intrpt_routine, /* The function to run */
> > >>NULL    /* The void* parameter for that function */
> > >>};
> > >>
> > >>/*IN THIS FUNCTION LOAD AVERAGE CALCULATIONS BE INCLUDED*/
> > >>static void intrpt_routine(void *irrelevant)
> > >>{
> > >>/* Increment the counter */
> > >>TimerIntrpt++;
> > >>
> > >>/* If cleanup wants us to die */
> > >>if (WaitQ != NULL)
> > >>  wake_up(&WaitQ);   /* Now cleanup_module can return */
> > >>else
> > >>  /* Put ourselves back in the task queue */
> > >>  queue_task(&Task, &tq_timer);
> > >>}
> > >>
> > >>
> > >>
> > >>
> > >>/* Put data into the proc fs file. */
> > >>int procfile_read(char *buffer,
> > >>                char **buffer_location, off_t offset,
> > >>                int buffer_length, int zero)
> > >>{
> > >>int len;  /* The number of bytes actually used */
> > >>
> > >>
> > >>static char my_buffer[80];
> > >>
> > >>static int count = 1;
> > >>
> > >>
> > >>if (offset > 0)
> > >>  return 0;
> > >>
> > >>/* Fill the buffer and get its length */
> > >>len = sprintf(my_buffer,
> > >>              "Timer was called %d times so far\n",
> > >>              TimerIntrpt);
> > >>count++;
> > >>
> > >>/* Tell the function which called us where the
> > >> * buffer is */
> > >>*buffer_location = my_buffer;
> > >>
> > >>/* Return the length */
> > >>return len;
> > >>}
> > >>
> > >>
> > >>struct proc_dir_entry Our_Proc_File =
> > >>{
> > >>  0, /* Inode number - ignore, it will be filled by
> > >>      * proc_register_dynamic */
> > >>  5, /* Length of the file name */
> > >>  "sched", /* The file name */
> > >>  S_IFREG | S_IRUGO,
> > >>  /* File mode - this is a regular file which can
> > >>   * be read by its owner, its group, and everybody
> > >>   * else */
> > >>  1,  /* Number of links (directories where
> > >>       * the file is referenced) */
> > >>  0, 0,  /* The uid and gid for the file - we give
> > >>          * it to root */
> > >>  80, /* The size of the file reported by ls. */
> > >>  NULL, /* functions which can be done on the
> > >>         * inode (linking, removing, etc.) - we don't
> > >>         * support any. */
> > >>  procfile_read,
> > >>  /* The read function for this file, the function called
> > >>   * when somebody tries to read something from it. */
> > >>  NULL
> > >>  /* We could have here a function to fill the
> > >>   * file's inode, to enable us to play with
> > >>   * permissions, ownership, etc. */
> > >>};
> > >>
> > >>
> > >>/* Initialize the module - register the proc file */
> > >>int init_module()
> > >>{
> > >>/* Put the task in the tq_timer task queue, so it
> > >> * will be executed at next timer interrupt */
> > >>queue_task(&Task, &tq_timer);
> > >>
> > >>/* Success if proc_register_dynamic is a success,
> > >> * failure otherwise */
> > >>#if LINUX_VERSION_CODE > KERNEL_VERSION(2,2,0)
> > >>return proc_register(&proc_root, &Our_Proc_File);
> > >>#else
> > >>return proc_register_dynamic(&proc_root, &Our_Proc_File);
> > >>#endif
> > >>}
> > >>
> > >>
> > >>/* Cleanup */
> > >>void cleanup_module()
> > >>{
> > >>/* Unregister our /proc file */
> > >>proc_unregister(&proc_root, Our_Proc_File.low_ino);
> > >>
> > >>/* Sleep until intrpt_routine is called one last
> > >> * time. This is necessary, because otherwise we'll
> > >> * deallocate the memory holding intrpt_routine and
> > >> * Task while tq_timer still references them.
> > >> * Notice that here we don't allow signals to
> > >> * interrupt us.
> > >> *
> > >> * Since WaitQ is now not NULL, this automatically
> > >> * tells the interrupt routine it's time to die. */
> > >>sleep_on(&WaitQ);
> > >>}
> > >>
> > >>
> > >>
> > >>
> > >
> > >
> > >
> >
> >

