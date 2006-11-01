Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752316AbWKAUXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbWKAUXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbWKAUXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:23:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31649 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752296AbWKAUXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:23:31 -0500
Subject: Re: [PATCH] Updated, add get_range, allows a hyhpenated range to
	get_options
From: Derek Fults <dfults@sgi.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <4548FAFC.5000409@oracle.com>
References: <1162410596.9524.544.camel@lnx-dfults.americas.sgi.com>
	 <4548FAFC.5000409@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 14:24:15 -0600
Message-Id: <1162412656.9524.556.camel@lnx-dfults.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 11:52 -0800, Randy Dunlap wrote:
> Derek Fults wrote:
> > This allows a hyphenated range of positive numbers M-N, in the string
> > passed to command line helper function, get_options.  This will expand
> > the range and insert the values[M, M+1, ..., N] into the ints array in
> > get_options.
> > 
> > Currently the command line option "isolcpus=" takes as its argument a
> > list of cpus.  
> > Format: <cpu number>,...,<cpu number>
> > This can get extremely long when isolating the majority of cpus on a
> > large system.  Valid values of <cpu_number>  include all cpus, 0 to
> > "number of CPUs in system - 1".
> > 
> > 
> > Signed-off-by: Derek Fults <dfults@sgi.com>  
> > 
> > Index: linux/lib/cmdline.c
> > ===================================================================
> > --- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
> > +++ linux/lib/cmdline.c	2006-11-01 12:36:20.059166727 -0600
> > @@ -16,6 +16,23 @@
> >  #include <linux/kernel.h>
> >  #include <linux/string.h>
> >  
> > +/**
> > + *	If a hyphen was found in get_option, this will handle the
> > + *	range of numbers, M-N.  This will expand the range and insert
> > + *	the values[M, M+1, ..., N] into the ints array in get_options.
> > + */
> 
> Derek,
> Thanks for persisting thru this.  It's all fine for me except the
> comment block above.  If a comment block begins with "/**", then
> it's supposed to be in kernel-doc format (see
> Documentation/kernel-doc-nano-HOWTO.txt), with function name &
> parameters (if applicable).  However, that mostly needs to be done
> for non-static functions, so probably just change /** to /*
> and leave the rest of the comment block as is.
> My other comment-block comment was also about kernel long-comment
> style, which is
> /*
>  * begin
>  * more
>  * end
>  */
> so now you have achieved that also, so thanks again.

I fixed both comments to match that format.  Thanks for all the help and
your patience.
I'm posting the new patch in this replay.  Is that an acceptable
practice, or does one normally post all fixes to a patch in a new
message?

Thanks 
Derek


Signed-off-by: Derek Fults <dfults@sgi.com>  

Index: linux/lib/cmdline.c
===================================================================
--- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
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
