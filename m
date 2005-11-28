Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVK1R43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVK1R43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVK1R42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:56:28 -0500
Received: from hera.kernel.org ([140.211.167.34]:55785 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932145AbVK1R42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:56:28 -0500
Date: Mon, 28 Nov 2005 10:14:34 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Krzysztof Strasburger <strasbur@chkw386.ch.pwr.wroc.pl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 PATCH] NFS server as a module with -mregparm=3
Message-ID: <20051128121434.GA24608@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff-tree b7844980a750ebe9f32ab5a29e370a4e32781e5d (from e8f3e8dd41308fb66c026f51bb86b23205ad48c1)
Author: Krzysztof Strasburger <strasbur@chkw386.ch.pwr.wroc.pl>
Date:   Wed Nov 2 10:43:36 2005 +0100

    [PATCH] NFS server as a module with -mregparm=3
    
    This patch makes it possible to compile the nfs server as a module, with
    -mregparm=3 (at least on x86).
    
    Such a combination did not work, as handle_sys_nfsservctl was called
    from the sys_nfsservctl function (in fs/filesystems.c) with parameters
    in registers, but tried to read them from the stack.
    
    Signed-off-by: Krzysztof Strasburger

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 59d65f5..287bcad 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -212,8 +212,13 @@ static struct {
 };
 #define CMD_MAX (sizeof(sizes)/sizeof(sizes[0])-1)
 
+#ifdef MODULE
+long
+handle_sys_nfsservctl(int cmd, void *opaque_argp, void *opaque_resp)
+#else
 long
 asmlinkage handle_sys_nfsservctl(int cmd, void *opaque_argp, void *opaque_resp)
+#endif
 {
 	struct nfsctl_arg *	argp = opaque_argp;
 	union nfsctl_res *	resp = opaque_resp;
