Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbWGKE3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbWGKE3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWGKE3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:29:33 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:9187 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965144AbWGKE3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:29:31 -0400
Subject: [Patch 2/6] per task delay accounting taskstats interface:
	documentation fix
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
       Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152592168.14142.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:29:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change documentation and example program to reflect the flow control
issues being addressed by the cpumask changes.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

 Documentation/accounting/getdelays.c   |  612 +++++++++++++++++----------------
 Documentation/accounting/taskstats.txt |   64 ++-
 2 files changed, 368 insertions(+), 308 deletions(-)

Index: linux-2.6.18-rc1/Documentation/accounting/taskstats.txt
===================================================================
--- linux-2.6.18-rc1.orig/Documentation/accounting/taskstats.txt	2006-07-10 23:44:10.000000000 -0400
+++ linux-2.6.18-rc1/Documentation/accounting/taskstats.txt	2006-07-10 23:44:18.000000000 -0400
@@ -26,20 +26,28 @@ leader - a process is deemed alive as lo
 Usage
 -----
 
-To get statistics during task's lifetime, userspace opens a unicast netlink
+To get statistics during a task's lifetime, userspace opens a unicast netlink
 socket (NETLINK_GENERIC family) and sends commands specifying a pid or a tgid.
 The response contains statistics for a task (if pid is specified) or the sum of
 statistics for all tasks of the process (if tgid is specified).
 
-To obtain statistics for tasks which are exiting, userspace opens a multicast
-netlink socket. Each time a task exits, its per-pid statistics is always sent
-by the kernel to each listener on the multicast socket. In addition, if it is
-the last thread exiting its thread group, an additional record containing the
-per-tgid stats are also sent. The latter contains the sum of per-pid stats for
-all threads in the thread group, both past and present.
+To obtain statistics for tasks which are exiting, the userspace listener
+sends a register command and specifies a cpumask. Whenever a task exits on
+one of the cpus in the cpumask, its per-pid statistics are sent to the
+registered listener. Using cpumasks allows the data received by one listener
+to be limited and assists in flow control over the netlink interface and is
+explained in more detail below.
+
+If the exiting task is the last thread exiting its thread group,
+an additional record containing the per-tgid stats is also sent to userspace.
+The latter contains the sum of per-pid stats for all threads in the thread
+group, both past and present.
 
 getdelays.c is a simple utility demonstrating usage of the taskstats interface
-for reporting delay accounting statistics.
+for reporting delay accounting statistics. Users can register cpumasks,
+send commands and process responses, listen for per-tid/tgid exit data,
+write the data received to a file and do basic flow control by increasing
+receive buffer sizes.
 
 Interface
 ---------
@@ -66,10 +74,20 @@ The messages are in the format
 
 The taskstats payload is one of the following three kinds:
 
-1. Commands: Sent from user to kernel. The payload is one attribute, of type
-TASKSTATS_CMD_ATTR_PID/TGID, containing a u32 pid or tgid in the attribute
-payload. The pid/tgid denotes the task/process for which userspace wants
-statistics.
+1. Commands: Sent from user to kernel. Commands to get data on
+a pid/tgid consist of one attribute, of type TASKSTATS_CMD_ATTR_PID/TGID,
+containing a u32 pid or tgid in the attribute payload. The pid/tgid denotes
+the task/process for which userspace wants statistics.
+
+Commands to register/deregister interest in exit data from a set of cpus
+consist of one attribute, of type
+TASKSTATS_CMD_ATTR_REGISTER/DEREGISTER_CPUMASK and contain a cpumask in the
+attribute payload. The cpumask is specified as an ascii string of
+comma-separated cpu ranges e.g. to listen to exit data from cpus 1,2,3,5,7,8
+the cpumask would be "1-3,5,7-8". If userspace forgets to deregister interest
+in cpus before closing the listening socket, the kernel cleans up its interest
+set over time. However, for the sake of efficiency, an explicit deregistration
+is advisable.
 
 2. Response for a command: sent from the kernel in response to a userspace
 command. The payload is a series of three attributes of type:
