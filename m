Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSCOGfT>; Fri, 15 Mar 2002 01:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311940AbSCOGfL>; Fri, 15 Mar 2002 01:35:11 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:51719 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311936AbSCOGe6>; Fri, 15 Mar 2002 01:34:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Hubertus Franke" <frankeh@us.ibm.com>
cc: torvalds@transmeta.com, matthew@hairy.beasts.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Starvation possible in futexes 8(
Date: Fri, 15 Mar 2002 17:37:22 +1100
Message-Id: <E16llL8-0001m7-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a bug (spotted by Anton) in my "starve.c" code, it wasn't
working properly.

Testing it properly, as below, shows how easy it is to starve someone
on SMP in the case of an extremely rapid release and reaquisition of a
lock.  Even doing a yield() in the up case doesn't help, if they are
scheduled on a different CPU.

I tried waiting for the woken task to ack, but I think it's better to
return to Hubertus' FUTEX_UP_FAIR.  Updated and attached (untested).

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/futex.h working-2.5.7-pre1-fair/include/linux/futex.h
--- linux-2.5.7-pre1/include/linux/futex.h	Wed Mar 13 13:30:38 2002
+++ working-2.5.7-pre1-fair/include/linux/futex.h	Fri Mar 15 16:59:54 2002
@@ -4,5 +4,6 @@
 /* Second argument to futex syscall */
 #define FUTEX_UP (0)
 #define FUTEX_DOWN (1)
+#define FUTEX_UP_FAIR (2)
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/kernel/futex.c working-2.5.7-pre1-fair/kernel/futex.c
--- linux-2.5.7-pre1/kernel/futex.c	Wed Mar 13 13:30:39 2002
+++ working-2.5.7-pre1-fair/kernel/futex.c	Fri Mar 15 17:34:44 2002
@@ -44,6 +44,9 @@
 /* FIXME: This may be way too small. --RR */
 #define FUTEX_HASHBITS 6
 
+/* Dummy value for page to mean "futex passed directly" */
+#define FUTEX_PASSED NULL
+
 /* We use this instead of a normal wait_queue_t, so we can wake only
    the relevent ones (hashed queues may be shared) */
 struct futex_q {
@@ -68,22 +71,30 @@
 	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
 }
 
-static inline void wake_one_waiter(struct list_head *head,
-				   struct page *page,
-				   unsigned int offset)
+static int wake_one_waiter(struct list_head *head,
+			   struct page *page,
+			   unsigned int offset,
+			   int pass)
 {
 	struct list_head *i;
+	int ret = 0;
 
 	spin_lock(&futex_lock);
 	list_for_each(i, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
 		if (this->page == page && this->offset == offset) {
+			if (pass) {
+				this->page = FUTEX_PASSED;
+				smp_wmb();
+			}
 			wake_up_process(this->task);
+			ret = 1;
 			break;
 		}
 	}
 	spin_unlock(&futex_lock);
+	return ret;
 }
 
 /* Add at end to avoid starvation */
@@ -154,7 +165,7 @@
 	current->state = TASK_INTERRUPTIBLE;
 	queue_me(head, &q, page, offset);
 
-	while (!decrement_to_zero(page, offset)) {
+	while (!decrement_to_zero(page, offset) && q.page != FUTEX_PASSED) {
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			break;
@@ -164,12 +175,14 @@
 	}
 	current->state = TASK_RUNNING;
 	unqueue_me(&q);
-	/* If we were signalled, we might have just been woken: we
-	   must wake another one.  Otherwise we need to wake someone
-	   else (if they are waiting) so they drop the count below 0,
-	   and when we "up" in userspace, we know there is a
-	   waiter. */
-	wake_one_waiter(head, page, offset);
+
+	/* If we were passed the mutex, we have it, even if signalled */
+	if (q.page == FUTEX_PASSED)
+		retval = 0;
+	else
+		/* We need to wake someone else to drop count below 0 */
+		wake_one_waiter(head, page, offset, 0);
+
 	return retval;
 }
 
@@ -181,7 +194,16 @@
 	atomic_set(count, 1);
 	smp_wmb();
 	kunmap(page);
-	wake_one_waiter(head, page, offset);
+	wake_one_waiter(head, page, offset, 0);
+	return 0;
+}
+
+/* We enforce fairness by never raising the mutex for someone random
+   to grab it, but pass it directly. */
+static int futex_up_fair(struct list_head *head, struct page *page, int offset)
+{
+	if (!wake_one_waiter(head, page, offset, 1))
+		return futex_up(head, page, offset);
 	return 0;
 }
 
@@ -211,6 +233,9 @@
 		break;
 	case FUTEX_DOWN:
 		ret = futex_down(head, page, pos_in_page);
+		break;
+	case FUTEX_UP_FAIR:
+		ret = futex_up_fair(head, page, pos_in_page);
 		break;
 	/* Add other lock types here... */
 	default:

================

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>
#include <sched.h>
#include "usersem.h"

#ifndef PROT_SEM
#define PROT_SEM 0x8
#endif

static void spinner(struct futex *sem, int hold)
{
	while (1) {
		futex_down(sem);
		if (hold) sleep(1);
		futex_up(sem);
	}
}

/* Test maximum time to lock given furious spinners. */
int main(int argc, char *argv[])
{
	struct futex *sem;
	unsigned int i;
	unsigned long maxtime = 0;
	int fd;
	pid_t children[100];

	if (argc != 4) {
		fprintf(stderr, "Usage: starve <file> <numspinners> <iterations>\n");
		exit(1);
	}

	fd = open(argv[1], O_RDWR);
	if (fd < 0) {
		perror("opening file");
		exit(1);
	}
	sem = mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (sem == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}

	if (futex_region(sem, 4096) != 0) {
		perror("futex_region");
		exit(1);
	}

	futex_init(sem);
	for (i = 0; i < atoi(argv[2]); i++) {
		children[i] = fork();
		if (children[i] == 0)
			spinner(sem, 1);
	}
	
	for (i = 0; i < atoi(argv[3]); i++) {
		struct timeval start, end, diff;

		sleep(1);
		gettimeofday(&start, NULL);
		futex_down(sem);
		gettimeofday(&end, NULL);
		futex_up(sem);
		timersub(&end, &start, &diff);
		printf("Wait time: %lu.%06lu\n", diff.tv_sec, diff.tv_usec);
		if (diff.tv_sec * 1000000 + diff.tv_usec > maxtime)
			maxtime = diff.tv_sec * 1000000 + diff.tv_usec;
	}

	/* Kill children */
	for (i = 0; i < atoi(argv[2]); i++)
		kill(children[i], SIGTERM);

	printf("Worst case: %lu\n", maxtime);
	exit(0);
}

