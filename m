Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUAMECG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 23:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUAMECG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 23:02:06 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:35545 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S263486AbUAMEBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 23:01:00 -0500
Message-ID: <400406CB.50607@sedal.usyd.edu.au>
Date: Wed, 14 Jan 2004 01:55:07 +1100
From: sena <auntvini@sedal.usyd.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: uid-Another Problem in writing to /proc/loadavg file
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Though I was able to run my code and get good results  as a kernel 
module (This was everytime only one set of results per loading of  the 
module).

Anyway I felt that it was hanging on a bit while values being 
calculated. (It looks like the host computer sends some messages to the 
users)

Thinking everything was well,  I then integrated it to the kernel code 
with those extra loops of mine,  this time there was nothing written to 
/proc/loadavg file.

First I thought that this was because the long list(5) of USER's UIDs I 
am saving in that file. (only 5)

Anyway it looks like that is not the real problem as I do calculate 
every 5 seconds and that seems to be enough time.


 Robin for further Real testing I thought of first running it as  a 
kernel module. Then this code has to be called every 5 seconds and will 
have to be scheduled as a task.?


I made the following attempt.

I have 2 questions for you.

What is this error about?    THE ERROR WAS sched.o: unresolved symbol 
proc_unregister

Thanks
Sena Seneviratene
Computer Engineering Lab
Sydney University


sched.c
/* The necessary header files */

/* Standard in kernel modules */
#include <linux/kernel.h>   /* We're doing kernel work */
#include <linux/module.h>   /* Specifically, a module */

/* Deal with CONFIG_MODVERSIONS */
#if CONFIG_MODVERSIONS==1
#define MODVERSIONS
#include <linux/modversions.h>
#endif        

/* Necessary because we use the proc fs */
#include <linux/proc_fs.h>

/* We scheduale tasks here */
#include <linux/tqueue.h>

/* We also need the ability to put ourselves to sleep 
 * and wake up later */
#include <linux/sched.h>

/* In 2.2.3 /usr/include/linux/version.h includes a 
 * macro for this, but 2.0.35 doesn't - so I add it 
 * here if necessary. */
#ifndef KERNEL_VERSION
#define KERNEL_VERSION(a,b,c) ((a)*65536+(b)*256+(c))
#endif



/* The number of times the timer interrupt has been 
 * called so far */
static int TimerIntrpt = 0;


/* This is used by cleanup, to prevent the module from 
 * being unloaded while intrpt_routine is still in 
 * the task queue */
static struct wait_queue *WaitQ = NULL;

static void intrpt_routine(void *);


/* The task queue structure for this task, from tqueue.h */
static struct tq_struct Task = {
  NULL,   /* Next item in list - queue_task will do 
           * this for us */
  0,      /* A flag meaning we haven't been inserted 
           * into a task queue yet */
  intrpt_routine, /* The function to run */
  NULL    /* The void* parameter for that function */
};

/*IN THIS FUNCTION LOAD AVERAGE CALCULATIONS BE INCLUDED*/
static void intrpt_routine(void *irrelevant)
{
  /* Increment the counter */
  TimerIntrpt++;

  /* If cleanup wants us to die */
  if (WaitQ != NULL) 
    wake_up(&WaitQ);   /* Now cleanup_module can return */
  else
    /* Put ourselves back in the task queue */
    queue_task(&Task, &tq_timer);  
}




/* Put data into the proc fs file. */
int procfile_read(char *buffer, 
                  char **buffer_location, off_t offset, 
                  int buffer_length, int zero)
{
  int len;  /* The number of bytes actually used */

  
  static char my_buffer[80];  

  static int count = 1;

  
  if (offset > 0)
    return 0;

  /* Fill the buffer and get its length */
  len = sprintf(my_buffer, 
                "Timer was called %d times so far\n", 
                TimerIntrpt);
  count++;

  /* Tell the function which called us where the 
   * buffer is */
  *buffer_location = my_buffer;

  /* Return the length */
  return len;
}


struct proc_dir_entry Our_Proc_File = 
  {
    0, /* Inode number - ignore, it will be filled by 
        * proc_register_dynamic */
    5, /* Length of the file name */
    "sched", /* The file name */
    S_IFREG | S_IRUGO, 
    /* File mode - this is a regular file which can
     * be read by its owner, its group, and everybody
     * else */
    1,  /* Number of links (directories where 
         * the file is referenced) */
    0, 0,  /* The uid and gid for the file - we give 
            * it to root */
    80, /* The size of the file reported by ls. */
    NULL, /* functions which can be done on the 
           * inode (linking, removing, etc.) - we don't 
           * support any. */
    procfile_read, 
    /* The read function for this file, the function called
     * when somebody tries to read something from it. */
    NULL 
    /* We could have here a function to fill the 
     * file's inode, to enable us to play with 
     * permissions, ownership, etc. */
  }; 


/* Initialize the module - register the proc file */
int init_module()
{
  /* Put the task in the tq_timer task queue, so it 
   * will be executed at next timer interrupt */
  queue_task(&Task, &tq_timer);

  /* Success if proc_register_dynamic is a success, 
   * failure otherwise */
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,2,0)
  return proc_register(&proc_root, &Our_Proc_File);
#else
  return proc_register_dynamic(&proc_root, &Our_Proc_File);
#endif
}


/* Cleanup */
void cleanup_module()
{
  /* Unregister our /proc file */
  proc_unregister(&proc_root, Our_Proc_File.low_ino);
  
  /* Sleep until intrpt_routine is called one last 
   * time. This is necessary, because otherwise we'll 
   * deallocate the memory holding intrpt_routine and
   * Task while tq_timer still references them. 
   * Notice that here we don't allow signals to 
   * interrupt us. 
   *
   * Since WaitQ is now not NULL, this automatically 
   * tells the interrupt routine it's time to die. */
 sleep_on(&WaitQ);
}



