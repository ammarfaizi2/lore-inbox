Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271836AbRIUIKG>; Fri, 21 Sep 2001 04:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271940AbRIUIJ6>; Fri, 21 Sep 2001 04:09:58 -0400
Received: from [194.8.76.131] ([194.8.76.131]:14092 "HELO imap.camline.com")
	by vger.kernel.org with SMTP id <S271924AbRIUIJw>;
	Fri, 21 Sep 2001 04:09:52 -0400
Date: Fri, 21 Sep 2001 10:16:25 +0200 (CEST)
From: Matthias Hanisch <matze@camline.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: fix for soundblaster module oops at rmmod time (fwd)
Message-ID: <Pine.LNX.4.10.10109211011350.4204-200000@homer.camline.com>
Organization: camLine Datensysteme fuer die Mikroelektronik
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-1463781119-750330687-1000998586=:4204"
Content-ID: <Pine.LNX.4.10.10109201710110.4204@homer.camline.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463781119-750330687-1000998586=:4204
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.10.10109201710111.4204@homer.camline.com>

[ I sent this to linux-sound yesterday. Nerijus Baliunas
  <nerijus@users.sourceforge.net> asked me to forward this also to
  linux-kernel. So here it is.
] 

Hi!

Soundblaster module in version 2.4.10-pre12 and many (pre-)patches before
oopsed in sb_dsp_unload at the module deletion phase.

Loading the module reports

Sep 17 23:08:05 pingu kernel: <Sound Blaster (8 BIT/MONO ONLY) (2.01)> at
0x220 irq 5 dma 1>

so sb_mixer_init() is not called, because devc->major == 2.

Problem is that at "module deletion time", the call to sb_mixer_unload()
is unconditional and a

        kfree(mixer_devs[devc->my_mixerdev]);

is not very healthy if devc->my_mixerdev == -1 (the initial value).

This kfree() call without checking the array index got introduced in
2.4.8, sound_unload_mixerdev() which is called after kfree() contains a
check for devc->my_mixerdev != -1.

The attached patch cures this, it just introduces this check. It should
apply to any recent kernel.

Regards,

        Matze

-- 
Matthias Hanisch    mailto:matze@camline.com    phone: +49 8137 935-219


---1463781119-750330687-1000998586=:4204
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sb-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10109211016250.4204@homer.camline.com>
Content-Description: 
Content-Disposition: attachment; filename="sb-fix.patch"

ZGlmZiAtcnUgbGludXgvZHJpdmVycy9zb3VuZC9zYl9taXhlci5jIGxpbnV4
LW1hdHplL2RyaXZlcnMvc291bmQvc2JfbWl4ZXIuYw0KLS0tIGxpbnV4L2Ry
aXZlcnMvc291bmQvc2JfbWl4ZXIuYwlNb24gU2VwIDE3IDIzOjM2OjM4IDIw
MDENCisrKyBsaW51eC1tYXR6ZS9kcml2ZXJzL3NvdW5kL3NiX21peGVyLmMJ
VHVlIFNlcCAxOCAwMDozOTo0NyAyMDAxDQpAQCAtNzQ4LDYgKzc0OCw5IEBA
DQogDQogdm9pZCBzYl9taXhlcl91bmxvYWQoc2JfZGV2YyAqZGV2YykNCiB7
DQorCWlmIChkZXZjLT5teV9taXhlcmRldiA9PSAtMSkNCisJCXJldHVybjsN
CisNCiAJa2ZyZWUobWl4ZXJfZGV2c1tkZXZjLT5teV9taXhlcmRldl0pOw0K
IAlzb3VuZF91bmxvYWRfbWl4ZXJkZXYoZGV2Yy0+bXlfbWl4ZXJkZXYpOw0K
IAlzYm1peG51bS0tOw0K
---1463781119-750330687-1000998586=:4204--
