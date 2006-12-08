Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425436AbWLHLy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425436AbWLHLy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425434AbWLHLxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:53:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52404 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425428AbWLHLxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:53:18 -0500
Message-Id: <200612081152.kB8BqZ08019786@shell0.pdx.osdl.net>
Subject: [patch 13/13] io-accounting: add to getdelays
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Wire up the IO accounting into getdelays.c.

Usage:

To display I/O stats for each exitting task:

vmm:/home/akpm> ./getdelays -m0,1,2,3 -i -l
cpumask 0 maskset 1
printing IO accounting
listen forever
rm: read=8192, write=0, cancelled_write=0
cvs: read=733184, write=4255744, cancelled_write=4096
make: read=217088, write=0, cancelled_write=0
cc1: read=4263936, write=12288, cancelled_write=0
as: read=811008, write=8192, cancelled_write=0
gcc: read=323584, write=0, cancelled_write=12288
cc1: read=0, write=8192, cancelled_write=0
as: read=4096, write=4096, cancelled_write=0
gcc: read=16384, write=0, cancelled_write=4096
as: read=4096, write=4096, cancelled_write=0
gcc: read=16384, write=0, cancelled_write=8192
ld: read=1011712, write=16384, cancelled_write=0
collect2: read=626688, write=0, cancelled_write=0
gcc: read=204800, write=0, cancelled_write=0
cc1: read=0, write=8192, cancelled_write=0
as: read=4096, write=4096, cancelled_write=0
gcc: read=16384, write=0, cancelled_write=8192
ld: read=8192, write=16384, cancelled_write=0
collect2: read=49152, write=0, cancelled_write=0
gcc: read=0, write=0, cancelled_write=0
cc1: read=0, write=4096, cancelled_write=0
ld: read=4096, write=12288, cancelled_write=0
collect2: read=49152, write=0, cancelled_write=0
gcc: read=0, write=0, cancelled_write=0


To display I/O stats for a particular presently-running task:

vmm:/home/akpm> ./getdelays -i -p $(pidof crond)
printing IO accounting
crond: read=61440, write=0, cancelled_write=0


Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/accounting/getdelays.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff -puN Documentation/accounting/getdelays.c~io-accounting-add-to-getdelays Documentation/accounting/getdelays.c
--- a/Documentation/accounting/getdelays.c~io-accounting-add-to-getdelays
+++ a/Documentation/accounting/getdelays.c
@@ -48,6 +48,7 @@ int rcvbufsz;
 char name[100];
 int dbg;
 int print_delays;
+int print_io_accounting;
 __u64 stime, utime;
 
 #define PRINTF(fmt, arg...) {			\
@@ -195,6 +196,15 @@ void print_delayacct(struct taskstats *t
 	       "count", "delay total", t->swapin_count, t->swapin_delay_total);
 }
 
+void print_ioacct(struct taskstats *t)
+{
+	printf("%s: read=%llu, write=%llu, cancelled_write=%llu\n",
+		t->ac_comm,
+		(unsigned long long)t->read_bytes,
+		(unsigned long long)t->write_bytes,
+		(unsigned long long)t->cancelled_write_bytes);
+}
+
 int main(int argc, char *argv[])
 {
 	int c, rc, rep_len, aggr_len, len2, cmd_type;
@@ -217,7 +227,7 @@ int main(int argc, char *argv[])
 	struct msgtemplate msg;
 
 	while (1) {
-		c = getopt(argc, argv, "dw:r:m:t:p:v:l");
+		c = getopt(argc, argv, "diw:r:m:t:p:v:l");
 		if (c < 0)
 			break;
 
@@ -226,6 +236,10 @@ int main(int argc, char *argv[])
 			printf("print delayacct stats ON\n");
 			print_delays = 1;
 			break;
+		case 'i':
+			printf("printing IO accounting\n");
+			print_io_accounting = 1;
+			break;
 		case 'w':
 			strncpy(logfile, optarg, MAX_FILENAME);
 			printf("write to file %s\n", logfile);
@@ -247,14 +261,12 @@ int main(int argc, char *argv[])
 			if (!tid)
 				err(1, "Invalid tgid\n");
 			cmd_type = TASKSTATS_CMD_ATTR_TGID;
-			print_delays = 1;
 			break;
 		case 'p':
 			tid = atoi(optarg);
 			if (!tid)
 				err(1, "Invalid pid\n");
 			cmd_type = TASKSTATS_CMD_ATTR_PID;
-			print_delays = 1;
 			break;
 		case 'v':
 			printf("debug on\n");
@@ -367,6 +379,8 @@ int main(int argc, char *argv[])
 						count++;
 						if (print_delays)
 							print_delayacct((struct taskstats *) NLA_DATA(na));
+						if (print_io_accounting)
+							print_ioacct((struct taskstats *) NLA_DATA(na));
 						if (fd) {
 							if (write(fd, NLA_DATA(na), na->nla_len) < 0) {
 								err(1,"write error\n");
_
