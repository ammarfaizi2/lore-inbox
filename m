Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUH0Mck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUH0Mck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUH0Mcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:32:36 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:2976 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S264278AbUH0M3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:29:33 -0400
Date: Fri, 27 Aug 2004 14:24:49 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: Albert Cahalan <albert@users.sf.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: [2/2][sample code] nproc: user space app
Message-ID: <20040827122449.GA20391@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827122412.GA20052@k3.hellgate.ch>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a system running a kernel with nproc, the sample program (below)
spits out the information it can gather from the kernel: Available
fields, data types, and associated values.

Obviously, real tools would have their own labels (and help texts) for
well-known fields. Scope information and the NPROC_GET_LABEL operation
allow them to provide additional information in a meaningful context.

The sample program does have some extra knowledge beyond the bare
interface: It knows that a time stamp (global scope) can be requested
within process scope as well, and it knows how to request a symbol name
from a wchan value.

Sample output:
----------------------------------------------------------------------------
================ Available fields =======================
    ----id---- --------label------- -scope- ----type-----
# 0 0x22000001 PID                  process __u32
# 1 0x21000002 Name                 process string
# 2 0x12000004 MemFree              global  __u32
# 3 0x12000005 PageSize             global  __u32
# 4 0x14000006 Jiffies              global  __u64
# 5 0x22000010 VmSize               process __u32
# 6 0x22000011 VmLock               process __u32
# 7 0x22000012 VmRSS                process __u32
# 8 0x22000013 VmData               process __u32
# 9 0x22000014 VmStack              process __u32
#10 0x22000015 VmExe                process __u32
#11 0x22000016 VmLib                process __u32
#12 0x13000051 nr_dirty             global  unsigned long
#13 0x13000052 nr_writeback         global  unsigned long
#14 0x13000053 nr_unstable          global  unsigned long
#15 0x13000054 nr_page_table_pages  global  unsigned long
#16 0x13000055 nr_mapped            global  unsigned long
#17 0x13000056 nr_slab              global  unsigned long
#18 0x23000100 wchan                process unsigned long
#19 0x01000101 wchan_symbol         (    0) string

================ Global fields ==========================
    ----id---- --------label------- --value---
# 0 0x12000004 MemFree                   97926
# 1 0x12000005 PageSize                   4096
# 2 0x14000006 Jiffies              4298132669
# 3 0x13000051 nr_dirty                     10
# 4 0x13000052 nr_writeback                  0
# 5 0x13000053 nr_unstable                   0
# 6 0x13000054 nr_page_table_pages         405
# 7 0x13000055 nr_mapped                 36021
# 8 0x13000056 nr_slab                    5956

================ Process fields =========================
---------------- process PID 14318 ----------------------
    ----id---- --------label------- --value---
# 0 0x14000006 Jiffies              4298132669
# 1 0x22000001 PID                       14318
# 2 0x21000002 Name                 tst
# 3 0x22000010 VmSize                     1456
# 4 0x22000011 VmLock                        0
# 5 0x22000012 VmRSS                       360
# 6 0x22000013 VmData                      272
# 7 0x22000014 VmStack                      12
# 8 0x22000015 VmExe                         8
# 9 0x22000016 VmLib                      1140
#10 0x23000100 wchan                         0
---------------- process PID     1 ----------------------
    ----id---- --------label------- --value---
# 0 0x14000006 Jiffies              4298132669
# 1 0x22000001 PID                           1
# 2 0x21000002 Name                 init
# 3 0x22000010 VmSize                     1340
# 4 0x22000011 VmLock                        0
# 5 0x22000012 VmRSS                       468
# 6 0x22000013 VmData                      144
# 7 0x22000014 VmStack                       4
# 8 0x22000015 VmExe                        28
# 9 0x22000016 VmLib                      1140
#10 0x23000100 wchan                0xc01924f9 (ksym: do_select)

1000 iterations for both processes:
	CPU time : 0.000000s
	Wall time: 0.008305s
============================================================================
Sample code below:
----------------------------------------------------------------------------
#include <asm/types.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>

/* Sample code to demonstrate nproc usage */

//#include "<linux/nproc.h>"

