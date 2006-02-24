Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWBXPZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWBXPZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWBXPZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:25:42 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:34742 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932249AbWBXPZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:25:41 -0500
Message-ID: <43FF24AF.63527544@tv-sign.ru>
Date: Fri, 24 Feb 2006 18:22:23 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Bryan Fink <bfink@eventmonitor.com>
Cc: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Steven Pratt <slpratt@austin.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS Still broken in 2.6.x?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew morton wrote:
>
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > On Thu, 2006-02-23 at 15:35 -0500, Bryan Fink wrote:
> >  > Hi All.  I'm running into a bit of trouble with NFS on 2.6.  I see that
> >  > at least Trond thought, mid-January, that "The readahead algorithm has
> >  > been broken in 2.6.x for at least the past 6 months." (
> >  > http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0559.html) Anyone
> >  > know if that has been fixed?
> > 
> >  No it hasn't been fixed. ...and no, this is not a problem that only
> >  affects NFS: it just happens to give a more noticeable performance
> >  impact due to the larger latency of NFS over a 100Mbps link.
> 
> iirc, last time we went round this loop Ram and I were unable to reproduce it.
> 
> Does anyone have a testcase?

Afaics, this problem was resolved a long ago.

The patch below should fix this problem. Does it?

Andrew, I'll resend it with a proper changelog and comments on Sunday,
currently I can't even do a compile test. I verified this patch still
applies cleanly.

------------------------------------------------------------------------------
>From - Thu Aug  4 20:33:03 2005
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
Message-ID: <42F2433F.CF3B797A@tv-sign.ru>
Date: Thu, 04 Aug 2005 20:33:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>,
 	Trond Myklebust <Trond.Myklebust@netapp.com>,
 	Linus Torvalds <torvalds@osdl.org>,
 	Steven Pratt <slpratt@austin.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Readahead algorithm problems again...
References: <1122690994.8240.21.camel@lade.trondhjem.org> ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Length: 1255
Lines: 47

Oleg Nesterov wrote:
> 
> What do you think about this patch?

Ohh... Sorry, I attached the wrong one.

--- 2.6.13-rc4/mm/readahead.c~	Thu Apr  7 12:59:41 2005
+++ 2.6.13-rc4/mm/readahead.c	Thu Aug  4 20:25:14 2005
@@ -57,8 +57,8 @@ static inline void ra_off(struct file_ra
 	ra->start = 0;
 	ra->flags = 0;
 	ra->size = 0;
+	ra->ahead_size += ra->ahead_start;
 	ra->ahead_start = 0;
-	ra->ahead_size = 0;
 	return;
 }
 
@@ -423,8 +423,8 @@ static int make_ahead_window(struct addr
 		 * congestion.  The ahead window will any way be closed
 		 * in case we failed due to excessive page cache hits.
 		 */
+		ra->ahead_size += ra->ahead_start;
 		ra->ahead_start = 0;
-		ra->ahead_size = 0;
 	}
 
 	return ret;
@@ -507,7 +507,7 @@ page_cache_readahead(struct address_spac
 
 	if (ra->ahead_start == 0) {	 /* no ahead window yet */
 		if (!make_ahead_window(mapping, filp, ra, 0))
-			goto out;
+			goto recheck;
 	}
 	/*
 	 * Already have an ahead window, check if we crossed into it.
@@ -520,6 +520,9 @@ page_cache_readahead(struct address_spac
 		ra->start = ra->ahead_start;
 		ra->size = ra->ahead_size;
 		make_ahead_window(mapping, filp, ra, 0);
+recheck:
+		ra->prev_page = min(ra->prev_page,
+			ra->ahead_start + ra->ahead_size - 1);
 	}
 
 out:

------------------------------------------------------------------------------

There is another one, from Steven Pratt:

------------------------------------------------------------------------------
>From - Sat Aug 13 11:49:43 2005
Return-Path: <slpratt@austin.ibm.com>
X-Original-To: oleg@tv-sign.ru
Delivered-To: oleg@tv-sign.ru
Received: from localhost (localhost [127.0.0.1])
	by several.ru (Postfix) with ESMTP id 08412C014B
	for <oleg@tv-sign.ru>; Fri, 12 Aug 2005 23:12:25 +0400 (MSD)
Received: from several.ru ([127.0.0.1])
 by localhost (several.ru [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23382-09 for <oleg@tv-sign.ru>; Fri, 12 Aug 2005 23:12:20 +0400 (MSD)
Received: by several.ru (Postfix, from userid 106)
	id 0F66CBFBC8; Fri, 12 Aug 2005 23:12:20 +0400 (MSD)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.133])
	by several.ru (Postfix) with ESMTP id 2DE8ABFB5D
	for <oleg@tv-sign.ru>; Fri, 12 Aug 2005 23:12:19 +0400 (MSD)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7CJCHWY067722
	for <oleg@tv-sign.ru>; Fri, 12 Aug 2005 15:12:17 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7CJCVc7234970
	for <oleg@tv-sign.ru>; Fri, 12 Aug 2005 13:12:31 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7CJCGGB032673
	for <oleg@tv-sign.ru>; Fri, 12 Aug 2005 13:12:16 -0600
Received: from [9.41.223.36] (slpratt-009041223036.austin.ibm.com [9.41.223.36])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7CJCFIx032651;
	Fri, 12 Aug 2005 13:12:16 -0600
Message-ID: <42FCF481.5050507@austin.ibm.com>
Date: Fri, 12 Aug 2005 14:12:01 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ram Pai <linuxram@us.ibm.com>, oleg@tv-sign.ru,
	Trond.Myklebust@netapp.com, torvalds@osdl.org
Subject: Re: Readahead algorithm problems again...
References: <1122690994.8240.21.camel@lade.trondhjem.org> ...
In-Reply-To: <20050812112141.1868a1af.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010005060703040509010104"
X-Mozilla-Status: 8011
X-Mozilla-Status2: 00000000
X-UIDL: 434d6b27fc1a5f9a
Status: O
Content-Length: 1655
Lines: 71

This is a multi-part message in MIME format.
--------------010005060703040509010104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The current current get_init_ra_size is not optimal across different IO 
sizes and max_readahead values.  Here is a quick summary of sizes 
computed under current design and under the attached patch.  All of 
these assume 1st IO at offset 0, or 1st detected sequential IO.

32k max, 4k request

old         new
-----------------
 8k        8k
16k       16k
32k       32k

128k max, 4k request
old         new
-----------------
32k         16k
64k         32k
128k        64k
128k       128k

128k max, 32k request
old         new
-----------------
32k         64k    <-----
64k        128k
128k       128k


512k max, 4k request
old         new
-----------------
4k         32k     <----
16k        64k
64k       128k
128k      256k
512k      512k


Steve

--- linux-2.6.12/mm/readahead.org.c	2005-08-01 08:52:12.000000000 -0500
+++ linux-2.6.12/mm/readahead.c	2005-08-10 10:16:52.000000000 -0500
@@ -72,10 +72,10 @@ static unsigned long get_init_ra_size(un
 {
 	unsigned long newsize = roundup_pow_of_two(size);
 
-	if (newsize <= max / 64)
-		newsize = newsize * newsize;
+	if (newsize <= max / 32)
+		newsize = newsize * 4;
 	else if (newsize <= max / 4)
-		newsize = max / 4;
+		newsize = newsize * 2;
 	else
 		newsize = max;
 	return newsize;

------------------------------------------------------------------------------

Oleg.
