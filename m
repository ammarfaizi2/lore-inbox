Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425423AbWLHLwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425423AbWLHLwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425425AbWLHLwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:52:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52351 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425423AbWLHLwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:52:45 -0500
Message-Id: <200612081152.kB8BqYc5019783@shell0.pdx.osdl.net>
Subject: [patch 12/13] getdelays: various fixes
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

- Various cleanups

- Report errors to stderr, not stdout

- A printf was missing a \n and was hiding from me.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/accounting/getdelays.c |   44 ++++++++++++++++---------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff -puN Documentation/accounting/getdelays.c~getdelays-various-fixes Documentation/accounting/getdelays.c
--- a/Documentation/accounting/getdelays.c~getdelays-various-fixes
+++ a/Documentation/accounting/getdelays.c
@@ -7,6 +7,8 @@
  * Copyright (C) Balbir Singh, IBM Corp. 2006
  * Copyright (c) Jay Lan, SGI. 2006
  *
+ * Compile with
+ *	gcc -I/usr/src/linux/include getdelays.c -o getdelays
  */
 
 #include <stdio.h>
@@ -35,13 +37,19 @@
 #define NLA_DATA(na)		((void *)((char*)(na) + NLA_HDRLEN))
 #define NLA_PAYLOAD(len)	(len - NLA_HDRLEN)
 
-#define err(code, fmt, arg...) do { printf(fmt, ##arg); exit(code); } while (0)
-int done = 0;
-int rcvbufsz=0;
-
-    char name[100];
-int dbg=0, print_delays=0;
+#define err(code, fmt, arg...)			\
+	do {					\
+		fprintf(stderr, fmt, ##arg);	\
+		exit(code);			\
+	} while (0)
+
+int done;
+int rcvbufsz;
+char name[100];
+int dbg;
+int print_delays;
 __u64 stime, utime;
+
 #define PRINTF(fmt, arg...) {			\
 	    if (dbg) {				\
 		printf(fmt, ##arg);		\
@@ -78,8 +86,9 @@ static int create_nl_socket(int protocol
 	if (rcvbufsz)
 		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF,
 				&rcvbufsz, sizeof(rcvbufsz)) < 0) {
-			printf("Unable to set socket rcv buf size to %d\n",
-			       rcvbufsz);
+			fprintf(stderr, "Unable to set socket rcv buf size "
+					"to %d\n",
+				rcvbufsz);
 			return -1;
 		}
 
@@ -277,7 +286,7 @@ int main(int argc, char *argv[])
 	mypid = getpid();
 	id = get_family_id(nl_sd);
 	if (!id) {
-		printf("Error getting family id, errno %d", errno);
+		fprintf(stderr, "Error getting family id, errno %d\n", errno);
 		goto err;
 	}
 	PRINTF("family id %d\n", id);
@@ -288,7 +297,7 @@ int main(int argc, char *argv[])
 			      &cpumask, strlen(cpumask) + 1);
 		PRINTF("Sent register cpumask, retval %d\n", rc);
 		if (rc < 0) {
-			printf("error sending register cpumask\n");
+			fprintf(stderr, "error sending register cpumask\n");
 			goto err;
 		}
 	}
@@ -298,7 +307,7 @@ int main(int argc, char *argv[])
 			      cmd_type, &tid, sizeof(__u32));
 		PRINTF("Sent pid/tgid, retval %d\n", rc);
 		if (rc < 0) {
-			printf("error sending tid/tgid cmd\n");
+			fprintf(stderr, "error sending tid/tgid cmd\n");
 			goto done;
 		}
 	}
@@ -310,13 +319,15 @@ int main(int argc, char *argv[])
 		PRINTF("received %d bytes\n", rep_len);
 
 		if (rep_len < 0) {
-			printf("nonfatal reply error: errno %d\n", errno);
+			fprintf(stderr, "nonfatal reply error: errno %d\n",
+				errno);
 			continue;
 		}
 		if (msg.n.nlmsg_type == NLMSG_ERROR ||
 		    !NLMSG_OK((&msg.n), rep_len)) {
 			struct nlmsgerr *err = NLMSG_DATA(&msg);
-			printf("fatal reply error,  errno %d\n", err->error);
+			fprintf(stderr, "fatal reply error,  errno %d\n",
+				err->error);
 			goto done;
 		}
 
@@ -365,7 +376,9 @@ int main(int argc, char *argv[])
 							goto done;
 						break;
 					default:
-						printf("Unknown nested nla_type %d\n", na->nla_type);
+						fprintf(stderr, "Unknown nested"
+							" nla_type %d\n",
+							na->nla_type);
 						break;
 					}
 					len2 += NLA_ALIGN(na->nla_len);
@@ -374,7 +387,8 @@ int main(int argc, char *argv[])
 				break;
 
 			default:
-				printf("Unknown nla_type %d\n", na->nla_type);
+				fprintf(stderr, "Unknown nla_type %d\n",
+					na->nla_type);
 				break;
 			}
 			na = (struct nlattr *) (GENLMSG_DATA(&msg) + len);
_
