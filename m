Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932275AbWFDWAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWFDWAT (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFDWAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:00:18 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:33739 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932279AbWFDWAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:00:15 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 2/8] Some documentation for kmemleak
Date: Sun, 04 Jun 2006 23:00:07 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060604220007.16277.13342.stgit@localhost.localdomain>
In-Reply-To: <20060604215636.16277.15454.stgit@localhost.localdomain>
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 Documentation/kmemleak.txt |   92 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/Documentation/kmemleak.txt b/Documentation/kmemleak.txt
new file mode 100644
index 0000000..7072325
--- /dev/null
+++ b/Documentation/kmemleak.txt
@@ -0,0 +1,92 @@
+Kernel Memory Leak Detector
+===========================
+
+
+Introduction
+------------
+
+Kmemleak provides a way of detecting possible kernel memory leaks in a
+way similar to a tracing garbage collector
+(http://en.wikipedia.org/wiki/Garbage_collection_%28computer_science%29#Tracing_garbage_collectors),
+with the difference that the orphan pointers are not freed but only
+reported via /sys/kernel/debug/memleak. A similar method is used by
+the Valgrind tool (memcheck --leak-check) to detect the memory leaks
+in user-space applications.
+
+
+Basic Algorithm
+---------------
+
+The memory allocations via kmalloc, vmalloc, kmem_cache_alloc and
+friends are tracked and the pointers, together with additional
+information like size and stack trace, are stored in a radix tree. The
+corresponding freeing function calls are tracked and the pointers
+removed from the radix tree.
+
+An allocated block of memory is considered orphan if a pointer to its
+start address or to an alias (pointer aliases are explained later)
+cannot be found by scanning the memory (including saved
+registers). This means that there might be no way for the kernel to
+pass the address of the allocated block to a freeing function and
+therefore the block is considered a leak.
+
+The scanning algorithm steps:
+
+  1. mark all pointers as white (remaining white pointers will later
+     be considered orphan)
+  2. scan the memory starting with the data section and stacks,
+     checking the values against the addresses stored in the radix
+     tree. If a white pointer is found, it is added to the grey list
+  3. scan the grey pointers for matching addresses (some white
+     pointers can become grey and added at the end of the grey list)
+     until the grey set is finished
+  4. the remaining white pointers are considered orphan and reported
+     via /sys/kernel/debug/memleak
+
+
+Improvements
+------------
+
+Because the Linux kernel calculates many pointers at run-time via the
+container_of macro (see the lists implementation), a lot of false
+positives would be reported. This tool re-writes the container_of
+macro so that the offset and size information is stored in the
+.init.memleak_offsets section. The memleak_init() function creates a
+radix tree with corresponding offsets for every encountered block
+size. The memory allocations hook stores the pointer address together
+with its aliases based on the size of the allocated block.
+
+While one level of offsets should be enough for most cases, two levels
+are considered, i.e. container_of(container_of(...)) (one false
+positive is the "struct socket_alloc" allocation in the
+sock_alloc_inode() function).
+
+Some allocated memory blocks have pointers stored in the kernel's
+internal data structures and they cannot be detected as orphans. To
+avoid this, kmemleak can also store the number of values equal to the
+pointer (or aliases) that need to be found so that the block is not
+considered a leak. One example is __vmalloc().
+
+
+Limitations and Drawbacks
+-------------------------
+
+The biggest drawback is the reduced performance of memory allocation
+and freeing. To avoid other penalties, the memory scanning is only
+performed when the /sys/kernel/debug/memleak file is read. Anyway,
+this tool is intended for debugging purposes where the performance
+might not be the most important requirement.
+
+The tool can report false positives. These are cases where an
+allocated block doesn't need to be freed (some cases in the init_call
+functions), the pointer is calculated by other methods than the
+container_of macro or the pointer is stored in a location not scanned
+by kmemleak. If the "member" argument in the offsetof(type, member)
+call is not constant, kmemleak considers the offset as zero since it
+cannot be determined at compilation time (as a side node, it seems
+that gcc-4.0 doesn't compile these offsetof constructs either).
+
+Page allocations and ioremap are not tracked. NUMA architectures are
+not supported yet.
+
+Only the ARM and i386 architectures are currently supported.
