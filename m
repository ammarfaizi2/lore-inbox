Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265640AbSJSRo7>; Sat, 19 Oct 2002 13:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSJSRo7>; Sat, 19 Oct 2002 13:44:59 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:40455 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265640AbSJSRo6>; Sat, 19 Oct 2002 13:44:58 -0400
Date: Sun, 20 Oct 2002 02:51:01 +0900 (JST)
Message-Id: <20021020.025101.53139005.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org
CC: usagi@linux-ipv6.org
Subject: [PATCH] mod->can_unload() does not take effect
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

mod->can_unload() does not take effect because it is not called.

This patch is against linux-2.4.19.

Thanks in advance.

Index: kernel/module.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux24/kernel/module.c,v
retrieving revision 1.1.1.11
diff -u -r1.1.1.11 module.c
--- kernel/module.c	23 Nov 2001 16:44:45 -0000	1.1.1.11
+++ kernel/module.c	19 Oct 2002 17:34:39 -0000
@@ -25,6 +25,7 @@
  *     http://www.uwsg.iu.edu/hypermail/linux/kernel/0008.3/0379.html
  * Replace xxx_module_symbol with inter_module_xxx.  Keith Owens <kaos@ocs.com.au> Oct 2000
  * Add a module list lock for kernel fault race fixing. Alan Cox <alan@redhat.com>
+ * Fix to respect mod->can_unload(). YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
  *
  * This source is covered by the GNU GPL, the same as all kernel sources.
  */
@@ -867,7 +868,8 @@
 		/* usecount is one too high here - report appropriately to
 		   compensate for locking */
 		info.usecount = (mod_member_present(mod, can_unload)
-				 && mod->can_unload ? -1 : atomic_read(&mod->uc.usecount)-1);
+				 && mod->can_unload && mod->can_unload() 
+				 ? -1 : atomic_read(&mod->uc.usecount)-1);
 
 		if (copy_to_user(buf, &info, sizeof(struct module_info)))
 			return -EFAULT;
@@ -1111,7 +1113,7 @@
 		if (mod->flags & MOD_RUNNING) {
 			len = sprintf(tmpstr, "%4ld",
 				      (mod_member_present(mod, can_unload)
-				       && mod->can_unload
+				       && mod->can_unload && mod->can_unload()
 				       ? -1L : (long)atomic_read(&mod->uc.usecount)));
 			safe_copy_str(tmpstr, len);
 		}

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
