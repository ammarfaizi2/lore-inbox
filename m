Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUBKPLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUBKPLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:11:51 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:2982 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S265352AbUBKPLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:11:48 -0500
Date: Wed, 11 Feb 2004 10:11:28 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: util-linux@math.uio.no
Cc: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix /etc/mtab updating with mount --move [was Re: devfs vs udev, thoughts from a devfs user]
Message-ID: <20040211151128.GB32657@ti19.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	util-linux@math.uio.no, viro@parcelfarce.linux.theplanet.co.uk,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com> <40293AF8.1080603@backtobasicsmgmt.com> <20040210203900.GA18263@ti19.telemetry-investments.com> <20040211011559.GA2153@kroah.com> <20040211075049.GJ21151@parcelfarce.linux.theplanet.co.uk> <20040211123352.GA32657@ti19.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20040211123352.GA32657@ti19.telemetry-investments.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2004 at 07:33:52AM -0500, Bill Rugolsky Jr. wrote:
> Anyway, with traditional /etc/mtab, mount --move produces:
> 
>    none on /tmp/a type ramfs (rw)
>    /tmp/a on /tmp/b type none (rw)

Andries, 

The attached patch against util-linux-2.12pre fixes /etc/mtab updating
when using mount --move.

Regards,

	Bill Rugolsky

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="util-linux-2.12pre-mountmove.patch"

--- util-linux-2.12pre/mount/fstab.c.move	2003-07-05 16:16:05.000000000 -0400
+++ util-linux-2.12pre/mount/fstab.c	2004-02-11 09:56:12.644436000 -0500
@@ -541,8 +541,12 @@
 				mc->nxt->prev = mc->prev;
 			}
 		} else {
-			/* A remount */
+			/* A remount or move */
 			mc->m.mnt_opts = instead->mnt_opts;
+			if (!streq(mc->m.mnt_dir, instead->mnt_dir)) {
+				free(mc->m.mnt_dir);
+				mc->m.mnt_dir = xstrdup(instead->mnt_dir);
+			}
 		}
 	} else if (instead) {
 		/* not found, add a new entry */
--- util-linux-2.12pre/mount/mount.c.move	2003-07-13 17:26:13.000000000 -0400
+++ util-linux-2.12pre/mount/mount.c	2004-02-11 10:03:25.754436000 -0500
@@ -635,7 +635,9 @@
 	    print_one (&mnt);
 
     if (!nomtab && mtab_is_writable()) {
-	if (flags & MS_REMOUNT)
+	if (flags & MS_MOVE)
+	    update_mtab (mnt.mnt_fsname, &mnt);
+	else if (flags & MS_REMOUNT)
 	    update_mtab (mnt.mnt_dir, &mnt);
 	else {
 	    mntFILE *mfp;

--lrZ03NoBR/3+SXJZ--
