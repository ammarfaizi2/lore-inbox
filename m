Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315460AbSEBW4I>; Thu, 2 May 2002 18:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSEBWyL>; Thu, 2 May 2002 18:54:11 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:6337 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315456AbSEBWxQ>;
	Thu, 2 May 2002 18:53:16 -0400
Message-ID: <3CD1C2B9.F2D276E5@us.ibm.com>
Date: Thu, 02 May 2002 15:50:33 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
CC: mjbligh@us.ibm.com, lse-tech@lists.sourceforge.net, rml@tech9.net,
        efocht@ess.nec.de
Subject: [patch] NUMA API for 2.5.12 (4/4)
Content-Type: multipart/mixed;
 boundary="------------87D521E2469322B2B1B67961"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------87D521E2469322B2B1B67961
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ok all,
	I'm going to go ahead and assume (hope) that the no response on the last
posting was because the patch was really large.  We'll try this again with 4
smaller patches and see what happens.

	This patch implements the NUMA API specified at:
http://lse.sourceforge.net/numa/numa_api.html for the 2.5.12 version of the
kernel.  The API implements such features as binding processes to CPUs
(similar to Robert Love's recent patch), binding to memory blocks, setting
launch policies for processes, and rudimentary topology features.  The patch
is currently used via a prctl() interface with a possible /proc interface in
the future.  I also have a syscall version if that is preferred.

	Again, this is a slightly cleaned-up, and (more) bite-sized version of the
previous patch sent out...

Enjoy, and please send me any comments on the patch, or the API it implements!

-Matt
colpatch@us.ibm.com
--------------87D521E2469322B2B1B67961
Content-Type: text/plain; charset=us-ascii;
 name="numa_api-prctl-2.5.12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-prctl-2.5.12.patch"

diff -Nur linux-2.5.8-vanilla/include/linux/prctl.h linux-2.5.8-api/include/linux/prctl.h
--- linux-2.5.8-vanilla/include/linux/prctl.h	Sun Apr 14 12:18:54 2002
+++ linux-2.5.8-api/include/linux/prctl.h	Wed Apr 24 17:31:33 2002
@@ -26,4 +26,31 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */

+/* Get/Set Restricted CPUs and MemBlks */
+#define PR_SET_RESTRICTED_CPUS		11
+#define PR_SET_RESTRICTED_MEMBLKS	12
+#define PR_GET_RESTRICTED_CPUS		13
+#define PR_GET_RESTRICTED_MEMBLKS	14
+
+/* Get CPU/Node */
+#define PR_GET_CPU	15
+#define PR_GET_NODE    	16
+
+/* X to Node conversion functions */
+#define PR_CPU_TO_NODE		17
+#define PR_MEMBLK_TO_NODE      	18
+#define PR_NODE_TO_NODE		19
+
+/* Node to X conversion functions */
+#define PR_NODE_TO_CPU		20
+#define PR_NODE_TO_MEMBLK      	21
+
+/* Set CPU/MemBlk/Memory Bindings */
+#define PR_BIND_TO_CPUS		22
+#define PR_BIND_TO_MEMBLKS	23
+#define PR_BIND_MEMORY		24
+
+/* Set Launch Policy */
+#define PR_SET_LAUNCH_POLICY	25
+
 #endif /* _LINUX_PRCTL_H */
diff -Nur linux-2.5.8-vanilla/kernel/sys.c linux-2.5.8-api/kernel/sys.c
--- linux-2.5.8-vanilla/kernel/sys.c	Sun Apr 14 12:18:45 2002
+++ linux-2.5.8-api/kernel/sys.c	Wed Apr 24 17:32:17 2002
@@ -16,6 +16,7 @@
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/numa.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1277,6 +1278,51 @@
 				break;
 			}
 			current->keep_capabilities = arg2;
+			break;
+		case PR_SET_RESTRICTED_CPUS:
+			error = (long) set_restricted_cpus((numa_bitmap_t)arg2, (numa_set_t *)arg3);
+			break;
+		case PR_SET_RESTRICTED_MEMBLKS:
+			error = (long) set_restricted_memblks((numa_bitmap_t)arg2, (numa_set_t *)arg3);
+			break;
+		case PR_GET_RESTRICTED_CPUS:
+			error = (long) get_restricted_cpus();
+			break;
+		case PR_GET_RESTRICTED_MEMBLKS:
+			error = (long) get_restricted_memblks();
+			break;
+		case PR_GET_CPU:
+			error = (long) get_cpu();
+			break;
+		case PR_GET_NODE:
+			error = (long) get_node();
+			break;
+		case PR_CPU_TO_NODE:
+			error = (long) cpu_to_node((int)arg2);
+			break;
+		case PR_MEMBLK_TO_NODE:
+			error = (long) memblk_to_node((int)arg2);
+			break;
+		case PR_NODE_TO_NODE:
+			error = (long) node_to_node((int)arg2);
+			break;
+		case PR_NODE_TO_CPU:
+			error = (long) node_to_cpu((int)arg2);
+			break;
+		case PR_NODE_TO_MEMBLK:
+			error = (long) node_to_memblk((int)arg2);
+			break;
+		case PR_BIND_TO_CPUS:
+			error = (long) bind_to_cpu((numa_bitmap_t)arg2, (int)arg3);
+			break;
+		case PR_BIND_TO_MEMBLKS:
+			error = (long) bind_to_memblk((numa_bitmap_t)arg2, (int)arg3);
+			break;
+		case PR_BIND_MEMORY:
+			error = (long) bind_memory((unsigned long)arg2, (size_t)arg3, (numa_bitmap_t)arg4, (int)arg5);
+			break;
+		case PR_SET_LAUNCH_POLICY:
+			error = (long) set_launch_policy((numa_bitmap_t)arg2, (int)arg3, (numa_bitmap_t)arg4, (int)arg5);
 			break;
 		default:
 			error = -EINVAL;

--------------87D521E2469322B2B1B67961--

