Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUFQVRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUFQVRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 17:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUFQVRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 17:17:53 -0400
Received: from mail.ccur.com ([208.248.32.212]:30470 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S263781AbUFQVRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 17:17:02 -0400
Date: Thu, 17 Jun 2004 17:16:59 -0400
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] up unpinned mmap usable address space from 2 to 3 GB
Message-ID: <20040617211659.GA4091@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the full 3 GB of process address space available to unpinned mmaps.
Previously only the 2 GB from 40000000-c0000000 was available.

The process address space allocation behavior should remain unchanged
for non-i386 architectures.

For i386, the new algorithm first allocates from virtual address 40000000
to the start of the stack area (as defined by ulimit -s), then from the
start of the text area (08000000) down to 00400000, then from 40000000
down to the sbrk area, then (as a last resort) starts allocating from
the unused portion of the stack area.

With this patch, a small java program, simulating a real application,
can spin off 3,790 threads.  Previously, only 1,750 threads could be
spun off.

Due to the fragility of making changes to get_unmapped_area(), this patch
is intended 'For Comment Only'.

Against 2.6.7.

Regards,
Joe

================== Test.java

public class Test
{
  private static int threadCounter = 0;

  public static synchronized int getThreadNumber() {
    return threadCounter++;
  }

  public static void main(String [] args) {
    for(int i = 0; i < 6000; i++) {
      new Thread(new Runnable() {
          public void run() {
            System.err.println("Thread " + getThreadNumber());
            while(true) { 
              try {
                Thread.currentThread().sleep(10000);
              } catch(InterruptedException ie) {
                // Don't care
              }
            }
          }
        }
      ).start();
    }
  }
}

================== compilation instructions

  Download Java 2 SDK 1.4.2_04 linux i586 from java.sun.com, install
  javac Test.java
  java -Xmx1000M -Xms1000M -cp . Test
  
================== patch

diff -ura base/include/asm-i386/processor.h new/include/asm-i386/processor.h
--- base/include/asm-i386/processor.h	2004-06-16 01:18:56.000000000 -0400
+++ new/include/asm-i386/processor.h	2004-06-17 12:47:01.000000000 -0400
@@ -301,6 +301,9 @@
  * space during mmap's.
  */
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#define TASK_UNMAPPED_BASE_2	(PAGE_ALIGN(16 * PAGE_SIZE))
+#define TASK_SLOP_FUNCTION	(current->rlim[RLIMIT_STACK].rlim_cur)
+#define MIN_TASK_SLOP		(64 * PAGE_SIZE)
 
 /*
  * Size of io_bitmap, covering ports 0 to 0x3ff.
diff -ura base/mm/mmap.c new/mm/mmap.c
--- base/mm/mmap.c	2004-06-16 01:19:37.000000000 -0400
+++ new/mm/mmap.c	2004-06-17 12:45:52.000000000 -0400
@@ -1002,13 +1002,26 @@
  * This function "knows" that -ENOMEM has the bits set.
  */
 #ifndef HAVE_ARCH_UNMAPPED_AREA
+
+#ifndef TASK_UNMAPPED_BASE_2
+#define TASK_UNMAPPED_BASE_2 TASK_UNMAPPED_BASE
+#endif
+
+#ifndef MIN_TASK_SLOP
+#define MIN_TASK_SLOP 1		/* must be >0 */
+#endif
+
+#ifndef TASK_SLOP_FUNCTION
+#define TASK_SLOP_FUNCTION 0
+#endif
+
 static inline unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
+	unsigned long start_addr, end_addr, end_slop;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
@@ -1020,27 +1033,45 @@
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
+	/* determine how close to TASK_SIZE we are willing to get */
+	end_slop = TASK_SLOP_FUNCTION;
+	if (end_slop < MIN_TASK_SLOP)
+		end_slop = MIN_TASK_SLOP;
+	end_slop = PAGE_ALIGN(end_slop);
+
+	end_addr = TASK_SIZE - end_slop;
 	start_addr = addr = mm->free_area_cache;
 
 full_search:
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
+		if (end_addr - len < addr) {
 			/*
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
+			if (end_addr == TASK_SIZE)
+				return -ENOMEM;
+			end_addr = start_addr;
+			if (start_addr > TASK_UNMAPPED_BASE) {
 				start_addr = addr = TASK_UNMAPPED_BASE;
-				goto full_search;
+			} else if (start_addr > TASK_UNMAPPED_BASE_2) {
+				/* dig a bit into the sbrk area if necessary */
+				start_addr = addr = TASK_UNMAPPED_BASE_2;
+			} else {
+				/* dig into the stack area as a last resort */
+				end_addr = TASK_SIZE;
+				addr = TASK_SIZE - end_slop;
 			}
-			return -ENOMEM;
+			goto full_search;
 		}
 		if (!vma || addr + len <= vma->vm_start) {
-			/*
-			 * Remember the place where we stopped the search:
-			 */
-			mm->free_area_cache = addr + len;
+			if (addr >= TASK_UNMAPPED_BASE) {
+				mm->free_area_cache = addr + len;
+			} else {
+				mm->free_area_cache = addr;
+				addr = (vma ? vma->vm_start : end_addr) - len;
+			}
 			return addr;
 		}
 		addr = vma->vm_end;

