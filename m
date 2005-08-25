Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVHYBNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVHYBNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVHYBNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:13:22 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39558 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932462AbVHYBNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:13:22 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124917003.5711.8.camel@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124749192.17515.16.camel@dhcp153.mvista.com>
	 <1124756775.5350.14.camel@localhost.localdomain>
	 <1124758291.9158.17.camel@dhcp153.mvista.com>
	 <1124760725.5350.47.camel@localhost.localdomain>
	 <1124768282.5350.69.camel@localhost.localdomain>
	 <1124908080.5604.22.camel@localhost.localdomain>
	 <1124917003.5711.8.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-SdJJ74aVVCo8dnk/Rm5y"
Organization: Kihon Technologies
Date: Wed, 24 Aug 2005 21:13:11 -0400
Message-Id: <1124932391.5527.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SdJJ74aVVCo8dnk/Rm5y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Well, after turning off hrtimers, I keep getting one bug. A possible
soft lockup with the ext3 code. But this didn't seem to be caused by the
changes I made. So just to be sure, I ran my test on the vanilla
2.6.13-rc6-rt11 and it gave the same bug too.  So, it looks like my
changes are now at par with what is out there with the rt11 release.
They both give the same bug! ;-)

Attached is the test I ran. I did a 

while : ; do ./test3a_rt ; done

Where test3a_rt is a C program that does adding, deleting and reading of
files, by different tasks that are each at a different priority.  Here's
the soft lockup I'm getting:

