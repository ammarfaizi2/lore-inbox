Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTF1PGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 11:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTF1PGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 11:06:21 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:49865 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265266AbTF1PGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 11:06:06 -0400
Message-ID: <3EFDB233.8050802@colorfullife.com>
Date: Sat, 28 Jun 2003 17:20:19 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] semadj handling
Content-Type: multipart/mixed;
 boundary="------------050503070504020308050903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050503070504020308050903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

SysV semaphores support automatic adjustment at process exit. But what 
should happen if these automatic adjustments create an out of bound 
semaphore value? I can't find anything about it in the susv3 specification.

- Tru64 and HP UX ignore the semadj and leave the semaphore value unchanged.
- Linux (and FreeBSD) cap the semaphore value at 0 - if an adjustment 
would make the value negative, then the value is set to 0. Adjustments 
above SEMVMX are applied.

What do you think about limiting the semaphore value to SEMVMX in 
exit_sem()?

Is someone around with access to other unices? I've attached my test app.

--
    Manfred


--------------050503070504020308050903
Content-Type: text/plain;
 name="undotest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="undotest.c"

/*
 * Copyright (C) 1999,2001 by Manfred Spraul.
 * 
 * Redistribution of this file is permitted under the terms of the GNU 
 * General Public License (GPL)
 * $Header: /pub/home/manfred/cvs-tree/ipcsem/undotest.c,v 1.2 2003/06/28 15:19:43 manfred Exp $
 */

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <assert.h>
#include <signal.h>
#include <time.h>
#include <unistd.h>

#ifdef __LINUX__
	#include <wait.h>
#endif

#ifndef SEMAEM
	#define SEMAEM 16000
#endif

#ifndef SEMVMX
	#define SEMVMX 32000
#endif


union semun {
	int val;
	struct semid_ds *buf;
	unsigned short int *array;
	struct seminfo* __buf;
};

int getval(char * str, int id)
{
	union semun arg;
	int res;

	res = semctl(id,0,GETVAL,arg);
	if(res==-1) {
		printf("GETVAL failed for %s.\n", str);
		exit(4);
	}
	printf("%s: GETVAL now %d.\n",str, res);
	return res;
}

void setzero(int id)
{
	union semun arg;
	int res;

	arg.val = 0;
	res = semctl(id,0,SETVAL,arg);
	if(res==-1) {
		printf("SETVAL failed, errno %d.\n", errno);
		exit(4);
	}
	printf("SETVAL succeeded.\n");
}


/* test1: verify that undo works at all. */
void test1(int id)
{
	int res;

	printf("****************************************\n");
	printf("test1: check that undo works.\n");
	setzero(id);

	res = getval("test1 init", id);
	if (res != 0) {
		printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
		printf("Bad: got unexpected value.\n");
		exit(99);
	}

	/* create sub-process */
	res = fork();
	if (res < 0) {
		printf("Fork failed (errno=%d). Aborting.\n", errno);
		res = semctl(id,1,IPC_RMID,NULL);
		exit(1);
	}
	fflush(stdout);
	if (!res) {
		struct sembuf sop[1];

		/* child: */
		sop[0].sem_num=0;
		sop[0].sem_op=1;
		sop[0].sem_flg=SEM_UNDO;

		res = semop(id,sop,1);
		if(res==-1) {
			printf("semop failed.\n");
			exit(1);
		}
		res = getval("before exit", id);
		if (res != 1) {
			printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
			printf("Bad: got unexpected value.\n");
			exit(99);
		}
		fflush(stdout);
		exit(1);
	} else {
		int retval;
		retval = wait4(res, NULL, 0, NULL);
		if (retval != res) {
			printf("wait4 returned unexpeted value %d, errno now %d.\n", 
					retval, errno);
		}
		res = getval("after exit", id);
		if (res != 0) {
			printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
			printf("Bad: got unexpected value.\n");
			return;
		}
	}
	printf("+++ test1 success: simple undo works.\n");
}

