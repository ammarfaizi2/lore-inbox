Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUIFWpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUIFWpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 18:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUIFWpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 18:45:15 -0400
Received: from nsa.as.arizona.edu ([128.196.210.37]:16787 "EHLO
	nsa4.srv.as.arizona.edu") by vger.kernel.org with ESMTP
	id S267362AbUIFWpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 18:45:02 -0400
Message-ID: <413CE863.3050400@as.arizona.edu>
Date: Mon, 06 Sep 2004 15:44:51 -0700
From: don fisher <dfisher@as.arizona.edu>
Organization: caao
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sched_setaffinity(), RT priorities and migration thread usage at
 30%
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: so4: not spam (minrbl = 3), SpamAssassin (score=0,
	required 8, autolearn=not spam)
X-MailScanner-From: dfisher@as.arizona.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Apologies in advance if this is a newbie question. I am attempting to 
write a real-time simulation of an application we have in house. I 
have a dual processor SMP system, hyperthreading enabled, running 
kernel 2.6.7.

The first thread begins at priority 1 (SCHED_RR) and subsequently 
spawns another time critical task running at priority 2. The initial 
thread uses setaffinity to set the desired cpu to 2. When the second 
task begins, the migration thread becomes 30% active (as reported by 
top) for the duration of its execution. When the priority 2 thread 
terminates the first thread continues with the migration task 
consuming only 2% of the CPU.

If there was any change, I was expecting that the higher priority of 
the second thread would cause it to execute closer to 100% CPU. I 
built a test code where each thread computes an identical dumb timing 
loop. The priority 2 thread ends up executing 30% slower than the 
priority 1 thread due to contention with the migration thread.

Is this the expected behavior, and if so could you please inform me 
why? I had not anticipated the any attempt by the kernel to shift the 
process to another CPU, since sched_setafinity had been applied.

I want to confirm that from xosview, both tasks do actually execute 
serially on processor 2 as expected. Code is include below.

don

int main(argc, argv)
{
   cpu_set_t cur_mask;
   struct sched_param policy;
   long ret;
   u32 page_size;
   pthread_attr_t attr;
   pthread_t task_pid;

   CPU_ZERO(&cur_mask);
   CPU_SET(2, &cur_mask);
   ret = sched_setaffinity(0, sizeof(cur_mask), &cur_mask);

   policy.sched_priority = 1;
   ret = sched_setparam(0, &policy);
   ret = sched_setscheduler(0, SCHED_RR, &policy);

   ret = pthread_attr_init(&attr);
   ret = pthread_attr_setschedpolicy(&attr, SCHED_RR);
   policy.sched_priority = 2;
   ret = pthread_attr_setschedparam(&attr, &policy);
   ret = pthread_attr_getstacksize(&attr, &stack_size);

   ret = pthread_create(&task_pid, &attr, (void *(*)())
		       local_thread, (void *)NULL);

   {
     long i, j = 0;
     fprintf(stderr, "enter %ld\n", j);
     for(i = 0; i < 1000000000; i++){
       j += sqrt((double)i);
     }
     fprintf(stderr, "end %ld\n", j);
   }

   policy.sched_priority = 0;
   ret = sched_setparam(0, &policy);
   ret = sched_setscheduler(0, SCHED_OTHER, &policy);

   return 0;
}
int32 local_thread(void)
{
   {
     long i, j = 0;
     fprintf(stderr, "thread %ld\n", j);
     for(i = 0; i < 1000000000; i++){
       j += sqrt((double)i);
     }
     fprintf(stderr, "thread %ld\n", j);
   }

   return 0;
}

