Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164336AbWLHBNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164336AbWLHBNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164328AbWLHBNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:13:35 -0500
Received: from ns1.suse.de ([195.135.220.2]:58422 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164325AbWLHBNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:18 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:31 +1100
Message-Id: <1061208011331.30579@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 18] knfsd: svcrpc: fix gss krb5i memory leak
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

The memory leak here is embarassingly obvious.

This fixes a problem that causes the kernel to leak a small amount of
memory every time it receives a integrity-protected request.

Thanks to Aimé Le Rouzic for the bug report.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-12-08 12:07:28.000000000 +1100
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-12-08 12:08:05.000000000 +1100
@@ -818,19 +818,19 @@ unwrap_integ_data(struct xdr_buf *buf, u
 
 	integ_len = svc_getnl(&buf->head[0]);
 	if (integ_len & 3)
-		goto out;
+		return stat;
 	if (integ_len > buf->len)
-		goto out;
+		return stat;
 	if (xdr_buf_subsegment(buf, &integ_buf, 0, integ_len))
 		BUG();
 	/* copy out mic... */
 	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
 		BUG();
 	if (mic.len > RPC_MAX_AUTH_SIZE)
-		goto out;
+		return stat;
 	mic.data = kmalloc(mic.len, GFP_KERNEL);
 	if (!mic.data)
-		goto out;
+		return stat;
 	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
 		goto out;
 	maj_stat = gss_verify_mic(ctx, &integ_buf, &mic);
@@ -840,6 +840,7 @@ unwrap_integ_data(struct xdr_buf *buf, u
 		goto out;
 	stat = 0;
 out:
+	kfree(mic.data);
 	return stat;
 }
 
