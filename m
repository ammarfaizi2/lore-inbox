Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWCXFz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWCXFz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWCXFz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:55:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:46745 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932538AbWCXFz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:55:56 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Mar 2006 16:53:52 +1100
Message-Id: <1060324055352.2333@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 2] knfsd: Tidy up unix_domain_find
References: <20060324165210.2285.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We shouldn't really compare &new->h with anything when new ==NULL,
and gather three different if statements that all start
  if (rv ...

into one large if.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcauth_unix.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff ./net/sunrpc/svcauth_unix.c~current~ ./net/sunrpc/svcauth_unix.c
--- ./net/sunrpc/svcauth_unix.c~current~	2006-03-24 12:06:14.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-03-24 12:08:04.000000000 +1100
@@ -36,16 +36,16 @@ struct auth_domain *unix_domain_find(cha
 
 	rv = auth_domain_lookup(name, NULL);
 	while(1) {
-		if (rv != &new->h) {
-			if (new) auth_domain_put(&new->h);
+		if (rv) {
+			if (new && rv != &new->h)
+				auth_domain_put(&new->h);
+
+			if (rv->flavour != &svcauth_unix) {
+				auth_domain_put(rv);
+				return NULL;
+			}
 			return rv;
 		}
-		if (rv && rv->flavour != &svcauth_unix) {
-			auth_domain_put(rv);
-			return NULL;
-		}
-		if (rv)
-			return rv;
 
 		new = kmalloc(sizeof(*new), GFP_KERNEL);
 		if (new == NULL)
