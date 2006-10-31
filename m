Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423499AbWJaRYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423499AbWJaRYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423711AbWJaRYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:24:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20107 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423499AbWJaRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:24:35 -0500
Subject: [PATCH] Allow a hyphenated range in get_options
From: Derek Fults <dfults@sgi.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Oct 2006 11:25:16 -0600
Message-Id: <1162315517.9542.372.camel@lnx-dfults.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows a hyphenated range of positive numbers in the string passed
to command line helper function, get_options.    

Signed-off-by: Derek Fults <dfults@sgi.com>  

Index: linux/lib/cmdline.c
===================================================================
--- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
+++ linux/lib/cmdline.c	2006-10-30 10:39:13.351641023 -0600
@@ -29,6 +29,10 @@
  *	0 : no int in string
  *	1 : int found, no subsequent comma
  *	2 : int found including a subsequent comma
+ *  -(int): int found with a subsequent hyphen to denote a range.
+ *          The negative number is the number of integers in the range
+ *          used to increment the counter in the while loop.
+ *      
  */
 
 int get_option (char **str, int *pint)
@@ -44,7 +48,16 @@
 		(*str)++;
 		return 2;
 	}
+	if (**str == '-') {
+	    int x,inc_counter= 0, upper_range = 0;
 
+	    (*str)++;
+	    upper_range = simple_strtol ((*str), NULL, 0);
+	    inc_counter = upper_range - *pint ;
+	    for (x=*pint; x < upper_range; x++) 
+		    *pint++ = x;
+	    return -inc_counter;
+	}
 	return 1;
 }
 
@@ -55,7 +68,8 @@
  *	@ints: integer array
  *
  *	This function parses a string containing a comma-separated
- *	list of integers.  The parse halts when the array is
+ *	list of integers, a hyphen-separated range of _positive_ integers,
+ *      or a combination of both.  The parse halts when the array is
  *	full, or when no more numbers can be retrieved from the
  *	string.
  *
@@ -75,6 +89,11 @@
 		i++;
 		if (res == 1)
 			break;
+		if (res < 0) 
+		        /* Decrement the result by one to leave out the 
+			   last number in the range.  The next iteration 
+			   will handle the upper number in the range */
+		        i += ((-res) - 1);
 	}
 	ints[0] = i - 1;
 	return (char *)str;