@@ -138,4 +156,26 @@ struct too much, requiring disparate use
 unnecessarily receive large structures whose fields are of no interest, then
 extending the attributes structure would be worthwhile.
 
+Flow control for taskstats
+--------------------------
+
+When the rate of task exits becomes large, a listener may not be able to keep
+up with the kernel's rate of sending per-tid/tgid exit data leading to data
+loss. This possibility gets compounded when the taskstats structure gets
+extended and the number of cpus grows large.
+
+To avoid losing statistics, userspace should do one or more of the following:
+
+- increase the receive buffer sizes for the netlink sockets opened by
+listeners to receive exit data.
+
+- create more listeners and reduce the number of cpus being listened to by
+each listener. In the extreme case, there could be one listener for each cpu.
+Users may also consider setting the cpu affinity of the listener to the subset
+of cpus to which it listens, especially if they are listening to just one cpu.
+
+Despite these measures, if the userspace receives ENOBUFS error messages
+indicated overflow of receive buffers, it should take measures to handle the
+loss of data.
+
 ----
Index: linux-2.6.18-rc1/Documentation/accounting/getdelays.c
===================================================================
--- linux-2.6.18-rc1.orig/Documentation/accounting/getdelays.c	2006-07-10 23:44:10.000000000 -0400
+++ linux-2.6.18-rc1/Documentation/accounting/getdelays.c	2006-07-10 23:44:18.000000000 -0400
@@ -5,6 +5,7 @@
  *
  * Copyright (C) Shailabh Nagar, IBM Corp. 2005
  * Copyright (C) Balbir Singh, IBM Corp. 2006
+ * Copyright (c) Jay Lan, SGI. 2006
  *
  */
 
@@ -36,341 +37,360 @@
 
 #define err(code, fmt, arg...) do { printf(fmt, ##arg); exit(code); } while (0)
 int done = 0;
+int rcvbufsz=0;
+
+    char name[100];
+int dbg=0, print_delays=0;
+__u64 stime, utime;
+#define PRINTF(fmt, arg...) {			\
+	    if (dbg) {				\
+		printf(fmt, ##arg);		\
+	    }					\
+	}
+
+/* Maximum size of response requested or message sent */
+#define MAX_MSG_SIZE	256
+/* Maximum number of cpus expected to be specified in a cpumask */
+#define MAX_CPUS	32
+/* Maximum length of pathname to log file */
+#define MAX_FILENAME	256
+
+struct msgtemplate {
+	struct nlmsghdr n;
+	struct genlmsghdr g;
+	char buf[MAX_MSG_SIZE];
+};
+
+char cpumask[100+6*MAX_CPUS];
 
 /*
  * Create a raw netlink socket and bind
  */
-static int create_nl_socket(int protocol, int groups)
+static int create_nl_socket(int protocol)
 {
-    socklen_t addr_len;
-    int fd;
-    struct sockaddr_nl local;
+	int fd;
+	struct sockaddr_nl local;
 
-    fd = socket(AF_NETLINK, SOCK_RAW, protocol);
-    if (fd < 0)
-	return -1;
+	fd = socket(AF_NETLINK, SOCK_RAW, protocol);
+	if (fd < 0)
+		return -1;
+
+	if (rcvbufsz)
+		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF,
+				&rcvbufsz, sizeof(rcvbufsz)) < 0) {
+			printf("Unable to set socket rcv buf size to %d\n",
+			       rcvbufsz);
+			return -1;
+		}
 
-    memset(&local, 0, sizeof(local));
-    local.nl_family = AF_NETLINK;
-    local.nl_groups = groups;
-
-    if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0)
-	goto error;
-
-    return fd;
-  error:
-    close(fd);
-    return -1;
-}
+	memset(&local, 0, sizeof(local));
+	local.nl_family = AF_NETLINK;
 
-int sendto_fd(int s, const char *buf, int bufLen)
-{
-    struct sockaddr_nl nladdr;
-    int r;
+	if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0)
+		goto error;
+
+	return fd;
+error:
+	close(fd);
+	return -1;
+}
 
