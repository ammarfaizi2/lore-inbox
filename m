Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVHXVNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVHXVNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHXVNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:13:53 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:10917 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932229AbVHXVNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:13:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Lju7DImFZG5bbiI+YrvHcuOdrDueRFJHfex+kqXhcN4Sht1l7I9B0GftS/JpaGHfIL75gMyAdR8eFb3lSIYooZVi1e7zaaU88vNNBo3WCEWgZDsHAVGRHmPTl/QYt0MpWEQMETqRAMJSrZEpJdjo6f+DjoiRsEI/UzPBUTLBsQo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
Date: Wed, 24 Aug 2005 23:14:40 +0200
User-Agent: KMail/1.8.2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Horst von Brand <vonbrand@inf.utfsm.cl>
References: <200508242108.53198.jesper.juhl@gmail.com> <9a87484905082413312b5a603a@mail.gmail.com> <430CDAFF.8070201@didntduck.org>
In-Reply-To: <430CDAFF.8070201@didntduck.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508242314.41324.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 August 2005 22:39, Brian Gerst wrote:
> 
> Do this instead:
> 	char ln[LINE_SIZE], *line;
> 
Right, now why didn't I think of that :)

Jeff: Does the patch below agree with you more?


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 usr/gen_init_cpio.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)
 
 --- linux-2.6.13-rc6-mm2-orig/usr/gen_init_cpio.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-mm2/usr/gen_init_cpio.c	2005-08-24 23:10:36.000000000 +0200
@@ -438,7 +438,8 @@ struct file_handler file_handler_table[]
 int main (int argc, char *argv[])
 {
 	FILE *cpio_list;
-	char line[LINE_SIZE];
+	char ln[LINE_SIZE];
+	char *line;
 	char *args, *type;
 	int ec = 0;
 	int line_nr = 0;
@@ -455,7 +456,7 @@ int main (int argc, char *argv[])
 		exit(1);
 	}
 
-	while (fgets(line, LINE_SIZE, cpio_list)) {
+	while (line = ln, fgets(line, LINE_SIZE, cpio_list)) {
 		int type_idx;
 		size_t slen = strlen(line);
 
@@ -466,11 +467,12 @@ int main (int argc, char *argv[])
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
 
 		if ('\n' == *type) {
@@ -483,16 +485,20 @@ int main (int argc, char *argv[])
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
@@ -503,7 +509,7 @@ int main (int argc, char *argv[])
 
 		if (NULL == file_handler_table[type_idx].type) {
 			fprintf(stderr, "unknown file type line %d: '%s'\n",
-				line_nr, line);
+				line_nr, ln);
 		}
 	}
 	cpio_trailer();
