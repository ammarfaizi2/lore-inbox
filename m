Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVAaX6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVAaX6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVAaX5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:57:40 -0500
Received: from [139.30.44.16] ([139.30.44.16]:48777 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261446AbVAaXjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:39:54 -0500
Date: Tue, 1 Feb 2005 00:39:47 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Michael Buesch <mbuesch@freenet.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] "biological parent" pid
In-Reply-To: <200501312309.57464.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.53.0502010035480.19436@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
 <200501312309.57464.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005, Michael Buesch wrote:

> Quoting Tim Schmielau <tim@physik3.uni-rostock.de>:
> > The ppid of a process is not really helpful if I want to reconstruct the 
> > real history of processes on a machine, since it may become 1 when the
> > parent dies and the process is reparented to init.
> > 
> > I am not aware of concepts in Linux or other unices that apply to this
> > case. So I made up the "biological parent pid" bioppid (in contrast to the
> > adoptive parents pid) that just never changes.
> > Any user of it must of course remember that it doesn't need to be a valid 
> > pid anymore or might even belong to a different process that was forked in 
> > the meantime. bioppid only had to be a valid pid at time btime (it's
> > a (btime, pid) pair that unambiguously identifies a process).
> > 
> > Comments? (other that I just broke /proc/nnn/status parsing once again :-)
> 
> Eh, I can't see how this bioppid would be useful.
> Help me. Examples?

I'm trying to reconstruct the complete history of processes from the 
BSD accounting records. However, this is not very useful if a large 
fraction of the processes look as if they were started by init.

The following program will print the history in a form vaguely resembling
pstree output from the accounting file:

Tim


/* treeacct.c: use ac_pid and ac_ppid fields of struct acct_v3 to
 * build a tree of the process history.
 *
 * $Id: treeacct.c,v 0.8 2005/01/31 23:34:51 tim Exp tim $
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <assert.h>

#include <linux/acct.h>


#define TIME_FUZZ 4

void *alloc(size_t size)
{
	void *mem;
	
	mem = malloc(size);
	if (mem==NULL) {
		fprintf(stderr, "out of memory.\n");
		exit(5);
	}
	return mem;
}

/*
 * For each pid the acct records are organized in a singly linked list
 * named task_struct that is sorted by process start time (btime).
 *
 * They also form a tree according to their family relations.
 */
 
struct task_struct {
	/* struct task_struct *prev;  seems to be superfluous  */
	struct task_struct *next, *parent, *children, *siblings;
	struct acct_v3 *acct;
       };
	

struct pid_struct {
	struct pid_struct *next;
	struct task_struct *tasklist;
       };

/*
 * The task_structs are stored in a hash array of singly linked pid_struct
 * lists sorted by pid.
 */

#define PID_HASH_MASK 0xf

struct pid_struct *pid_hash[PID_HASH_MASK + 1];

/*
 * List of tasks without parents.
 */

struct task_struct *orphans=NULL;

/*
 * Find the task that is uniquely determined by it's pid and the
 * time when the pid was valid.
 * If create!=0 and the task doesn't exist yet, create it.
 */

struct task_struct *get_task(__u32 pid, __u32 time, int create)
{
	struct task_struct **task, *newtask;
	struct pid_struct **pidlist, *newpid;
	
	pidlist = &pid_hash[pid & PID_HASH_MASK];
	while (*pidlist!=NULL && (*pidlist)->tasklist->acct->ac_pid > pid)
		pidlist = &((*pidlist)->next);
	if (*pidlist==NULL || (*pidlist)->tasklist->acct->ac_pid < pid) {
		/* this pid doesn't exist */
		if (create!=0) {
			/* so create task */
			newtask = alloc(sizeof(struct task_struct));
			newtask->next = NULL;
			/* as well as a pidlist for it*/
			newpid = alloc(sizeof(struct pid_struct));
			newpid->next = *pidlist;
			newpid->tasklist = newtask;
			*pidlist = newpid;
			return newtask;
		} else {
			return NULL;
		}
	} else {
		/* find task on pidlist */ 
		task = &((*pidlist)->tasklist);
		while (*task!=NULL
		       && (*task)->acct->ac_btime < time)
			task = &((*task)->next);
		if (*task!=NULL
		     && (*task)->acct->ac_btime <= time+TIME_FUZZ
		     && (*task)->acct->ac_btime
		         + (__u32)((*task)->acct->ac_etime+1)
		        >= time-TIME_FUZZ) {
			/* process found */
			if (create!=0) {
				fprintf(stderr,
				        "warning: pid %lu, occurs twice"
				        " at time $lu.",
				        pid, time);
			} else {
				return *task;
			}
		}
		if (create!=0) {
			newtask = alloc(sizeof(struct task_struct));
			newtask->next = *task;
			*task = newtask;
			return newtask;
			
		} else {
			return NULL;
		}
	}
}

