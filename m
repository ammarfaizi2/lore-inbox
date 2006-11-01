Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946924AbWKAQWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946924AbWKAQWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946926AbWKAQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:22:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44427 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946924AbWKAQV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:21:59 -0500
Subject: [PATCH] Add get_range, allows a hyhpenated range to get_options
From: Derek Fults <dfults@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 10:22:36 -0600
Message-Id: <1162398157.9524.490.camel@lnx-dfults.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows a hyphenated range of positive numbers in the string passed
to command line helper function, get_options.    
Currently the command line option "isolcpus=" takes as its argument a
list of cpus.  
Format: <cpu number>,...,<cpu number>
This can get extremely long when isolating the majority of cpus on a
large system.  Valid values of <cpu_number>  include all cpus, 0 to
"number of CPUs in system - 1".

Signed-off-by: Derek Fults <dfults@sgi.com>  

Index: linux/lib/cmdline.c
===================================================================
--- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
+++ linux/lib/cmdline.c	2006-11-01 10:16:09.988659834 -0600
@@ -16,6 +16,21 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 
+/* If a hyphen was found in get_option, this will handle the 
+ * range of numbers given. 
+ */
+
+static int get_range(char **str, int *pint)
+{
+	int x, inc_counter = 0, upper_range = 0;
+
+	(*str)++;
+	upper_range = simple_strtol((*str), NULL, 0);
+	inc_counter = upper_range - *pint;
+	for (x = *pint; x < upper_range; x++)
+		*pint++ = x;
+	return inc_counter;
+}
 
 /**
  *	get_option - Parse integer from an option string
@@ -29,6 +44,7 @@
  *	0 : no int in string
  *	1 : int found, no subsequent comma
  *	2 : int found including a subsequent comma
+ *	3 : hyphen found to denote a range
  */
 
 int get_option (char **str, int *pint)
@@ -44,6 +60,8 @@
 		(*str)++;
 		return 2;
 	}
+	if (**str == '-')
+		return 3;
 
 	return 1;
 }
@@ -55,7 +73,8 @@
  *	@ints: integer array
  *
  *	This function parses a string containing a comma-separated
- *	list of integers.  The parse halts when the array is
+ *	list of integers, a hyphen-separated range of _positive_ integers,
+ *	or a combination of both.  The parse halts when the array is
  *	full, or when no more numbers can be retrieved from the
  *	string.
  *
@@ -72,6 +91,14 @@
 		res = get_option ((char **)&str, ints + i);
 		if (res == 0)
 			break;
+		if (res == 3) {
+			int range_nums = 0;
+			range_nums = get_range((char **)&str, ints + i);
+			/* Decrement the result by one to leave out the
+			   last number in the range.  The next iteration
+			   will handle the upper number in the range */
+			i += (range_nums - 1);
+		}
 		i++;
 		if (res == 1)
 			break;
