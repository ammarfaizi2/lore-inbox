Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130040AbRBADER>; Wed, 31 Jan 2001 22:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130025AbRBADEH>; Wed, 31 Jan 2001 22:04:07 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:48491 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129552AbRBADDy>; Wed, 31 Jan 2001 22:03:54 -0500
Message-ID: <3A78D1AB.2C2E743B@sgi.com>
Date: Wed, 31 Jan 2001 19:02:03 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Power usage Q and parallel make question (separate issues)
In-Reply-To: <9806.980987520@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
>
> The only bit that could run in parallel is this one.
> 
> .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
> $(patsubst %, _modinst_%, $(SUBDIRS)) :
>         $(MAKE) -C $(patsubst _modinst_%, %, $@) modules_install
> 
> The erase must be done first (serial), then make modules_install in
> every subdir (parallel), then depmod (serial).
---
Right...Wouldn't something like this work?  (Seems to)
--- Makefile.old        Wed Jan 31 18:57:21 2001
+++ Makefile    Wed Jan 31 18:54:53 2001
@@ -351,8 +351,12 @@
 $(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h include/config/MARKER
        $(MAKE) -C $(patsubst _mod_%, %, $@) CFLAGS="$(CFLAGS) $(MODFLAGS)" MAKING_MODULES=1 modules
 
+modules_inst_subdirs: _modinst_
+       $(MAKE) $(patsubst %, _modinst_%, $(SUBDIRS))
+
+
 .PHONY: modules_install
-modules_install: _modinst_ $(patsubst %, _modinst_%, $(SUBDIRS)) _modinst_post
+modules_install: _modinst_post
 
 .PHONY: _modinst_
 _modinst_:
@@ -372,7 +376,7 @@
 depmod_opts    := -b $(INSTALL_MOD_PATH) -r
 endif
 .PHONY: _modinst_post
-_modinst_post: _modinst_post_pcmcia
+_modinst_post: _modinst_post_pcmcia modules_inst_subdirs
        if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
 # Backwards compatibilty symlinks for people still using old versions          
---
This seems to serialize the delete, run the mod-installs in parallel, then run the
depmod when they are done.  
-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
