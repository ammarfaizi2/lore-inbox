Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292776AbSCEWto>; Tue, 5 Mar 2002 17:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292968AbSCEWtf>; Tue, 5 Mar 2002 17:49:35 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:7946 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S292776AbSCEWtP>; Tue, 5 Mar 2002 17:49:15 -0500
To: frankeh@watson.ibm.com
Cc: "Rajan Ravindran" <rajancr@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
	<20020305195211.144FC3FE0C@smtp.linux.ibm.com>
	<87g03e3hdl.fsf@devron.myhome.or.jp>
	<20020305215759.21E623FFD3@smtp.linux.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 06 Mar 2002 07:48:53 +0900
In-Reply-To: <20020305215759.21E623FFD3@smtp.linux.ibm.com>
Message-ID: <87vgcazl4a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hubertus Franke <frankeh@watson.ibm.com> writes:

> > > @@ -153,13 +155,18 @@
> > >                               if(last_pid & 0xffff8000)
> > >                                     last_pid = 300;
> > >                               next_safe = PID_MAX;
> > > +                             goto repeat;
> > >                         }
> > > -                       goto repeat;
> > > +                       if(unlikely(last_pid == beginpid))
> > > +                             goto nomorepids;
> > > +                       continue;
> >
> > You changed it. No?
> 
> Yes, we changed but only the logic that once a pid is busy we start searching 
> for every task again. This is exactly the O(n**2) problem.
> Run the program and you'll see.

Run the attached file.

Result,
	new pid: 301, 300: pid 300, pgrp 301

new pid == task(300)->pgrp. This get_pid() has bug.
I'm missing something?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=get_pid.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>

#define spin_lock(x)
#define spin_unlock(x)
#define read_lock(x)
#define read_unlock(x)
#define unlikely(x)	(x)
#define SET_LINKS(p) do {			\
	(p)->next_task = &init_task;		\
	(p)->prev_task = init_task.prev_task;	\
	init_task.prev_task->next_task = (p);	\
	init_task.prev_task = (p);		\
} while (0)
#define REMOVE_LINKS(p) do {				\
	(p)->next_task->prev_task = (p)->prev_task;	\
	(p)->prev_task->next_task = (p)->next_task;	\
} while (0)
#define CLONE_PID	0x00001000	/* set if pid shared */
#define PID_MAX		0x8000

#define for_each_task(p) \
	for (p = &init_task ; (p = p->next_task) != &init_task ; )

struct task_struct {
	struct task_struct *next_task, *prev_task;
	pid_t pid;
	pid_t pgrp;
	pid_t session;
	pid_t tgid;
	int did_exec;
};

struct task_struct init_task = {
	next_task: 	&init_task,
	prev_task: 	&init_task,
	pid:		0,
	pgrp:		0,
	session:	0,
	tgid:		0,
	did_exec:	0,
};
struct task_struct *current = &init_task;
static pid_t last_pid;

static int get_pid(unsigned long flags)
{
	static int next_safe = PID_MAX;
	struct task_struct *p;
	int pid, beginpid;

	if (flags & CLONE_PID)
		return current->pid;

	spin_lock(&lastpid_lock);
	beginpid = last_pid;
	if((++last_pid) & 0xffff8000) {
		last_pid = 300;		/* Skip daemons etc. */
		goto inside;
	}
	if(last_pid >= next_safe) {
inside:
		next_safe = PID_MAX;
		read_lock(&tasklist_lock);
	repeat:
		for_each_task(p) {
			if(p->pid == last_pid	||
			   p->pgrp == last_pid	||
			   p->tgid == last_pid	||
			   p->session == last_pid) {
				if(++last_pid >= next_safe) {
					if(last_pid & 0xffff8000)
						last_pid = 300;
					next_safe = PID_MAX;
					goto repeat;
				}
				if(unlikely(last_pid == beginpid))
					goto nomorepids;
				continue;
			}
			if(p->pid > last_pid && next_safe > p->pid)
				next_safe = p->pid;
			if(p->pgrp > last_pid && next_safe > p->pgrp)
				next_safe = p->pgrp;
			if(p->tgid > last_pid && next_safe > p->tgid)
				next_safe = p->tgid;
			if(p->session > last_pid && next_safe > p->session)
				next_safe = p->session;
		}
		read_unlock(&tasklist_lock);
	}
	pid = last_pid;
	spin_unlock(&lastpid_lock);

	return pid;

nomorepids:
	read_unlock(&tasklist_lock);
	spin_unlock(&lastpid_lock);
	return 0;
}

static void fatal(char *msg)
{
	fprintf(stderr, "%s: %s", msg, strerror(errno));
	exit(1);
}

static struct task_struct *find_task_by_pid(pid_t pid)
{
	struct task_struct *tsk;

	for_each_task(tsk)
		if (tsk->pid == pid)
			return tsk;
	return NULL;
}

static struct task_struct *add_task(pid_t pid, pid_t pgrp, pid_t session,
				    pid_t tgid)
{
	struct task_struct *tsk;

	tsk = malloc(sizeof(struct task_struct));
	if (tsk == NULL)
		fatal("malloc");
	tsk->pid = pid;
	tsk->pgrp = pgrp;
	tsk->session = session;
	tsk->tgid = tgid;
	SET_LINKS(tsk);

	return tsk;
}

static void del_task(struct task_struct *tsk)
{
	REMOVE_LINKS(tsk);
	free(tsk);
}

int main()
{
	int i;
	pid_t pid, pgrp;
	struct task_struct *tsk;

	for (i = 1; i < PID_MAX; i++) {
		pid = get_pid(0);
		add_task(pid, pid, pid, pid);
	}
	/* exit() */
	tsk = find_task_by_pid(301);
	del_task(tsk);
	/* fork() */
	pgrp = pid = get_pid(0);
	add_task(pid, pid, pid, pid);
	/* exit() */
	tsk = find_task_by_pid(300);
	del_task(tsk);
	/* fork() */
	pid = get_pid(0);
	add_task(pid, pgrp, pid, pid);
	/* exit() */
	tsk = find_task_by_pid(301);
	del_task(tsk);

	/* fork() */
	pid = get_pid(0);
	add_task(pid, pgrp, pid, pid);

	tsk = find_task_by_pid(300);
	printf("new pid: %d, 300: pid %d, pgrp %d\n",
	       pid, tsk->pid, tsk->pgrp);

	return 0;
}

--=-=-=--
