Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269188AbRHBWUm>; Thu, 2 Aug 2001 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269183AbRHBWUe>; Thu, 2 Aug 2001 18:20:34 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:28795 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269178AbRHBWUZ>;
	Thu, 2 Aug 2001 18:20:25 -0400
Message-Id: <200108022220.AAA1547023@mail.takas.lt>
Date: Fri, 3 Aug 2001 00:16:00 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Fw: PATCH: creating devices for multiple sound cards
To: linux-kernel@vger.kernel.org, Chris Rankin <rankinc@pacbell.net>,
        linux-sound@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Why this patch was not applied (I checked 2.4.7)?

------ Forwarded message ------
From: Chris Rankin <rankinc@pacbell.net>
Date: Sat, 14 Apr 2001 09:44:35 +0200
Subject: PATCH: creating devices for multiple sound cards
To: linux-sound@vger.kernel.org

Hi,
I have just installed a new sound card in my machine, and have left
the built-in sound chip enabled despite the motherboard manufacturer's
warning of Bad Things. The result is that I now have two sound devices
in my machine - an ICH (i810_audio) and a Soundblaster Live! The Live!
is device 0, of course. Anyway, I am using the ALSA drivers because
the native i810_audio module caused a kernel panic (NULL pointer
reference in an interrupt handler, I believe), and I have noticed that
the ALSA drivers have difficulty creating OSS device nodes for both
cards. I have traced the problem to the register_sound_special()
function within Linux's soundcore.o module. Basically, ALSA uses this
function to create OSS devices, but this function was never written
with more than one sound device in mind. Until now.

A few points about this patch:

1. I have renamed "sequencer2" to "music" because of a potential naming
conflict between devices 14,8 ("music" on card 0) and 14,33 ("sequencer"
on card 2).

2. I have renamed device "midi00" to "midi". "midi01" now becomes "midi1"
as well, although I would also point out that this is now consistent with
the behaviour of the register_sound_midi() function.

Having applied this patch, ALSA gives me two mixer devices in /dev/sound,
and I no longer get messages like these in my logs:

Apr 12 01:36:54 (none) kernel: devfs: devfs_register(): device already registered: "unknown"

Apr 12 01:40:04 (none) kernel: devfs: devfs_register(): device already registered: "mixer"
Apr 12 01:40:04 (none) kernel: devfs: devfs_register(): device already registered: "dsp"

Cheers,
Chris

--- linux-2.4.3/drivers/sound/sound_core.c.orig        Fri Mar 16 23:00:44 2001
+++ linux-2.4.3/drivers/sound/sound_core.c        Sat Apr 14 00:13:18 2001
@@ -227,9 +227,10 @@
  
 int register_sound_special(struct file_operations *fops, int unit)
 {
-        char *name;
+        const char *name;
+        const int minor = (unit & 15);

-        switch (unit) {
+        switch (minor) {
             case 0:
                 name = "mixer";
                 break;
@@ -237,7 +238,7 @@
                 name = "sequencer";
                 break;
             case 2:
-                name = "midi00";
+                name = "midi";
                 break;
             case 3:
                 name = "dsp";
@@ -255,7 +256,7 @@
                 name = "unknown7";
                 break;
             case 8:
-                name = "sequencer2";
+                name = "music";
                 break;
             case 9:
                 name = "dmmidi";
@@ -279,7 +280,7 @@
                 name = "unknown";
                 break;
         }
-        return sound_insert_unit(&chains[unit&15], fops, -1, unit, unit+1,
+        return sound_insert_unit(&chains[minor], fops, -1, minor, minor+128,
                                  name, S_IRUSR | S_IWUSR);
 }
  

To unsubscribe from this list: send the line "unsubscribe linux-sound" in
the body of a message to majordomo@vger.kernel.org

-------- End of message -------

