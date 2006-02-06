Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWBFWAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWBFWAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWBFWAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:00:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43650 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932162AbWBFWAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:00:12 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id
 namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<43E7B452.2080706@watson.ibm.com>
	<m1ek2gi52a.fsf@ebiederm.dsl.xmission.com>
	<43E7BA78.6030501@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 14:56:42 -0700
In-Reply-To: <43E7BA78.6030501@watson.ibm.com> (Hubertus Franke's message of
 "Mon, 06 Feb 2006 16:07:04 -0500")
Message-ID: <m13biwi21x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> Eric W. Biederman wrote:
>> Hubertus Franke <frankeh@watson.ibm.com> writes:
>>
>>
>>>find_task_by_pid( pid ) { return find_task_pidspace_by_pid ( current->pspace,
>>>pid ); }
>>>
>>>and then only deal with the exceptional cases using find_task_pidspace_by_pid
>>>when the pidspace is different..
>> That is a possibility.  However I want to break some eggs so that the
>> users are updated appropriately.  It is only by a strenuous act of
>> will that I don't change the type of pid,tgid,pgrp,session.
>> The size of the changes is much less important than being clear.
>> So for I want find_task_by_pid to be an absolute interface.
>>
>
> Fair enough, valid answers .. I checked the patch and it would only take
> 19/33 instances out .. so not the end of the world.
>
>>
>>>>  Does the use of clone to create a new namespace instance look
>>>>  like the sane approach?
>>>>
>>>
>>>At he surface it looks OK .. how does this work in a multi-threaded
>>>process which does cloen ( CLONE_NPSPACE ) ?
>>>We discussed at some point that exec is the right place to do it,
>>>but what I get is that because this is the container_init task
>>>we are OK !
>>>A bit clarification would help here ...
>> Well the parent doesn't much matter.  But the child must have a fresh
>> start on all the groups of processes.  As all other groupings known by
>> a pid are per pspace, so they can't cross that line.
>>
>
> Now, on which kernel does this compile/work ?

2.6.latest plus a few patches I have already sent off to Andrew.

> Do you have a "helper" program you can share that starts/exec's an
> app under a new container (uhmm, namespace). No point for us to
> actually write that..

Ok here is my little helper/tester program.  Not beautiful but
it should work.

Eric


/* gcc -Wall -O2 -g chpid.c -o chpid */
#define _XOPEN_SOURCE
#define _XOPEN_SOURCE_EXTENDED
#define _SVID_SOURCE
#define _GNU_SOURCE
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/mount.h>
#include <sys/vfs.h>
#include <fcntl.h>
#include <unistd.h>
#include <sched.h>
#include <stdarg.h>
#include <dirent.h>

#ifndef MNT_FORCE
#define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
#endif /* MNT_FORCE */
#ifndef MNT_DETACH
#define MNT_DETACH	0x00000002	/* Just detach from the tree */
#endif /* MNT_DETACH */
#ifndef MNT_EXPIRE
#define MNT_EXPIRE	0x00000004	/* Mark for expiry */
#endif /* MNT_EXPIRE */

#ifndef MS_MOVE
#define MS_MOVE 8192
#endif
#ifndef MS_REC
#define MS_REC 16384
#endif

#ifndef CLONE_NPSPACE
#define CLONE_NPSPACE	0x04000000	/* New process space */
#endif


#ifndef PROC_SUPER_MAGIC
#define PROC_SUPER_MAGIC 0x9fa0
#endif /* PROC_SUPER_MAGIC */

struct user_desc;
static pid_t raw_clone(int flags, void *child_stack, 
	int *parent_tidptr, struct user_desc *newtls, int *child_tidptr)
{
	return syscall(__NR_clone, flags, child_stack, parent_tidptr, newtls, child_tidptr);
}

static int raw_pivot_root(const char *new_root, const char *old_root)
{
	return syscall(__NR_pivot_root, new_root, old_root);
}

static void (*my_exit)(int status) = exit;

static void die(char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fflush(stderr);
	fflush(stdout);
	my_exit(1);
}

static void *xmalloc(size_t size)
{
	void *ptr;
	ptr = malloc(size);
	if (!ptr) die("malloc of %d bytes failed: %s\n", size, strerror(errno));
	return ptr;
}

