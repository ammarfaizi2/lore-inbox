Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWJAVMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWJAVMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWJAVMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 17:12:41 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:44730 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932329AbWJAVMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 17:12:40 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
Subject: [PATCH 1/4] fdtable: Delete pointless code in dup_fd().
Date: Sun, 1 Oct 2006 14:12:38 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011412.39072.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dup_fd() function creates a new files_struct and fdtable embedded inside
that files_struct, and then possibly expands the fdtable using expand_files().
The out_release error path is invoked when expand_files() returns an error
code. However, when this attempt to expand fails, the fdtable is left in its
original embedded form, so it is pointless to try to free the associated
fdarray and fdsets.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru old/kernel/fork.c new/kernel/fork.c
--- old/kernel/fork.c	2006-09-25 22:31:57.000000000 -0700
+++ new/kernel/fork.c	2006-09-25 22:35:01.000000000 -0700
@@ -727,14 +727,11 @@ static struct files_struct *dup_fd(struc
 		memset(&new_fdt->close_on_exec->fds_bits[start], 0, left);
 	}
 
-out:
 	return newf;
 
 out_release:
-	free_fdset (new_fdt->close_on_exec, new_fdt->max_fdset);
-	free_fdset (new_fdt->open_fds, new_fdt->max_fdset);
-	free_fd_array(new_fdt->fd, new_fdt->max_fds);
 	kmem_cache_free(files_cachep, newf);
+out:
 	return NULL;
 }
 
