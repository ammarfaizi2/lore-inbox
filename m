Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVDBTkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVDBTkl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVDBTkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:40:41 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:15242 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261222AbVDBTiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:38:16 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050402051254.GA23786@elte.hu>
References: <20050325145908.GA7146@elte.hu>
	 <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com>
	 <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
Content-Type: multipart/mixed; boundary="=-3MphZyM2UJs5TDX5Bjrl"
Organization: Kihon Technologies
Date: Sat, 02 Apr 2005 14:37:55 -0500
Message-Id: <1112470675.27149.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3MphZyM2UJs5TDX5Bjrl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ingo,

I've discovered a problem with basically all "yields" in the kernel. But
that's not why I'm writing you this. To see if your kernel has the same
problems as mine, I wrote a modified test that caused me the problems,
and ran it on your kernel. But too my surprise, this test caused other
problems. This modified test causes my kernel the same types of problems
too.

Attached is the test I ran. The list.h is just my version of the kernels
list functions for userspace. It's used in the test program. 

What the test program does, is spawn 5 processes, each with a different
priority. Starting with 10 and going to 14. All are SCHED_FIFO.  Each of
these processes just do a scan of all directories starting with the root
directory '/' and going down. I usually run this with a directory NFS
mounted too, but I don't think this was a problem.

Here's the bug I get:

Slab corruption: start=cfc45938, len=276
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c0142b1d>](mempool_free+0x9d/0xb0)
050: 68 9a 3e c0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=cfc45818, len=276
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c01426a8>](mempool_create+0xe8/0x120)
000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Next obj: start=cfc45a58, len=276
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
BUG at kernel/timer.c:419!
------------[ cut here ]------------
kernel BUG at kernel/timer.c:419!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c012142d>]    Not tainted VLI
EFLAGS: 00010282   (2.6.12-rc1-RT-V0.7.43-06) 
EIP is at cascade+0x6d/0x80
eax: 0000001e   ebx: c03e9a90   ecx: 00000000   edx: c0118720
esi: c03e9a68   edi: c03e9a90   ebp: c1273f44   esp: c1273f2c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process ksoftirqd/0 (pid: 2, threadinfo=c1272000 task=cffed260)
Stack: c0387e66 c0389ef9 000001a3 00000000 c03e9878 c1273f60 c1273f78 c0121bae 
       c03e9080 c03e98f0 0000002f 00000000 c1272000 c1273f60 c1273f60 c0112643 
       00000005 c1272000 00000000 c1273fa0 c011d45a c04f3e28 c1272000 cffeff00 
Call Trace:
 [<c0103bef>] show_stack+0x8f/0xb0 (28)
 [<c0103daa>] show_registers+0x16a/0x1d0 (56)
 [<c0103fc6>] die+0xf6/0x190 (64)
 [<c01044e1>] do_invalid_op+0xc1/0xd0 (204)
 [<c010381b>] error_code+0x2b/0x30 (84)
 [<c0121bae>] run_timer_softirq+0x2ae/0x420 (52)
 [<c011d45a>] ___do_softirq+0x9a/0x100 (40)
 [<c011d579>] _do_softirq+0x29/0x30 (8)
 [<c011da41>] ksoftirqd+0xb1/0x130 (20)
 [<c012de1a>] kthread+0xaa/0xb0 (48)
 [<c0100e35>] kernel_thread_helper+0x5/0x10 (1054392340)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0103f13>] .... die+0x43/0x190
.....[<c01044e1>] ..   ( <= do_invalid_op+0xc1/0xd0)
.. [<c0137b8d>] .... print_traces+0x1d/0x60
.....[<c0103bef>] ..   ( <= show_stack+0x8f/0xb0)

Code: 76 04 8b 45 10 83 c4 0c 5b 5e 5f 5d c3 c7 04 24 66 7e 38 c0 b8 a3 01 00 00 89 44 24 08 b8 f9 9e 38 c0 89 44 24 04 e8 d3 6e ff ff <0f> 0b a3 01 f9 9e 38 c0 eb b3 89 f6 8d bc 27 00 00 00 00 55 89 
 BUG: ksoftirqd/0/2, lock held at task exit time!
 [c03e9080] {&base->lock}
.. held by:       ksoftirqd/0:    2 [cffed260, 106]
... acquired at:  run_timer_softirq+0x243/0x420


-- Steve




--=-3MphZyM2UJs5TDX5Bjrl
Content-Disposition: attachment; filename=test3_rt.c
Content-Type: text/x-csrc; name=test3_rt.c; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <fcntl.h>
#include <signal.h>
#include <ctype.h>
#include <sched.h>

