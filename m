Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162016AbWKVKzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162016AbWKVKzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162055AbWKVKzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:55:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:47518 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1162053AbWKVKzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:55:45 -0500
X-Authenticated: #14349625
Subject: [rfc patch] Re: Sluggish system responsiveness on I/O
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christian <christiand59@web.de>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1163961295.5977.53.camel@Homer.simpson.net>
References: <200611181412.29144.christiand59@web.de>
	 <1163922694.7504.42.camel@Homer.simpson.net>
	 <1163958288.22176.82.camel@mindpipe>
	 <1163961295.5977.53.camel@Homer.simpson.net>
Content-Type: multipart/mixed; boundary="=-6WqoyMyILLH0h+IoNU10"
Date: Wed, 22 Nov 2006 11:57:42 +0100
Message-Id: <1164193062.7925.72.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6WqoyMyILLH0h+IoNU10
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greetings,

Problem:  If X or one of it's clients gets into a position where it
can't get it's work done and go to sleep, no sleep means no priority
boost.  The consequence is terrible interactivity.  Our sleep based
interactivity heuristics are very good, but not perfect.

Solution:  The simple patch belows acknowledges this shortcoming in
scheduler interactivity heuristics by making a(nother) concession to the
real world - it adds the complement of class SCHED_BATCH to the
scheduler.  While SCHED_BATCH tasks are never interactive, tasks which
are class SCHED_INTERACTIVE will always have interactive status, as will
any tasks they awaken (excluding in_interrupt()).  The awakened task
will only have it's sleep_avg adjusted, it will not change class.

Setting X to SCHED_INTERACTIVE obviously cures the situation where X
can't get to sleep often enough.  It also cures a scenario which
demonstrates the client problem very well here:  start xmms, enable it's
G-FORCE visualization, and stretch it out large enough that it eats
massive cpu and then start a modest parallel kernel build.  The very
hungry, but nonetheless definitely interactive (while I'm watching;)
G-FORCE visualization has no chance of producing decent output.  Set X
to SCHED_INTERACTIVE, and presto, G-FORCE becomes a happy camper.

Setting X won't help if a threaded interactive application has it's cpu
hog component awakened by one of it's threads.  The application would
either have to be started as SCHED_INTERACTIVE by the user, or modified
to set interactive threads to SCHED_INTERACTIVE during startup.

It also won't eliminate hiccups that can happen when the anti-starvation
logic kicks in on an overloaded box.

I've attached a modified userland tool (which was posted here a few
years ago, I didn't write it) to allow setting SCHED_INTERACTIVE if
anyone wants to try this out on their favorite interactivity problem.

(Hi Christian;)

Suggestions for a solution that doesn't include adding yet another
scheduling class would be most welcome.

--- linux-2.6.19-rc6/include/linux/sched.h.org	2006-11-21 09:08:31.000000000 +0100
+++ linux-2.6.19-rc6/include/linux/sched.h	2006-11-21 11:34:15.000000000 +0100
@@ -34,6 +34,7 @@
 #define SCHED_FIFO		1
 #define SCHED_RR		2
 #define SCHED_BATCH		3
+#define SCHED_INTERACTIVE	4
 
 #ifdef __KERNEL__
 
@@ -505,7 +506,7 @@ struct signal_struct {
 #define rt_prio(prio)		unlikely((prio) < MAX_RT_PRIO)
 #define rt_task(p)		rt_prio((p)->prio)
 #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
-#define is_rt_policy(p)		((p) != SCHED_NORMAL && (p) != SCHED_BATCH)
+#define is_rt_policy(p)		((p) == SCHED_RR || (p) == SCHED_FIFO)
 #define has_rt_policy(p)	unlikely(is_rt_policy((p)->policy))
 
 /*
--- linux-2.6.19-rc6/kernel/sched.c.org	2006-11-16 10:02:26.000000000 +0100
+++ linux-2.6.19-rc6/kernel/sched.c	2006-11-22 09:01:35.000000000 +0100
@@ -921,6 +921,14 @@ static int recalc_task_prio(struct task_
 			p->sleep_avg += sleep_time;
 
 		}
+		/*
+		 * If a task of class SCHED_INTERACTIVE awakens another,
+		 * that task should also be considered interactive despite
+		 * heavy cpu usage.
+		 */
+		if (!in_interrupt() && current->policy == SCHED_INTERACTIVE &&
+				p->sleep_avg < ceiling)	
+			p->sleep_avg = ceiling;
 		if (p->sleep_avg > NS_MAX_SLEEP_AVG)
 			p->sleep_avg = NS_MAX_SLEEP_AVG;
 	}
@@ -3091,6 +3099,13 @@ void scheduler_tick(void)
 		goto out_unlock;
 	}
 	if (!--p->time_slice) {
+		if (p->policy == SCHED_INTERACTIVE) {
+			unsigned long floor = INTERACTIVE_SLEEP(p);
+			if (floor > NS_MAX_SLEEP_AVG)
+				floor = NS_MAX_SLEEP_AVG;
+			if (p->sleep_avg < floor)
+				p->sleep_avg = floor;
+		}
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
@@ -4117,7 +4132,8 @@ recheck:
 	if (policy < 0)
 		policy = oldpolicy = p->policy;
 	else if (policy != SCHED_FIFO && policy != SCHED_RR &&
-			policy != SCHED_NORMAL && policy != SCHED_BATCH)
+			policy != SCHED_NORMAL && policy != SCHED_BATCH &&
+			policy != SCHED_INTERACTIVE)
 		return -EINVAL;
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
@@ -4663,6 +4679,7 @@ asmlinkage long sys_sched_get_priority_m
 		break;
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
+	case SCHED_INTERACTIVE:
 		ret = 0;
 		break;
 	}