#define NPROC_BASE		0x10
#define NPROC_GET_LIST		(NPROC_BASE+0)
#define NPROC_GET_LABEL		(NPROC_BASE+1)
#define NPROC_GET_GLOBAL	(NPROC_BASE+2)
#define NPROC_GET_PS		(NPROC_BASE+3)

#define NETLINK_NPROC		12

#define NPROC_SCOPE_MASK	0xF0000000
#define NPROC_SCOPE_GLOBAL	0x10000000	/* Global w/o arguments */
#define NPROC_SCOPE_PROCESS	0x20000000
#define NPROC_SCOPE_LABEL	0x30000000

#define NPROC_TYPE_MASK		0x0F000000
#define NPROC_TYPE_STRING	0x01000000
#define NPROC_TYPE_U32		0x02000000
#define NPROC_TYPE_UL		0x03000000
#define NPROC_TYPE_U64		0x04000000

#define NPROC_SELECT_ALL	0x00000001
#define NPROC_SELECT_PID	0x00000002
#define NPROC_SELECT_UID	0x00000003

#define NPROC_LABEL_FIELD	0x00000001
#define NPROC_LABEL_KSYM	0x00000002

struct nproc_field {
	__u32	id;
	const char *label;
};

#define NPROC_JIFFIES		(0x00000006 | NPROC_TYPE_U64    | NPROC_SCOPE_GLOBAL)
#define NPROC_WCHAN		(0x00000100 | NPROC_TYPE_UL     | NPROC_SCOPE_PROCESS)


//#define DEBUG

#ifdef DEBUG
#define pdebug(x,args...) printf("%s:%d " x, __func__ , __LINE__, ##args)
#else
#define pdebug(x,args...)
#endif
#define perror(x,args...) fprintf(stderr, "%s:%d " x, __func__ , __LINE__, ##args)

static __u32 seq_nr;
static pid_t pid;
static int nsk;		/* netlink socket */

struct proc_message {
	struct nlmsghdr nlh;
	__u32 data[256];
};

int open_netlink()
{
	if ((nsk = socket(PF_NETLINK, SOCK_RAW, NETLINK_NPROC)) == -1) {
		perror("Failed to open netlink proc socket.\n");
		exit(1);
	}
	return nsk;
}

void send_request(struct proc_message *req)
{
	int sent;

	req->nlh.nlmsg_flags = NLM_F_REQUEST;
	req->nlh.nlmsg_seq = seq_nr++;
	req->nlh.nlmsg_pid = pid;

	if ((sent = send(nsk, req, req->nlh.nlmsg_len, 0)) == -1) {
		perror("Failed to send netlink proc msg.\n");
		exit(1);
	}
		pdebug("sent %d bytes seq %#x type %#x \n", sent,
				req->nlh.nlmsg_seq, req->nlh.nlmsg_type);
}

void *get_reply(__u32 type, struct proc_message *ans)
{
	int len;
	if ((len = recv(nsk, ans, sizeof(struct proc_message), 0)) == -1) {
		perror("Failed to read netlink proc msg.\n");
		exit(1);
	};

	if (!NLMSG_OK((&(*ans).nlh), len)) {
		perror("Bad netlink msg.\n");
		exit(1);
	}

	if (ans->nlh.nlmsg_type != type) {
		perror("read %d bytes seq %#x type %#x len %d\n", len,
				ans->nlh.nlmsg_seq, ans->nlh.nlmsg_type,
				ans->nlh.nlmsg_len);
		exit(1);
	}
	else
		pdebug("read %d bytes seq %#x type %#x len %d\n", len,
				ans->nlh.nlmsg_seq, ans->nlh.nlmsg_type,
				ans->nlh.nlmsg_len);

	return NLMSG_DATA(&ans->nlh);
}

void *get_global(__u32 num, struct proc_message *nlmsg)
{
	int len = num * sizeof(__u32);

	nlmsg->nlh.nlmsg_len = NLMSG_LENGTH(len);
	nlmsg->nlh.nlmsg_type = NPROC_GET_GLOBAL;

	send_request(nlmsg);

	return get_reply(NPROC_GET_GLOBAL, nlmsg);
}

void get_ps(__u32 num, struct proc_message *nlmsg)
{
	int len = num * sizeof(__u32);

	nlmsg->nlh.nlmsg_len = NLMSG_LENGTH(len);
	nlmsg->nlh.nlmsg_type = NPROC_GET_PS;

	send_request(nlmsg);
}

