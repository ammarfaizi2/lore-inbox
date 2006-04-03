Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWDCFZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWDCFZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWDCFZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:25:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36252 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964838AbWDCFUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:16 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:28 +1000
Message-Id: <1060403051828.1785@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 16] knfsd: nfsd: oops exporting nonexistent directory
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Export a directory that does not exist:
	exportfs -orw,fsid=0,insecure,no_subtree_check client:/home/NFS4

Try to mount from client with nfs4. Mount hangs (I'm not sure why -
that's another issue).

While client is hung, back on server

	mkdir /home/NFS4

The server panics in dput. I traced the problem back to svc_export_parse()
calling path_release() even though path_lookup() failed (it happens
to fill in the nameidata structure with a negative dentry - so the test
after out: succeeds).

After patching, an recreating the problem, the client mount still takes
some time before finally exiting with a message "couldn't read
superblock".

Here is a simple patch to resolve this issue:

Signed-Off-By: Frank Filz <ffilzlnx@us.ibm.com>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-04-03 15:12:08.000000000 +1000
+++ ./fs/nfsd/export.c	2006-04-03 15:12:08.000000000 +1000
@@ -422,7 +422,7 @@ static int svc_export_parse(struct cache
 	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
 		goto out;
 	err = path_lookup(buf, 0, &nd);
-	if (err) goto out;
+	if (err) goto out_no_path;
 
 	exp.h.flags = 0;
 	exp.ex_client = dom;
@@ -475,6 +475,7 @@ static int svc_export_parse(struct cache
  out:
 	if (nd.dentry)
 		path_release(&nd);
+ out_no_path:
 	if (dom)
 		auth_domain_put(dom);
 	kfree(buf);
