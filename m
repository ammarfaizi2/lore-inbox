Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318466AbSGSIQ7>; Fri, 19 Jul 2002 04:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318467AbSGSIQ7>; Fri, 19 Jul 2002 04:16:59 -0400
Received: from ns.suse.de ([213.95.15.193]:48655 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318466AbSGSIQ4>;
	Fri, 19 Jul 2002 04:16:56 -0400
Date: Fri, 19 Jul 2002 10:19:50 +0200
From: Olaf Kirch <okir@suse.de>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: Locking patches (generic & nfs)
Message-ID: <20020719101950.A15819@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi,

I've been investigating an NFS locking problem a customer
of SuSE has had between an OpenServer machine (oh boy)
acting as the NFS client and a Linux box acting as the server.

In the process of debugging this, I came across a number of
bugs in the 2.4.18 kernel.


fs/locks.c:
	When a program locks the entire file, and then does an unlock
	of just the first byte in the file, the kernel will not modify
	the existing lock because of an overflow/signedness problem.

fs/lockd/svclock.c, include/linux/lockd.h:
	Consider the following scenario:
	 client A locks a file
	 client B requests a conflicting lock, and asks
		for "blocking" mode.
		lockd creates a "struct block" and attaches
		it to the existing lock
	 client A unlocks the file
		This causes a call to nlmsvc_notify_blocked,
		which puts the blocked lock onto a list
		of locks which sould be retried, setting
		the b_when field to 0.
	The next time lockd comes around to inspecting this
	list, it should notice that the lock can now be granted,
	and send a NLM_GRANTED message to client B.

	However, due to a signedness problem, the lock is
	appended to the *end* of the list, where it's never
	picked up.

fs/lockd/svcproc.c:
	There's an interoperability problem with OpenServer and
	probably other lockd implementations when it comes to
	handling of blocked locks.
	
	The way Linux clients deal with blocked locks goes
	like this

		C->S: lock this range, block if already taken
	 (1)	S->C: blocked
		...
		(some other client removes the conflicting lock)
	 (2)	S->C: the lock has been granted
	 	C->S: ack
	 (3)	C->S: lock this range, block if already taken
		S->C: granted

	At (1), the server records the fact that there's a blocking
	lock request, and uses it at (2) to find out whom to
	notify that the previously blocked request can now
	be granted. When the client then follows up with a
	LOCK call, the server notices that there's a blocked
	lock around and destroys it.

	Now OSR and maybe other lockd implementations do not
	follow up on the GRANTED callback with another LOCK 
	call. According to the NLM spec this is sufficient,
	because the GRANTED callback actually says "the lock
	has been granted". The reason the Linux client does an
	additional LOCK call is for stability (the NLM protocol is
	full of race conditions).

	However, for this to work properly, the Linux lockd must interpret
	the client's response to the GRANTED callback. When receiving
	this "ack" (in fact, it's a GRANTED_RES call), it must look
	up the corresponding blocked lock and take if off the
	list of blocked locks. If it doesn't, server and client
	get out of sync wrt to who is blocking on what lock, and
	start timing out).
	(If you want details of what's exactly going wrong, mail me
	for a packet trace).

	At any rate, the above means that lockd needs to handle
	GRANTED_MSG properly. The functionality to do so is already
	there; it's just the handling of the RPC call itself that
	wasn't there (or has been removed for some reason).

	The second patch does this (even though for NFSv2 only; the
	NFSv3 case is analogous).

I'm also attaching the test program I used.

Cheers
Olaf
-- 
Olaf Kirch     |  Anyone who has had to work with X.509 has probably
okir@suse.de   |  experienced what can best be described as
---------------+  ISO water torture. -- Peter Gutmann

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="linux-2.4.18-locks.patch"


	This patch addresses two problems.

	 fs/locks.c:
	 	When a program locked the entire file, and
		then did an unlock of just the first byte
		in the file, the kernel would not modify the
		existing lock because of an overflow/signedness
		problem.

	fs/lockd/*.c:
		Consider the following scenario:
		 client A locks a file
		 client B requests a conflicting lock, and asks
		 	for "blocking" mode.
			lockd creates a "struct block" and attaches
			it to the existing lock
		 client A unlocks the file
		 	This causes a call to nlmsvc_notify_blocked,
			which puts the blocked lock onto a list
			of locks which sould be retried, setting
			the b_when field to 0.
		The next time lockd comes around to inspecting this
		list, it should notice that the lock can now be granted,
		and send a NLM_GRANTED message to client B.

		However, due to a signedness problem, the lock is
		appended to the *end* of the list, where it's never
		picked up.

				Olaf Kirch -okir@suse.de

--- linux/fs/lockd/svclock.c.locks	Mon Jun 17 13:32:21 2002
+++ linux/fs/lockd/svclock.c	Mon Jun 17 13:37:36 2002
@@ -62,8 +62,8 @@
 		nlmsvc_remove_block(block);
 	bp = &nlm_blocked;
 	if (when != NLM_NEVER) {
-		if ((when += jiffies) == NLM_NEVER)
-			when ++;
+		if ((when += jiffies) > NLM_NEVER)
+			when = NLM_NEVER;
 		while ((b = *bp) && time_before_eq(b->b_when,when))
 			bp = &b->b_next;
 	} else
--- linux/fs/locks.c.locks	Thu Oct 11 16:52:18 2001
+++ linux/fs/locks.c	Mon Jun 17 13:32:35 2002
@@ -926,8 +926,11 @@
 				goto next_lock;
 			/* If the next lock in the list has entirely bigger
 			 * addresses than the new one, insert the lock here.
+			 *
+			 * be careful if fl_end == OFFSET_MAX --okir
 			 */
-			if (fl->fl_start > caller->fl_end + 1)
+			if (fl->fl_start > caller->fl_end + 1
+			 && caller->fl_end != OFFSET_MAX)
 				break;
 
 			/* If we come here, the new and old lock are of the
--- linux/include/linux/lockd/lockd.h.locks	Thu Nov 22 20:47:20 2001
+++ linux/include/linux/lockd/lockd.h	Mon Jun 17 13:38:51 2002
@@ -89,8 +89,11 @@
 /*
  * This is a server block (i.e. a lock requested by some client which
  * couldn't be granted because of a conflicting lock).
+ *
+ * XXX: Beware of signedness errors. b_when is passed as a signed long
+ * into time_before_eq et al. --okir
  */
-#define NLM_NEVER		(~(unsigned long) 0)
+#define NLM_NEVER		(0x7FFFFFF)
 struct nlm_block {
 	struct nlm_block *	b_next;		/* linked list (all blocks) */
 	struct nlm_block *	b_fnext;	/* linked list (per file) */

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="linux-2.4.18-lockd2.patch"

diff -ur linux/fs/lockd.orig/svcproc.c linux/fs/lockd/svcproc.c
--- linux/fs/lockd.orig/svcproc.c	Thu Jul 18 10:47:35 2002
+++ linux/fs/lockd/svcproc.c	Thu Jul 18 11:19:32 2002
@@ -344,6 +344,15 @@
 	return stat;
 }
 
+static int
+nlmsvc_proc_granted_res(struct svc_rqst *rqstp, struct nlm_res *argp,
+						void           *resp)
+{
+	dprintk("lockd: GRANTED_RES   called\n");
+	nlmsvc_grant_reply(&argp->cookie, argp->status);
+	return 0;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -546,14 +555,12 @@
 #define nlmsvc_decode_lockres	nlmsvc_decode_void
 #define nlmsvc_decode_unlockres	nlmsvc_decode_void
 #define nlmsvc_decode_cancelres	nlmsvc_decode_void
-#define nlmsvc_decode_grantedres	nlmsvc_decode_void
 
 #define nlmsvc_proc_none	nlmsvc_proc_null
 #define nlmsvc_proc_test_res	nlmsvc_proc_null
 #define nlmsvc_proc_lock_res	nlmsvc_proc_null
 #define nlmsvc_proc_cancel_res	nlmsvc_proc_null
 #define nlmsvc_proc_unlock_res	nlmsvc_proc_null
-#define nlmsvc_proc_granted_res	nlmsvc_proc_null
 
 struct nlm_void			{ int dummy; };
 
@@ -583,7 +590,7 @@
   PROC(lock_res,	lockres,	norep,		res,	void),
   PROC(cancel_res,	cancelres,	norep,		res,	void),
   PROC(unlock_res,	unlockres,	norep,		res,	void),
-  PROC(granted_res,	grantedres,	norep,		res,	void),
+  PROC(granted_res,	res,		norep,		res,	void),
   /* statd callback */
   PROC(sm_notify,	reboot,		void,		reboot,	void),
   PROC(none,		void,		void,		void,	void),

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="mlock.c"

/* Small locking test program. Run 2 or more copies on the client
 * in an NFS mounted directory.
 * Invoke as "mlock N" to test with N files. I tried both N = 2
 * and N = 20 (which produces more conflicts, but the logs are
 * also harder to track). --okir
 */
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#define MAXFILES 255

static int fds[MAXFILES];

static void
lockit(int num, int len, int unlock)
{
    if (lockf(fds[num], unlock? F_ULOCK : F_LOCK, len) < 0) {
      fprintf(stderr, "Failed to %slock tfile%03d: %s\n",
      			unlock? "un" : "", num, strerror(errno));
      exit(1);
    }
}

int
main(int argc, char **argv)
{
    int	nfiles = 0, counter, rounds = 0;

    if (argc >= 2)
        nfiles = atoi(argv[1]);

    if (nfiles <= 0 || nfiles > MAXFILES)
      nfiles = MAXFILES;

    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);

    printf("Opening %d files...  ", nfiles);
    for ( counter = 0; counter < nfiles; counter++ ) {
      char filename[64];

      sprintf( filename, "tfile%03d", counter );
      fds[counter] = open(filename, O_CREAT | O_RDWR, 0644);
      if (fds[counter] < 0) {
	perror(filename);
	return 1;
      }
    }
    printf("done.\n");

    while (1) {
      printf("\r%d", rounds++);

      for (counter = 0; counter < nfiles; counter++)
        lockit(counter, 0, 0);

      /* Change 0 to 1 in the lockit call to test for the
       * lock all/unlock at offset 1 bug */
      for (counter = 0; counter < nfiles; counter++)
        lockit(counter, 0, 1);
    }

    exit(0);
}

--FL5UXtIhxfXey3p5--
