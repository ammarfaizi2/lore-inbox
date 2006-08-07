Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWHGT76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWHGT76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWHGT76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:59:58 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:40924 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932334AbWHGT75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:59:57 -0400
Date: Mon, 7 Aug 2006 21:59:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>, Jeff Dike <jdike@addtoit.com>,
       "lkml@o2.pl / IMAP" <lkml@o2.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm1: O= builds broken
Message-ID: <20060807195912.GA14126@mars.ravnborg.org>
References: <20060806002400.694948a1.akpm@osdl.org> <20060806082321.GZ25692@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806082321.GZ25692@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 10:23:21AM +0200, Adrian Bunk wrote:
> <--  snip  -->
> 
> $ make O=/home/bunk/linux/kernel-2.6/out/full/ oldconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/docproc
>   GEN     /home/bunk/linux/kernel-2.6/out/full/Makefile
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/kxgettext.o
>   HOSTCC  scripts/kconfig/lxdialog/checklist.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc3-mm1/scripts/kconfig/lxdialog/checklist.c:325: 
> fatal error: opening dependency file 
> scripts/kconfig/lxdialog/.checklist.o.d: No such file or directory
> compilation terminated.
> make[2]: *** [scripts/kconfig/lxdialog/checklist.o] Error 1
> make[1]: *** [oldconfig] Error 2
> make: *** [oldconfig] Error 2
> $ 
>
If the lxdialog directory is missing then kbuild barfs out.
Fixed by followign patch that is already pushed out to my kbuild.git
tree. Thanks for the reports (all senders added to to:).

	Sam

commit a886c8972f22033e720405ce4c4fed941b5eb406
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Aug 7 21:55:33 2006 +0200

    kbuild: create output directory for hostprogs with O=.. build
    
    hostprogs-y only supported creating output directory for the final
    program. Extend this to also cover the situation where a .o
    file (used when host program is made from compositie objects) is
    locate in another directory.
    First user of this is the built-in lxdialog that.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 18ecd4d..aa208e8 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -32,11 +32,6 @@ # Note: Shared libraries consisting of C
 
 __hostprogs := $(sort $(hostprogs-y)$(hostprogs-m))
 
-# hostprogs-y := tools/build may have been specified. Retreive directory
-host-objdirs := $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
-host-objdirs := $(strip $(sort $(filter-out ./,$(host-objdirs))))
-
-
 # C code
 # Executables compiled from a single .c file
 host-csingle	:= $(foreach m,$(__hostprogs),$(if $($(m)-objs),,$(m)))
@@ -65,6 +60,21 @@ host-cobjs	:= $(filter-out %.so,$(host-c
 #Object (.o) files used by the shared libaries
 host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-objs))))
 
+# output directory for programs/.o files
+# hostprogs-y := tools/build may have been specified. Retreive directory
+host-objdirs := $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
+# directory of .o files from prog-objs notation
+host-objdirs += $(foreach f,$(host-cmulti),                  \
+                    $(foreach m,$($(f)-objs),                \
+                        $(if $(dir $(m)),$(dir $(m)))))
+# directory of .o files from prog-cxxobjs notation
+host-objdirs += $(foreach f,$(host-cxxmulti),                  \
+                    $(foreach m,$($(f)-cxxobjs),                \
+                        $(if $(dir $(m)),$(dir $(m)))))
+
+host-objdirs := $(strip $(sort $(filter-out ./,$(host-objdirs))))
+
+
 __hostprogs     := $(addprefix $(obj)/,$(__hostprogs))
 host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
 host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
@@ -75,6 +85,7 @@ host-cshlib	:= $(addprefix $(obj)/,$(hos
 host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
 host-objdirs    := $(addprefix $(obj)/,$(host-objdirs))
 
+$(warning host-objdirs=$(host-objdirs))
 obj-dirs += $(host-objdirs)
 
 #####