@@ -4687,6 +4704,7 @@ asmlinkage long sys_sched_get_priority_m
 		break;
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
+	case SCHED_INTERACTIVE:
 		ret = 0;
 	}
 	return ret;


--=-6WqoyMyILLH0h+IoNU10
Content-Disposition: attachment; filename=schedctl.c
Content-Type: text/x-csrc; name=schedctl.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <unistd.h>
#include <sched.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifndef SCHED_BATCH
#define SCHED_BATCH 3
#endif
#ifndef SCHED_INTERACTIVE
#define SCHED_INTERACTIVE 4
#endif

void usage();
void version();
void info(int pid);
void setsched(int pid, int policy, int pri, char flags);

unsigned char *ourname;

/* flags */
#define	GOTPID		1
#define	GOTPOLICY	2
#define	GOTPRI		4
#define GOTCMD		8
#define GOTINFO		16

int main(argc, argv)
unsigned int argc;
unsigned char *argv[];
{
	int pid;
	int policy;
	int pri = 0;
	int i1;
	int i2;
	unsigned long l1;
	char *ptr;
	char flags = 0;

	ourname = argv[0];

	if (argc <= 1) {
		usage();
		exit(1);
	}

	for (i1 = 1; i1 < argc; i1++)
		if (argv[i1][0] == '-') {	/* switch */
			if (argv[i1][1] >= '0' && argv[i1][1] <= '9') {
				l1 = strtol(&argv[i1][1], &ptr, 10);
				if (*ptr || l1 < 0 || l1 > 0x7FFF) {
					fprintf(stderr,
						"invalid priority: %s\n",
						argv[i1]);
					exit(1);
				}
				pri = l1;
				flags |= GOTPRI;
				continue;
			}
			if (argv[i1][1] == '-') {	/* long opt. */
				if (!strcasecmp("help", &argv[i1][2])) {
					usage();
					exit(0);
				}
				if (!strcasecmp("version", &argv[i1][2])) {
					version();
					exit(0);
				}
				if (!strcasecmp("info", &argv[i1][2])) {
				      INFO:
					if (i1 < argc - 1) {
						i1++;
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr) {
							i1--;
						} else {
							if (l1 < 0
							    || l1 > 0x7FFF) {
								fprintf(stderr,
									"invalid PID: %s\n",
									argv
									[i1]);
								exit(1);
							}
							if (!l1)
								pid = getpid();
							else {
								pid = l1;
							}
							flags |= GOTPID;
						}
					}
					if (flags & GOTPID) {
						info(pid);
						exit(0);
					} else {
						flags |= GOTINFO;
//                                              fprintf(stderr,"no PID given\n");
//                                              exit(1);
					}
					continue;
				}	/* end of --info */
				if (!strcasecmp("pid", &argv[i1][2])) {
				      PID:
					i1++;
					if (i1 >= argc) {
						fprintf(stderr,
							"option requires an argument\n");
						exit(1);
					} else {
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr || l1 < 0
						    || l1 > 0x7FFF) {
							fprintf(stderr,
								"invalid PID: %s\n",
								argv[i1]);
							exit(1);
						}
						if (!l1)
							pid = getpid();
						else
							pid = l1;
						flags |= GOTPID;
					}
					continue;
				}	/* end of --pid */
				if (!strcasecmp("priority", &argv[i1][2])
				    || !strcasecmp("pri", &argv[i1][2])) {
				      PRIORITY:
					i1++;
					if (i1 >= argc) {
						fprintf(stderr,
							"option requires an argument\n");
						exit(1);
					} else {
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr) {
							fprintf(stderr,
								"invalid priority: %s\n",
								argv[i1]);
							exit(1);
						}
						pri = l1;
						flags |= GOTPRI;
					}
					continue;
				}	/* end of --priority */
				if (!strcasecmp("other", &argv[i1][2])
				    || !strcasecmp("normal", &argv[i1][2])) {
				      OTHER:
					if (i1 < argc - 1) {
						i1++;
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr) {
							i1--;
						} else {
							if (l1 < 0
							    || l1 > 0x7FFF) {
								fprintf(stderr,
									"invalid PID: %s\n",
									argv
									[i1]);
								exit(1);
							}
							if (!l1)
								pid = getpid();
							else {
								pid = l1;
								flags |= GOTPID;
							}
						}
					}
					flags |= GOTPOLICY;
					policy = SCHED_OTHER;
					continue;
				}	/* end of --other */
				if (!strcasecmp("batch", &argv[i1][2])) {
				      BATCH:
					if (i1 < argc - 1) {
						i1++;
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr) {
							i1--;
						} else {
							if (l1 < 0
							    || l1 > 0x7FFF) {
								fprintf(stderr,
									"invalid PID: %s\n",
									argv
									[i1]);
								exit(1);
							}
							if (!l1)
								pid = getpid();
							else {
								pid = l1;
								flags |= GOTPID;
							}
						}
					}
					flags |= GOTPOLICY;
					policy = SCHED_BATCH;
					continue;
				}	/* end of --batch */
				if (!strcasecmp("interactive", &argv[i1][2])) {
				      INTERACTIVE:
					if (i1 < argc - 1) {
						i1++;
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr) {
							i1--;
						} else {
							if (l1 < 0
							    || l1 > 0x7FFF) {
								fprintf(stderr,
									"invalid PID: %s\n",
									argv
									[i1]);
								exit(1);
							}
							if (!l1)
								pid = getpid();
							else {
								pid = l1;
								flags |= GOTPID;
							}
						}
					}
					flags |= GOTPOLICY;
					policy = SCHED_INTERACTIVE;
					continue;
				}	/* end of --interactive */
				if (!strcasecmp("fifo", &argv[i1][2])) {
				      FIFO:
					if (i1 < argc - 1) {
						i1++;
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr) {
							i1--;
						} else {
							if (l1 < 0
							    || l1 > 0x7FFF) {
								fprintf(stderr,
									"invalid PID: %s\n",
									argv
									[i1]);
								exit(1);
							}
							if (!l1)
								pid = getpid();
							else {
								pid = l1;
								flags |= GOTPID;
							}
						}
					}
					flags |= GOTPOLICY;
					policy = SCHED_FIFO;
					continue;
				}	/* end of --fifo */
				if (!strcasecmp("rr", &argv[i1][2])
				    || !strcasecmp("round-robin",
						   &argv[i1][2])) {
				      RR:
					if (i1 < argc - 1) {
						i1++;
						l1 = strtol(argv[i1], &ptr, 0);
						if (*ptr) {
							i1--;
						} else {
							if (l1 < 0
							    || l1 > 0x7FFF) {
								fprintf(stderr,
									"invalid PID: %s\n",
									argv
									[i1]);
								exit(1);
							}
							if (!l1)
								pid = getpid();
							else {
								pid = l1;
								flags |= GOTPID;
							}
						}
					}
					flags |= GOTPOLICY;
					policy = SCHED_RR;
					continue;
				}
				/* end of --rr */
				fprintf(stderr,
					"warning: unknown long switch: %s\n",
					&argv[i1][2]);
				continue;
			}
			for (i2 = 1; i2 < strlen(argv[i1]); i2++)
				switch (argv[i1][i2]) {
				case 'h':
				case 'H':
				case '?':
					usage();
					exit(0);
				case 'i':
					goto INFO;
				case 'p':
					goto PID;
				case 'P':
					goto PRIORITY;
				case 'n':
				case 'O':
					goto OTHER;
				case 'B':
					goto BATCH;
				case 'I':
					goto INTERACTIVE;
				case 'F':
					goto FIFO;
				case 'R':
					goto RR;
				default:
					fprintf(stderr,
						"warning: unknown switch: %c\n",
						argv[i1][i2]);
					break;
				}
		} else {	/* command */

//                      printf("command: %s\n",argv[i1]);
			if (flags & GOTPID) {
				fprintf(stderr,
					"warning: both PID and command given\n");
			} else
				pid = getpid();
			if (!(flags & (GOTPOLICY | GOTPRI))) {
				fprintf(stderr,
					"warning: neither policy nor priority given\n");
			}

			flags |= GOTCMD;

			setsched(pid, policy, pri, flags);

			execvp(argv[i1], (char **)(&argv[i1]));
			if (errno) {
				printf("%s: error: %s\n", argv[i1],
				       strerror(errno));
				exit(1);
			}
			break;
		}

	if (flags & GOTINFO) {
		if (!(flags & GOTPID)) {
			fprintf(stderr, "no PID given\n");
			exit(1);
		}
		info(pid);
	}

	if (!(flags & (GOTCMD | GOTINFO))) {
		if (!(flags & GOTPID)) {
			fprintf(stderr, "neither PID nor command given\n");
			exit(1);
		}
		if (!(flags & (GOTPOLICY | GOTPRI))) {
			fprintf(stderr,
				"warning: neither policy nor priority given\n");
		}
		setsched(pid, policy, pri, flags);
	}
	exit(0);
}