-    memset(&nladdr, 0, sizeof(nladdr));
-    nladdr.nl_family = AF_NETLINK;
 
-    while ((r = sendto(s, buf, bufLen, 0, (struct sockaddr *) &nladdr,
-		       sizeof(nladdr))) < bufLen) {
-	if (r > 0) {
-	    buf += r;
-	    bufLen -= r;
-	} else if (errno != EAGAIN)
-	    return -1;
-    }
-    return 0;
+int send_cmd(int sd, __u16 nlmsg_type, __u32 nlmsg_pid,
+	     __u8 genl_cmd, __u16 nla_type,
+	     void *nla_data, int nla_len)
+{
+	struct nlattr *na;
+	struct sockaddr_nl nladdr;
+	int r, buflen;
+	char *buf;
+
+	struct msgtemplate msg;
+
+	msg.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	msg.n.nlmsg_type = nlmsg_type;
+	msg.n.nlmsg_flags = NLM_F_REQUEST;
+	msg.n.nlmsg_seq = 0;
+	msg.n.nlmsg_pid = nlmsg_pid;
+	msg.g.cmd = genl_cmd;
+	msg.g.version = 0x1;
+	na = (struct nlattr *) GENLMSG_DATA(&msg);
+	na->nla_type = nla_type;
+	na->nla_len = nla_len + 1 + NLA_HDRLEN;
+	memcpy(NLA_DATA(na), nla_data, nla_len);
+	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
+
+	buf = (char *) &msg;
+	buflen = msg.n.nlmsg_len ;
+	memset(&nladdr, 0, sizeof(nladdr));
+	nladdr.nl_family = AF_NETLINK;
+	while ((r = sendto(sd, buf, buflen, 0, (struct sockaddr *) &nladdr,
+			   sizeof(nladdr))) < buflen) {
+		if (r > 0) {
+			buf += r;
+			buflen -= r;
+		} else if (errno != EAGAIN)
+			return -1;
+	}
+	return 0;
 }
 
+
 /*
  * Probe the controller in genetlink to find the family id
  * for the TASKSTATS family
  */
 int get_family_id(int sd)
 {
-    struct {
-	struct nlmsghdr n;
-	struct genlmsghdr g;
-	char buf[256];
-    } family_req;
-    struct {
-	struct nlmsghdr n;
-	struct genlmsghdr g;
-	char buf[256];
-    } ans;
-
-    int id;
-    struct nlattr *na;
-    int rep_len;
-
-    /* Get family name */
-    family_req.n.nlmsg_type = GENL_ID_CTRL;
-    family_req.n.nlmsg_flags = NLM_F_REQUEST;
-    family_req.n.nlmsg_seq = 0;
-    family_req.n.nlmsg_pid = getpid();
-    family_req.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
-    family_req.g.cmd = CTRL_CMD_GETFAMILY;
-    family_req.g.version = 0x1;
-    na = (struct nlattr *) GENLMSG_DATA(&family_req);
-    na->nla_type = CTRL_ATTR_FAMILY_NAME;
-    na->nla_len = strlen(TASKSTATS_GENL_NAME) + 1 + NLA_HDRLEN;
-    strcpy(NLA_DATA(na), TASKSTATS_GENL_NAME);
-    family_req.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
-
-    if (sendto_fd(sd, (char *) &family_req, family_req.n.nlmsg_len) < 0)
-	err(1, "error sending message via Netlink\n");
-
-    rep_len = recv(sd, &ans, sizeof(ans), 0);
-
-    if (rep_len < 0)
-	err(1, "error receiving reply message via Netlink\n");
-
-
-    /* Validate response message */
-    if (!NLMSG_OK((&ans.n), rep_len))
-	err(1, "invalid reply message received via Netlink\n");
-
-    if (ans.n.nlmsg_type == NLMSG_ERROR) {	/* error */
-	printf("error received NACK - leaving\n");
-	exit(1);
-    }
-
-
-    na = (struct nlattr *) GENLMSG_DATA(&ans);
-    na = (struct nlattr *) ((char *) na + NLA_ALIGN(na->nla_len));
-    if (na->nla_type == CTRL_ATTR_FAMILY_ID) {
-	id = *(__u16 *) NLA_DATA(na);
-    }
-    return id;
-}
+	struct {
+		struct nlmsghdr n;
+		struct genlmsghdr g;
+		char buf[256];
+	} ans;
+
+	int id, rc;
+	struct nlattr *na;
+	int rep_len;
+
+	strcpy(name, TASKSTATS_GENL_NAME);
+	rc = send_cmd(sd, GENL_ID_CTRL, getpid(), CTRL_CMD_GETFAMILY,
+			CTRL_ATTR_FAMILY_NAME, (void *)name,
+			strlen(TASKSTATS_GENL_NAME)+1);
+
+	rep_len = recv(sd, &ans, sizeof(ans), 0);
+	if (ans.n.nlmsg_type == NLMSG_ERROR ||
+	    (rep_len < 0) || !NLMSG_OK((&ans.n), rep_len))
+		return 0;
 
