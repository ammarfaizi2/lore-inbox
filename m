Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVIFMlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVIFMlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVIFMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:41:08 -0400
Received: from spirit.analogic.com ([208.224.221.4]:16393 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964841AbVIFMlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:41:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <6b5347dc05090604596ac08cb6@mail.gmail.com>
References: <6b5347dc0509060215128d477e@mail.gmail.com> <003a01c5b2d6$610d6360$6464a8c0@pc0001> <6b5347dc05090604596ac08cb6@mail.gmail.com>
X-OriginalArrivalTime: 06 Sep 2005 12:41:05.0687 (UTC) FILETIME=[3F735A70:01C5B2E0]
Content-class: urn:content-classes:message
Subject: Re: what will connect the fork() with its following code ? a simple example below:
Date: Tue, 6 Sep 2005 08:41:05 -0400
Message-ID: <Pine.LNX.4.61.0509060814530.20318@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what will connect the fork() with its following code ? a simple example below:
Thread-Index: AcWy4D96SeWHQQlOQfevwVULZj9ejQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sat." <walking.to.remember@gmail.com>
Cc: "Dirk Gerdes" <mail@dirk-gerdes.de>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Sep 2005, Sat. wrote:

> here is a snip in 0.11 version linux ,
> in linux/init/main.c
>
>
> 179 if (!(pid=fork())) {
> 180 close(0);
> 181 if (open( "/etc/rc",O_RDONLY,0))
> 182 _exit(1);
> 183 execve( "/bin/sh",argv_rc,envp_rc);
> 184 _exit(2);
> 185 }
>
> natually, the code from 180 to 184 is runned by the new process, what
> I can understand is why the new process know that the next code will
> run is close(0) and why it know It will end at line 184 ?
>
> so ,I feel that there should be some connection between  them . but
> what the relationship in depth is ?
>
> thanks your help :)
>

After the fork() system call, fork() returns the child's pid
(or an error) to the parent, and a ZERO (0) to the child. That
way the code 'knows' if the child or the parent is executing.


     switch ((pid = fork()))
     {
     case 0:    			// Child runs here
         printf("Child\n");
         sleep(1);
         exit(0);
     case -1:			// This is for errors
         fprintf(stderr, "fork() failed (%s)\n", strerror(errno));
         exit(1);
     default:			// The parent executes here
        printf("Parent waits for child with pid %d\n", pid);
        wait(&status);
        printf("Child executed with %d status\n", status >> 8);
     }

>
> 2005/9/6, Dirk Gerdes <mail@dirk-gerdes.de>:
>> There is no connection between a child an its parent.
>> The child only gets a copy of the code.
>> If there were a pointer to a child or to the parent, you wouldn't need any
>> signals.
>> The processes could communicate directly.
>>
>> regards
>>
>> ----- Original Message -----
>> From: "Sat." <walking.to.remember@gmail.com>
>> To: <linux-kernel@vger.kernel.org>
>> Sent: Tuesday, September 06, 2005 11:15 AM
>> Subject: what will connect the fork() with its following code ? a simple
>> example below:
>>
>>
>>> if(!(pid=fork())){
>>>     ......
>>>     printk("in child process");
>>>     ......
>>> }else{
>>>     .....
>>>     printk("in father process");
>>>     .....
>>> }
>>>
>>> this is a classical example, when the fork() system call runs, it will
>>> build a new process and active it . while the schedule() select the
>>> new process it will run. this is rather normal.
>>>
>>> but there is always a confusion in my minds.
>>> because , sys_fork() only copies father process and configure some new
>>> values., and do nothing . so the bridge  between the new process and
>>> its following code, printk("in child process"), seems disappear . so I
>>> always believe that the new process should have a pointer which point
>>> the code "printk("in child process");". except this , there are not
>>> any connection between them ?
>>>
>>> very confused :(
>>>
>>> any help will  appreciate  !

sys_fork() should never be executed from inside the kernel because
it is going to copy a process' code and data. The kernel isn't a
process. To make a process from inside the kernel, you need to use:

//
//   Code to execute as a kernel thread.
//

int thread_code(void *ptr)
{
     daemonize("%s", "Kernel Thread!");
     allow_signal(SIGTERM);
     for(;;)		// Run forever
     {
         do_something();

         set_current_state(TASK_INTERRUPTIBLE);
         if(signal_pending(current))
             complete_and_exit(&exit_flag);
     }
}

//
//   Code to start the kernel thread.
//

pid = kernel_thread(thread_code, NULL, CLONE_FS|CLONE_FILES);


//
//   Code to stop the kernel thread.
//

     kill_proc(pid, SIGTERM);
     wait_for_completion(&exit_flag);


>>>
>>>
>>>
>>> --
>>> Sat.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
