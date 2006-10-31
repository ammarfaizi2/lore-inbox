Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945998AbWJaVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945998AbWJaVGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945999AbWJaVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:06:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:25513 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1945998AbWJaVGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:06:19 -0500
Subject: [PATCH] Allow a hyphenated range in get_options, with cleanup
From: Derek Fults <dfults@sgi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Oct 2006 15:07:03 -0600
Message-Id: <1162328823.9542.434.camel@lnx-dfults.americas.sgi.com>
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
+++ linux/lib/cmdline.c	2006-10-31 14:57:25.553572860 -0600
@@ -29,6 +29,7 @@
  *	0 : no int in string
  *	1 : int found, no subsequent comma
  *	2 : int found including a subsequent comma
+ *  -(int): int found with a subsequent hyphen to denote a range.
  */
 
 int get_option (char **str, int *pint)
@@ -44,7 +45,16 @@
 		(*str)++;
 		return 2;
 	}
+	if (**str == '-') {
+		int x, inc_counter= 0, upper_range = 0;
 
+		(*str)++;
+		upper_range = simple_strtol((*str), NULL, 0);
+		inc_counter = upper_range - *pint;
+		for (x =*pint; x < upper_range; x++)
+			*pint++ = x;
+		return -inc_counter;
+	}
 	return 1;
 }
 
@@ -55,7 +65,8 @@
  *	@ints: integer array
  *
  *	This function parses a string containing a comma-separated
- *	list of integers.  The parse halts when the array is
+ *	list of integers, a hyphen-separated range of _positive_ integers,
+ *	or a combination of both.  The parse halts when the array is
  *	full, or when no more numbers can be retrieved from the
  *	string.
  *
@@ -75,6 +86,11 @@
 		i++;
 		if (res == 1)
 			break;
+		if (res < 0)
+			/* Decrement the result by one to leave out the
+			   last number in the range.  The next iteration
+			   will handle the upper number in the range */
+			i += ((-res) - 1);
 	}
 	ints[0] = i - 1;
 	return (char *)str;
