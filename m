Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUHXBPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUHXBPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUHXBNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:13:06 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:60824 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269065AbUHXBIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:08:00 -0400
Date: Tue, 24 Aug 2004 02:07:23 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com
Subject: Re: [PATCH] Writeback page range hint
Message-ID: <20040824010723.GA15668@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com
References: <200408232138.i7NLcfJd019125@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408232138.i7NLcfJd019125@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 07:59:27PM +0000, Linux Kernel wrote:
 > ChangeSet 1.2034, 2004/08/23 12:59:27-07:00, akpm@osdl.org
 > 
 > 	[PATCH] Writeback page range hint
 > 	
 > 	Modify mpage_writepages to optionally only write back dirty pages within a
 > 	specified range in a file (as in the case of O_SYNC).  Cheat a little to avoid
 > 	changes to prototypes of aops - just put the <start, end> hint into the
 > 	writeback_control struct instead.  If <start, end> are not set, then default
 > 	to writing back all the mapping's dirty pages.

FYI, this chunk...

 >  	long pages_skipped;		/* Pages which were not written */
 > -	int nonblocking;		/* Don't get stuck on request queues */
 > -	int encountered_congestion;	/* An output: a queue is full */
 > -	int for_kupdate;		/* A kupdate writeback */
 > -	int for_reclaim;		/* Invoked from the page allocator */
 > +
 > +	/*
 > +	 * For a_ops->writepages(): is start or end are non-zero then this is
 > +	 * a hint that the filesystem need only write out the pages inside that
 > +	 * byterange.  The byte at `end' is included in the writeout request.
 > +	 */
 > +	loff_t start;
 > +	loff_t end;
 > +
 > +	int nonblocking:1;		/* Don't get stuck on request queues */
 > +	int encountered_congestion:1;	/* An output: a queue is full */
 > +	int for_kupdate:1;		/* A kupdate writeback */
 > +	int for_reclaim:1;		/* Invoked from the page allocator */

Causes sparse spew..

include/linux/writeback.h:54:19: warning: dubious one-bit signed bitfield
include/linux/writeback.h:55:30: warning: dubious one-bit signed bitfield
include/linux/writeback.h:56:19: warning: dubious one-bit signed bitfield
include/linux/writeback.h:57:19: warning: dubious one-bit signed bitfield

		Dave

