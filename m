Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbSJAHje>; Tue, 1 Oct 2002 03:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJAHje>; Tue, 1 Oct 2002 03:39:34 -0400
Received: from angband.namesys.com ([212.16.7.85]:35719 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261513AbSJAHjd>; Tue, 1 Oct 2002 03:39:33 -0400
Date: Tue, 1 Oct 2002 11:44:54 +0400
From: Oleg Drokin <green@namesys.com>
To: James Stevenson <james@stev.org>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.5.39
Message-ID: <20021001114454.A27039@namesys.com>
References: <200209301955.OAA03608@ccure.karaya.com> <1033417581.1854.1.camel@god.stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1033417581.1854.1.camel@god.stev.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 30, 2002 at 09:26:21PM +0100, James Stevenson wrote:
> > The build works again.
> not as far as i can tell.
> just after typing make
> Makefile:363: target `arch/um/os-Linux' given more than once in the same
> rule.
> Makefile:363: target `arch/um/kernel' given more than once in the same
> rule.
> Makefile:363: target `arch/um/drivers' given more than once in the same
> rule.
> Makefile:363: target `arch/um/sys-i386' given more than once in the same
> rule.
> Makefile:533: target `_modinst_arch/um/os-Linux' given more than once in
> the same rule.
> Makefile:533: target `_modinst_arch/um/kernel' given more than once in
> the same rule.
> Makefile:533: target `_modinst_arch/um/drivers' given more than once in
> the same rule.
> Makefile:533: target `_modinst_arch/um/sys-i386' given more than once in
> the same rule.

Here's what I need to apply before I can build bk-current with UML support.
If you use Jeff's patch to 2.5.39, you then only need Makefle part of the patch,
I guess.

Jeff: BTW, UML crashes for me on shutdown quite often, if I have
CONFIG_DEBUG_SLAB enabled. Just before the crash it warns about
winch_interrupt : read failed, errno = 9
fd 57 is losing SIGWINCH support
(this is immediatelly after 'System halted.' message from kernel).
And then kernel mode fault at 0x5a5a5a5e

Bye,
    Oleg

===== arch/um/Makefile 1.5 vs edited =====
--- 1.5/arch/um/Makefile	Tue Oct  1 10:42:18 2002
+++ edited/arch/um/Makefile	Tue Oct  1 11:20:00 2002
@@ -30,11 +30,6 @@
 LINK_PROFILE = $(PROFILE) -Wl,--wrap,__monstartup
 endif
 
-ARCH_SUBDIRS = $(ARCH_DIR)/drivers $(ARCH_DIR)/kernel \
-	$(ARCH_DIR)/sys-$(SUBARCH) $(ARCH_DIR)/os-$(OS)
-
-SUBDIRS += $(ARCH_SUBDIRS)
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
===== arch/um/drivers/ubd_kern.c 1.5 vs edited =====
--- 1.5/arch/um/drivers/ubd_kern.c	Tue Oct  1 10:56:09 2002
+++ edited/arch/um/drivers/ubd_kern.c	Tue Oct  1 11:33:18 2002
@@ -406,7 +406,7 @@
 	ubd_gendisk[n].major = MAJOR_NR;
 	ubd_gendisk[n].first_minor = n << UBD_SHIFT;
 	ubd_gendisk[n].minor_shift = UBD_SHIFT;
-	ubd_gendisk[n].fops = &ubd_fops;
+	ubd_gendisk[n].fops = &ubd_blops;
 	if (fakehd_set)
 		sprintf(ubd_gendisk[n].disk_name, "hd%c", n + 'a');
 	else
@@ -416,7 +416,7 @@
 		fake_gendisk[n].major = fake_major;
 		fake_gendisk[n].first_minor = n << UBD_SHIFT;
 		fake_gendisk[n].minor_shift = UBD_SHIFT;
-		fake_gendisk[n].fops = &ubd_fops;
+		fake_gendisk[n].fops = &ubd_blops;
 		sprintf(fake_gendisk[n].disk_name, "ubd%d", n);
 	}
 
@@ -445,7 +445,7 @@
  	if(real == NULL) return(-1);
  	ubd_dev[n].real = real;
  
-	make_ide_entries(ubd_gendisk[n].name);
+	make_ide_entries(ubd_gendisk[n].disk_name);
 	return(0);
 }
 
@@ -863,6 +863,7 @@
 			return(-EFAULT);
 		return(0);
 	}
+	return -ENOTTY;
 }
 
 static int ubd_revalidate(kdev_t rdev)
