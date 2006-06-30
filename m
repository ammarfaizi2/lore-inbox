Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933095AbWF3TLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbWF3TLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933097AbWF3TLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:11:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:27029 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S933095AbWF3TLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:11:04 -0400
Message-ID: <44A5770F.3080206@watson.ibm.com>
Date: Fri, 30 Jun 2006 15:10:07 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, Jamal <hadi@cyberus.ca>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com>
In-Reply-To: <44A57310.3010208@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:

> Andrew,
>
> Based on previous discussions, the above solutions can be expanded/modified to:
>
> a) allow userspace to listen to a group of cpus instead of all. Multiple
> collection daemons can distribute the load as you pointed out. Doing collection
> by cpu groups rather than individual cpus reduces the aggregation burden on
> userspace (and scales better with NR_CPUS)


> I'm sending a patch that demonstrates how a) can be done quite simply
> and a patch for b) is in progress.
>

Here's the patch.
Testing etc. need to be done (an earlier version that did per-cpu queues
has worked) but the main point is to show how small a change is needed
in the interface (on both the kernel and user side)
and current codebase to achieve the a) solution.

Also to get feedback on this kind of usage of the nl_pid field, the
approach etc.

Thanks,
Shailabh






=======================================================================


On systems with a large number of cpus, with even a modest rate of tasks
exiting per cpu, the volume of taskstats data sent on thread exit can overflow
a userspace listener's buffers.

One approach to avoiding overflow is to allow listeners to get data for a
limited number of cpus. By scaling the number of listening programs, each
listening to a different set of cpus, userspace can avoid more overflow
situations.

This patch implements this idea by creating simple grouping of cpus and
allowing userspace to listen to any cpu group it chooses.

Alternative designs considered and rejected were:

- creating a separate netlink group for each group of cpus. Since only 32
netlink groups can be specified by a user, this option will not scale with
number of cpus.

- aligning the grouping of cpus with cpusets. The unnecessary tying together
of the two functionalities was not merited.

Thanks to Balbir Singh for discovering the potential use of the pid field of
sockaddr_nl as a communication subchannel in the same socket, Paul Jackson and
Vivek Kashyap for suggesting cpus be grouped together for data send purposes.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Balbir Singh <balbir@in.ibm.com>

 Documentation/accounting/getdelays.c |   30 +++++++++++++++++++-----------
 include/linux/taskstats.h            |   22 ++++++++++++++++++++++
 kernel/taskstats.c                   |    5 +++--
 3 files changed, 44 insertions(+), 13 deletions(-)