void usage()
{
	printf("Usage: %s [options] [command [params...]]\n\n", ourname);
	printf("  --pid, -p <n>		specify process id\n");
	printf("  --fifo, -F [pid]	set scheduling policy to FIFO\n");
	printf("  --rr, -R [pid]	set scheduling policy to RR\n");
	printf("  --batch, -B [pid]	set scheduling policy to BATCH\n");
	printf("  --int, -I [pid]	set scheduling policy to INTERACTIVE\n");
	printf("  --other, --normal,\n");
	printf("      -n, -o [pid]	specify normal scheduling\n");
	printf("  --priority, --pri,\n");
	printf("      -<n>		set priority\n");
	printf("  --info, -i [pid]	show scheduling data\n");
	printf("  --help, -h, -H, -?	display this text\n");
	printf("  --version		show version data\n\n");
}

void version()
{
	printf("schedctl, version 0.95 (beta), 8-May-1998\n");
	printf("report bugs to aw@mail1.bet1.puv.fi or awik@freenet.fi\n");
}

void info(int pid)
{
	struct sched_param sp;
	int i1;

	i1 = sched_getscheduler(pid);
	if (errno == ESRCH) {
		fprintf(stderr, "process not found\n");
		return;
	}
	printf("scheduling policy of process %d is ", pid);
	switch (i1) {
	case SCHED_FIFO:
		printf("FIFO");
		break;
	case SCHED_RR:
		printf("RR");
		break;
	case SCHED_OTHER:
		printf("OTHER (normal)");
		break;
	case SCHED_INTERACTIVE:
		printf("INTERACTIVE");
		break;
	default:
		printf("**UNKNOWN**");
	}
	sched_getparam(pid, &sp);
	printf(", priority is %d\n", sp.sched_priority);
}

