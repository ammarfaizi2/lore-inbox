Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTLGH2J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 02:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLGH2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 02:28:09 -0500
Received: from holomorphy.com ([199.26.172.102]:14040 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261368AbTLGH2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 02:28:06 -0500
Date: Sat, 6 Dec 2003 23:28:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031207072803.GU8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com> <20031130164301.GK8039@holomorphy.com> <20031201073632.GQ8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201073632.GQ8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 08:43:01AM -0800, William Lee Irwin III wrote:
>> I wonder if this would be enough to get sysenter support going again.
>> I've not got a sysenter-capable userspace around, so I can't really
>> test this myself.
>> vs. pgcl-2.6.0-test11-5

On Sun, Nov 30, 2003 at 11:36:32PM -0800, William Lee Irwin III wrote:
> Stack decoding fixes, shutting up some compiler warnings, and dumping
> PAGE_SIZE and MMUPAGE_SIZE into /proc/meminfo (for lack of a better place).
> The printk()'s down there should eventually get ripped out anyway for
> minimal impact and a quieter boot, but until then...

Woops, those page sizes were a bit off. Come to think of it, so is
aio_setup_ring()...


-- wli

diff -prauN pgcl-2.6.0-test11-9/fs/aio.c pgcl-2.6.0-test11-10/fs/aio.c
--- pgcl-2.6.0-test11-9/fs/aio.c	2003-11-27 21:55:19.000000000 -0800
+++ pgcl-2.6.0-test11-10/fs/aio.c	2003-12-02 04:43:21.000000000 -0800
@@ -187,8 +187,8 @@ static int aio_setup_ring(struct kioctx 
 	struct io_event *__event;					\
 	unsigned long pfn;						\
 	pfn = (info)->ring_pages[pos/AIO_EVENTS_PER_PAGE];		\
-	__event = kmap_atomic(pfn_to_page(pfn), km);			\
-	__event += (pfn % PAGE_MMUCOUNT) * MMUPAGE_SIZE;		\
+	__event = (void *)((char *)kmap_atomic(pfn_to_page(pfn), km)	\
+			+ MMUPAGE_SIZE * (pfn % PAGE_MMUCOUNT));	\
 	__event += pos % AIO_EVENTS_PER_PAGE;				\
 	__event;							\
 })
diff -prauN pgcl-2.6.0-test11-9/fs/proc/proc_misc.c pgcl-2.6.0-test11-10/fs/proc/proc_misc.c
--- pgcl-2.6.0-test11-9/fs/proc/proc_misc.c	2003-11-30 12:50:32.000000000 -0800
+++ pgcl-2.6.0-test11-10/fs/proc/proc_misc.c	2003-12-02 00:42:13.000000000 -0800
@@ -231,8 +231,8 @@ static int meminfo_read_proc(char *page,
 		vmtot,
 		vmi.used,
 		vmi.largest_chunk,
-		K(PAGE_SIZE),
-		K(MMUPAGE_SIZE)
+		PAGE_SIZE >> 10,
+		MMUPAGE_SIZE >> 10
 		);
 
 		len += hugetlb_report_meminfo(page + len);