#define __USE_GNU
#include <sys/ipc.h>

#ifdef SDR_TOOLS
#include <dump_log.h>
#include <linux/logdev.h>
#include <dump_log.h>
#include <tracer_xml.h>
#include "dump_trace.h"
int logfd = -1;
#else
#define logdev_print(x...) do {} while(0)
#define logdev_switch_set(x) (0)
#endif

#include <list.h>


static int reader (int i);

typedef int (*callfunc_t)(int);

#define NR_PROCS 5
pid_t pids[NR_PROCS];
callfunc_t dofunc[NR_PROCS] = {
	reader,
	reader,
	reader,
	reader,
	reader
};

int priorities[NR_PROCS] = {
	10,
	11,
	12,
	13,
	14,
};

key_t key;
int semid = -1;
int shmid = -1;
int safe = 0;
int tod = 0;
int *flags;

void cleanup(void)
{
	int i;

	for (i=0; i < NR_PROCS; i++) {
		if (pids[i])
			kill(pids[i],SIGKILL);
	}

	if (semid >= 0)
		semctl(semid, 0, IPC_RMID);
	if (shmid >= 0)
		shmctl(shmid, IPC_RMID, NULL);
#ifdef SDR_TOOLS
	if (logfd >= 0)
		close_logdev(logfd);
#endif
}

void catchall(int sig)
{
	cleanup();
	psignal(sig,"Caught: ");
	exit(-1);
}

static int compare_timeval(const struct timeval *a, const struct timeval *b)
{
	return (a->tv_sec > b->tv_sec) ? 1 :
		(a->tv_sec < b->tv_sec) ? -1:
		(a->tv_usec > b->tv_usec) ? 1:
		(a->tv_usec < b->tv_usec) ? -1:
		0;
}

static void add_timeval(const struct timeval *a, const struct timeval *b, struct timeval *c)
{

	c->tv_usec = a->tv_usec + b->tv_usec;
	c->tv_sec = a->tv_sec + b->tv_sec;
	while (c->tv_usec > 1000000) {
		c->tv_usec -= 1000000;
		c->tv_sec++;
	}

}

static void sub_timeval(const struct timeval *a, const struct timeval *b, struct timeval *c)
{

	c->tv_usec = a->tv_usec - b->tv_usec;
	c->tv_sec = a->tv_sec - b->tv_sec;
	while (c->tv_usec < 0) {
		c->tv_usec += 1000000;
		c->tv_sec--;
	}

}

struct dir_item {
	struct list_head list;
	char *dir;
};

LIST_HEAD_DECLARE(dirs);

static void read_dirs(char *dirname)
{
	DIR *dir;
	struct dirent *dent;
	struct stat st;
	struct dir_item *item;
	int len = strlen(dirname);
	char *name;
	
	if ((dir = opendir(dirname)) == NULL)
		return;

	while ((dent = readdir(dir))) {
		if (strcmp(dent->d_name,".") == 0 ||
		    strcmp(dent->d_name,"..") == 0)
			continue;

		
		name = malloc(strlen(dent->d_name)+len+2);
		if (!name) {
			goto out;
		}

		strcpy(name,dirname);
		name[len] = '/';
		strcpy(name+len+1,dent->d_name);

		if (stat(name,&st) < 0) {
			perror(name);
			free(name);
			continue;
		}

		if ((S_ISDIR(st.st_mode))) {
			item = malloc(sizeof(*item));
			if (!item) {
				free(name);
				goto out;
			}
			item->dir = name;
			
			list_add_tail(&item->list,&dirs);
		} else {
			free(name);
		}
	}
 out:
	closedir(dir);
}
			