Index: linux-2.6.17-mm3equiv/include/linux/taskstats.h
===================================================================
--- linux-2.6.17-mm3equiv.orig/include/linux/taskstats.h	2006-06-30 11:57:14.000000000 -0400
+++ linux-2.6.17-mm3equiv/include/linux/taskstats.h	2006-06-30 14:24:49.000000000 -0400
@@ -89,6 +89,28 @@ struct taskstats {

 #define TASKSTATS_LISTEN_GROUP	0x1

+
+/*
+ * Per-task exit data sent from the kernel to user space
+ * is tagged by an id based on grouping of cpus.
+ *
+ * If userspace specifies a non-zero P as the nl_pid field of
+ * the sockaddr_nl structure while binding to a netlink socket,
+ * it will receive exit data from threads that exited on cpus in the range
+ *
+ *    [(P-1)*Y, P*Y-1]
+ *
+ *  where Y = TASKSTATS_CPUS_PER_SET
+ *  i.e. if TASKSTATS_CPUS_PER_SET is 16,
+ *  to listen to data from cpus 0..15, specify P=1
+ *  for cpus 16..32, specify P=2 etc.
+ *
+ *  To listen to data from all cpus, userspace should use P=0
+ */
+
+#define TASKSTATS_CPUS_PER_SET	16
+
+
 /*
  * Commands sent from userspace
  * Not versioned. New commands should only be inserted at the enum's end
Index: linux-2.6.17-mm3equiv/kernel/taskstats.c
===================================================================
--- linux-2.6.17-mm3equiv.orig/kernel/taskstats.c	2006-06-30 11:57:14.000000000 -0400
+++ linux-2.6.17-mm3equiv/kernel/taskstats.c	2006-06-30 13:58:36.000000000 -0400
@@ -266,7 +266,7 @@ void taskstats_exit_send(struct task_str
 	struct sk_buff *rep_skb;
 	void *reply;
 	size_t size;
-	int is_thread_group;
+	int is_thread_group, setid;
 	struct nlattr *na;

 	if (!family_registered || !tidstats)
@@ -320,7 +320,8 @@ void taskstats_exit_send(struct task_str
 	nla_nest_end(rep_skb, na);

 send:
-	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+	setid = (smp_processor_id()%TASKSTATS_CPUS_PER_SET)+1;
+	send_reply(rep_skb, setid, TASKSTATS_MSG_MULTICAST);
 	return;

 nla_put_failure:
Index: linux-2.6.17-mm3equiv/Documentation/accounting/getdelays.c
===================================================================
--- linux-2.6.17-mm3equiv.orig/Documentation/accounting/getdelays.c	2006-06-28 16:08:56.000000000 -0400
+++ linux-2.6.17-mm3equiv/Documentation/accounting/getdelays.c	2006-06-30 14:09:28.000000000 -0400
@@ -40,7 +40,7 @@ int done = 0;
 /*
  * Create a raw netlink socket and bind
  */
-static int create_nl_socket(int protocol, int groups)
+static int create_nl_socket(int protocol, int cpugroup)
 {
     socklen_t addr_len;
     int fd;
@@ -52,7 +52,8 @@ static int create_nl_socket(int protocol

     memset(&local, 0, sizeof(local));
     local.nl_family = AF_NETLINK;
-    local.nl_groups = groups;
+    local.nl_groups = TASKSTATS_LISTEN_GROUP;
+    local.nl_pid = cpugroup;

     if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0)
 	goto error;
@@ -203,7 +204,7 @@ int main(int argc, char *argv[])
     pid_t rtid = 0;
     int cmd_type = TASKSTATS_TYPE_TGID;
     int c, status;
-    int forking = 0;
+    int forking = 0, cpugroup = 0;
     struct sigaction act = {
 	.sa_handler = SIG_IGN,
 	.sa_mask = SA_NOMASK,
@@ -222,7 +223,7 @@ int main(int argc, char *argv[])

     while (1) {

-	c = getopt(argc, argv, "t:p:c:");
+	c = getopt(argc, argv, "t:p:c:g:l");
 	if (c < 0)
 	    break;

@@ -252,8 +253,14 @@ int main(int argc, char *argv[])
 	    }
 	    forking = 1;
 	    break;
+	case 'g':
+		cpugroup = atoi(optarg);
+		break;
+	case 'l':
+		loop = 1;
+		break;
 	default:
-	    printf("usage %s [-t tgid][-p pid][-c cmd]\n", argv[0]);
+	    printf("usage %s [-t tgid][-p pid][-c cmd][-g cpugroup][-l]\n", argv[0]);
 	    exit(-1);
 	    break;
 	}
@@ -266,7 +273,7 @@ int main(int argc, char *argv[])
     /* Send Netlink request message & get reply */

     if ((nl_sd =
-	 create_nl_socket(NETLINK_GENERIC, TASKSTATS_LISTEN_GROUP)) < 0)
+	 create_nl_socket(NETLINK_GENERIC, cpugroup)) < 0)
 	err(1, "error creating Netlink socket\n");


@@ -287,10 +294,10 @@ int main(int argc, char *argv[])


     if (!forking && sendto_fd(nl_sd, (char *) &req, req.n.nlmsg_len) < 0)
+    if ((!forking && !loop) &&
+	sendto_fd(nl_sd, (char *) &req, req.n.nlmsg_len) < 0)
 	err(1, "error sending message via Netlink\n");

-    act.sa_handler = SIG_IGN;
-    sigemptyset(&act.sa_mask);
     if (sigaction(SIGINT, &act, NULL) < 0)
 	err(1, "sigaction failed for SIGINT\n");

@@ -349,10 +356,11 @@ int main(int argc, char *argv[])
 			rtid = *(int *) NLA_DATA(na);
 			break;
 		    case TASKSTATS_TYPE_STATS:
-			if (rtid == tid) {
+			if (rtid == tid || loop) {
 			    print_taskstats((struct taskstats *)
 					    NLA_DATA(na));
-			    done = 1;
+			    if (!loop)
+				    done = 1;
 			}
 			break;
 		    }
@@ -369,7 +377,7 @@ int main(int argc, char *argv[])
 	if (done)
 	    break;
     }
-    while (1);
+    while (loop);

     close(nl_sd);
     return 0;

