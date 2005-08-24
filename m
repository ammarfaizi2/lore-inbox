Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVHXTIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVHXTIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVHXTIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:08:09 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:48606 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751418AbVHXTIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:08:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ED8sGO9WUpR5cToJ2wA74jAi1mQ4Q+RDrzwp2MTuR/iU2BznVdm0vlEojs+3vZCy78kMLFcfQXqnOGUHIMiiXDViNcBa9inCJO6FWeEMV8Q+To38nIiHqYG98Qc0QLLUuf6KkOMQOB3B71UUHdkAh7TIBeG7C2CbeCFGtB34gPA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
Date: Wed, 24 Aug 2005 21:08:53 +0200
User-Agent: KMail/1.8.2
Cc: jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242108.53198.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert strtok() use to strsep() in usr/gen_init_cpio.c

I've compile tested this patch and it compiles fine.
I build a 2.6.13-rc6-mm2 kernel with the patch applied without problems, and
the resulting kernel boots and runs just fine (using it right now).
But despite this basic testing it would still be nice if someone would 
double-check that I haven't made some silly mistake that would break some 
other setup than mine.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 gen_init_cpio.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

--- linux-2.6.13-rc6-mm2-orig/usr/gen_init_cpio.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-mm2/usr/gen_init_cpio.c	2005-08-24 18:58:21.000000000 +0200
@@ -438,7 +438,7 @@ struct file_handler file_handler_table[]
 int main (int argc, char *argv[])
 {
 	FILE *cpio_list;
-	char line[LINE_SIZE];
+	char *line, *ln;
 	char *args, *type;
 	int ec = 0;
 	int line_nr = 0;
@@ -455,7 +455,14 @@ int main (int argc, char *argv[])
 		exit(1);
 	}
 
-	while (fgets(line, LINE_SIZE, cpio_list)) {
+	ln = malloc(LINE_SIZE);
+	if (!ln) {
+		fprintf(stderr,
+			"ERROR: unable to allocate %d bytes of buffer\n", LINE_SIZE);
+		exit(1);
+	}
+
+	while (line = ln, fgets(line, LINE_SIZE, cpio_list)) {
 		int type_idx;
 		size_t slen = strlen(line);
 
@@ -466,14 +473,15 @@ int main (int argc, char *argv[])
 			continue;
 		}
 
-		if (! (type = strtok(line, " \t"))) {
+		if (! (type = strsep(&line, " \t"))) {
 			fprintf(stderr,
 				"ERROR: incorrect format, could not locate file type line %d: '%s'\n",
-				line_nr, line);
+				line_nr, ln);
 			ec = -1;
+			continue;
 		}
 
-		if ('\n' == *type) {
+		if (!*type || '\n' == *type) {
 			/* a blank line */
 			continue;
 		}
@@ -483,16 +491,20 @@ int main (int argc, char *argv[])
 			continue;
 		}
 
-		if (! (args = strtok(NULL, "\n"))) {
+		if (! (args = strsep(&line, "\n"))) {
 			fprintf(stderr,
 				"ERROR: incorrect format, newline required line %d: '%s'\n",
-				line_nr, line);
+				line_nr, ln);
 			ec = -1;
+			continue;
 		}
+		
+		if (!*args)
+			continue;
 
 		for (type_idx = 0; file_handler_table[type_idx].type; type_idx++) {
 			int rc;
-			if (! strcmp(line, file_handler_table[type_idx].type)) {
+			if (! strcmp(type, file_handler_table[type_idx].type)) {
 				if ((rc = file_handler_table[type_idx].handler(args))) {
 					ec = rc;
 					fprintf(stderr, " line %d\n", line_nr);
@@ -503,9 +515,10 @@ int main (int argc, char *argv[])
 
 		if (NULL == file_handler_table[type_idx].type) {
 			fprintf(stderr, "unknown file type line %d: '%s'\n",
-				line_nr, line);
+				line_nr, ln);
 		}
 	}
+	free(ln);
 	cpio_trailer();
 
 	exit(ec);