int main(int argc, char **argv, char **envp)
{
	pid_t pid;
	int status;
	struct rlimit rlim;
	int clone_flags;
	char **cmd_argv, *shell_argv[2];
	char *root = "/", *old = "/mnt";
	int i;
	int tty, tty_force;
	
	tty = 0;
	tty_force = 0;
	clone_flags = CLONE_NPSPACE | SIGCHLD;

	for (i = 1; (i < argc) && (argv[i][0] == '-'); i++) {
		if (strcmp(argv[i], "--") == 0) {
			break;
		}
		else if (((argc - i) >= 2) && (strcmp(argv[i], "-r") == 0)) {
			clone_flags |= CLONE_NEWNS;
			root = argv[i + 1];
			i++;
		}
		else if (((argc - i) >= 2) && (strcmp(argv[i], "-o") == 0)) {
			old = argv[i + 1];
			i++;
		}
		else if (strcmp(argv[i], "-n") == 0) {
			clone_flags |= CLONE_NEWNS;
		}
		else if (strcmp(argv[i], "--tty") == 0) {
			tty = 1;
		}
		else if (strcmp(argv[i], "--tty-force") == 0) {
			tty = 1; tty_force = 1;
		}
		else {
			die("Bad argument %s\n", argv[i]);
		}
	}
	cmd_argv = argv + i;
	if (cmd_argv[0] == NULL) {
		cmd_argv = shell_argv;
		shell_argv[0] = getenv("SHELL");
		shell_argv[1] = NULL;
	}
	if (cmd_argv[0] == NULL) {
		die("No command specified\n");
	}
#if 1
	fprintf(stderr, "cmd_argv: %s\n", cmd_argv[0]);
#endif
	if (root[0] != '/') {
		die("root path: '%s' not absolute\n", root);
	}
	if (old[0] != '/') {
		die("old path: '%s' not absolute\n", old);
	}
	
	pid = raw_clone(clone_flags, NULL, NULL, NULL, NULL);
	if (pid < 0) {
		fprintf(stderr, "clone_failed: pid: %d %d:%s\n", 
			pid, errno, strerror(errno));
		exit(2);
	}
	if (pid == 0) {
		/* In the child */
		int result;
		my_exit = _exit;

		/* FIXME allocate a process inside for controlling the new process space */

		fprintf(stderr, "pid: %d, ppid: %d pgrp: %d sid: %d\n",
			getpid(), getppid(), getpgid(0), getsid(0));
		/* If CLONE_NPSPACE isn't implemented exit */
		if (getpid() != 1) 
			die("CLONE_NPSPACE not implemented\n");
		if (clone_flags & CLONE_NEWNS) {
			struct statfs stfs;
			if (strcmp(root, "/") != 0) {
				char put_old[PATH_MAX];
				result = snprintf(put_old, sizeof(put_old), "%s%s", root, old);
				if (result >= sizeof(put_old))
					die("path name to long\n");
				if (result < 0)
					die("snprintf failed: %d:%s\n",
						errno, strerror(errno));
				
				/* Ensure I have a mount point at the directory I want to export */
				result = mount(root, root, NULL, MS_BIND | MS_REC, NULL);
				if (result < 0)
					die("bind of '%s' failed: %d:%s\n",
						root, errno, strerror(errno));
				
				/* Switch the mount points */
				result = raw_pivot_root(root, put_old);
				if (result < 0)
					die("pivot_root('%s', '%s') failed: %d:%s\n",
						root, put_old, errno, strerror(errno));
				
				/* Unmount all of the old mounts */
				result = umount2(old, MNT_DETACH);
				if (result < 0)
					die("umount2 of '%s' failed: %d:%s\n",
						put_old, errno, strerror(errno));
			}

			result = statfs("/proc", &stfs);
			if ((result == 0) && (stfs.f_type == PROC_SUPER_MAGIC))  {
				/* Unmount and remount proc so it reflects the new pid space */
				result = umount2("/proc", 0);
				if (result < 0) 
					die("umount failed: %d:%s\n", errno, strerror(errno));
				
				result = mount("proc", "/proc", "proc", 0, NULL);
				if (result < 0)
					die("mount failed: %d:%s\n",
						errno, strerror(errno));
			}
		}
		if (tty) {
			pid_t sid, pgrp;
			sid = setsid();
			if (sid < 0)
				die("setsid failed: %d:%s\n",
					errno, strerror(errno));
			fprintf(stderr, "pid: %d, ppid: %d pgrp: %d sid: %d\n",
				getpid(), getppid(), getpgid(0), getsid(0));

			result = ioctl(STDIN_FILENO, TIOCSCTTY, tty_force);
			if (result < 0)
				die("tiocsctty failed: %d:%s\n",
					errno, strerror(errno));

			pgrp = tcgetpgrp(STDIN_FILENO);
			
			fprintf(stderr, "pgrp: %d\n", pgrp);

			fprintf(stderr, "pid: %d, ppid: %d pgrp: %d sid: %d\n",
				getpid(), getppid(), getpgid(0), getsid(0));

		}
		result = execve(cmd_argv[0], cmd_argv, envp);
		die("execve of %s failed: %d:%s\n",
			cmd_argv[0], errno, strerror(errno));
	}
	/* In the parent */
	fprintf(stderr, "child pid: %d\n", pid);
	pid = waitpid(pid, &status, 0);
	fprintf(stderr, "pid: %d exited status: %d\n", 
		pid, status);
	if (pid < 0) {
		fprintf(stderr, "waitpid failed: %d %s\n",
			errno, strerror(errno));
		exit(9);
	}
	if (pid == 0) {
		fprintf(stderr, "waitpid returned no pid!\n");
		exit(10);
	}
	if (WIFEXITED(status)) {
		fprintf(stderr, "pid: %d exited: %d\n",
			pid, WEXITSTATUS(status));
	}
	if (WIFSIGNALED(status)) {
		fprintf(stderr, "pid: %d exited with a uncaught signal: %d %s\n",
			pid, WTERMSIG(status), strsignal(WTERMSIG(status)));
	}
	if (WIFSTOPPED(status)) {
		fprintf(stderr, "pid: %d stopped with signal: %d\n", 
			pid, WSTOPSIG(status));
	}
	return 0;
}
