Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbTIVPzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTIVPyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:54:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47283 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263211AbTIVPxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:53:24 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: torvalds@osdl.org, akpm@zip.com.au, thornber@sistina.com
Subject: [PATCH] DM 6/6: Support arbitrary number of target params
Date: Mon, 22 Sep 2003 10:53:08 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200309221044.21694.kevcorry@us.ibm.com>
In-Reply-To: <200309221044.21694.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221053.08510.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support an arbitrary number of target parameters.  [Alasdair Kergon]

--- diff/drivers/md/dm-table.c	2003-09-17 12:28:06.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-09-17 13:09:41.000000000 +0100
@@ -534,12 +534,36 @@
 }
 
 /*
+ * Used to dynamically allocate the arg array.
+ */
+static char **realloc_argv(unsigned *array_size, char **old_argv)
+{
+	char **argv;
+	unsigned new_size;
+
+	new_size = *array_size ? *array_size * 2 : 64;
+	argv = kmalloc(new_size * sizeof(*argv), GFP_KERNEL);
+	if (argv) {
+		memcpy(argv, old_argv, *array_size * sizeof(*argv));
+		*array_size = new_size;
+	}
+
+	kfree(old_argv);
+	return argv;
+}
+
+/*
  * Destructively splits up the argument list to pass to ctr.
  */
-static int split_args(int max, int *argc, char **argv, char *input)
+static int split_args(int *argc, char ***argvp, char *input)
 {
-	char *start, *end = input, *out;
+	char *start, *end = input, *out, **argv = NULL;
+	unsigned array_size = 0;
+
 	*argc = 0;
+	argv = realloc_argv(&array_size, argv);
+	if (!argv)
+		return -ENOMEM;
 
 	while (1) {
 		start = end;
@@ -568,8 +592,11 @@
 		}
 
 		/* have we already filled the array ? */
-		if ((*argc + 1) > max)
-			return -EINVAL;
+		if ((*argc + 1) > array_size) {
+			argv = realloc_argv(&array_size, argv);
+			if (!argv)
+				return -ENOMEM;
+		}
 
 		/* we know this is whitespace */
 		if (*end)
@@ -581,6 +608,7 @@
 		(*argc)++;
 	}
 
+	*argvp = argv;
 	return 0;
 }
 
@@ -588,7 +616,7 @@
 			sector_t start, sector_t len, char *params)
 {
 	int r = -EINVAL, argc;
-	char *argv[32];
+	char **argv;
 	struct dm_target *tgt;
 
 	if ((r = check_space(t)))
@@ -617,13 +645,14 @@
 		goto bad;
 	}
 
-	r = split_args(ARRAY_SIZE(argv), &argc, argv, params);
+	r = split_args(&argc, &argv, params);
 	if (r) {
-		tgt->error = "couldn't split parameters";
+		tgt->error = "couldn't split parameters (insufficient memory)";
 		goto bad;
 	}
 
 	r = tgt->type->ctr(tgt, argc, argv);
+	kfree(argv);
 	if (r)
 		goto bad;
 

