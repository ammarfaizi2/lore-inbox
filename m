Return-Path: <linux-kernel-owner+w=401wt.eu-S1161071AbWLPPrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWLPPrL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWLPPrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:11 -0500
Received: from queue02-winn.ispmail.ntl.com ([81.103.221.56]:11466 "EHLO
	queue02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161071AbWLPPrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:10 -0500
X-Greylist: delayed 773 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 10:47:09 EST
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 02/10] Kmemleak documentation
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:34:37 +0000
Message-ID: <20061216153437.18200.43689.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 Documentation/kmemleak.txt |  161 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/Documentation/kmemleak.txt b/Documentation/kmemleak.txt
new file mode 100644
index 0000000..4689f85
--- /dev/null
+++ b/Documentation/kmemleak.txt
@@ -0,0 +1,161 @@
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
+with the difference that the orphan objects are not freed but only
+reported via /sys/kernel/debug/memleak. A similar method is used by
+the Valgrind tool (memcheck --leak-check) to detect the memory leaks
+in user-space applications.
+
+
+Usage
+-----
+
+CONFIG_DEBUG_MEMLEAK has to be enabled. For additional config options,
+look in:
+
+  -> Kernel hacking
+    -> Kernel debugging
+      -> Debug slab memory allocations
+        -> Kernel memory leak detector
+
+To display the possible memory leaks:
+
+  # mount -t debugfs nodev /sys/kernel/debug/
+  # cat /sys/kernel/debug/memleak
+
+In order to reduce the run-time overhead, memory scanning is only
+performed when reading the /sys/kernel/debug/memleak file. Note that
+the orphan objects are listed in the order they were allocated and one
+object at the beginning of the list may cause other subsequent objects
+to be reported as orphan.
+
+
+Basic Algorithm
+---------------
+
+The memory allocations via kmalloc, vmalloc, kmem_cache_alloc and
+friends are tracked and the pointers, together with additional
+information like size and stack trace, are stored in a hash table. The
+corresponding freeing function calls are tracked and the pointers
+removed from the hash table.
+
+An allocated block of memory is considered orphan if no pointer to its
+start address or to an alias (pointer aliases are explained later) can
+be found by scanning the memory (including saved registers). This
+means that there might be no way for the kernel to pass the address of
+the allocated block to a freeing function and therefore the block is
+considered a leak.
+
+The scanning algorithm steps:
+
+  1. mark all objects as white (remaining white objects will later be
+     considered orphan)
+  2. scan the memory starting with the data section and stacks,
+     checking the values against the addresses stored in the hash
+     table. If a pointer to a white object is found, the object is
+     added to the grey list
+  3. scan the grey objects for matching addresses (some white objects
+     can become grey and added at the end of the grey list) until the
+     grey set is finished
+  4. the remaining white objects are considered orphan and reported
+     via /sys/kernel/debug/memleak
+
+
+Improvements
+------------
+
+Because the Linux kernel calculates many pointers at run-time via the
+container_of macro (see the lists implementation), a lot of false
+positives would be reported. This tool re-writes the container_of
+macro so that the offset and type information is stored in the
+.init.memleak_offsets section. The memleak_init() function creates a
+radix tree with corresponding offsets for every encountered block
+type. The memory allocations hook stores the pointer address together
+with its aliases based on the type of the allocated block.
+
+While one level of offsets should be enough for most cases, a second
+level, i.e. container_of(container_of(...)), can be enabled via the
+configuration options (one false positive is the "struct socket_alloc"
+allocation in the sock_alloc_inode() function).
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
+Kmemleak currently approximates the type id using the sizeof()
+compiler built-in function. This is not accurate and can lead to false
+negatives. The aim is to gradually change the kernel and kmemleak to
+do more precise type identification.
+
+Another source of false negatives is the data stored in non-pointer
+values. Together with the more precise type identification, kmemleak
+could only scan the pointer members in the allocated structures.
+
+The tool can report false positives. These are cases where an
+allocated block doesn't need to be freed (some cases in the init_call
+functions), the pointer is calculated by other methods than the
+container_of macro or the pointer is stored in a location not scanned
+by kmemleak. If the "member" argument in the offsetof(type, member)
+call is not constant, kmemleak considers the offset as zero since it
+cannot be determined at compilation time.
+
+Page allocations and ioremap are not tracked. Only the ARM and i386
+architectures are currently supported.
+
+
+Kmemleak API
+------------
+
+See the include/linux/memleak.h header for the functions prototype.
+
+memleak_init		- initialize kmemleak
+memleak_alloc		- notify of a memory block allocation
+memleak_free		- notify of a memory block freeing
+memleak_padding		- mark the boundaries of the data inside the block
+memleak_not_leak	- mark an object as not a leak
+memleak_ignore		- do not scan or report an object as leak
+memleak_scan_area	- add scan areas inside a memory block
+memleak_insert_aliases	- add aliases for a given type
+memleak_erase		- erase an old value in a pointer variable
+memleak_typeid_raw	- set the typeid for an allocated block
+memleak_container	- statically declare a pointer alias
+memleak_typeid		- set the typeid for an allocated block (takes
+			  a type rather than typeid as argument)
+
+
+Dealing with false positives/negatives
+--------------------------------------
+
+To reduce the false negatives, kmemleak provides the memleak_ignore,
+memleak_scan_area and memleak_erase functions. The task stacks also
+increase the amount of false negatives and their scanning is not
+enabled by default.
+
+To eliminate the false positives caused by code allocating a different
+size from the object one (either for alignment or for extra memory
+after the end of the structure), kmemleak provides the memleak_padding
+and memleak_typeid functions.
+
+For objects known not to be leaks, kmemleak provides the
+memleak_not_leak function. The memleak_ignore could also be used if
+the memory block is known not to contain other pointers and it will no
+longer be scanned.
