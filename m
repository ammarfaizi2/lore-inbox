Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270657AbUJUKQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270657AbUJUKQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270650AbUJUKON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:14:13 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:24960 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S270629AbUJUKNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:13:14 -0400
Date: Thu, 21 Oct 2004 12:13:13 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: NPTL: Parent thread receives SIGHUP when child thread terminates?
Message-ID: <20041021101313.GA19246@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  one friend noticed that multithreaded programs (VMware...) behave erraticaly 
when started from rxvt or xterm with -e option.  We've traced it down to some 
strange SIGHUP delivery.

  When process is session leader, is it supposed to receive SIGHUP when child
thread terminates?  It did not receive SIGHUP under non-NPTL library, and IMHO
it was correct behavior.  Now all exiting threads cause SIGHUP to be delivered
to the parent, and parent (I'd say correctly) assumes that connection to the
program was broken and terminates.

  Probably disassociate_ctty(1) in do_exit() should not be invoked for all
tsk->signal->leader, but only for those with thread_group_empty() == 1, i.e.
when this process is really going away ?  Or only for thread group leader?

					Thanks,
						Petr Vandrovec




/* Build with:
gcc -W -Wall -O2 -o testhup testhup.c -lpthread -lutil

vana:~# ./testhup
Got SIGHUP!
vana:~# LD_ASSUME_KERNEL=2.4.1 ./testhup
vana:~#

*/

#include <pthread.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <fcntl.h>
#include <pty.h>
#include <stdlib.h>
#include <sys/wait.h>

static void sighup(int sig) {
	printf("Got SIGHUP!\n");
}

static void* child(void* arg) {
	return arg;
}

int main(void) {
	int master, slave;
	char name[100];

	openpty(&master, &slave, name, NULL, NULL);
	if (fork() == 0) {
		pthread_t pth;

		signal(SIGHUP, sighup);

		/* Become session leader. */
		if (setsid() == -1) {
			perror("SetSID");
			exit(1);
		}
		/* Assign controlling terminal. */
		if (open(name, O_RDWR) == -1) {
			perror("Open PTY");
			exit(2);
		}

		/* In reality code above is xterm/rxvt, code below is an
                 * innocent MT application execed by xterm/rxvt */

		/* Die with SIGHUP after child thread terminates. */
		pthread_create(&pth, NULL, child, NULL);
		pthread_join(pth, NULL);
		exit(3);
	} else {
		wait(NULL);
	}
	return 0;
}

