Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133009AbRDYNIj>; Wed, 25 Apr 2001 09:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRDYNIh>; Wed, 25 Apr 2001 09:08:37 -0400
Received: from belcebu.upc.es ([147.83.2.63]:63116 "EHLO belcebu.upc.es")
	by vger.kernel.org with ESMTP id <S133009AbRDYNIO>;
	Wed, 25 Apr 2001 09:08:14 -0400
Message-ID: <3AE6CD6B.745E@mat.upc.es>
Date: Wed, 25 Apr 2001 15:13:16 +0200
From: Francesc Oller <francesc@mat.upc.es>
Reply-To: francesc@mat.upc.es
Organization: UPC
X-Mailer: Mozilla 3.01 (Win95; I)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: a fork-like C-wrapper for clone(), DONE!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Some days before I asked for a fork-like C-wrapper for clone() which
could be used like fork() thinking that somebody could have done it
before but I only received two e-mails saying that probably it
wasn't worth it or even it was complete non-sense.

Therefore, I've done it myself. Code follows.

Please, before beginning to flame me for doing "such kind of non-
standard threading model", I've to say that IMHO it has some merit.
After all it was E.W.Dijkstra who invented it in the late sixties.

Greetings from Barcelona

Francesc Oller


cut here ------------------------------

/*
* Implementation of Dijkstra's parbegin/parend using clone()
* Modified from original Linus' clone.c example
* A proof of concept for academic purposes
* (c) Francesc Oller 2001, Linus Torvalds
* Under GPL license
*/

#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sched.h>

#include <linux/unistd.h>

#include "tinyx.h"

#define STACKSIZE 4096 /* 4 KB */

pid_t myclone(void)
{
	long retval;
	long *childsp;
	register long * motherbp __asm__ ("%ebp");

	/*
	 * allocate new stack for child
	 */
	childsp = malloc(STACKSIZE);
	if (!childsp)
		return -1;
	childsp = (long *)(((char *)childsp) + STACKSIZE);
	*--childsp = *(motherbp + 1);	/* push return address */
	*--childsp = *motherbp;		/* push mother's bp */

	/*
	 * Do clone() system call. We need to do the low-level stuff
	 * entirely in assembly as we're returning with a different
	 * stack in the child process and we couldn't otherwise guarantee
	 * that the program doesn't use the old stack incorrectly.
	 *
	 * Parameters to clone() system call:
	 *	%eax - __NR_clone, clone system call number
	 *	%ebx - clone_flags, bitmap of cloned data
	 *	%ecx - new stack pointer for cloned child
	 *
	 * In this example %ebx is CLONE_VM | CLONE_FS | CLONE_FILES |
	 * CLONE_SIGHAND which shares as much as possible between parent
	 * and child. (We or in the signal to be sent on child termination
	 * into clone_flags: SIGCHLD makes the cloned process work like
	 * a "normal" unix child process)
	 *
	 * The clone() system call returns (in %eax) the pid of the newly
	 * cloned process to the mother, and 0 to the cloned process. If
	 * an error occurs, the return value will be the negative errno.
	 *
	 * Prior to the creation of the child process, we have stored
	 * return adress and caller's bp in child's stack. Child will 
	 * restore caller's bp and jmp to the post-clone adress. The
	 * "_exit()" system call at the child's body end will terminate
	 * the child.
	 */
	__asm__ __volatile__(
		"int $0x80\n\t"		/* Linux/i386 system call */
		"testl %0,%0\n\t"	/* check return value */
		"jne 1f\n\t"		/* jump if mother */
		"popl %%ebp\n\t"	/* restore caller's bp */
		"ret\n"			/* jmp to return address */
		"1:\t"
		:"=a" (retval)
		:"0" (__NR_clone),
		 "b" (CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD),
		 "c" (childsp));

	if (retval < 0) {
		errno = -retval;
		retval = -1;
	}
	return retval;
}

int show_same_vm;

int main()
{
	int fd;

	fd = open("/dev/null", O_RDWR);
	if (fd < 0) {
		perror("/dev/null");
		exit(1);
	}
	printf("mother:\t fd = %d\n", fd);
	show_same_vm = 10;
	printf("mother:\t vm = %d\n", show_same_vm);

	switch(myclone())
	{
		case -1: perror("clone"); exit(1);
		case  0: 
			printf("child:\t fd = %d\n", fd);
			show_same_vm = 5;
			printf("child:\t vm = %d\n", show_same_vm);
			close(fd);
			_exit(0);
		default:
			sleep(1);
			printf("mother:\t vm = %d\n", show_same_vm);
			if (write(fd, "c", 1) < 0)
				printf("mother:\t child closed our file descriptor\n");
	}

	/*
	 * The implementation of this construct is left as an exercise
	 * to the reader ;-)
	 */
	/*parbegin
		altpar
			printf("I'm thread 1\n");
			parbegin
				altpar
					printf("I'm thread 4, child of thread 1\n");
				altpar
					printf("I'm thread 5, child of thread 1\n");
				altpar
					printf("I'm thread 6, child of thread 1\n");
			parend
		altpar
			printf("I'm thread 2\n");
		altpar
			printf("I'm thread 3\n");
	parend*/
	return 0;
}

cut here -----------------------------
