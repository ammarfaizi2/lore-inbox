Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWIQRxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWIQRxY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWIQRxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:53:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17896 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965035AbWIQRxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:53:23 -0400
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
X-Sieve: CMU Sieve 2.3
X-Spam-TestScore: none
X-Spam-TokenSummary: Bayes not run.
X-Spam-Relay-Country: US ** US US ** US US ** US
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>, Balbir Singh <balbir@in.ibm.com>
Date: Sun, 17 Sep 2006 20:42:12 +0530
Message-Id: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH 0/4] Aggregated beancounters (v3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt #3 to build aggregated beancounters on top of beancounters.
The earlier patch built per tgid beancounters, but that did not work
well. Subsystems keep track of references to beancounters. This patch
creates an aggregated beancounters - they aggregate beancounters. A
beancounter is created for every tgid.

This patch is an RFC for early comments and discussion and a proof of
concept approach to check if this approach can be used as a basis to support
task migration. Dave Hansen initially suggested the idea.

TODOs (some of so many)

1. Add limit checking before migrating tasks
2. Add support for reclamation.
3. Add support for guarantees
4. Add support for per-task beancounters (cpu controller is likely to
   require it)

series
------
per-tgid-beancounters.patch
add-aggr-bc.patch
aggr-bc-syscalls.patch
aggr-bc-charging-support.patch

This patch was minimally tested on a x86-64 box.

Comments?

Balbir Singh


Utility ctl.c for controlling and creating beancounters
-------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <getopt.h>
#include <string.h>
#include <asm/unistd.h>

#ifdef DEBUG
#define debug(x...) printf(x)
#else
#define debug(x...)
#endif

#define err(stream, msg...)	fprintf(stream, msg), exit(1);

char *resources[] = {
	"kmemsize",
	"lockedpages",
	"privvmpages",
};

/*
 * For i386
 */
#if 0
#define __NR_get_bcid           319
#define __NR_set_bcid           320
#define __NR_set_bclimit        321
#define __NR_get_bcstat         322
#endif

/* For ia64 */
#define __NR_get_bcid           280
#define __NR_set_bcid           281
#define __NR_set_bclimit        282
#define __NR_get_bcstat         283

struct ab_resource_parm {
	unsigned long barrier;
	unsigned long held;
	unsigned long limit;	/* hard resource limit */
	unsigned long failcnt;	/* count of failed charges */
};

struct bc_resource_parm {
	unsigned long barrier;	/* A barrier over which resource allocations
				 * are failed gracefully. e.g. if the amount
				 * of consumed memory is over the barrier
				 * further sbrk() or mmap() calls fail, the
				 * existing processes are not killed.
				 */
	unsigned long limit;	/* hard resource limit */
	unsigned long held;	/* consumed resources */
	unsigned long maxheld;	/* maximum amount of consumed resources */
	unsigned long minheld;	/* minumum amount of consumed resources */
	unsigned long failcnt;	/* count of failed charges */
};

_syscall2(long, set_bcid, int, id, int, pid)
_syscall0(long, get_bcid)
_syscall3(long, set_bclimit, int, id, unsigned long, resource, unsigned long *,
	  limits)
_syscall5(long, get_bcstat, int, ab_id, int, bc_id,
	   unsigned long, resource, struct bc_resource_parm *,
	    bc_parm, struct ab_resource_parm *, ab_parm)

int main(int argc, char *argv[])
{
	int opt;
	int ab_id = 0, bc_id;
	unsigned long limit[2] = { 0, 0 };
	int rc = 0;
	int set_limit = 0;
	struct bc_resource_parm bc_parm;
	struct ab_resource_parm ab_parm;
	int res_id = 0;
	int pid = getpid();

	do {
		opt = getopt(argc, argv, "i:c:b:l:d:gr:p:");
		if (opt < 0)
			break;
		switch (opt) {
		case 'i':
			ab_id = atoi(optarg);
			debug("id %d\n", ab_id);
			break;
		case 'p':
			pid = atoi(optarg);
			debug("pid %d\n", pid);
			break;
		case 'r':
			res_id = atoi(optarg);
			debug("resource %s\n", resources[res_id]);
			break;
		case 'c':
			ab_id = atoi(optarg);
			debug("ab_id %d\n", ab_id);
			rc = set_bcid(ab_id, pid);
			if (rc < 0) {
				perror("set_bcid  failed:");
				break;
			}
			break;
		case 'g':
			rc = get_bcid();
			if (rc < 0) {
				perror("set_bcid  failed:");
				break;
			}
			printf("current id %d\n", rc);
			break;
		case 'd':
			bc_id = atoi(optarg);
			rc = get_bcstat(bc_id, ab_id, res_id, &bc_parm,
					&ab_parm);
			if (rc < 0) {
				perror("getstat  failed:");
				break;
			}
			printf("BC: %d, limit %lu, barrier %lu held %lu\n",
			       bc_id, bc_parm.barrier, bc_parm.limit,
			       bc_parm.held);
			printf("AB: %d, limit %lu, barrier %lu held %lu\n",
			       ab_id, ab_parm.barrier, ab_parm.limit,
			       ab_parm.held);
			break;
		case 'b':
			limit[0] = atoi(optarg);
			if (limit[0] == 0)
				err(stderr,
				    "Invalid barrier, please try again barrier"
				    " %lu\n", limit[0]);
			debug("barrier is %lu\n", limit[0]);
			break;
		case 'l':
			set_limit = 1;
			limit[1] = atoi(optarg);
			if (limit[1] == 0)
				err(stderr,
				    "Invalid limit, please try again limit %lu\n",
				    limit[1]);
			debug("limit is %lu\n", limit[1]);
			break;
		default:
			err(stderr, "unknown option %c\n", opt);
		}
	} while (1);

	if (set_limit && ab_id && limit[0] && limit[1]) {
		rc = set_bclimit(ab_id, 0UL, limit);
		if (rc < 0)
			perror("set_bclimit failed: ");
	}
	return rc;
}

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
