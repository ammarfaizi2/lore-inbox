Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTLaLpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTLaLpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:45:17 -0500
Received: from codepoet.org ([166.70.99.138]:17381 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S264155AbTLaLpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:45:03 -0500
Date: Wed, 31 Dec 2003 04:45:01 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] fix broken 2.4.x rt_sigprocmask error handling
Message-ID: <20031231114501.GA14865@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

SuSv3 says:

	"The argument 'how' indicates the way in which the set is
	changed, and the application shall ensure it consists of
	one of [SIG_BLOCK, SIG_UNBLOCK, SIG_SETMASK] ... If
	sigprocmask() fails, the thread's signal mask shall not
	be changed."

The sigprocmask(2) syscall implements this correctly, however the
rt_sigprocmask(2) syscall in 2.4.x does not comply with SuSv3.
When this syscall is provided with a valid 'set' value, and a
bogus value for 'how', the process signal mask is still changed.

The attached test application demonstrates the problem.  This
patch below fixes it.  Please apply!


--- linux/kernel/signal.c.orig	2003-12-31 04:01:59.000000000 -0700
+++ linux/kernel/signal.c	2003-12-31 04:38:06.000000000 -0700
@@ -879,16 +879,16 @@
 			error = -EINVAL;
 			break;
 		case SIG_BLOCK:
-			sigorsets(&new_set, &old_set, &new_set);
+			sigorsets(&current->blocked, &old_set, &new_set);
 			break;
 		case SIG_UNBLOCK:
-			signandsets(&new_set, &old_set, &new_set);
+			signandsets(&current->blocked, &old_set, &new_set);
 			break;
 		case SIG_SETMASK:
+			current->blocked = new_set;
 			break;
 		}
 
-		current->blocked = new_set;
 		recalc_sigpending(current);
 		spin_unlock_irq(&current->sigmask_lock);
 		if (error)
--- linux/CREDITS	2003-12-02 13:04:50.000000000 -0700
+++ linux/CREDITS	2003-12-02 13:04:50.000000000 -0700
@@ -82,13 +82,13 @@
 S: USA
 
 N: Erik Andersen
-E: andersee@debian.org
-W: http://www.xmission.com/~andersen
-P: 1024/FC4CFFED 78 3C 6A 19 FA 5D 92 5A  FB AC 7B A5 A5 E1 FF 8E
+E: andersen@codepoet.org
+W: http://www.codepoet.org/
+P: 1024D/30D39057 1BC4 2742 E885 E4DE 9301  0C82 5F9B 643E 30D3 9057
 D: Maintainer of ide-cd and Uniform CD-ROM driver, 
 D: ATAPI CD-Changer support, Major 2.1.x CD-ROM update.
-S: 4538 South Carnegie Tech Street
-S: Salt Lake City, Utah 84120
+S: 352 North 525 East
+S: Springville, Utah 84663
 S: USA
 
 N: Michael Ang

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--vkogqOf2sHV7VnPd
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test-setprocmask.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <signal.h>
#include <errno.h>
#include <sys/syscall.h>


#if 0

/* The sigprocmask syscall works correctly */
_syscall3(int, sigprocmask, int, how, const sigset_t *, set,
	sigset_t *, oldset);

#else

/* The rt_sigprocmask syscall currently fails */
_syscall4(int, rt_sigprocmask, int, how, const sigset_t *, set,
	sigset_t *, oldset, size_t, size);
int sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
{
	return rt_sigprocmask(how, set, oldset, _NSIG/8);
}

#endif

int main(void)
{
	sigset_t set;
	sigset_t oset;
	int r;

	sigemptyset(&set);
	sigemptyset(&oset);

	/* Block no signals since set is empty.
	 * oset will be set to the app default. */
	errno = 0;
	r = sigprocmask(SIG_SETMASK, &set, &oset);
	if (r != 0) {
		printf("r=%d : %m\n", r);
	}

	/* Block no signals since set is empty.
	 * oset will now also be empty. */
	errno = 0;
	r = sigprocmask(SIG_SETMASK, &set, &oset);
	if (r != 0) {
		printf("r=%d : %m\n", r);
	}

	/* * SuSv3 says:
	 *	"The * argument how indicates the way in which the set is
	 *	changed, and the application shall ensure it consists of one
	 *	of [SIG_BLOCK, SIG_UNBLOCK, SIG_SETMASK] ... If sigprocmask()
	 *	fails, the thread's signal mask shall not be changed."
	 *
	 * Attempt to block SIGHUP with a bogus 'how'.  This should fail,
	 * and return EINVAL, and oset should should still be empty. */
	errno = 0;
	r = sigaddset(&set, SIGHUP);
	if (r != 0) {
		printf("r=%d : %m\n", r);
	}
	errno = 0;
	r = sigprocmask(0xdeadbeef, &set, &oset);
	if (r != 0) {
		printf("Expected failure: %m\n");
	}

	/* Query the value of oset.  It should still be empty */
	errno = 0;
	r = sigprocmask(SIG_SETMASK, (sigset_t *)0, &oset);
	if (r != 0) {
		printf("r=%d : %m\n", r);
	}

	/* But oset is not empty!  This is contrary to SuSv3! */
	if (sigismember(&oset, SIGHUP)==1) {
		printf("FAIL -- oset was changed when we supplied an invalid 'how'\n");
		return 1;
	} else {
		printf("PASS\n");
	}

	return 0;
}

--vkogqOf2sHV7VnPd--
