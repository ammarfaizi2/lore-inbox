Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278662AbRKSMpZ>; Mon, 19 Nov 2001 07:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRKSMpQ>; Mon, 19 Nov 2001 07:45:16 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:2311 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278625AbRKSMpE>;
	Mon, 19 Nov 2001 07:45:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mark Orr <markorr@intersurf.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.15pre6] Funny error on "make modules_install" - cosmetic cleanup probably needed 
In-Reply-To: Your message of "Mon, 19 Nov 2001 02:32:58 MDT."
             <20011119023258.4bb705b0.markorr@intersurf.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Nov 2001 23:44:50 +1100
Message-ID: <5682.1006173890@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001 02:32:58 -0600, 
Mark Orr <markorr@intersurf.com> wrote:
>make[2]: Entering directory `/usr/src/linux/drivers/cdrom'
>mkdir -p /lib/modules/2.4.15-pre6/kernel/drivers/cdrom/
>cp cdrom.o cdrom.o /lib/modules/2.4.15-pre6/kernel/drivers/cdrom/
>cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/cdrom/cdrom.o' with `cdrom.o'

There are several places where a module gets installed twice, because
of the way that module objects are selected in 2.4 (2.5 does not have
this feature).  The fix is easy but it should not be necessary.  IMNSHO
it is *wrong* for fileutils to decide that it will not copy a file
twice, cp should do what the user asked.  Complain to the fileutils
maintainer as a first step.

Work around for unexpected cp behaviour, against 2.4.14, untested.

Index: 14.1/Rules.make
--- 14.1/Rules.make Wed, 07 Mar 2001 23:04:43 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2 644)
+++ 14.1(w)/Rules.make Mon, 19 Nov 2001 23:42:58 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2 644)
@@ -173,7 +173,7 @@ modules: $(ALL_MOBJS) dummy \
 _modinst__: dummy
 ifneq "$(strip $(ALL_MOBJS))" ""
 	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
-	cp $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
+	cp $(sort $(ALL_MOBJS)) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
 endif
 
 .PHONY: modules_install