static int reader(int i)
{
	struct sembuf sops;
	int semid;
	struct timeval starttv;
	struct timeval endtv;
	struct timeval tv;
	struct timeval lasttv;
	struct timeval deltatv;
	time_t t;
	char timebuf[30];
	unsigned long long starttsc, nowtsc;

	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(key,1,0)) < 0) {
		perror("semget");
		return -1;
	}

	printf("reader %d grabbing waiting on sem\n",i);
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		return -1;
	}

	logdev_print(logfd,"reader %d past semaphore\n",i);

	if (gettimeofday(&starttv,NULL) < 0) {
		perror("gettimeofday");
		return -1;
	}

	memset (&deltatv,0,sizeof(deltatv));

	endtv.tv_sec = 10;
	endtv.tv_usec = 0;

	add_timeval(&starttv,&endtv,&endtv);

	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;

	printf("reader %d starting loop (%s)\n",i,timebuf);
	logdev_print(logfd,"reader %d (pid %d) starting loop (%s)\n",i,getpid(),timebuf);
	lasttv = starttv;
	asm ("rdtsc" : "=A"(starttsc));
	
	chdir("/");
	read_dirs("/");
	
	do {
		struct list_head *p;
		struct dir_item *item;

		asm ("rdtsc" : "=A"(nowtsc));
		if (safe && (nowtsc - starttsc > 8000000000ULL)) {
			printf("now - start > 8000000000\n");
			break;
		}
		
		
		if (list_empty(&dirs))
			break;

		p = dirs.next;
		list_del(p);
		item = list_entry(p,struct dir_item, list);
		read_dirs(item->dir);
		free(item->dir);
		free(item);
		
		if (gettimeofday(&tv,NULL) < 0) {
			perror("gettimeofday (in loop)");
			return -1;
		}

		sub_timeval(&tv,&lasttv,&lasttv);
		if (compare_timeval(&deltatv,&lasttv) < 0)
			deltatv = lasttv;
		lasttv = tv;
	} while(!tod || compare_timeval(&endtv,&tv) > 0);
	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;
	logdev_print(logfd,"spinner %d (pid %d) done (%s)\n",i,getpid(),timebuf);
	printf("spinner %d ended loop (%s)  (%d.%06d secs delta)\n",
	       i,timebuf,(int)deltatv.tv_sec,(int)deltatv.tv_usec);
	

	return 0;
}


void usage(char **argv)
{
	char *arg = argv[0];
	char *p = arg+strlen(arg);

	while (p >= arg && *p != '/') p--;
	p++;

	printf("\nusage: %s [-st]\n"
	       "  -s : safe mode. Have the readers use the tsc to stop\n"
	       "  -t : use timeofday to stop loop\n"
	       "\n",p);
	exit(-1);
}

int main (int argc, char **argv)
{
	int ret=0;
	int i;
	int nr_procs=0;
	struct sembuf sops;
	int c;

	opterr = 0;
	while ((c=getopt(argc,argv,"hnsf:")) >= 0) {
		switch (c) {
		case 's':
			safe = 1;
			break;
		case 't':
			tod = 1;
			break;
		case 'h':
		default:
			printf("\n");
			if (c != ':' && tolower(optopt) != 'h' && optopt != '?')
				printf("unknown option: %c\n",optopt);
			usage(argv);
		}
	}

	key = ftok(argv[0],123);
	
	if ((semid = semget(key,1,IPC_CREAT|IPC_EXCL|0600)) < 0) {
		perror("semget");
		exit (-1);
	}

	if ((shmid = shmget(key,30,IPC_CREAT|IPC_EXCL|0600)) < 0) {
		perror("shmget");
		goto out;
	}
	
	if ((flags = shmat(shmid, NULL, 0)) == (void*)-1) {
		perror("shmat");
		goto out;
	}

#ifdef SDR_TOOLS
	if ((logfd = open_logdev(NULL,O_RDWR)) < 0) {
		perror("open_logdev");
		goto out;
	}

	if (logdev_switch_set(1)) {
		perror("logdev_switch_on");
	}
#endif


	/* Grab the semaphore before anyone else can take it. */
	memset(&sops,0,sizeof(sops));
//	sops.sem_flg = SEM_UNDO;
	sops.sem_op = 1;
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		ret = -1;
		goto out;
	}

	for (i=0; i < NR_PROCS; i++) {
		struct sched_param p;

		if ((pids[i] = fork()) < 0) {
			perror("fork");
			ret = -1;
			goto out;
		} else if (pids[i] == 0) {
			/* child */
			ret = dofunc[i](i);
			exit(ret);
		}
		nr_procs++;

		p.sched_priority = priorities[i];
		if (sched_setscheduler(pids[i],SCHED_FIFO,&p)) {
			perror("sched_setscheduler");
			goto out;
		}

		
		/* parent */
	}

	
	signal(SIGINT,catchall);
	signal(SIGILL,catchall);
	signal(SIGFPE,catchall);
	signal(SIGSEGV,catchall);
	signal(SIGBUS,catchall);

	sleep(1);
	printf("parent zeroing semaphore\n");

	sops.sem_op = -1;
	
	if (semop(semid,&sops,1) < 0) {
		perror("semop");
		ret = -1;
		goto out;
	}

	while (nr_procs) {
		int status;
		pid_t pid;
		if ((pid = wait(&status)) < 0) {
			perror("wait");
			break;
		}
		for (i=0; i < NR_PROCS; i++) {
			if (pids[i] == pid) {
				pids[i] = 0;
				nr_procs--;
			}
		}
		
	}

	if (logdev_switch_set(0)) {
		perror("logdev_switch_off");
	}

 out:
	cleanup();
	exit(ret);
}

