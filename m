Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUBTSIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUBTSIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:08:15 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2205 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261361AbUBTSIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:08:05 -0500
Message-ID: <40364D01.9030504@nortelnetworks.com>
Date: Fri, 20 Feb 2004 13:08:01 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: possible problems with kernel threading code?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running the following code under 2.4.18-2.4.20, with the standard 
thread library, and sometimes I get an error of "No such process".  How 
can this possibly happen?  The pthread_setschedparam() call is running 
in the thread that it is trying to operate on, but somehow it can't find 
itself?

I also have managed to trigger reboots with this code, and I'm not sure how.

Anyone have any ideas?  Is this a kernel problem?  I can trigger it on 
ppc hardware under kernel versions 2.4.18-2.4.20 and a modified 2.4.22. 
(I haven't tried 2.4.21)  My x86 with a 2.4.18-19.8.0 redhat kernel 
doesn't show the problem.

Thanks,

Chris



#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>

pthread_t t1;

void *func(void *p)
{
   pid_t pid;
   int status;

   struct sched_param schedParam;
   int         policy = SCHED_RR;
   int         priority = 40;

  schedParam.sched_priority = priority;
  int schedRc = pthread_setschedparam(t1, policy, &schedParam);
  if (schedRc){
       fprintf(stderr, "pthread_setschedparam error:%s, priority:%d,
               policy:%d\n",strerror(schedRc), priority, policy);
   }
   pthread_exit(EXIT_SUCCESS);
   return 0;
}


int main(int argc, char **argv)
{
   pthread_create(&t1, 0, func,(void*)1);
   pthread_join(t1,0);
   return 0;
}


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