void setsched(int pid, int policy, int pri, char flags)
{
	struct sched_param sp;
	int i1;

	i1 = sched_getscheduler(pid);
	if (errno == ESRCH) {
		fprintf(stderr, "process not found\n");
		return;
	}
	if (!(flags & GOTPOLICY))
		policy = i1;
	sched_getparam(pid, &sp);
	if (!(flags & GOTPRI))
		pri = sp.sched_priority;
	else if (pri < sched_get_priority_min(policy)
		 || pri > sched_get_priority_max(policy)) {
		fprintf(stderr, "priority (%d) out of range\n", pri);
		return;
	}
	if (policy == SCHED_FIFO || policy == SCHED_RR) {
		if (!pri) {
			if (!sp.sched_priority)
				sp.sched_priority++;
		} else
			sp.sched_priority = pri;
	} else if (pri && (policy == SCHED_OTHER || policy == SCHED_INTERACTIVE))
		sp.sched_priority = 0;
	else
		sp.sched_priority = pri;
	if (sched_setscheduler(pid, policy, &sp)) {
		fprintf(stderr, "error #%d: %s\n", errno, strerror(errno));
		return;
	}

	i1 = sched_getscheduler(pid);
	sched_getparam(pid, &sp);
	if (flags & GOTCMD)
		return;
	printf("scheduling policy of process %d set to ", pid);
	switch (i1) {
		case SCHED_FIFO:
			printf("FIFO");
			break;
		case SCHED_RR:
			printf("RR");
			break;
		case SCHED_OTHER:
			printf("OTHER");
			break;
		case SCHED_BATCH:
			printf("BATCH");
			break;
		case SCHED_INTERACTIVE:
			printf("INTERACTIVE");
			break;
	}
	printf("\n");
}

--=-6WqoyMyILLH0h+IoNU10--