--=-3MphZyM2UJs5TDX5Bjrl
Content-Disposition: attachment; filename=list.h
Content-Type: text/x-chdr; name=list.h; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#ifndef __USER_LIST_H
#define __USER_LIST_H

#include <sys/types.h>
#include <unistd.h>

#define DEBUG_LIST

#ifdef DEBUG_LIST
#include <sys/types.h>
#include <signal.h>
#ifndef LIST_BUG
#define LIST_BUG() do { printf(">>>>> list bug <<<< at %d\n",__LINE__); kill(getpid(),SIGSEGV); } while(0)
#endif
#define __LIST_MAGIC 0xdeabbeef
#define __LIST_MAGIC_POISON 0xbeefdead
#define __LIST_MAGIC_COMMA , __LIST_MAGIC
#define __LIST_MAGIC_ASSIGN(x) (x).magic = __LIST_MAGIC;
#else
#define __LIST_MAGIC
#define __LIST_MAGIC_COMMA
#define __LIST_MAGIC_ASSIGN(x) 
#endif

#define __LIST_POISON ((struct list_head *)-1)

struct list_head {
	struct list_head *next;
	struct list_head *prev;
#ifdef DEBUG_LIST
	int magic;
#endif
};

#define LIST_HEAD_INIT(x) { &x, &x __LIST_MAGIC_COMMA}
#define LIST_HEAD_DECLARE(x) struct list_head x = LIST_HEAD_INIT(x)
#define INIT_LIST_HEAD(x) do { (x).next = &x; (x).prev = &x; __LIST_MAGIC_ASSIGN(x)} while (0)

#define list_for_each(p,list) for(p=(list)->next; p != list; p=p->next)
#define list_for_each_reverse(p,list) for(p=(list)->prev; p != list; p=p->prev)
#define list_for_each_safe(p,n,list) for(p=(list)->next,n=p->next; p != list; p=n,n=p->next)

#ifdef DEBUG_LIST
static inline void list_check(struct list_head *x)
{
	struct list_head *p;
	list_for_each_reverse(p,x) { if (p->magic != __LIST_MAGIC) LIST_BUG(); }
	list_for_each(p,x) { if (p->magic != __LIST_MAGIC) LIST_BUG(); }
}
#endif

static inline void list_add(struct list_head *x,struct list_head *list)
{
#ifdef DEBUG_LIST
	if (x->magic == __LIST_MAGIC_POISON && 
	    (x->next != __LIST_POISON || x->prev != __LIST_POISON))
		LIST_BUG();
#endif
	x->next = list->next;
	x->prev = list;
	list->next->prev = x;
	list->next = x;
#ifdef DEBUG_LIST
	x->magic = __LIST_MAGIC;
	list_check(list);
#endif
}

static inline void list_add_tail(struct list_head *x, struct list_head *list)
{
#ifdef DEBUG_LIST
	if (x->magic == __LIST_MAGIC && 
	    (x->next != __LIST_POISON || x->prev != __LIST_POISON))
		LIST_BUG();
#endif
	x->prev = list->prev;
	x->next = list;
	list->prev->next = x;
	list->prev = x;
#ifdef DEBUG_LIST
	x->magic = __LIST_MAGIC;
	list_check(list);
#endif
}

#define list_entry(p,type,list) ((type*)(((char*)(p))-((char*)&(((type*)NULL)->list))))

#define list_empty(list) ((list)->next == (list))
#define list_head(list) ((list)->next)

static inline void list_del(struct list_head *x)
{
#ifdef DEBUG_LIST
	if (x->magic != __LIST_MAGIC)
		LIST_BUG();
	list_check(x);
	x->magic = __LIST_MAGIC_POISON;
#endif
	x->prev->next = x->next;
	x->next->prev = x->prev;
	x->next = __LIST_POISON;
	x->prev = __LIST_POISON;
}

static inline struct list_head * pop_list_head(struct list_head *head)
{
	struct list_head *p;
	if (list_empty(head))
		return NULL;
	p = head->next;
	list_del(p);
#ifdef DEBUG_LIST
	list_check(head);
#endif
	return p;
}

#endif /* __USER_LIST_H */

--=-3MphZyM2UJs5TDX5Bjrl--