void test2(int id)
{
	int res;

	printf("****************************************\n");
	printf("test2: undo into negative values.\n");
	setzero(id);

	res = getval("test2 init", id);
	if (res != 0) {
		printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
		printf("Bad: got unexpected value.\n");
		exit(99);
	}

	res = fork();
	if (res < 0) {
		printf("Fork failed (errno=%d). Aborting.\n", errno);
		res = semctl(id,1,IPC_RMID,NULL);
		exit(1);
	}
	fflush(stdout);
	if (!res) {
		struct sembuf sop[1];

		/* child: */
		sop[0].sem_num=0;
		sop[0].sem_op=5;
		sop[0].sem_flg=SEM_UNDO;

		res = semop(id,sop,1);
		if(res==-1) {
			printf("semop failed.\n");
			exit(1);
		}
		res = getval("after inc(,5,SEM_UNDO)", id);
		if (res != 5) {
			printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
			printf("Bad: got unexpected value.\n");
			exit(99);
		}

		sop[0].sem_num=0;
		sop[0].sem_op=-3;
		sop[0].sem_flg=0;

		res = semop(id,sop,1);
		if(res==-1) {
			printf("semop failed.\n");
			exit(1);
		}
		res = getval("after inc(,-3,)", id);
		if (res != 2) {
			printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
			printf("Bad: got unexpected value.\n");
			exit(99);
		}
		fflush(stdout);
		exit(1);
	} else {
		int retval;
		retval = wait4(res, NULL, 0, NULL);
		if (retval != res) {
			printf("wait4 returned unexpeted value %d, errno now %d.\n", 
					retval, errno);
		}
		res = getval("after exit()", id);
		switch (res) {
			case 0:
				printf("success, OS sets semaphore value to 0.\n");
				break;
			case 2:
				printf("success, OS ignores undo into negative values.\n");
				break;
			default:
				printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
				printf("Bad: got unexpected value.\n");
				return;
		}
	}
	printf("+++ test2 success: undo into negative area doesn't corrupt internal state.\n");
}


void test3(int id)
{
	int res;

	printf("****************************************\n");
	printf("test3: undo above SEMVMX\n");
	printf("values: SEMVMX %d, SEMAEM %d.\n", SEMVMX, SEMAEM);
	setzero(id);

	res = getval("test3 init", id);
	if (res != 0) {
		printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
		printf("Bad: got unexpected value.\n");
		exit(99);
	}

	res = fork();
	if (res < 0) {
		printf("Fork failed (errno=%d). Aborting.\n", errno);
		res = semctl(id,1,IPC_RMID,NULL);
		exit(1);
	}
	fflush(stdout);
	if (!res) {
		struct sembuf sop[1];

		/* child: */
		sop[0].sem_num=0;
		sop[0].sem_op=SEMVMX;
		sop[0].sem_flg=0;

		res = semop(id,sop,1);
		if(res==-1) {
			printf("semop failed.\n");
			exit(1);
		}
		res = getval("after inc(,SEMVMX,0)", id);
		if (res != SEMVMX) {
			printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
			printf("Bad: got unexpected value.\n");
			exit(99);
		}

		sop[0].sem_num=0;
		sop[0].sem_op=-SEMAEM;
		sop[0].sem_flg=SEM_UNDO;

		res = semop(id,sop,1);
		if(res==-1) {
			printf("semop failed.\n");
			exit(1);
		}
		res = getval("after inc(,-SEMAEM,SEM_UNDO)", id);
		if (res != SEMVMX-SEMAEM) {
			printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
			printf("Bad: got unexpected value.\n");
			exit(99);
		}

		sop[0].sem_num=0;
		sop[0].sem_op=SEMAEM-5;
		sop[0].sem_flg=0;

		res = semop(id,sop,1);
		if(res==-1) {
			printf("semop failed.\n");
			exit(1);
		}
		res = getval("after inc(,SEMAEM-5,)", id);
		if (res != SEMVMX-5) {
			printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
			printf("Bad: got unexpected value.\n");
			exit(99);
		}

		fflush(stdout);
		exit(1);
	} else {
		int retval;
		retval = wait4(res, NULL, 0, NULL);
		if (retval != res) {
			printf("wait4 returned unexpeted value %d, errno now %d.\n", 
					retval, errno);
		}
		res = getval("after exit()", id);
		switch (res) {
			case SEMVMX:
				printf("success, OS limits semaphore value to SEMVMX.\n");
				break;
			case SEMVMX-5:
				printf("success, OS ignores undo that would increase above SEMVMX.\n");
				break;
			default:
				printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
				printf("Bad: got unexpected value.\n");
				return;
		}
	}
	printf("+++ test3 success: SEMVMX enforced with undo.\n");
}

int main(int argc,char** argv)
{
	int res;

	printf("undotest: check that undo works.\n");

	/* create array */
	res = semget(IPC_PRIVATE, 1, 0700 | IPC_CREAT);
	if(res == -1) {
		printf(" create failed.\n");
		return 1;
	}
	test1(res);
	test2(res);
	test3(res);
	/* destroy the segment. */
	res = semctl(res,1,IPC_RMID,NULL);

	return 0;
}

--------------050503070504020308050903--

