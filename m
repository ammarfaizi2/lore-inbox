Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVHXSn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVHXSn4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVHXSn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:43:56 -0400
Received: from mail.intersys.com ([198.133.74.1]:19982 "EHLO
	mail.intersystems.com") by vger.kernel.org with ESMTP
	id S1751390AbVHXSny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:43:54 -0400
Message-ID: <430CBFD1.7020101@intersystems.com>
Date: Wed, 24 Aug 2005 14:43:29 -0400
From: Ray Fucillo <fucillo@intersystems.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: process creation time increases linearly with shmem
Content-Type: multipart/mixed;
 boundary="------------010201030003030607040508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201030003030607040508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am seeing process creation time increase linearly with the size of the 
shared memory segment that the parent touches.  The attached forktest.c 
is a very simple user program that illustrates this behavior, which I 
have tested on various kernel versions from 2.4 through 2.6.  Is this a 
known issue, and is it solvable?

TIA,
Ray

--------------010201030003030607040508
Content-Type: text/plain;
 name="forktest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="forktest.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/time.h>
#include <errno.h>
#include <sys/shm.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <signal.h>

#define MAXJOBS 50
#define MAXMALLOC 1024

#define USESIGCHLDHND
/* USESIGCHLDHND feature code changes how the parent waits
   for the children.  When this feature code is on we define
   a signal handler for SIGCHLD and call waitpid to clean up
   the child process.  If this feature code is off, we wait
   until all children are forked and then loop through the 
   array of child pids and call waitpid() on each.  The
   purpose of this feature code was to see if there is any
   difference in timing based on cleaning up zombies faster.
   Test have shown no appreciable difference.  */

/* Return a floating point number of seconds since the start
   time in the timeval structure pointed to by starttv */
float elapsedtime(struct timeval *starttv) {
	struct timeval currenttime;
	gettimeofday(&currenttime,NULL);
	return ((currenttime.tv_sec - starttv->tv_sec) +
	       ((float)(currenttime.tv_usec - starttv->tv_usec)/1000000));
}

#ifdef USESIGCHLDHND
int childexitcnt = 0;
void sigchldhnd(int signum) {
	if (waitpid(-1,NULL,WNOHANG)) ++childexitcnt;
	return;
}
#endif

int main(void) {
	pid_t childpid[MAXJOBS];
	int x,i;
	int childcnt = 0;
        float endfork, endwait;
	struct shmid_ds myshmid_ds;
	unsigned int mb;
	int myshmid;
	key_t mykey = 0xf00df00d;
	char *mymem = 0;
	struct timeval starttime;
#ifdef USESIGCHLDHND
	struct sigaction sa;
	sa.sa_handler = sigchldhnd;
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = SA_RESTART;
	if (sigaction(SIGCHLD, &sa, NULL) == -1) {
	   printf("sigaction() failed, errno %d - exiting\n",errno);
	   exit(1);
	}
#endif
        printf("\nNumber of jobs to fork (max %d):  ",MAXJOBS);
        scanf("%d",&x);
        if ((x < 1) || (x > MAXJOBS)) {
           printf("\ninvalid input - exiting\n");
           exit(1);
        }
        printf("\nNumber of MB to allocate (0-%d):  ",MAXMALLOC);
        scanf("%d",&mb);
        if (mb > MAXMALLOC) {
           printf("\ninvalid input - exiting\n");
           exit(1);
        }
	/* allocate and initialize shared memory if number
	   of MB is not zero */
	if (mb) {
	   myshmid = shmget(mykey,mb*1024*1024,IPC_CREAT|0777);
	   if (myshmid == -1) {
	      printf("\nshmget() failed, errno %d. - exiting\n",errno);
	      exit(1);
	   }
	   mymem = (char *) shmat(myshmid,0,0);
	   if (mymem == (char *) -1) {
	      printf("\nshmat() failed, errno %d. - exiting\n",errno);
	      exit(1);
	   }
	   if (shmctl(myshmid,IPC_STAT,&myshmid_ds)) {
	      printf("\nshmctl() failed, errno %d. - exiting\n",errno);
	      exit(1);
	   }
	   /* write a pattern in the new shmem segment*/
	   for (i=0; i < (mb*1024*1024); i+=32) mymem[i]='R';
	}	
	printf("\nStarting %d jobs.  time:0.0", x);
	fflush(stdout);
	gettimeofday(&starttime,NULL); 
	for (i=0; i<x; i++) {
	   childpid[i] = fork();
	   if (!childpid[i]) {
	      /* child process */
	      printf("\n - Child %d         time:%f",i,elapsedtime(&starttime));
	      exit(1);
	   } else if (childpid[i] == -1) {
	      /* failure */
	      printf("\nfork failed, errno = %d");
	   } else childcnt++;
	}
	endfork = elapsedtime(&starttime);
#ifndef USESIGCHLDHND
	for (i=0; i<x; i++) waitpid(childpid[i],0,0);
#else
	while (childexitcnt < childcnt) {
	   if (waitpid(-1,NULL,0)) ++childexitcnt;
	}
#endif	   
	endwait = elapsedtime(&starttime);
	printf("\nTime to fork all processes in seconds: %f", endfork);
        printf("\nTime for all processes to complete: %f\n", endwait);

	/* kill shmem segment */
	if ((mb) && (shmctl(myshmid,IPC_RMID,&myshmid_ds))) {
	   printf("\nshmctl() failed, errno %d. - exiting\n",errno);
	   exit(1);
	}
}



--------------010201030003030607040508--
