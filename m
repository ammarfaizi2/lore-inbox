Return-Path: <linux-kernel-owner+w=401wt.eu-S932107AbWLNJI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWLNJI6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWLNJI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:08:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33809 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbWLNJI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:08:56 -0500
Date: Thu, 14 Dec 2006 01:08:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Ben Collins <ben.collins@ubuntu.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] ib_verbs: Use explicit if-else statements to
 avoid errors with do-while macros
Message-Id: <20061214010848.6fbb920f.akpm@osdl.org>
In-Reply-To: <20061214065624.GN4587@ftp.linux.org.uk>
References: <1166065805.6748.135.camel@gullible>
	<20061214064430.GM4587@ftp.linux.org.uk>
	<20061214065624.GN4587@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 06:56:24 +0000
Al Viro <viro@ftp.linux.org.uk> wrote:

> On Thu, Dec 14, 2006 at 06:44:30AM +0000, Al Viro wrote:
> > On Wed, Dec 13, 2006 at 10:10:05PM -0500, Ben Collins wrote:
> > > At least on PPC, the "op ? op : dma" construct causes a compile failure
> > > because the dma_* is a do{}while(0) macro.
> > > 
> > > This turns all of them into proper if/else to avoid this problem.
> > 
> > NAK.
> > 
> > Proper fix is to kill stupid do { } while (0) mess.  It's supposed
> > to behave like a function returning void, so it should be ((void)0).
> 
> BTW, even though the original patch is already merged, I think that
> we ought to get rid of do-while in such stubs, exactly to avoid such
> problems in the future.  Probably even add to CodingStyle - it's not
> the first time such crap happens.
> 
> IOW, do ; while(0) / do { } while (0)  is not a proper way to do a macro
> that imitates a function returning void.
> 
> Objections?

Would prefer static inline void foo(args){} when possible - for the arg
typechecking and arg existence checking and unused variable warnings.

I end up having to do rather a lot of things like this:

--- a/mm/vmalloc.c~virtual-memmap-on-sparsemem-v3-map-and-unmap-fix-2
+++ a/mm/vmalloc.c
@@ -929,6 +929,6 @@ int unmap_generic_kernel(unsigned long a
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
-	flush_tlb_kernel_range((unsigned long)start_addr, end_addr);
+	flush_tlb_kernel_range(addr, addr);
 	return err;
 }


and this:


@@ -85,12 +84,24 @@ extern void vm_events_fold_cpu(int cpu);
 #else
 
 /* Disable counters */
-#define get_cpu_vm_events(e)	0L
-#define count_vm_event(e)	do { } while (0)
-#define count_vm_events(e,d)	do { } while (0)
-#define __count_vm_event(e)	do { } while (0)
-#define __count_vm_events(e,d)	do { } while (0)
-#define vm_events_fold_cpu(x)	do { } while (0)
+static inline void count_vm_event(enum vm_event_item item)
+{
+}
+static inline void count_vm_events(enum vm_event_item item, long delta)
+{
+}
+static inline void __count_vm_event(enum vm_event_item item)
+{
+}
+static inline void __count_vm_events(enum vm_event_item item, long delta)
+{
+}
+static inline void all_vm_events(unsigned long *ret)
+{
+}
+static inline void vm_events_fold_cpu(int cpu)
+{
+}

because of these problems.

Plus macros are putrid.
