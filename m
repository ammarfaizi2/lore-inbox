Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWHXGgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWHXGgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWHXGgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:36:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:24754 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030339AbWHXGgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:36:43 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:36:45 +1000
Message-Id: <1060824063645.4937@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 11] knfsd: call lockd_down when closing a socket via a write to nfsd/portlist
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The refcount that nfsd holds on lockd is based on the number
of open sockets.
So when we close a socket, we should decrement the ref (with lockd_down).

Currently when a socket is closed via writing to the portlist
file, that doesn't happen.

So: make sure we get an error return if the socket that was requested
does is not found, and call lockd_down if it was.

Cc: "J. Bruce Fields" <bfields@fieldses.org>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsctl.c     |    2 ++
 ./net/sunrpc/svcsock.c |    2 ++
 2 files changed, 4 insertions(+)

diff .prev/fs/nfsd/nfsctl.c ./fs/nfsd/nfsctl.c
--- .prev/fs/nfsd/nfsctl.c	2006-08-24 16:24:21.000000000 +1000
+++ ./fs/nfsd/nfsctl.c	2006-08-24 16:24:21.000000000 +1000
@@ -545,6 +545,8 @@ static ssize_t write_ports(struct file *
 		if (nfsd_serv)
 			len = svc_sock_names(buf, nfsd_serv, toclose);
 		unlock_kernel();
+		if (len >= 0)
+			lockd_down();
 		kfree(toclose);
 		return len;
 	}

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-08-24 16:23:37.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-08-24 16:24:21.000000000 +1000
@@ -493,6 +493,8 @@ svc_sock_names(char *buf, struct svc_ser
 	spin_unlock(&serv->sv_lock);
 	if (closesk)
 		svc_delete_socket(closesk);
+	else if (toclose)
+		return -ENOENT;
 	return len;
 }
 EXPORT_SYMBOL(svc_sock_names);
