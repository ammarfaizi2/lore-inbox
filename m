Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbUKXOVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUKXOVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUKXOU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:20:27 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:63621 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262727AbUKXOPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:15:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WYAV5Ia4sqXPHP/jfCuvfV8SHGEIAu1PVjg2RZoQAeTjUIuEAssVn1B56nLCS/IUhOYnbP5jx3Jk4H1pJ2/TK9sS2raVO0Rt5QatB/cv8NgRdJ7nRAw4SxrIAnSgmQpNdjs39tPhYvGkkrryjEPQfPcetTb+8P0qXXHVf1cX/bc=
Message-ID: <4b41a25041124051572892c7@mail.gmail.com>
Date: Wed, 24 Nov 2004 18:45:39 +0530
From: Jyoti Wagholikar <jyoti.wagholikar@gmail.com>
Reply-To: Jyoti Wagholikar <jyoti.wagholikar@gmail.com>
To: linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com
Subject: Thread priority scheduling across linux kernels RH9.0 and RH 7.2.
In-Reply-To: <4b41a25.0408290455.111c1747@posting.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4b41a25.0408290455.111c1747@posting.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I have come across some strange behaviour of
priority base scheduling of threads across linux
kernels.

  The program below shows that main priority is
raised to max = 99. Another thread with priority =30
is created.

void main()
{
struct sched_param schedparam, getparam,
taskschedparam;
int policy, status;
pthread_attr_t attribs;

pthread_t id =pthread_self();

/* Raising main priority to max =99 */
schedparam.__sched_priority
=sched_get_priority_max( SCHED_FIFO );
pthread_setschedparam(id, SCHED_FIFO, &schedparam);
pthread_getschedparam(id,&policy , &getparam);
printf("\n main  :  priority = %d, policy = %d",
getparam.__sched_priority, policy);

/* First Assign default attributes for the thread */
pthread_attr_init(&attribs);

/*Set stack size as specified by user*/
attribs.__stacksize = 10000;

/*set scheduling policy*/
pthread_attr_setschedpolicy(&attribs, SCHED_FIFO);

/*Set task priority*/
taskschedparam.__sched_priority = 30;
pthread_attr_setschedparam(&attribs, &taskschedparam);

status = pthread_create(&firstTask, &attribs,
task_fun1, (void*)1 );
printf("\n main :first task = %d,firstTask);
fflush(stdout);

sleep(10000);
}
void *task_fun1 ( void *param)
{
struct sched_param schedparam, getparam ;
int policy;

pthread_getschedparam(pthread_self(),&policy ,
&getparam);
printf("\n task_fun1: priority = %d, policy = %d",
getparam.__sched_priority, policy);fflush(stdout);
printf("\n FIRST TASK = %x", firstTask);
fflush(stdout);
}

Ouputs:
Redhat: 7.2 :[CORRECT OUTPUT]
main  :  priority = 99, policy = 1
pthread_create status = 0
main :first task = 1026
Sleeping for 1000 sec
task_fun1: priority = 30, policy = 1
FIRST TASK = 402

Redhat: 9.0 [ WRONG OUTPUT]
main  :  priority = 99, policy = 1
task_fun1: priority = 0, policy = 0
FIRST TASK = 40838cc0
pthread_create status = 0
main :first task = 1082363072
Sleeping for 1000 sec

Just wondering if there is any inconsistency in the
priority scheduling across linux version: linux
2.4.20-8(Redhat 9.0) linux 2.4.7(Redhat 7.2).

Has anyone come across this problem earlier? Any
solution to overcome it? 
I want my implementation which is running fine on RH7.2 to run on RH9.0

Just wondering if it is related to priority based real time futexes.  


Your input will be helpful in my project.

thanks and regards,
-Jyoti
