Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUHIIwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUHIIwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266359AbUHIIup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:50:45 -0400
Received: from holomorphy.com ([207.189.100.168]:64221 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266364AbUHIItV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:49:21 -0400
Date: Mon, 9 Aug 2004 01:49:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809084914.GM11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040808152936.1ce2eab8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808152936.1ce2eab8.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 03:29:36PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm2/
> - Added a little patch to the CPU scheduler which disables its array
>   switching.
[...]

During the kernel summit, some discussion was had about the support
requirements for a userspace program loader that loads executables
into hugetlb on behalf of a major application (Oracle). In order to
support this in a robust fashion, the cleanup of the hugetlb must be
robust in the presence of disorderly termination of the programs
(e.g. kill -9). Hence, the cleanup semantics are those of System V
shared memory, but Linux' System V shared memory needs one critical
extension for this use: executability.

The following microscopic patch enables this major application to
provide robust hugetlb cleanup.

Index: premm2-2.6.8-rc3/include/linux/shm.h
===================================================================
--- premm2-2.6.8-rc3.orig/include/linux/shm.h	2004-08-07 02:17:59.231816608 -0700
+++ premm2-2.6.8-rc3/include/linux/shm.h	2004-08-07 03:46:10.163472736 -0700
@@ -44,6 +44,7 @@
 #define	SHM_RDONLY	010000	/* read-only access */
 #define	SHM_RND		020000	/* round attach address to SHMLBA boundary */
 #define	SHM_REMAP	040000	/* take-over region on attach */
+#define	SHM_EXEC	0100000	/* execution access */
 
 /* super user shmctl commands */
 #define SHM_LOCK 	11
Index: premm2-2.6.8-rc3/ipc/shm.c
===================================================================
--- premm2-2.6.8-rc3.orig/ipc/shm.c	2004-08-07 02:17:59.395791680 -0700
+++ premm2-2.6.8-rc3/ipc/shm.c	2004-08-07 02:58:23.613254608 -0700
@@ -688,6 +688,10 @@
 		o_flags = O_RDWR;
 		acc_mode = S_IRUGO | S_IWUGO;
 	}
+	if (shmflg & SHM_EXEC) {
+		prot |= PROT_EXEC;
+		acc_mode |= S_IXUGO;
+	}
 
 	/*
 	 * We cannot rely on the fs check since SYSV IPC does have an
