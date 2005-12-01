Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVLAId4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVLAId4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbVLAId4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:33:56 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:62821 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751394AbVLAIdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:33:55 -0500
Date: Thu, 1 Dec 2005 17:33:53 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] modinfo vmlinux
Message-ID: <20051201083353.GA6060@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes I want to know which kind of kernel parameters are available
for modules that are built into the kernel image.

This patch supports modinfo for vmlinux.

# modinfo -p vmlinux
i8042.nokbd:Do not probe or use KBD port.
i8042.noaux:Do not probe or use AUX (mouse) port.
i8042.nomux:Do not check whether an active multiplexing conrtoller is present.
 :
tcp_bic.initial_ssthresh:initial value of slow start threshold
tcp_bic.bic_scale:scale (scaled by 1024) value for bic function (bic_scale/1024)
tcp_bic.tcp_friendliness:turn on/off tcp friendliness

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6-rc/include/linux/module.h.orig	2005-12-01 13:06:56.000000000 +0900
+++ 2.6-rc/include/linux/module.h	2005-12-01 14:31:04.000000000 +0900
@@ -134,7 +134,7 @@ extern struct module __this_module;
 /* One for each parameter, describing how to use it.  Some files do
    multiple of these per line, so can't just use MODULE_INFO. */
 #define MODULE_PARM_DESC(_parm, desc) \
-	__MODULE_INFO(parm, _parm, #_parm ":" desc)
+	__MODULE_INFO(parm, _parm, MODULE_PARAM_PREFIX #_parm ":" desc)
 
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
--- 2.6-rc/include/linux/moduleparam.h.orig	2005-11-30 20:57:56.000000000 +0900
+++ 2.6-rc/include/linux/moduleparam.h	2005-12-01 14:30:17.000000000 +0900
@@ -13,18 +13,14 @@
 #define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
 #endif
 
-#ifdef MODULE
 #define ___module_cat(a,b) __mod_ ## a ## b
 #define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)					  \
 static const char __module_cat(name,__LINE__)[]				  \
   __attribute_used__							  \
   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
-#else  /* !MODULE */
-#define __MODULE_INFO(tag, name, info)
-#endif
 #define __MODULE_PARM_TYPE(name, _type)					  \
-  __MODULE_INFO(parmtype, name##type, #name ":" _type)
+  __MODULE_INFO(parmtype, name##type, MODULE_PARAM_PREFIX #name ":" _type)
 
 struct kernel_param;
 
