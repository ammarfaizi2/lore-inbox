Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbSJASus>; Tue, 1 Oct 2002 14:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbSJAStz>; Tue, 1 Oct 2002 14:49:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:28644 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262152AbSJAStG>;
	Tue, 1 Oct 2002 14:49:06 -0400
Message-ID: <3D99EF62.3A3E6932@digeo.com>
Date: Tue, 01 Oct 2002 11:54:26 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.39 "Sleeping function called from illegal context at 
 slab.c:1374"
References: <3D99885B.533C320D@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 18:54:26.0451 (UTC) FILETIME=[F6EE6E30:01C2697B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> ..
>  [<c01146c4>]__might_sleep+0x54/0x60
>  [<c012dca0>]kmalloc+0x4c/0x130
>  [<c010b6b2>]sys_ioperm+0x82/0x11c
>  [<c0106fbb>]syscall_call+0x7/0xb
> 


You up to trying this fix?

--- 2.5.40/arch/i386/kernel/ioport.c~ioperm-fix	Tue Oct  1 02:17:51 2002
+++ 2.5.40-akpm/arch/i386/kernel/ioport.c	Tue Oct  1 02:17:51 2002
@@ -56,6 +56,7 @@ asmlinkage int sys_ioperm(unsigned long 
 {
 	struct thread_struct * t = &current->thread;
 	struct tss_struct * tss;
+	unsigned long *bitmap = NULL;
 	int ret = 0;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_SIZE*32))
@@ -63,15 +64,12 @@ asmlinkage int sys_ioperm(unsigned long 
 	if (turn_on && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	tss = init_tss + get_cpu();
-
 	/*
 	 * If it's the first ioperm() call in this thread's lifetime, set the
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
 	 * this is why we delay this operation until now:
 	 */
 	if (!t->ts_io_bitmap) {
-		unsigned long *bitmap;
 		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!bitmap) {
 			ret = -ENOMEM;
@@ -83,20 +81,19 @@ asmlinkage int sys_ioperm(unsigned long 
 		 */
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
 		t->ts_io_bitmap = bitmap;
-		/*
-		 * this activates it in the TSS
-		 */
-		tss->bitmap = IO_BITMAP_OFFSET;
 	}
 
+	tss = init_tss + get_cpu();
+	if (bitmap)
+		tss->bitmap = IO_BITMAP_OFFSET;	/* Activate it in the TSS */
+
 	/*
 	 * do it in the per-thread copy and in the TSS ...
 	 */
 	set_bitmap(t->ts_io_bitmap, from, num, !turn_on);
 	set_bitmap(tss->io_bitmap, from, num, !turn_on);
-
-out:
 	put_cpu();
+out:
 	return ret;
 }
 

.