void fill_hashtab(struct acct_v3 *acct_record)
{
	struct task_struct *newtask;
	
	newtask = get_task(acct_record->ac_pid, acct_record->ac_btime, 1);
	assert(newtask!=0);
	
	newtask->acct = acct_record;
	newtask->children = NULL;
}

void tree_insert(struct task_struct *newtask)
{
	struct task_struct **task;

	newtask->parent = get_task(newtask->acct->ac_ppid,
	                           newtask->acct->ac_btime, 0);
	if (newtask->parent==NULL) {
		task = &orphans;
	} else {
		task = &(newtask->parent->children);
	}
	/* keep the list sorted */
	while ((*task) != NULL
	       && ((*task)->acct->ac_pid < newtask->acct->ac_pid
	           || ((*task)->acct->ac_pid == newtask->acct->ac_pid
		       && (*task)->acct->ac_btime < newtask->acct->ac_btime)))
		task = &((*task)->siblings);
	newtask->siblings = *task;
	*task = newtask;
}

void build_tree(unsigned long count)
{
	struct task_struct *newtask;
	struct pid_struct *pidlist;
	int i;
	
	for (i=PID_HASH_MASK; i>=0; i--) 
		for (pidlist = pid_hash[i];
		     pidlist!=NULL;
		     pidlist = pidlist->next)
			for (newtask = pidlist->tasklist;
			     newtask!=NULL;
			     newtask = newtask->next) {
				tree_insert(newtask);
				count--;
			}
	assert(count==0);
}

void dump_task(struct task_struct *task, unsigned long depth)
{
	struct task_struct *parent;
	time_t t;
	char start[32], end[32];
	unsigned long i;
	int pos;

	/* convert start and end time to ascii */
	t = task->acct->ac_btime;
	ctime_r(&t, start);
	/* start[24] = 0; */
	t += (unsigned long)(task->acct->ac_etime+1);
	ctime_r(&t, end);
	/* end[24] = 0; */

	for(i=1; i<2*depth; i++)
		putchar(' ');
	printf("%.*s (%lu, parent %lu) %nstart %s",
		ACCT_COMM,
		task->acct->ac_comm,
		task->acct->ac_pid,
		task->acct->ac_ppid,
		&pos,
		start);
	for(i=1; i<pos+2*depth; i++)
		putchar(' ');
	printf("end   %s", end);
}

void dump_tree(unsigned long count)
{
	__u32 pid, maxpid=PID_HASH_MASK;
	struct pid_struct *pidlist;
	struct task_struct *task, *parent;
	unsigned long dumped = 0;
	unsigned depth = 1;
	
	task = orphans;
	while (task!=NULL) {
		dump_task(task, depth);
		dumped++;
		if (task->children != NULL) {
			depth++;
			task = task->children;
		} else if (task->siblings != NULL) {
			task = task->siblings;
		} else {
			while (1) {
				task = task->parent;
				depth--;
				if (task==NULL)
					break;
				if (task->siblings != NULL) {
					task = task->siblings;
					break;
				}
			}
		}
	}
	fprintf(stderr, "dumped %lu records.\n", dumped);
	assert(depth==0);
	assert(dumped==count);
}

struct acct_v3
*mmap_acct_file(char *name, size_t *length, off_t *offset)
{
	int acctfile;
	struct acct_v3 *acct_records;
	struct stat acctfile_status;
	
	acctfile = open(name, O_RDONLY);
	if (acctfile==-1) {
		perror("error opening accounting file");
		exit(2);
	}
	if (fstat(acctfile, &acctfile_status)!=0) {
		perror("cannot fstat accounting file");
		exit(3);
	}
	*length = acctfile_status.st_size - *offset;
	fprintf(stderr, "length: %lu.\n", *length);
	
	acct_records = mmap(NULL, *length, PROT_READ, MAP_PRIVATE, acctfile,
	                    *offset);
	if (acct_records==MAP_FAILED) {
		perror("error mmapping accounting file");
		exit(4);
	}
	close(acctfile);
	
	return acct_records;
}

int main(int argc, char *argv[])
{
	struct acct_v3 *acct_records;
	size_t length = (unsigned long)(-1);
	off_t offset = 0;
	unsigned long count=0;
	
	if (argc!=2) {
		printf("usage: %s <acctfile>\n", argv[0]);
		return 1;
	}
	acct_records = mmap_acct_file(argv[1], &length, &offset);
	
	while (length>=sizeof(struct acct_v3)) {
		fill_hashtab(acct_records);
		acct_records++;
		length -= sizeof(struct acct_v3);
		count++;
	}
	if (length!=0)
		fprintf(stderr,"Inclomplete last record of length %lu.\n",
			       length);
	fprintf(stderr, "%lu records sucessfully read.\n", count);
	
	build_tree(count);
	dump_tree(count);

	return 0;
}