NFSD: starting 90-second grace period
BUG: test3a_rt:6138, possible softlockup detected on CPU#0!
 [<c01043f3>] dump_stack+0x23/0x30 (20)
 [<c014cf81>] softlockup_detected+0x41/0x60 (24)
 [<c014d090>] softlockup_tick+0xf0/0x100 (24)
 [<c012bbbb>] update_process_times+0x5b/0x80 (28)
 [<c011415e>] smp_apic_timer_interrupt+0xee/0x100 (36)
 [<c0103ec1>] apic_timer_interrupt+0x21/0x28 (124)
 [<c01c1641>] ext3_add_entry+0xd1/0x210 (60)
 [<c01c1e0d>] ext3_add_nondir+0x2d/0x80 (32)
 [<c01c1f1b>] ext3_create+0xbb/0x110 (40)
 [<c0180721>] vfs_create+0xf1/0x170 (44)
 [<c018105b>] open_namei+0x61b/0x6e0 (72)
 [<c016eb5f>] filp_open+0x3f/0x70 (92)
 [<c016f033>] sys_open+0x53/0x100 (44)
 [<c01033da>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00010000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (test3a_rt/6138 [f7ef61a0,  89]):
------------------------------

#001:             [f2eaddac] {(struct semaphore *)(&inode->i_sem)}
... acquired at:               open_namei+0xf9/0x6e0

NMI show regs on CPU#0:

Pid: 6138, comm:            test3a_rt
EIP: 0060:[<c0114929>] CPU: 0
EIP is at nmi_show_all_regs+0x89/0xd0
 EFLAGS: 00000046    Not tainted  (2.6.13-rc6-rt11-real)
EAX: 00000000 EBX: 000017fa ECX: 00000060 EDX: 00000080
ESI: 00000000 EDI: 0006c692 EBP: f07dbd48 DS: 007b ES: 007b
CR0: 8005003b CR2: b7e37ae0 CR3: 30850000 CR4: 000006d0
 [<c01013b4>] show_regs+0x164/0x16c (36)
 [<c0114a98>] nmi_watchdog_tick+0x128/0x2b0 (56)
 [<c01054bf>] default_do_nmi+0x7f/0x190 (52)
 [<c0105630>] do_nmi+0x50/0x60 (24)
 [<c010405a>] nmi_stack_correct+0x1d/0x22 (72)
 [<c014cf86>] softlockup_detected+0x46/0x60 (24)
 [<c014d090>] softlockup_tick+0xf0/0x100 (24)
 [<c012bbbb>] update_process_times+0x5b/0x80 (28)
 [<c011415e>] smp_apic_timer_interrupt+0xee/0x100 (36)
 [<c0103ec1>] apic_timer_interrupt+0x21/0x28 (124)
 [<c01c1641>] ext3_add_entry+0xd1/0x210 (60)
 [<c01c1e0d>] ext3_add_nondir+0x2d/0x80 (32)
 [<c01c1f1b>] ext3_create+0xbb/0x110 (40)
 [<c0180721>] vfs_create+0xf1/0x170 (44)
 [<c018105b>] open_namei+0x61b/0x6e0 (72)
 [<c016eb5f>] filp_open+0x3f/0x70 (92)
 [<c016f033>] sys_open+0x53/0x100 (44)
 [<c01033da>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0143f5c>] .... add_preempt_count+0x1c/0x20
.....[<c0114a7d>] ..   ( <= nmi_watchdog_tick+0x10d/0x2b0)

------------------------------
| showing all locks held by: |  (test3a_rt/6138 [f7ef61a0,  89]):
------------------------------

#001:             [f2eaddac] {(struct semaphore *)(&inode->i_sem)}
... acquired at:               open_namei+0xf9/0x6e0

NMI show regs on CPU#1:

Pid: 6137, comm:            test3a_rt
EIP: 0060:[<c01cd9c3>] CPU: 1
EIP is at do_get_write_access+0x83/0x560
 EFLAGS: 00000206    Not tainted  (2.6.13-rc6-rt11-real)
EAX: 000e201d EBX: f7ffe000 ECX: f71e49bc EDX: f71e49bc
ESI: f7f6b3bc EDI: f71e49bc EBP: f1409e94 DS: 007b ES: 007b
CR0: 8005003b CR2: b7fdb000 CR3: 326fb000 CR4: 000006d0
 [<c01013b4>] show_regs+0x164/0x16c (36)
 [<c0114a98>] nmi_watchdog_tick+0x128/0x2b0 (56)
 [<c01054bf>] default_do_nmi+0x7f/0x190 (52)
 [<c0105630>] do_nmi+0x50/0x60 (24)
 [<c010405a>] nmi_stack_correct+0x1d/0x22 (132)
 [<c01cded5>] journal_get_write_access+0x35/0x50 (28)
 [<c01c2b02>] ext3_orphan_del+0x1a2/0x230 (80)
 [<c01bae03>] ext3_delete_inode+0x73/0x110 (24)
 [<c018cad9>] generic_delete_inode+0x99/0x160 (28)
 [<c018cd1d>] generic_drop_inode+0x1d/0x30 (12)
 [<c018cda0>] iput+0x70/0x80 (20)
 [<c0181ee0>] sys_unlink+0x110/0x140 (96)
 [<c01033da>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0143f5c>] .... add_preempt_count+0x1c/0x20
.....[<c0114a7d>] ..   ( <= nmi_watchdog_tick+0x10d/0x2b0)

------------------------------
| showing all locks held by: |  (test3a_rt/6137 [f5d437f0,  90]):
------------------------------

#001:             [f709cc88] {(struct semaphore *)(&s->s_lock)}
... acquired at:               ext3_orphan_del+0x3a/0x230



Well, looking at this further, it seems to release somehow, and
continue, since I've got multiple "possible soft lockups", by different
threads. But It doesn't seem to go any further.  Somethings spinning
quite a bit, and something else must be starved.  I'll look further into
this.

So, Ingo, what do you think of the changes so far?  Do you feel that it
is stable enough to send you an actual real patch. That way we can work
together in cleaning it up and get all the other kinks out.

Also, let me know if you are getting this.  The last couple of messages
I sent, never reached me on the LKML, and I sent the last one 4 hours
ago. :-(

Thomas, I did get your reply.

-- Steve


--=-SdJJ74aVVCo8dnk/Rm5y
Content-Disposition: attachment; filename=test3a_rt.c
Content-Type: text/x-csrc; name=test3a_rt.c; charset=us-ascii
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


static char *testdir = "/tmp/test3a";

static int reader (int i);
static int deleter (int i);
static int creator (int i);

typedef int (*callfunc_t)(int);

#define NR_PROCS 5
pid_t pids[NR_PROCS];
callfunc_t dofunc[NR_PROCS] = {
	deleter,
	creator,
	reader,
	reader,
	reader
};

int priorities[NR_PROCS] = {
	9,
	10,
	11,
	12,
	13,
};

key_t semkey;
key_t shmkey;
int semid = -1;
int shmid = -1;
int safe = 0;
int *flags;

static void remove_testdir(void);

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
	remove_testdir();

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
	struct sembuf sops;
	int semid;

	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(semkey,1,0)) < 0) {
		perror("semget");
		return;
	}
	
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
	struct timespec ts = {0,250000000UL};
	time_t t;
	char timebuf[30];
	unsigned long long starttsc, nowtsc;

	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(semkey,1,0)) < 0) {
		perror("semget");
		return -1;
	}

	if (gettimeofday(&starttv,NULL) < 0) {
		perror("gettimeofday");
		return -1;
	}

	memset (&deltatv,0,sizeof(deltatv));

	endtv.tv_sec = 10;
	endtv.tv_usec = 0;

	add_timeval(&starttv,&endtv,&endtv);
	printf("reader %d grabbing waiting on sem\n",i);
	printf("(id=%d) start time is %ld.%06ld\n",i,starttv.tv_sec,starttv.tv_usec);
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		return -1;
	}

	logdev_print(logfd,"reader %d past semaphore\n",i);


	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;

	printf("reader %d starting loop (%s)\n",i,timebuf);
	logdev_print(logfd,"reader %d (pid %d) starting loop (%s)\n",i,getpid(),timebuf);
	lasttv = starttv;
	asm ("rdtsc" : "=A"(starttsc));
	
	chdir("/");
	read_dirs("/tmp");
	
	do {
		struct list_head *p;
		struct dir_item *item;

		asm ("rdtsc" : "=A"(nowtsc));
		if (safe && (nowtsc - starttsc > 8000000000ULL)) {
			printf("now - start > 8000000000\n");
			break;
		}
		
		
		if (list_empty(&dirs)) {
			nanosleep(&ts,NULL);
			read_dirs("/tmp");
			if (list_empty(&dirs))
				/* ?? */
				break;
		}

		p = dirs.next;
		list_del(p);
		item = list_entry(p,struct dir_item, list);
		printf("%d: reading dir %s\n",i,item->dir);
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
	} while(compare_timeval(&endtv,&tv) > 0);
	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;
	logdev_print(logfd,"spinner %d (pid %d) done (%s)\n",i,getpid(),timebuf);
	printf("spinner %d ended loop (%s)  (%d.%06d secs delta)\n",
	       i,timebuf,(int)deltatv.tv_sec,(int)deltatv.tv_usec);
	printf(" (id=%d) end time is %ld.%06ld\n",i,tv.tv_sec,tv.tv_usec);
	printf(" (id=%d) end time should be %ld.%06ld\n",i,endtv.tv_sec,endtv.tv_usec);
	

	/*
	 * When the readers are done, stop the others that don't
	 * have any other test to stop with. No locks needed, we
	 * all just set it to one.
	 */
	*flags = 1;
	return 0;
}