char *get_label(struct proc_message *nlmsg)
{
	nlmsg->nlh.nlmsg_type = NPROC_GET_LABEL;

	send_request(nlmsg);

	return get_reply(NPROC_GET_LABEL, nlmsg);
}

char *get_field_label(__u32 id, struct proc_message *nlmsg)
{
	__u32 *buf = NLMSG_DATA(&nlmsg->nlh);
	int len = 2 * sizeof(__u32);

	nlmsg->nlh.nlmsg_len = NLMSG_LENGTH(len);

	buf[0] = NPROC_LABEL_FIELD;
	buf[1] = id;

	return get_label(nlmsg);
}

char *get_ksym(unsigned long wchan, struct proc_message *nlmsg)
{
	__u32 *buf = NLMSG_DATA(&nlmsg->nlh);
	unsigned long *addr;
	int len = sizeof(__u32) + sizeof(unsigned long);

	*buf++ = NPROC_LABEL_KSYM;
	addr = (unsigned long *)buf;
	*addr = wchan;

	nlmsg->nlh.nlmsg_len = NLMSG_LENGTH(len);

	return get_label(nlmsg);
}

__u32 *get_list(struct proc_message *nlmsg)
{
	nlmsg->nlh.nlmsg_len = NLMSG_LENGTH(0);
	nlmsg->nlh.nlmsg_type = NPROC_GET_LIST;

	send_request(nlmsg);

	return get_reply(NPROC_GET_LIST, nlmsg);
}

void print_ps(char *res, int psc, struct nproc_field *ps_label)
{
	int i;
	struct proc_message nlmsg;

	printf("    ----id---- --------label------- --value---\n");
	for (i = 0; i < psc; i++) {
		const char *label = ps_label[i].label;
		__u32 id    = ps_label[i].id;
		__u32 type  = id & NPROC_TYPE_MASK;

		printf("#%2d %#x %-20s ", i, id, label);
		switch (type) {
			case NPROC_TYPE_U32: {
				__u32 *p = (__u32 *)res;
				printf("%10u\n", *p);
				res = (char *)++p;
				break;
			}
			case NPROC_TYPE_UL: {
				unsigned long *p = (unsigned long *)res;
				if ((id == NPROC_WCHAN) && *p) {
					printf("%#8lx ", *p);
					printf("(ksym: %s)\n", get_ksym(*p,
								&nlmsg));
				}
				else
					printf("%10lu\n", *p);
				res = (char *)++p;
				break;
			}
			case NPROC_TYPE_U64: {
				__u64 *p = (__u64 *)res;
				printf("%10llu\n", *p);
				res = (char *)++p;
				break;
			}
			case NPROC_TYPE_STRING: {
				__u32 *len = (__u32 *)res;
				char *p = res + sizeof(__u32);
				printf("%s\n", p);
				res += *len + sizeof(__u32);
				break;
			}
			default:
				printf("(?)\t");
		}
	}
}


#define MAX_FIELDS	64

