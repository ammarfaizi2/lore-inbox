Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVF1XIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVF1XIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVF1XEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:04:42 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:41396 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262237AbVF1XD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:58 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037130:sNHT28093444"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 16/16] IB uverbs: add documentation file
In-Reply-To: <2005628163.VUsohVlfE72duiiM@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:44 -0700
Message-Id: <2005628163.mVVkhZjoFQLjYM7E@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for InfiniBand userspace verbs.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 Documentation/infiniband/user_verbs.txt |   69 ++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+)



--- /dev/null	2005-06-23 14:14:38.423479552 -0700
+++ linux/Documentation/infiniband/user_verbs.txt	2005-06-28 15:20:31.245140214 -0700
@@ -0,0 +1,69 @@
+USERSPACE VERBS ACCESS
+
+  The ib_uverbs module, built by enabling CONFIG_INFINIBAND_USER_VERBS,
+  enables direct userspace access to IB hardware via "verbs," as
+  described in chapter 11 of the InfiniBand Architecture Specification.
+
+  To use the verbs, the libibverbs library, available from
+  <http://openib.org/>, is required.  libibverbs contains a
+  device-independent API for using the ib_uverbs interface.
+  libibverbs also requires appropriate device-dependent kernel and
+  userspace driver for your InfiniBand hardware.  For example, to use
+  a Mellanox HCA, you will need the ib_mthca kernel module and the
+  libmthca userspace driver be installed.
+
+User-kernel communication
+
+  Userspace communicates with the kernel for slow path, resource
+  management operations via the /dev/infiniband/uverbsN character
+  devices.  Fast path operations are typically performed by writing
+  directly to hardware registers mmap()ed into userspace, with no
+  system call or context switch into the kernel.
+
+  Commands are sent to the kernel via write()s on these device files.
+  The ABI is defined in drivers/infiniband/include/ib_user_verbs.h.
+  The structs for commands that require a response from the kernel
+  contain a 64-bit field used to pass a pointer to an output buffer.
+  Status is returned to userspace as the return value of the write()
+  system call.
+
+Resource management
+
+  Since creation and destruction of all IB resources is done by
+  commands passed through a file descriptor, the kernel can keep track
+  of which resources are attached to a given userspace context.  The
+  ib_uverbs module maintains idr tables that are used to translate
+  between kernel pointers and opaque userspace handles, so that kernel
+  pointers are never exposed to userspace and userspace cannot trick
+  the kernel into following a bogus pointer.
+
+  This also allows the kernel to clean up when a process exits and
+  prevent one process from touching another process's resources.
+
+Memory pinning
+
+  Direct userspace I/O requires that memory regions that are potential
+  I/O targets be kept resident at the same physical address.  The
+  ib_uverbs module manages pinning and unpinning memory regions via
+  get_user_pages() and put_page() calls.  It also accounts for the
+  amount of memory pinned in the process's locked_vm, and checks that
+  unprivileged processes do not exceed their RLIMIT_MEMLOCK limit.
+
+  Pages that are pinned multiple times are counted each time they are
+  pinned, so the value of locked_vm may be an overestimate of the
+  number of pages pinned by a process.
+
+/dev files
+
+  To create the appropriate character device files automatically with
+  udev, a rule like
+
+    KERNEL="uverbs*", NAME="infiniband/%k"
+
+  can be used.  This will create device nodes named
+
+    /dev/infiniband/uverbs0
+
+  and so on.  Since the InfiniBand userspace verbs should be safe for
+  use by non-privileged processes, it may be useful to add an
+  appropriate MODE or GROUP to the udev rule.