-void print_taskstats(struct taskstats *t)
-{
-    printf("\n\nCPU   %15s%15s%15s%15s\n"
-	   "      %15llu%15llu%15llu%15llu\n"
-	   "IO    %15s%15s\n"
-	   "      %15llu%15llu\n"
-	   "MEM   %15s%15s\n"
-	   "      %15llu%15llu\n\n",
-	   "count", "real total", "virtual total", "delay total",
-	   t->cpu_count, t->cpu_run_real_total, t->cpu_run_virtual_total,
-	   t->cpu_delay_total,
-	   "count", "delay total",
-	   t->blkio_count, t->blkio_delay_total,
-	   "count", "delay total", t->swapin_count, t->swapin_delay_total);
+	na = (struct nlattr *) GENLMSG_DATA(&ans);
+	na = (struct nlattr *) ((char *) na + NLA_ALIGN(na->nla_len));
+	if (na->nla_type == CTRL_ATTR_FAMILY_ID) {
+		id = *(__u16 *) NLA_DATA(na);
+	}
+	return id;
 }
 
-void sigchld(int sig)
+void print_delayacct(struct taskstats *t)
 {
-    done = 1;
+	printf("\n\nCPU   %15s%15s%15s%15s\n"
+	       "      %15llu%15llu%15llu%15llu\n"
+	       "IO    %15s%15s\n"
+	       "      %15llu%15llu\n"
+	       "MEM   %15s%15s\n"
+	       "      %15llu%15llu\n\n",
+	       "count", "real total", "virtual total", "delay total",
+	       t->cpu_count, t->cpu_run_real_total, t->cpu_run_virtual_total,
+	       t->cpu_delay_total,
+	       "count", "delay total",
+	       t->blkio_count, t->blkio_delay_total,
+	       "count", "delay total", t->swapin_count, t->swapin_delay_total);
 }
 
 int main(int argc, char *argv[])
 {
-    int rc;
-    int sk_nl;
-    struct nlmsghdr *nlh;
-    struct genlmsghdr *genlhdr;
-    char *buf;
-    struct taskstats_cmd_param *param;
-    __u16 id;
-    struct nlattr *na;
-
-    /* For receiving */
-    struct sockaddr_nl kern_nla, from_nla;
-    socklen_t from_nla_len;
-    int recv_len;
-    struct taskstats_reply *reply;
-
-    struct {
-	struct nlmsghdr n;
-	struct genlmsghdr g;
-	char buf[256];
-    } req;
-
-    struct {
-	struct nlmsghdr n;
-	struct genlmsghdr g;
-	char buf[256];
-    } ans;
+	int c, rc, rep_len, aggr_len, len2, cmd_type;
+	__u16 id;
+	__u32 mypid;
+
+	struct nlattr *na;
+	int nl_sd = -1;
+	int len = 0;
+	pid_t tid = 0;
+	pid_t rtid = 0;
+
+	int fd = 0;
+	int count = 0;
+	int write_file = 0;
+	int maskset = 0;
+	char logfile[128];
+	int loop = 0;
+
+	struct msgtemplate msg;
+
+	while (1) {
+		c = getopt(argc, argv, "dw:r:m:t:p:v:l");
+		if (c < 0)
+			break;
 
-    int nl_sd = -1;
-    int rep_len;
-    int len = 0;
-    int aggr_len, len2;
-    struct sockaddr_nl nladdr;
-    pid_t tid = 0;
-    pid_t rtid = 0;
-    int cmd_type = TASKSTATS_TYPE_TGID;
-    int c, status;
-    int forking = 0;
-    struct sigaction act = {
-	.sa_handler = SIG_IGN,
-	.sa_mask = SA_NOMASK,
-    };
-    struct sigaction tact ;
-
-    if (argc < 3) {
-	printf("usage %s [-t tgid][-p pid][-c cmd]\n", argv[0]);
-	exit(-1);
-    }
-
-    tact.sa_handler = sigchld;
-    sigemptyset(&tact.sa_mask);
-    if (sigaction(SIGCHLD, &tact, NULL) < 0)
-	err(1, "sigaction failed for SIGCHLD\n");
-
-    while (1) {
-
-	c = getopt(argc, argv, "t:p:c:");
-	if (c < 0)
-	    break;
-
-	switch (c) {
-	case 't':
-	    tid = atoi(optarg);
-	    if (!tid)
-		err(1, "Invalid tgid\n");
-	    cmd_type = TASKSTATS_CMD_ATTR_TGID;
-	    break;
-	case 'p':
-	    tid = atoi(optarg);
-	    if (!tid)
-		err(1, "Invalid pid\n");
-	    cmd_type = TASKSTATS_CMD_ATTR_TGID;
-	    break;
-	case 'c':
-	    opterr = 0;
-	    tid = fork();
-	    if (tid < 0)
-		err(1, "fork failed\n");
-
-	    if (tid == 0) {	/* child process */
-		if (execvp(argv[optind - 1], &argv[optind - 1]) < 0) {
-		    exit(-1);
+		switch (c) {
+		case 'd':
+			printf("print delayacct stats ON\n");
+			print_delays = 1;
+			break;
+		case 'w':
+			strncpy(logfile, optarg, MAX_FILENAME);
+			printf("write to file %s\n", logfile);
+			write_file = 1;
+			break;
+		case 'r':
+			rcvbufsz = atoi(optarg);
+			printf("receive buf size %d\n", rcvbufsz);
+			if (rcvbufsz < 0)
+				err(1, "Invalid rcv buf size\n");
+			break;
+		case 'm':
+			strncpy(cpumask, optarg, sizeof(cpumask));
+			maskset = 1;
+			printf("cpumask %s maskset %d\n", cpumask, maskset);
+			break;
+		case 't':
+			tid = atoi(optarg);
+			if (!tid)
+				err(1, "Invalid tgid\n");
+			cmd_type = TASKSTATS_CMD_ATTR_TGID;
+			print_delays = 1;
+			break;
+		case 'p':
+			tid = atoi(optarg);
+			if (!tid)
+				err(1, "Invalid pid\n");
+			cmd_type = TASKSTATS_CMD_ATTR_PID;
+			print_delays = 1;
+			break;
+		case 'v':
+			printf("debug on\n");
+			dbg = 1;
+			break;
+		case 'l':
+			printf("listen forever\n");
+			loop = 1;
+			break;
+		default:
+			printf("Unknown option %d\n", c);
+			exit(-1);
 		}
-	    }
-	    forking = 1;
-	    break;
-	default:
-	    printf("usage %s [-t tgid][-p pid][-c cmd]\n", argv[0]);
-	    exit(-1);
-	    break;
 	}
-	if (c == 'c')
-	    break;
-    }
-
-    /* Construct Netlink request message */
-
-    /* Send Netlink request message & get reply */
-
-    if ((nl_sd =
-	 create_nl_socket(NETLINK_GENERIC, TASKSTATS_LISTEN_GROUP)) < 0)
-	err(1, "error creating Netlink socket\n");
-
-
-    id = get_family_id(nl_sd);
-
-    /* Send command needed */
-    req.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
-    req.n.nlmsg_type = id;
-    req.n.nlmsg_flags = NLM_F_REQUEST;
-    req.n.nlmsg_seq = 0;
-    req.n.nlmsg_pid = tid;
-    req.g.cmd = TASKSTATS_CMD_GET;
-    na = (struct nlattr *) GENLMSG_DATA(&req);
-    na->nla_type = cmd_type;
-    na->nla_len = sizeof(unsigned int) + NLA_HDRLEN;
-    *(__u32 *) NLA_DATA(na) = tid;
-    req.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
-
-
-    if (!forking && sendto_fd(nl_sd, (char *) &req, req.n.nlmsg_len) < 0)
-	err(1, "error sending message via Netlink\n");
-
-    act.sa_handler = SIG_IGN;
-    sigemptyset(&act.sa_mask);
-    if (sigaction(SIGINT, &act, NULL) < 0)
-	err(1, "sigaction failed for SIGINT\n");
-
-    do {
-	int i;
-	struct pollfd pfd;
-	int pollres;
-
-	pfd.events = 0xffff & ~POLLOUT;
-	pfd.fd = nl_sd;
-	pollres = poll(&pfd, 1, 5000);
-	if (pollres < 0 || done) {
-	    break;
+
+	if (write_file) {
+		fd = open(logfile, O_WRONLY | O_CREAT | O_TRUNC,
+			  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		if (fd == -1) {
+			perror("Cannot open output file\n");
+			exit(1);
+		}
 	}
 
-	rep_len = recv(nl_sd, &ans, sizeof(ans), 0);
-	nladdr.nl_family = AF_NETLINK;
-	nladdr.nl_groups = TASKSTATS_LISTEN_GROUP;
+	if ((nl_sd = create_nl_socket(NETLINK_GENERIC)) < 0)
+		err(1, "error creating Netlink socket\n");
 
-	if (ans.n.nlmsg_type == NLMSG_ERROR) {	/* error */
-	    printf("error received NACK - leaving\n");
-	    exit(1);
+
+	mypid = getpid();
+	id = get_family_id(nl_sd);
+	if (!id) {
+		printf("Error getting family id, errno %d", errno);
+		goto err;
 	}
+	PRINTF("family id %d\n", id);
 
-	if (rep_len < 0) {
-	    err(1, "error receiving reply message via Netlink\n");
-	    break;
+	if (maskset) {
+		rc = send_cmd(nl_sd, id, mypid, TASKSTATS_CMD_GET,
+			      TASKSTATS_CMD_ATTR_REGISTER_CPUMASK,
+			      &cpumask, sizeof(cpumask));
+		PRINTF("Sent register cpumask, retval %d\n", rc);
+		if (rc < 0) {
+			printf("error sending register cpumask\n");
+			goto err;
+		}
 	}
 
-	/* Validate response message */
-	if (!NLMSG_OK((&ans.n), rep_len))
-	    err(1, "invalid reply message received via Netlink\n");
+	if (tid) {
+		rc = send_cmd(nl_sd, id, mypid, TASKSTATS_CMD_GET,
+			      cmd_type, &tid, sizeof(__u32));
+		PRINTF("Sent pid/tgid, retval %d\n", rc);
+		if (rc < 0) {
+			printf("error sending tid/tgid cmd\n");
+			goto done;
+		}
+	}
 
-	rep_len = GENLMSG_PAYLOAD(&ans.n);
+	do {
+		int i;
 
-	na = (struct nlattr *) GENLMSG_DATA(&ans);
-	len = 0;
-	i = 0;
-	while (len < rep_len) {
-	    len += NLA_ALIGN(na->nla_len);
-	    switch (na->nla_type) {
-	    case TASKSTATS_TYPE_AGGR_PID:
-		/* Fall through */
-	    case TASKSTATS_TYPE_AGGR_TGID:
-		aggr_len = NLA_PAYLOAD(na->nla_len);
-		len2 = 0;
-		/* For nested attributes, na follows */
-		na = (struct nlattr *) NLA_DATA(na);
-		done = 0;
-		while (len2 < aggr_len) {
-		    switch (na->nla_type) {
-		    case TASKSTATS_TYPE_PID:
-			rtid = *(int *) NLA_DATA(na);
-			break;
-		    case TASKSTATS_TYPE_TGID:
-			rtid = *(int *) NLA_DATA(na);
-			break;
-		    case TASKSTATS_TYPE_STATS:
-			if (rtid == tid) {
-			    print_taskstats((struct taskstats *)
-					    NLA_DATA(na));
-			    done = 1;
+		rep_len = recv(nl_sd, &msg, sizeof(msg), 0);
+		PRINTF("received %d bytes\n", rep_len);
+
+		if (rep_len < 0) {
+			printf("nonfatal reply error: errno %d\n", errno);
+			continue;
+		}
+		if (msg.n.nlmsg_type == NLMSG_ERROR ||
+		    !NLMSG_OK((&msg.n), rep_len)) {
+			printf("fatal reply error,  errno %d\n", errno);
+			goto done;
+		}
+
+		PRINTF("nlmsghdr size=%d, nlmsg_len=%d, rep_len=%d\n",
+		       sizeof(struct nlmsghdr), msg.n.nlmsg_len, rep_len);
+
+
+		rep_len = GENLMSG_PAYLOAD(&msg.n);
+
+		na = (struct nlattr *) GENLMSG_DATA(&msg);
+		len = 0;
+		i = 0;
+		while (len < rep_len) {
+			len += NLA_ALIGN(na->nla_len);
+			switch (na->nla_type) {
+			case TASKSTATS_TYPE_AGGR_TGID:
+				/* Fall through */
+			case TASKSTATS_TYPE_AGGR_PID:
+				aggr_len = NLA_PAYLOAD(na->nla_len);
+				len2 = 0;
+				/* For nested attributes, na follows */
+				na = (struct nlattr *) NLA_DATA(na);
+				done = 0;
+				while (len2 < aggr_len) {
+					switch (na->nla_type) {
+					case TASKSTATS_TYPE_PID:
+						rtid = *(int *) NLA_DATA(na);
+						if (print_delays)
+							printf("PID\t%d\n", rtid);
+						break;
+					case TASKSTATS_TYPE_TGID:
+						rtid = *(int *) NLA_DATA(na);
+						if (print_delays)
+							printf("TGID\t%d\n", rtid);
+						break;
+					case TASKSTATS_TYPE_STATS:
+						count++;
+						if (print_delays)
+							print_delayacct((struct taskstats *) NLA_DATA(na));
+						if (fd) {
+							if (write(fd, NLA_DATA(na), na->nla_len) < 0) {
+								err(1,"write error\n");
+							}
+						}
+						if (!loop)
+							goto done;
+						break;
+					default:
+						printf("Unknown nested nla_type %d\n", na->nla_type);
+						break;
+					}
+					len2 += NLA_ALIGN(na->nla_len);
+					na = (struct nlattr *) ((char *) na + len2);
+				}
+				break;
+
+			default:
+				printf("Unknown nla_type %d\n", na->nla_type);
+				break;
 			}
-			break;
-		    }
-		    len2 += NLA_ALIGN(na->nla_len);
-		    na = (struct nlattr *) ((char *) na + len2);
-		    if (done)
-			break;
+			na = (struct nlattr *) (GENLMSG_DATA(&msg) + len);
 		}
-	    }
-	    na = (struct nlattr *) (GENLMSG_DATA(&ans) + len);
-	    if (done)
-		break;
+	} while (loop);
+done:
+	if (maskset) {
+		rc = send_cmd(nl_sd, id, mypid, TASKSTATS_CMD_GET,
+			      TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK,
+			      &cpumask, sizeof(cpumask));
+		printf("Sent deregister mask, retval %d\n", rc);
+		if (rc < 0)
+			err(rc, "error sending deregister cpumask\n");
 	}
-	if (done)
-	    break;
-    }
-    while (1);
-
-    close(nl_sd);
-    return 0;
+err:
+	close(nl_sd);
+	if (fd)
+		close(fd);
+	return 0;
 }


