Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbTICX2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264350AbTICX2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:28:55 -0400
Received: from smtp01.web.de ([217.72.192.180]:58404 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264312AbTICX2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:28:51 -0400
From: "Mehmet Ceyran" <mceyran@web.de>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@lxorguk.ukuu.org.uk>
Subject: drivers/sound/i810_audio.c bug and patch
Date: Thu, 4 Sep 2003 01:31:40 +0200
Message-ID: <005d01c37273$88183840$0100a8c0@server1>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005E_01C37284.4BE42BC0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200309031429.01672.m.c.p@wolk-project.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_005E_01C37284.4BE42BC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks to Jeff and Marc for your answers.

On my laptop (P4-2533, SiS 7012 onBoard sound) the i810 driver didn't
work in its shipped 2.4.23-pre2 and 2.4.22 (and probably below) form.
The kernel messages related to this were as follows:

---8<---
Intel 810 + AC97 Audio, version 0.24, 19:25:34 Aug 31 2003
PCI: Enabling device 00:02.7 (0000 -> 0001)
i810: SiS 7012 found at IO 0x1800 and 0x1c00, MEM 0x0000 and 0x0000, IRQ
10
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: CRY52 (Cirrus Logic CS4299 rev D)
i810_audio: timed out waiting for codec 0 analog ready.
--->8---

After hesitating for a while (I code in C/C++ and many more languages
but I've never been to kernel and drivers, YET ;) ) I decided to look at
the sources and fix the bug if I could.

I found out that the driver gives the sound chip 10 chances to become
ready and my sound chip fails to do that in time. The following patch
gives the chip 100 tries instead of 10:

---8<---
--- i810_audio.c	2003-09-02 13:58:02.000000000 +0200
+++ i810_audio.c.new	2003-09-02 13:58:12.000000000 +0200
@@ -2727,7 +2727,7 @@
 		      i810_ac97_get(codec, AC97_POWER_CONTROL) &
~0x7f00);
 
 	/* wait for analog ready */
-	for (i=10; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) &
0xf) != 0xf); i--)
+	for (i=100; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) &
0xf) != 0xf); i--)
 	{
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ/20);
--->8---

Well, why not? The loop will only go through it's body 100 times if the
hardware is actually not available or corrupt and even in this case the
whole block won't take much time. It works for me and it should work for
all the other people using this driver too:

---8<---
i810: SiS 7012 found at IO 0x1800 and 0x1c00, MEM 0x0000 and 0x0000, IRQ
10
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: CRY52 (Cirrus Logic CS4299 rev D)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
--->8---

Umm, the maintainers list says I should try to include credit lines.
Well yeah, I'd like to have my name and email address in the changelog
if this gets through to the kernel ;). And I'm really interested in
contributing more than just this to the kernel.

In hope for feedback,
Mehmet Ceyran

------=_NextPart_000_005E_01C37284.4BE42BC0
Content-Type: application/octet-stream;
	name="i810_audio.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="i810_audio.patch"

--- i810_audio.c	2003-09-02 13:58:02.000000000 +0200=0A=
+++ i810_audio.c.new	2003-09-02 13:58:12.000000000 +0200=0A=
@@ -2727,7 +2727,7 @@=0A=
 		      i810_ac97_get(codec, AC97_POWER_CONTROL) & ~0x7f00);=0A=
 =0A=
 	/* wait for analog ready */=0A=
-	for (i=3D10; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) & 0xf) =
!=3D 0xf); i--)=0A=
+	for (i=3D100; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) & 0xf) =
!=3D 0xf); i--)=0A=
 	{=0A=
 		set_current_state(TASK_UNINTERRUPTIBLE);=0A=
 		schedule_timeout(HZ/20);=0A=

------=_NextPart_000_005E_01C37284.4BE42BC0--

