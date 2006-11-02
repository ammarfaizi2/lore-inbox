Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWKBPp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWKBPp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWKBPp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:45:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:21908 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751413AbWKBPpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:45:55 -0500
Date: Thu, 2 Nov 2006 09:46:27 -0600 (CST)
From: Derek Fults <dfults@sgi.com>
X-X-Sender: dfults@lnx-dfults.americas.sgi.com
To: linux-kernel@vger.kernel.org
cc: randy.dunlap@oracle.com, akpm@osdl.org
Subject: [PATCH] get_options to allow a hypenated range for isolcpus
Message-ID: <Pine.LNX.4.64.0611020937360.29306@lnx-dfults.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows a hyphenated range of positive numbers in the string passed
to command line helper function, get_options. 
Currently the command line option "isolcpus=" takes as its argument a
list of cpus. 
Format: <cpu number>,...,<cpu number>
Valid values of <cpu_number>  include all cpus, 0 to "number of CPUs in
system - 1". This can get extremely long when isolating the majority of
cpus on a large system.  The kernel isolcpus code would not need any
changing to use this feature.  To use it, the change would be in the
command line format for 'isolcpus='
Format:
<cpu number>,...,<cpu number>
or 
<cpu number>-<cpu number>  (must be a positive range in ascending
order.) 
or a mixture
<cpu number>,...,<cpu number>-<cpu number>

Signed-off-by: Derek Fults <dfults@sgi.com>

===================================================================
--- linux.orig/Documentation/kernel-parameters.txt	2006-10-27 15:02:12.338594489 -0500
+++ linux/Documentation/kernel-parameters.txt	2006-11-01 15:22:36.021698253 -0600
@@ -713,7 +713,12 @@
  			Format: <RDP>,<reset>,<pci_scan>,<verbosity>

  	isolcpus=	[KNL,SMP] Isolate CPUs from the general scheduler.
-			Format: <cpu number>,...,<cpu number>
+			Format:
+			<cpu number>,...,<cpu number>
+			or
+			<cpu number>-<cpu number>  (must be a positive range in ascending order)
+			or a mixture
+			<cpu number>,...,<cpu number>-<cpu number>
  			This option can be used to specify one or more CPUs
  			to isolate from the general SMP balancing and scheduling
  			algorithms. The only way to move a process onto or off
--- linux.orig/lib/cmdline.c	2006-11-02 07:51:05.247994341 -0600
+++ linux/lib/cmdline.c	2006-11-01 14:21:38.579984694 -0600
@@ -16,6 +16,23 @@
  #include <linux/kernel.h>
  #include <linux/string.h>

+/*
+ *	If a hyphen was found in get_option, this will handle the
+ *	range of numbers, M-N.  This will expand the range and insert
+ *	the values[M, M+1, ..., N] into the ints array in get_options.
+ */
+
+static int get_range(char **str, int *pint)
+{
+	int x, inc_counter, upper_range;
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
@@ -29,6 +46,7 @@
   *	0 : no int in string
   *	1 : int found, no subsequent comma
   *	2 : int found including a subsequent comma
+ *	3 : hyphen found to denote a range
   */

  int get_option (char **str, int *pint)
@@ -44,6 +62,8 @@
  		(*str)++;
  		return 2;
  	}
+	if (**str == '-')
+		return 3;

  	return 1;
  }
@@ -55,7 +75,8 @@
   *	@ints: integer array
   *
   *	This function parses a string containing a comma-separated
- *	list of integers.  The parse halts when the array is
+ *	list of integers, a hyphen-separated range of _positive_ integers,
+ *	or a combination of both.  The parse halts when the array is
   *	full, or when no more numbers can be retrieved from the
   *	string.
   *
@@ -72,6 +93,18 @@
  		res = get_option ((char **)&str, ints + i);
  		if (res == 0)
  			break;
+		if (res == 3) {
+			int range_nums;
+			range_nums = get_range((char **)&str, ints + i);
+			if (range_nums < 0)
+				break;
+			/*
+			 * Decrement the result by one to leave out the
+			 * last number in the range.  The next iteration
+			 * will handle the upper number in the range
+			 */
+			i += (range_nums - 1);
+		}
  		i++;
  		if (res == 1)
  			break;
