Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280744AbRKSWAu>; Mon, 19 Nov 2001 17:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280748AbRKSWAj>; Mon, 19 Nov 2001 17:00:39 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:55761 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S280744AbRKSWAa>; Mon, 19 Nov 2001 17:00:30 -0500
Message-ID: <3BF980F6.6080503@lucent.com>
Date: Mon, 19 Nov 2001 17:00:22 -0500
From: John Ellson <ellson@lucent.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] "make modules_install" breaks with new /bin/cp
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.4.15-pre6, fileutils-4.1.1-1.i386.rpm

With my configuration (details not important), "make modules_install" results in:

mkdir -p /lib/modules/2.4.15-pre6/kernel/drivers/sound/
cp soundcore.o sound.o cs4232.o ad1848.o pss.o ad1848.o mpu401.o cs4232.o uart401.o ad1848.o mpu401.o uart6850.o 
v_midi.o btaudio.o /lib/modules/2.4.15-pre6/kernel/drivers/sound/
cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/ad1848.o' with `ad1848.o'
cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/cs4232.o' with `cs4232.o'
cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/ad1848.o' with `ad1848.o'
cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/mpu401.o' with `mpu401.o'
make[2]: *** [_modinst__] Error 1

This hasn't been a problem with earlier version of /bin/cp (upto fileutils-4.1-4.i386.rpm in RH7.2),
but /bin/cp from fileutils-4.1.1-1.i386.rpm (in the Rawhide collection) is more pedantic about
multiple copies of the same file.

This patch works around this "feature".  It would be better if the Makefiles were changed to only
install modules once, but thats a deeper problem.



--- Rules.make.orig	Mon Nov 19 16:49:55 2001
+++ Rules.make	Mon Nov 19 16:50:20 2001
@@ -173,7 +173,7 @@
  _modinst__: dummy
  ifneq "$(strip $(ALL_MOBJS))" ""
  	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
- 
cp $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
+ 
for i in $(ALL_MOBJS);do cp $$i $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET);done
  endif

  .PHONY: modules_install

	


-- 
John Ellson (ellson@lucent.com)  Lucent Technologies, Holmdel, NJ, 07733

