Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSBMU4W>; Wed, 13 Feb 2002 15:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288936AbSBMU4N>; Wed, 13 Feb 2002 15:56:13 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:9994 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S288919AbSBMU4B>; Wed, 13 Feb 2002 15:56:01 -0500
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] -- filesystems.c::sys_nfsservctl 
Date: Wed, 13 Feb 2002 15:51:47 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Keith Owens <kaos@ocs.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BMOHPIKMF7YKQ9ECLLSF"
Message-Id: <20020213205144Z282414-24962+32@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BMOHPIKMF7YKQ9ECLLSF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ok guys get ready to flame me....  

	The attached patch removes the lock/unlock in this function.   Now I am 80% 
sure of this one, but would like a word from the kmod maintainer about 
whether request_module needs the BKL or not.   do_nfsservctl already takes 
the BKL inside the function so as long as request_module is safe this pair 
can be removed -- effectively making do_nfsservctl responsible for it's own 
locking scheme.

	So whoever knows for SURE about request_module, please reply.

========NOT A PATCH --- filesystems.c::sys_nfsservctl================
long
asmlinkage sys_nfsservctl(int cmd, void *argp, void *resp)
{
	int ret = -ENOSYS;
	
	lock_kernel();

	if (nfsd_linkage ||
	    (request_module ("nfsd") == 0 && nfsd_linkage))
		ret = nfsd_linkage->do_nfsservctl(cmd, argp, resp);

	unlock_kernel();
	return ret;
}


==================PATCH ATTACHED==========================

--------------Boundary-00=_BMOHPIKMF7YKQ9ECLLSF
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="filesystems-remove-lock_kernel-nfsd.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="filesystems-remove-lock_kernel-nfsd.diff"

===== fs/filesystems.c 1.4 vs edited =====
--- 1.4/fs/filesystems.c	Fri Feb  8 22:10:55 2002
+++ edited/fs/filesystems.c	Wed Feb 13 15:30:20 2002
@@ -22,13 +22,11 @@
 {
 	int ret = -ENOSYS;
 	
-	lock_kernel();
 
 	if (nfsd_linkage ||
 	    (request_module ("nfsd") == 0 && nfsd_linkage))
 		ret = nfsd_linkage->do_nfsservctl(cmd, argp, resp);
 
-	unlock_kernel();
 	return ret;
 }
 EXPORT_SYMBOL(nfsd_linkage);

--------------Boundary-00=_BMOHPIKMF7YKQ9ECLLSF--
