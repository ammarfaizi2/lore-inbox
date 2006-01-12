Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161302AbWALVQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbWALVQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbWALVQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:16:47 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28108 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161299AbWALVQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:16:46 -0500
Message-Id: <200601122116.k0CLGaiO005357@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.15-mm3 - disk quotas apparently busticated..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137100596_2950P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Jan 2006 16:16:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137100596_2950P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <5348.1137100595.1@turing-police.cc.vt.edu>

Disk quotas have been functioning for me for quite a while (including 2.6.15 and
2.6.15-rc*-mm* - haven't tried 15-mm1 or 15-mm2 yet).

Under the 2.6.15-mm3 kernel, 'quotaon /home' (or any other ext3 filesystem
that had functional quotas on it fails:

# quotaon /home
quotaon: using /home/aquota.group on /dev/mapper/rootvg-home [/home]: Invalid argument
quotaon: Maybe create new quota files with quotacheck(8)?
quotaon: using /home/aquota.user on /dev/mapper/rootvg-home [/home]: Invalid argument
quotaon: Maybe create new quota files with quotacheck(8)?
# quotacheck -u -g -m /home
# quotaon /home
quotaon: using /home/aquota.group on /dev/mapper/rootvg-home [/home]: Invalid argument
quotaon: Maybe create new quota files with quotacheck(8)?
quotaon: using /home/aquota.user on /dev/mapper/rootvg-home [/home]: Invalid argument
quotaon: Maybe create new quota files with quotacheck(8)?

Using quota-3.13.

Poking with strace finds:
...
quotactl(Q_QUOTAON|GRPQUOTA, "/dev/mapper/rootvg-home", 2, {8169863311701010479, 8030594534456192885, 141733949557, 8097873655606109231, 8390047167027504496, 28549297904379766, 1309965025280, 13254570172929388888}) = -1 EINVAL (Invalid argument)
...
quotactl(Q_QUOTAON|USRQUOTA, "/dev/mapper/rootvg-home", 2, {8169863311701010479, 7310315462216413045, 141733920882, 8097873655606109231, 8390047167027504496, 28549297904379766, 210453397504, 7018986666877744431}) = -1 EINVAL (Invalid argument)

And the following corresponding cryptic messages in dmesg:

[ 1833.288000] failed read
[ 1833.332000] failed read

(which is why I just submitted a patch to fs/quota_v2.c)

Further digging based on the info from that patch implicates ext3_quota_read()
(which itself seems potentially buggy - it has code that says:

                bh = ext3_bread(NULL, inode, blk, 0, &err);
                if (err)
                        return err;

which is returning 1 in my case.  Good thing that ext3_get_blocks_handle()
(which eventually gets called) can't return 8....

It's getting down to fs/ext3/inode.c ext3_getblk() and this code:

        *errp = ext3_get_blocks_handle(handle, inode, block, 1, &dummy, create, 1);
        if ((*errp == 1 ) && buffer_mapped(&dummy)) {

which sets *errp to 1. We then enter a 40-line block, which can return a valid
struct buffer_head, but never set another value into *errp.

Bug/question: Should that big 'if' statement reset *errp if things work out OK?

--- inode.c     2006-01-12 13:35:44.000000000 -0500
+++ inode.c.temp        2006-01-12 16:13:44.000000000 -0500
@@ -1048,14 +1048,16 @@
                } else {
                        BUFFER_TRACE(bh, "not a new buffer");
                }
                if (fatal) {
                        *errp = fatal;
                        brelse(bh);
                        bh = NULL;
+               } else {
+                       *errp = 0;
                }
                return bh;
        }
 err:
        return NULL;
 }


--==_Exmh_1137100596_2950P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDxsc0cC3lWbTT17ARAoIoAKDPzfAYFaxNoybacHivgjaBBeH0NgCfWXP5
tVlSGxD6rbVACcEqMFf48ls=
=kaNU
-----END PGP SIGNATURE-----

--==_Exmh_1137100596_2950P--
