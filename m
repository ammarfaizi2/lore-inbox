Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTJNPp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTJNPp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:45:57 -0400
Received: from ginger.lcs.mit.edu ([18.26.0.82]:18180 "EHLO ginger.lcs.mit.edu")
	by vger.kernel.org with ESMTP id S262718AbTJNPpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:45:55 -0400
Message-Id: <200310141545.h9EFjVWB013311@ginger.lcs.mit.edu>
From: Tim Shepard <shep@alum.mit.edu>
To: davem@redhat.com, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, netdev@oss.sgi.com
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] (linux-2.6.0-test7) fix missing connections in /proc/net/tcp ("netstat -n -t -a")
Date: Tue, 14 Oct 2003 11:45:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running linux-2.6.0-test7 and I have just found and fixed a bug
that was causing "netstat -n -t" to fail to display all of the
relevant connections (in some cases).  The bug can be demonstrated by
noticing that

	dd if=/proc/net/tcp bs=128k of=/tmp/tcp.big

returns more lines into the output file than does

	dd if=/proc/net/tcp bs=1k of=/tmp/tcp.1k

which is using the same size read buffer that /bin/netstat uses.

(Note, the first number on each line read from /proc/net/tcp is crazy
 on a linux-2.6.0-test7 kernel, and I will in a few moments send
 another patch along to address that.   But fixing *this* bug is
 much more important than fixing that bug.)

Triggering this bug depends on having enough TCP sockets in LISTEN (I
believe 8 is sufficient) and you may have to create a few more TCP
connections and/or transition some to TIMEWAIT (by closing them) to be
able to see the bug.  The bug is most easily seen on a system where
you know exactly what TCP connections you have open and in time-wait
and can spot the descrepency in the output from "netstat -n -t".


Patch is below.  The problem is that listening_get_idx was not
decrementing *pos exactly the same number of times that it cdr'd down
the list.

The change to established_get_idx is not necessary to fix the bug,
but does keep it in sync with listening_get_idx.

I hope this is helpful and that that I have properly submitted this patch.
I welcome any comments.

			-Tim Shepard
			 shep@alum.mit.edu


--- ../pristine/linux-2.6.0-test7/net/ipv4/tcp_ipv4.c	2003-10-08 15:24:03.000000000 -0400
+++ net/ipv4/tcp_ipv4.c	2003-10-13 17:33:09.000000000 -0400
@@ -2233,14 +2233,15 @@
 
 static void *listening_get_idx(struct seq_file *seq, loff_t *pos)
 {
 	void *rc = listening_get_first(seq);
 
-	if (rc)
-		while (*pos && (rc = listening_get_next(seq, rc)))
-			--*pos;
-	return *pos ? NULL : rc;
+	while (rc && *pos) {
+		rc = listening_get_next(seq, rc);
+		--*pos;
+	}
+	return rc;
 }
 
 static void *established_get_first(struct seq_file *seq)
 {
 	struct tcp_iter_state* st = seq->private;
@@ -2325,14 +2326,15 @@
 
 static void *established_get_idx(struct seq_file *seq, loff_t pos)
 {
 	void *rc = established_get_first(seq);
 
-	if (rc)
-		while (pos && (rc = established_get_next(seq, rc)))
-			--pos;
-	return pos ? NULL : rc;
+	while (rc && pos) {
+		rc = established_get_next(seq, rc);
+		--pos;
+	}		
+	return rc;
 }
 
 static void *tcp_get_idx(struct seq_file *seq, loff_t pos)
 {
 	void *rc;
