Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFPUg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFPUg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFPUg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:36:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVFPUgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:36:53 -0400
Date: Thu, 16 Jun 2005 13:37:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
Message-Id: <20050616133730.1924fca3.akpm@osdl.org>
In-Reply-To: <1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	<20050616002451.01f7e9ed.akpm@osdl.org>
	<1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > 
> > We seem to be always ooming when allocating scsi command structures. 
> > Perhaps the block-level request structures are being allocated with
> > __GFP_WAIT, but it's a bit odd.  Which I/O scheduler?  If cfq, does
> > reducing /sys/block/*/queue/nr_requests help?
> 
> Yes. I am using CFQ scheduler. I changed nr_requests to 4 for all
> my devices. I also changed "min_free_kbytes" to 64M.

Yeah, that monster cfq queue depth continues to hurt in corner cases.

> Response time is still bad. Here is the vmstat, meminfo, slabinfo
> and profle output. I am not sure why profile output shows 
> default_idle(), when vmstat shows 100% CPU sys.

(please inline text rather then using attachments)

> MemTotal:      7209056 kB
> ...
> Dirty:         5896240 kB

That's not going to help - we're way over 40% there, so the VM is getting
into some trouble.

Try reducing the dirty limits in /proc/sys/vm by a lot to confirm that it
helps.

There are various bits of slop and hysteresis and deliberate overshoot in
page-writeback.c which are there to enhance IO batching and to reduce CPU
consumption.  A few megs here and there adds up when you multiply it by
2000...

Try this:

diff -puN mm/page-writeback.c~a mm/page-writeback.c
--- 25/mm/page-writeback.c~a	Thu Jun 16 13:36:29 2005
+++ 25-akpm/mm/page-writeback.c	Thu Jun 16 13:36:54 2005
@@ -501,6 +501,8 @@ void laptop_sync_completion(void)
 
 static void set_ratelimit(void)
 {
+	ratelimit_pages = 32;
+	return;
 	ratelimit_pages = total_pages / (num_online_cpus() * 32);
 	if (ratelimit_pages < 16)
 		ratelimit_pages = 16;
_

