Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTKJBsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 20:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTKJBsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 20:48:09 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:56773 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id S262109AbTKJBsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 20:48:01 -0500
Reply-To: <sks@alum.mit.edu>
From: "Shan Sinha" <sks@alum.mit.edu>
To: <linux-kernel@vger.kernel.org>
Subject: (2.4 question) open_namei hangs
Date: Sun, 9 Nov 2003 20:47:53 -0500
Message-ID: <001901c3a72c$a8575080$0200a8c0@bombay>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20031109221546.GA11520%konsti@ludenkalle.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone-

I know everyone is probably focused on 2.6 right now, but I hope someone
will have the time to answer this question about 2.4.20! I'm extremely
confused, and am not sure what work-around I could employ.

I am trying to read the contents of a file from a kernel thread, spawned
when an LKM is insmod'ed. open_namei appears to hang.  The LKM is
something that I created.  When I call filp_open("/mydirectory",
O_RDONLY, 0), and then subsequently call vfs_readdir on the returned
file *, it traverses the files in the directory correctly.  

However, in the call back passed to vfs_readdir, if I try to do a
filp_open("/mydirectory/file1"), where "file1" is the string passed to
the call back, filp_open appears to hang somewhere inside open_namei (I
verified this by modifying filp_open).

But!  if I do "touch /mydirectory/*" in user space before I insert the
module and spawn my thread, the open and subsequent read for any files
in /mydirectory work fine.  

I suspect this is something to do with the files being loaded into the
buffer cache and my doing something incorrectly with respect to being in
a kernel thread.  Does anyone have any ideas of what may be happening?

I have included snips of the relevant code below.  I guessing my thread
is getting deadlocked somehow when the kernel has to go to disk to fetch
the file.  However, I created the code using khttpd as a sample (not
sure if this was a mistake).

Cheers-
Shan Sinha
Network and Mobile Systems
MIT CSAIL
ssinha@nms.mit.edu

------------------------------------------------------------
int my_callback(void * buf, const char * name, int namlen, loff_t
offset,
	     ino_t ino, unsigned int d_type)
{

       // for each file
  if (d_type == DT_REG) {
    struct file * f;
    read_descriptor_t read_desc;

    char * file_name = make_file_name("/mydirectory/", name, namlen);

    printk(KERN_INFO "loading file: %s\n", file_name);

    // WE HANG IN HERE (IF FILES HAVE NOT BEEN LOADED INTO BUFFER
CACHE??)!!!
    f = filp_open(file_name, O_RDONLY, 0);

    printk(KERN_INFO "opened file: %s\n", file_name);

    // Code snipped - set up code for call to do_generic_file_read
    // Code snipped - call to do_generic_file_read

    kfree(file_name);

  }

  return 0;
}

// Main daemon thread
int pm_daemon(void * data)
{

  DECLARE_WAIT_QUEUE_HEAD(WQ);

  sigset_t tmpsig;
  daemon_running = 1;
  leave_daemon_running = 1;
  sprintf(current->comm, "mythread");
  daemonize();

  /* Code snipped that blocks all signals except SIGKILL and SIGTERM */

  /* main loop */
  while (leave_daemon_running) {
    int signal_counter = 0;


    // count the number of files
    int num_files = 0;

    struct file * f = filp_open("/mydirectory/", O_RDONLY, 0);
    vfs_readdir(f, file_counter, &num_files);
 
    // loop through all files
    fput(f);
    printk(KERN_INFO "Counted files: %d\n", num_files );

    f = filp_open("/mydirectory/", O_RDONLY, 0);
    vfs_readdir(f, my_callback, NULL);

    // code snipped sleep and respond to signals
  }
  leave_daemon_running = 0;
  daemon_running = 0;

  return 0;
}



// called on module init
void pm_init(void)
{
   
  if (!daemon_running)
    kernel_thread(pm_daemon, NULL, CLONE_FS | CLONE_FILES |
CLONE_SIGHAND);

}