int main() {
	struct proc_message flist;
	struct proc_message nlmsg;
	struct proc_message gl_msg;
	struct proc_message ps_msg;

	__u32 *fields;
	__u32 *gl = NLMSG_DATA(&gl_msg.nlh);
	__u32 *ps = NLMSG_DATA(&ps_msg.nlh);

	struct nproc_field gl_label[MAX_FIELDS];
	struct nproc_field ps_label[MAX_FIELDS];

	char *res;

	int i;
	int ac, glc = 0, psc = 0;		/* Count fields */

	int cpu_0;
	struct timeval tv0, tv1;
	float wall;
	struct timezone tz;

	pid = getpid();
	nsk = open_netlink();

	fields = get_list(&flist);
	ac = *fields++;


	*gl++ = 0;		/* Reserve space for field count */
	*ps++ = 0;

	*ps++ = NPROC_JIFFIES;	/* Special: both global and ps context */
	ps_label[psc].id = NPROC_JIFFIES;
	ps_label[psc++].label = strdup(get_field_label(NPROC_JIFFIES, &nlmsg));

	printf("================ Available fields =======================\n");
	printf("    ----id---- --------label------- -scope- ----type-----\n");
	for (i = 0; i < ac; i++) {
		char *label;
		__u32 scope, type;

		scope = fields[i] & NPROC_SCOPE_MASK;
		type  = fields[i] & NPROC_TYPE_MASK;
		label = strdup(get_field_label(fields[i], &nlmsg));

		printf("#%2d %#8.8x %-20s ", i, fields[i], label);
		switch (scope) {
			case NPROC_SCOPE_GLOBAL:
				printf("global  ");
				*gl++ = fields[i];
				gl_label[glc].id = fields[i];
				gl_label[glc++].label = label;
				break;
			case NPROC_SCOPE_PROCESS:
				printf("process ");
				*ps++ = fields[i];
				ps_label[psc].id = fields[i];
				ps_label[psc++].label = label;
				break;
			default:
				printf("(%#5x) ", scope);
		}
		switch (type) {
			case NPROC_TYPE_U32:
				printf("__u32");
				break;
			case NPROC_TYPE_UL:
				printf("unsigned long");
				break;
			case NPROC_TYPE_U64:
				printf("__u64");
				break;
			case NPROC_TYPE_STRING:
				printf("string");
				break;
			default:
				printf("type: (%#8.8x)\t", type);
		}
		if ((glc == MAX_FIELDS) || (psc == MAX_FIELDS)) {
			perror("Array too small.\n");
			exit(1);
		}
		printf("\n");
	}

	gl = NLMSG_DATA(&gl_msg.nlh);
	*gl = glc;

	res = get_global(glc + 1, &gl_msg);

	printf("\n================ Global fields ==========================\n");
	printf("    ----id---- --------label------- --value---\n");
	for (i = 0; i < glc; i++) {
		const char *label = gl_label[i].label;
		__u32 id    = gl_label[i].id;
		__u32 type  = id & NPROC_TYPE_MASK;

		printf("#%2d %#8.8x %-20s ", i, id, label);
		switch (type) {
			case NPROC_TYPE_U32: {
				__u32 *p = (__u32 *)res;
				printf("%10u", *p);
				res = (char *)++p;
				break;
			}
			case NPROC_TYPE_UL: {
				unsigned long *p = (unsigned long *)res;
				printf("%10lu", *p);
				res = (char *)++p;
				break;
			}
			case NPROC_TYPE_U64: {
				__u64 *p = (__u64 *)res;
				printf("%10llu", *p);
				res = (char *)++p;
				break;
			}
			case NPROC_TYPE_STRING: {
				__u32 *len = (__u32 *)res;
				char *p = res + sizeof(__u32);
				printf("%s", p);
				res += *len + sizeof(__u32);
				break;
			}
			default:
				printf("(?)");
		}
		printf("\n");
	}

	printf("\n================ Process fields =========================\n");

	*ps++ = NPROC_SELECT_PID;
	*ps++ = 2;		// Number of PIDs to follow
	*ps++ = pid;
	*ps++ = 1;

	ps = NLMSG_DATA(&ps_msg.nlh);
	*ps = psc;

	get_ps(psc + 1 + 4, &ps_msg);

	res = get_reply(NPROC_GET_PS, &nlmsg);

	printf("---------------- process PID %5d ----------------------\n", pid);
	print_ps(res, psc, ps_label);

	res = get_reply(NPROC_GET_PS, &nlmsg);
	printf("---------------- process PID %5d ----------------------\n", 1);
	print_ps(res, psc, ps_label);

	gettimeofday(&tv0, &tz);
	cpu_0 = clock();

#define RUNS 1000
	for (i = 0; i < RUNS; i++) {
		get_ps(psc + 1 + 4, &ps_msg);
		get_reply(NPROC_GET_PS, &nlmsg);
		get_reply(NPROC_GET_PS, &nlmsg);
	}

	printf("\n%d iterations for both processes:\n", RUNS);
	printf("\tCPU time : %fs\n", (float)(clock() - cpu_0)/CLOCKS_PER_SEC);
	gettimeofday(&tv1,&tz);
	wall = (float) tv1.tv_sec - tv0.tv_sec +
		(tv1.tv_usec - tv0.tv_usec) / 1.0e6;
	printf("\tWall time: %fs\n", wall);

	return 0;
}
----------------------------------------------------------------------------
