Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUHXBWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUHXBWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUHXBTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:19:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:40678 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269084AbUHXBPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:15:54 -0400
Date: Mon, 23 Aug 2004 18:14:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [PATCH] Writeback page range hint
Message-Id: <20040823181400.7d721370.akpm@osdl.org>
In-Reply-To: <20040824010723.GA15668@redhat.com>
References: <200408232138.i7NLcfJd019125@hera.kernel.org>
	<20040824010723.GA15668@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> FYI, this chunk...
> 
>   >  	long pages_skipped;		/* Pages which were not written */
>   > -	int nonblocking;		/* Don't get stuck on request queues */
>   > -	int encountered_congestion;	/* An output: a queue is full */
>   > -	int for_kupdate;		/* A kupdate writeback */
>   > -	int for_reclaim;		/* Invoked from the page allocator */
>   > +
>   > +	/*
>   > +	 * For a_ops->writepages(): is start or end are non-zero then this is
>   > +	 * a hint that the filesystem need only write out the pages inside that
>   > +	 * byterange.  The byte at `end' is included in the writeout request.
>   > +	 */
>   > +	loff_t start;
>   > +	loff_t end;
>   > +
>   > +	int nonblocking:1;		/* Don't get stuck on request queues */
>   > +	int encountered_congestion:1;	/* An output: a queue is full */
>   > +	int for_kupdate:1;		/* A kupdate writeback */
>   > +	int for_reclaim:1;		/* Invoked from the page allocator */
> 
>  Causes sparse spew..
> 
>  include/linux/writeback.h:54:19: warning: dubious one-bit signed bitfield
>  include/linux/writeback.h:55:30: warning: dubious one-bit signed bitfield
>  include/linux/writeback.h:56:19: warning: dubious one-bit signed bitfield
>  include/linux/writeback.h:57:19: warning: dubious one-bit signed bitfield

That's fussy of it.  I assume this shuts it up?

--- 25/include/linux/writeback.h~writeback-sparse-warning-fix	2004-08-23 18:12:09.669385176 -0700
+++ 25-akpm/include/linux/writeback.h	2004-08-23 18:12:44.064156376 -0700
@@ -51,10 +51,10 @@ struct writeback_control {
 	loff_t start;
 	loff_t end;
 
-	int nonblocking:1;		/* Don't get stuck on request queues */
-	int encountered_congestion:1;	/* An output: a queue is full */
-	int for_kupdate:1;		/* A kupdate writeback */
-	int for_reclaim:1;		/* Invoked from the page allocator */
+	unsigned int nonblocking:1;	/* Don't get stuck on request queues */
+	unsigned int encountered_congestion:1;	/* An output: a queue is full */
+	unsigned int for_kupdate:1;	/* A kupdate writeback */
+	unsigned int for_reclaim:1;	/* Invoked from the page allocator */
 };
 
 /*
_

