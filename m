Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVAXImn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVAXImn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 03:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVAXImm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 03:42:42 -0500
Received: from h80ad250c.async.vt.edu ([128.173.37.12]:7178 "EHLO
	h80ad250c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261468AbVAXImj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 03:42:39 -0500
Message-Id: <200501240842.j0O8gX2C022890@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LSM hook addition? 
In-Reply-To: Your message of "Mon, 24 Jan 2005 00:58:08 EST."
             <41F48E70.5090200@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <41F48E70.5090200@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106556153_17091P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jan 2005 03:42:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106556153_17091P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Jan 2005 00:58:08 EST, John Richard Moser said:

> I believe this would be sufficient to finish an LSM module to implement
> linking restrictions from GrSecurity.  I did Symlinks in an LSM module,
> but haven't tested it out; it's purely academic. 
> The hook here would be used (in my academic exploration) to prevent hard
> links from being created to files you don't own, unless you're root.

You don't need a hook there to do that.  The inode_link hook should be sufficient,
using code something like this:

+int vtkit_link (struct dentry *old_entry, struct inode *dir, struct dentry *new_entry)
+{
+       struct inode *i_target = old_entry->d_inode;
+       struct inode *i_new = new_entry->d_inode;
+       int perm_check = 0;
+
+       /* We check as follows - if the target of the link isn't owned by us,
+        * and we're not a privileged user, then we complain if any of the
+        * following are true:
+        * 1) It's not a special file
+        * 2) the target is set-uid or set-gid
+        * 3) user doesn't have permission to the target
+        *
+        * Yes, a "current->uid" check is pig-headed and wrong in the context of a
+        * system that uses priv separation...
+        */
+       perm_check = generic_permission(i_target, MAY_READ | MAY_WRITE, NULL);
+       if (security_safe_hardlink && (current->fsuid != i_target->i_uid) &&
+               !capable(CAP_FOWNER) && current->uid &&
+               (!S_ISREG(i_target->i_mode) || (i_target->i_mode & S_ISUID) ||
+               ((i_target->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) ||
+               perm_check)) {
+                       printk(KERN_NOTICE "vtkit - rejecting hard link (target UID %d) by PID %d (uid=%d, comm=%s)\n",
+                               i_target->i_uid, current->pid, current->uid, current->comm);
+                       return (perm_check ? perm_check:-EPERM);
+       }
+       return 0;
+}

If I'm missing something here, please let me know... ;)


--==_Exmh_1106556153_17091P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB9LT5cC3lWbTT17ARAnf0AJ90Ztd92vkfG4Nn0XIk+px5bKrs/QCgl0LY
ynyJNmecMP7KnNR0WTpT+SM=
=hM4A
-----END PGP SIGNATURE-----

--==_Exmh_1106556153_17091P--
