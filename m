Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTFPR7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFPR7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:59:52 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:46653 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264083AbTFPR7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:59:48 -0400
Message-ID: <3EEE08CD.6020702@google.com>
Date: Mon, 16 Jun 2003 11:13:33 -0700
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21 /proc/<pid>/cmdline overflow
Content-Type: multipart/mixed;
 boundary="------------080204060700050606050005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080204060700050606050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Currently when a process has a command line that is more than 4k long, 
the internal buffer does not end up being null terminated and the kernel 
assumes that the process has called setproctitle.  The net effect is 
that for processes with >4k command lines, the commnad line available 
via proc is terminated after argv[0].

This patch terminates >4k command lines with ... at the 4k mark.

It has been only minimal tested in 2.4.21, but has been used quite a bit 
in 2.4.18.

    Ross




--------------080204060700050606050005
Content-Type: text/plain;
 name="4kcmdline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4kcmdline.patch"

diff -urbBd linux-2.4.21-1/fs/proc/base.c linux-2.4.21-2/fs/proc/base.c
--- linux-2.4.21-1/fs/proc/base.c	Fri Jun 13 07:51:37 2003
+++ linux-2.4.21-2/fs/proc/base.c	Mon Jun 16 11:08:09 2003
@@ -26,6 +26,15 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 
+ /*
+ * What to put in the command line when we truncat them.
+ *
+ */
+#define DOTS "..."
+// includes the trailing null.
+#define DOTLEN 4 
+
+
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
  * Feel free to change the macro below - just keep the range distinct from
@@ -154,11 +163,23 @@
 	task_unlock(task);
 	if (mm) {
 		int len = mm->arg_end - mm->arg_start;
-		if (len > PAGE_SIZE)
+		if (len > PAGE_SIZE) {
 			len = PAGE_SIZE;
-		res = access_process_vm(task, mm->arg_start, buffer, len, 0);
+			res = access_process_vm(task, mm->arg_start,
+						buffer, len, 0);
+			if (res > 0) {
+				memcpy(buffer + PAGE_SIZE - DOTLEN, 
+				       DOTS, DOTLEN);
+				res = PAGE_SIZE;
+			}
+		} else {
+			res = access_process_vm(task, mm->arg_start, 
+						buffer, len, 0);
+		}
+
 		// If the nul at the end of args has been overwritten, then
 		// assume application is using setproctitle(3).
+
 		if ( res > 0 && buffer[res-1] != '\0' )
 		{
 			len = strnlen( buffer, res );

--------------080204060700050606050005--