void delete_all(char *dirname)
{
	DIR *dir;
	struct dirent *dent;
	int len = strlen(dirname);
	char *name;
	struct sembuf sops;
	int semid;
	
	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(semkey,1,0)) < 0) {
		perror("semget");
		return;
	}
	
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

		unlink(name);
		free(name);
	}
 out:
	closedir(dir);
}

static int deleter(int i)
{
	struct sembuf sops;
	int semid;

	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(semkey,1,0)) < 0) {
		perror("semget");
		return -1;
	}

	printf("deleter %d grabbing waiting on sem\n",i);
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		return -1;
	}

	logdev_print(logfd,"deleter %d past semaphore\n",i);

	while (!*flags) {
		delete_all(testdir);
	}

	return 0;
}

static int creator(int i)
{
	struct sembuf sops;
	int semid;
	int x;
	char name[100];

	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(semkey,1,0)) < 0) {
		perror("semget");
		return -1;
	}

	mkdir(testdir,0777);

	printf("creator %d grabbing waiting on sem\n",i);
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		return -1;
	}

	logdev_print(logfd,"creator %d past semaphore\n",i);

	while (!*flags) {
		int fd;
		char *garbage = "garbage\n";
		snprintf(name,100,"%s/dummy%d",testdir,x++);
		if ((fd = open(name,O_CREAT|O_WRONLY,0777)) < 0) {
			perror(name);
			continue;
		}
		write(fd,garbage,strlen(garbage));
		close(fd);
	}

	return 0;
}

static void remove_testdir(void)
{
	delete_all(testdir);
	rmdir(testdir);
}


void usage(char **argv)
{
	char *arg = argv[0];
	char *p = arg+strlen(arg);

	while (p >= arg && *p != '/') p--;
	p++;

	printf("\nusage: %s [-sn]\n"
	       "  -s : safe mode. Have the readers use the tsc to stop\n"
	       "  -n : run without RT\n"
	       "\n",p);
	exit(-1);
}

int main (int argc, char **argv)
{
	int ret=0;
	int i;
	int nr_procs=0;
	int noprio = 0;
	struct sembuf sops;
	int c;

	opterr = 0;
	while ((c=getopt(argc,argv,"hsn")) >= 0) {
		switch (c) {
		case 's':
			safe = 1;
			break;
		case 'n':
			noprio = 1;
			break;
		case 'h':
		default:
			printf("\n");
			if (c != ':' && tolower(optopt) != 'h' && optopt != '?')
				printf("unknown option: %c\n",optopt);
			usage(argv);
		}
	}

	semkey = ftok(argv[0],123);
	shmkey = ftok(argv[0],456);
	
	if ((semid = semget(semkey,1,IPC_CREAT|IPC_EXCL|0600)) < 0) {
		perror("semget");
		exit (-1);
	}

	if ((shmid = shmget(shmkey,30,IPC_CREAT|IPC_EXCL|0600)) < 0) {
		perror("shmget");
		goto out;
	}
	
	if ((flags = shmat(shmid, NULL, 0)) == (void*)-1) {
		perror("shmat");
		goto out;
	}

	*flags = 0;
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

		if (!noprio && priorities[i]) {
			p.sched_priority = priorities[i];
			if (sched_setscheduler(pids[i],SCHED_FIFO,&p)) {
				perror("sched_setscheduler");
				goto out;
			}
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

--=-SdJJ74aVVCo8dnk/Rm5y
Content-Disposition: attachment; filename=list.h
Content-Type: text/x-chdr; name=list.h; charset=us-ascii
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

--=-SdJJ74aVVCo8dnk/Rm5y--

