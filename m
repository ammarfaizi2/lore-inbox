Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267112AbTGTMq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 08:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbTGTMq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 08:46:27 -0400
Received: from ns.tasking.nl ([195.193.207.2]:24589 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S267112AbTGTMqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 08:46:23 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <65b6.3f1a6fae.1d70b@altium.nl>
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: Re: 2.6.0-test1: autofs4 doesn't expire
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <1d60.3f1a9267.2bf5e@altium.nl>
Date: Sun, 20 Jul 2003 13:00:23 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spam@streefland.xs4all.nl (Dick Streefland) wrote:
| In 2.6.0-test1, the autofs4 automounter doesn't expire mounts anymore,
| both NFS and CDROM mounts. It did work in my previous kernel, 2.5.72.
| When I try to unmount manually, I get "device is busy", although
| "fuser -m" doesn't report anything. I've also searched /proc/*/fd/,
| but there are no open files below the mount points.
| 
| Is anybody else seeing this? Any ideas what could be the cause?

Update: 2.5.75 is OK, so the problem was introduced in 2.6.0-test1.
I have not yet verified it, but I suspect that the addition of the
mntget() call is the cause:

==> fs/namespace.c <==
+/*
+ * Now, lookup_mnt increments the ref count before returning
+ * the vfsmount struct.
+ */
 struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct list_head * head = mount_hashtable + hash(mnt, dentry);
 	struct list_head * tmp = head;
-	struct vfsmount *p;
+	struct vfsmount *p, *found = NULL;
 
+	spin_lock(&vfsmount_lock);
 	for (;;) {
 		tmp = tmp->next;
 		p = NULL;
 		if (tmp == head)
 			break;
 		p = list_entry(tmp, struct vfsmount, mnt_hash);
-		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry)
+		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
+			found = mntget(p);
 			break;
+		}
 	}
-	return p;
+	spin_unlock(&vfsmount_lock);
+	return found;
 }

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

