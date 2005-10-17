Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVJQN6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVJQN6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 09:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVJQN6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 09:58:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751341AbVJQN6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 09:58:17 -0400
Message-ID: <4353ADDF.1020308@RedHat.com>
Date: Mon, 17 Oct 2005 09:57:51 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH] NFS/RPC/GSS - oops in gss_pipe_release()]
Content-Type: multipart/mixed;
 boundary="------------030104020706010109070506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030104020706010109070506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Resending since this problem still appears to be in
both the -mm and mainline kernels..

steved.

-------- Original Message --------
Subject: [PATCH] NFS/RPC/GSS - oops in gss_pipe_release()
Date: Fri, 16 Sep 2005 13:40:15 -0400
From: Steve Dickson <SteveD@RedHat.com>
To: nfs@lists.sourceforge.net

During some recent debugging I found that an oops can
occur in gss_pipe_release() because the client handle
that is being passed in has already been freed.

The scenario is as follows:

1) root# mount -o sec=krb5 server:/export /mnt/export
2) user$ ls /mnt/export (which hangs because user does not
                        have the correct credentials)
3) root# reboot

The oops occurs when the /mnt/export filesystem
is unmounted. The reason being is gss_pipe_release()
was already called when the ls process was killed.
The stack dump of the ls process was:

   [<e09dda84>] gss_pipe_release+0x74/0xd8 [auth_rpcgss]
   [<e0a045c0>] rpc_pipe_release+0xa5/0xb9 [sunrpc]
   [<c015a9d6>] __fput+0x55/0x100
   [<c0159626>] filp_close+0x59/0x5f
   [<c012363f>] put_files_struct+0x57/0xc0
   [<c0124255>] do_exit+0x227/0x3de
   [<c01244fa>] sys_exit_group+0x0/0xd
   [<c02d120b>] syscall_call+0x7/0xb

So when the rpc_shutdown_client code is called
via the umount:
   [<e09dda84>] gss_pipe_release+0x74/0xd8 [auth_rpcgss]
   [<e0a0447c>] rpc_close_pipes+0x80/0x9a [sunrpc]
   [<e0a04bb0>] rpc_depopulate+0xfb/0x142 [sunrpc]
   [<c01651bc>] cached_lookup+0xf/0x56
   [<c0166410>] __lookup_hash+0x46/0x89
   [<e0a05005>] rpc_rmdir+0x5a/0x89 [sunrpc]
   [<e09fcede>] rpcauth_free_credcache+0x87/0xd0 [sunrpc]
   [<e09f8431>] rpc_destroy_client+0x70/0xa4 [sunrpc]
   [<e09f8421>] rpc_destroy_client+0x60/0xa4 [sunrpc]
   [<e09f83ba>] rpc_shutdown_client+0xd1/0xd8 [sunrpc]
   [<c011e586>] default_wake_function+0x0/0xc
   [<e0aefe75>] nfs_kill_super+0x38/0x63 [nfs]

the client handle (which is in the rpc_inode) passed
to gss_pipe_release() has already been freeded.

It appears from other places in the code (namely
rpc_close_pipes()) that the only way to invalidate
an rpc_inode is to set the ops pointer to NULL which
is what the attached patch does.

Is there a better way to invalid an rpc_inode?

steved.


--------------030104020706010109070506
Content-Type: text/x-patch;
 name="linux-2.6.13-rpc-gss-release.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.13-rpc-gss-release.patch"

This patch stops the release_pipe() funtion from being called
twice by invalidating the ops pointer in the rpc_inode
when rpc_pipe_release() is called.

Signed-off-by: Steve Dickson <steved@redhat.com>
------------------------------------------------------
--- linux-2.6.13/net/sunrpc/rpc_pipe.c.orig	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/net/sunrpc/rpc_pipe.c	2005-09-16 11:18:53.598157000 -0400
@@ -177,6 +177,8 @@ rpc_pipe_release(struct inode *inode, st
 		__rpc_purge_upcall(inode, -EPIPE);
 	if (rpci->ops->release_pipe)
 		rpci->ops->release_pipe(inode);
+	if (!rpci->nreaders && !rpci->nwriters)
+		rpci->ops = NULL;
 out:
 	up(&inode->i_sem);
 	return 0;


--------------030104020706010109070506--
