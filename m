Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbTCVPzU>; Sat, 22 Mar 2003 10:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262897AbTCVPxg>; Sat, 22 Mar 2003 10:53:36 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:59781 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262800AbTCVPv4>;
	Sat, 22 Mar 2003 10:51:56 -0500
Message-ID: <3E7C8927.5030808@colorfullife.com>
Date: Sat, 22 Mar 2003 17:02:47 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
References: <Pine.LNX.4.44.0303162203590.11399-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0303162203590.11399-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------070306000201000805020305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070306000201000805020305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:

>On Sun, 16 Mar 2003, Manfred Spraul wrote:
>
>  
>
>>Below is a proposal to get rid of the quadratic behaviour of
>>proc_pid_readir(): Instead of storing the task number in f_pos and
>>walking tasks by tasklist order, the pid is stored in f_pos and the
>>tasks are walked by (hash-mangled) pid order.
>>    
>>
>
>have you seen my "procfs/procps threading performance speedup" patch? It
>does something like this.
>  
>
The implementation is flawed:

>+static int get_pid_list(int index, int *pids, struct file *filp)
> {
>-	struct task_struct *p;
>-	int nr_pids = 0;
>+	int nr_pids = 0, pid = 0, pid_cursor = (int)filp->private_data;
>+	struct task_struct *g = NULL, *p = NULL;
> 
>-	index--;
> 	read_lock(&tasklist_lock);
>-	for_each_process(p) {
>-		int pid = p->pid;
>-		if (!pid)
>-			continue;
>+	if (pid_cursor) {
>+		p = find_task_by_pid(pid_cursor);
>+		g = p->group_leader;
>+	}
>+	if (!p) {
>+		g = p = &init_task;
>+		index--;
>+	} else
>+		index = 0;
>+
>+	goto inside;
>+
>+	__do_each_thread(g, p) {
> 		if (--index >= 0)
> 			continue;
>-		pids[nr_pids] = pid;
>+		pid = p->pid;
>+		if (!pid)
>+			BUG();
>+		if (p->tgid != p->pid)
>+			pids[nr_pids] = -pid;
>+		else
>+			pids[nr_pids] = pid;
> 		nr_pids++;
> 		if (nr_pids >= PROC_MAXPIDS)
>-			break;
>-	}
>+			goto out;
>+inside:
>+		;
>+	} while_each_thread(g, p);
>+out:
>+	filp->private_data = (void *)pid;
> 	read_unlock(&tasklist_lock);
>+
> 	return nr_pids;
> }
> 
>
get_pid_list stores up to 20 pids in an array, and the last pid in the 
array is stored in filp->private_data, for the next call.

> int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
> {
>-	unsigned int pid_array[PROC_MAXPIDS];
>+	int pid_array[PROC_MAXPIDS];
> 	char buf[PROC_NUMBUF];
> 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
> 	unsigned int nr_pids, i;
>@@ -1192,14 +1217,16 @@ int proc_pid_readdir(struct file * filp,
> 		nr++;
> 	}
> 
>-	nr_pids = get_pid_list(nr, pid_array);
>+	nr_pids = get_pid_list(nr, pid_array, filp);
> 
> 	for (i = 0; i < nr_pids; i++) {
>-		int pid = pid_array[i];
>+		int pid = abs(pid_array[i]);
> 		ino_t ino = fake_ino(pid,PROC_PID_INO);
> 		unsigned long j = PROC_NUMBUF;
> 
> 		do buf[--j] = '0' + (pid % 10); while (pid/=10);
>+		if (pid_array[i] < 0)
>+			buf[--j] = '.';
> 
> 		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0)
> 			break;
>  
>
But:  proc_pid_readdir() doesn't use all 20 pids: It may return early if 
the user space buffer is full. Then your patch skips a few threads. 
Attached is my test app:

./getdents /proc 0 24 returns just 3 threads,
./getdents /proc 0 4000 returns (probably) all: 66 threads or processes.

--
    Manfred

--------------070306000201000805020305
Content-Type: text/plain;
 name="getdents.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="getdents.cpp"

/*
 * gendents.cpp: getdents tester.
 *
 * Copyright (C) 1999, 2001, 2003 by Manfred Spraul.
 *	All rights reserved except the rights granted by the GPL.
 *
 * Redistribution of this file is permitted under the terms of the GNU 
 * General Public License (GPL) version 2 or later.
 * $Header: /pub/home/manfred/cvs-tree/getdents/getdents.cpp,v 1.2 2003/03/22 16:01:34 manfred Exp $
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/types.h>
#include <linux/dirent.h>
#include <linux/unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

#define BUFSZ	131072
unsigned char entries[BUFSZ];

#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
type name(type1 arg1,type2 arg2,type3 arg3) \
{ \
long __res; \
__asm__ volatile ("int $0x80" \
	: "=a" (__res) \
	: "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
		  "d" ((long)(arg3))); \
__syscall_return(type,__res); \
}

_syscall3(int, getdents, uint, fd, struct dirent *, dirp, uint, count);

static void hexdump(unsigned char* array, int len)
{
	int i;
	for(i=0;i<len;i++) {
		if ((i%16) == 0)
			printf("\n%03x:", i);
		if((i%16)==8)
			printf(":");
		printf("%02x ",(unsigned)array[i]); 
	}
	printf("\n");
}

int main(int argc, char **argv)
{
	int fd, retval, bufsz;
	printf("GETDENTS <dir> <offset> [<bufsz>]\n");
	if (argc < 3 || argc > 4)
		return 1;
	fd = open(argv[1],O_RDONLY);
	if (fd < 0) {
		printf("open failed, errno %d.\n", errno);
		return 2;
	}
	if (argc == 4)
		bufsz = atoi(argv[3]);
	 else
		bufsz = BUFSZ;
	lseek(fd, atoi(argv[2]), SEEK_SET);
	for(;;) {
		int offset = 0;

		retval = getdents(fd, (struct dirent *)entries, bufsz);
		printf("retval is %d.\n", retval);
		if (retval <= 0)
			break;
		while (offset < retval) {
			struct dirent *walk = (struct dirent *)(&entries[offset]);
		//	printf("dirent: %lxh.\n", (unsigned long)walk);
		//	printf("dirent->d_ino = %ld.\n", walk->d_ino);
		//	printf("dirent->d_off = %ld.\n", walk->d_off);
		//	printf("dirent->d_reclen = %ld.\n", walk->d_reclen);
			printf("dirent->d_name = '%s'@%ld\n", walk->d_name, walk->d_off);
			offset += walk->d_reclen;
		}
	}
	return 0;
}

--------------070306000201000805020305--

