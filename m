Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUAWELt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 23:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUAWELt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 23:11:49 -0500
Received: from h80ad2532.async.vt.edu ([128.173.37.50]:62592 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266502AbUAWELq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 23:11:46 -0500
Message-Id: <200401222235.i0MMZmRQ018593@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc1-mm1 and Fedora gcc-3.5ssa - memcmp issues
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_707970002P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jan 2004 17:35:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_707970002P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_7077073520"

This is a multipart MIME message.

--==_Exmh_7077073520
Content-Type: text/plain; charset=us-ascii

Tried building with Fedora gcc-ssa, and got this on 'make modules_install':

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.2-rc1-mm1; fi
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/fs/nfsd/nfsd.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/fs/nfs/nfs.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/fs/msdos/msdos.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/fs/lockd/lockd.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/fs/fat/fat.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/net/ipv6/netfilter/ip6t_mac.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/net/sunrpc/sunrpc.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/net/sunrpc/auth_gss/rpcsec_gss_krb5.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/net/ipv4/netfilter/ipt_recent.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/net/ipv4/netfilter/ipt_mac.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/net/ipv4/netfilter/ip_conntrack_irc.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/drivers/pcmcia/pcmcia_core.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/drivers/net/slhc.ko needs unknown symbol memcmp
WARNING: /lib/modules/2.6.2-rc1-mm1/kernel/drivers/char/i8k.ko needs unknown symbol memcmp


The cause?  A chain of events:

1) Inlining didn't happen for at least one case in the failing modules.
2) There wasn't an EXPORT_SYMBOL.
3) Even once that got added, it didn't help because a "#define memcmp __buildin_memcmp"
caused the wrong symbol to get exported:

% nm lib/string.o|grep memcmp
00000000 r __kstrtab___builtin_memcmp
00000000 r __ksymtab___builtin_memcmp
00000217 T memcmp
% nm lib/string.o|grep strlcpy
00000027 r __kstrtab_strlcpy
00000020 r __ksymtab_strlcpy
00000325 T strlcpy

Patch to fix memcmp attached - with it, the depmod succeeds.

Should I do the similar thing for *all* the things in lib/string.c?  Only some
of the functions have EXPORT_SYMBOL, and various releases of gcc *may*
have different __builtin_foo lists.


--==_Exmh_7077073520
Content-Type: text/plain ; name="2.6.2-ssa-patch"; charset=us-ascii
Content-Description: 2.6.2-ssa-patch
Content-Disposition: attachment; filename="2.6.2-ssa-patch"

--- linux-2.6.2-rc1-mm1/lib/string.c.dist	2004-01-22 17:20:00.859598882 -0500
+++ linux-2.6.2-rc1-mm1/lib/string.c	2004-01-22 17:29:43.316730389 -0500
@@ -501,6 +501,9 @@
 #endif
 
 #ifndef __HAVE_ARCH_MEMCMP
+#ifdef memcmp
+#undef memcmp
+#endif
 /**
  * memcmp - Compare two areas of memory
  * @cs: One area of memory
@@ -517,6 +520,7 @@
 			break;
 	return res;
 }
+EXPORT_SYMBOL(memcmp);
 #endif
 
 #ifndef __HAVE_ARCH_MEMSCAN

--==_Exmh_7077073520--


--==_Exmh_707970002P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAEFBDcC3lWbTT17ARArO6AJ99HKTUZcoAUgUNMBgMXonpv+Ar8QCgvY3M
e6pE3H6uaMlR91AeTjUEC40=
=mMc6
-----END PGP SIGNATURE-----

--==_Exmh_707970002P--
