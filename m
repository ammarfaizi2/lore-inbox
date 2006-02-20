Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWBTQyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWBTQyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWBTQyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:54:52 -0500
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:45699 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1161030AbWBTQyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:54:51 -0500
Message-ID: <43F9F45D.20000@keyaccess.nl>
Date: Mon, 20 Feb 2006 17:54:53 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: snd-cs4236 (possibly all isa-pnp cards or all alsa isa-pnp cards)
 broken in 2.6.16-rc4
Content-Type: multipart/mixed;
 boundary="------------080709070608060602050800"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709070608060602050800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

I noticed on 2.6.16-rc4 that my MPU-401 wasn't functional, due to a 
simple copy & paste error in sound/isa/cs423x/cs4236.c:

Index: local/sound/isa/cs423x/cs4236.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4236.c        2006-02-11 
00:34:12.000000000 +0100
+++ local/sound/isa/cs423x/cs4236.c     2006-02-20 04:01:29.000000000 +0100
@@ -414,7 +414,7 @@ static int __devinit snd_card_cs423x_pnp
         }
         /* MPU initialization */
         if (acard->mpu && mpu_port[dev] > 0) {
-               if (snd_cs423x_pnp_init_mpu(dev, acard->ctrl, cfg) < 0)
+               if (snd_cs423x_pnp_init_mpu(dev, acard->mpu, cfg) < 0)
                         goto error;
         }
         kfree(cfg);

Please apply. However, when I tested it (mpu works fine again after 
this) I noticed that modprobe -r snd-cs4236 didn't release things -- 
specifically that the fixed index=1 I have for the card failed on a 
subsequent modprobe since ALSA believes that index is still taken.

I stuck a few printks in cs4236.c. From "snd_cs423x_unregister_all", 
"pnp_unregister_card_driver(&cs423x_pnpc_driver)" is indeed being called 
but the card driver's own remove method, snd_cs423x_pnpc_remove, is not.

I started looking, but ran into the next issue again -- when snd-cs4236 
is not card1 but card0, modprobe -r oopses in snd_timer_free (attached) 
meaning debugging this wants someone with more of an overview of recent 
damage done^W^Wchanges made.

Given that calling pnp_unregister_card_driver() is not cs4236 specific, 
I assume the problem is more general. Possibly all ALSA ISA-PnP drivers. 
Or, given that pnp_unregister_card_driver is not an ALSA function, maybe 
even all ISA-PnP drivers using the card_driver interface.

The more general this problem turns out, the more reason there would be 
for fixing this pre 2.6.16, obviously. I can test patches...

Rene.



--------------080709070608060602050800
Content-Type: text/plain;
 name="oops"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="oops"

cG5wOiBEZXZpY2UgMDE6MDEuMDMgZGlzYWJsZWQuCnBucDogRGV2aWNlIDAxOjAxLjAyIGRp
c2FibGVkLgpBTFNBIHNvdW5kL2lzYS9jczQyM3gvY3M0MjMxX2xpYi5jOjIwODogaW46IGF1
dG8gY2FsaWJyYXRpb24gdGltZSBvdXQgLSByZWcgPSAweDE4CkFMU0Egc291bmQvaXNhL2Nz
NDIzeC9jczQyMzFfbGliLmM6MTg3OiBvdXQ6IGF1dG8gY2FsaWJyYXRpb24gdGltZSBvdXQg
LSByZWcgPSAweDEwLCB2YWx1ZSA9IDB4ODAKQUxTQSBzb3VuZC9pc2EvY3M0MjN4L2NzNDIz
MV9saWIuYzoxNDk6IG91dG06IGF1dG8gY2FsaWJyYXRpb24gdGltZSBvdXQgLSByZWcgPSAw
eDE4LCB2YWx1ZSA9IDB4MApwbnA6IERldmljZSAwMTowMS4wMCBkaXNhYmxlZC4KcG5wOiB0
aGUgZHJpdmVyICdjczQyMzZfaXNhcG5wJyBoYXMgYmVlbiB1bnJlZ2lzdGVyZWQKQUxTQSBz
b3VuZC9jb3JlL3NlcS9zZXFfZGV2aWNlLmM6NTc0OiBkcml2ZXJzIG5vdCByZWxlYXNlZCAo
MikKVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBh
ZGRyZXNzIGYwOWM2MDU4CiBwcmludGluZyBlaXA6CmYwOWM2MDU4CipwZGUgPSAwMTZkNjA2
NwoqcHRlID0gMDAwMDAwMDAKT29wczogMDAwMCBbIzFdClBSRUVNUFQgCk1vZHVsZXMgbGlu
a2VkIGluOiBzbmRfdGltZXIgc25kIHNvdW5kY29yZSBzbmRfcGFnZV9hbGxvYyBtZ2EgYW1k
X2s3X2FncCBkcm0gYWdwZ2FydCBuZnNkIGV4cG9ydGZzIGxvY2tkIHN1bnJwYyBubHNfaXNv
ODg1OV8xIG5sc19jcDQzNyB2ZmF0IGZhdCBubHNfYmFzZQpDUFU6ICAgIDAKRUlQOiAgICAw
MDYwOls8ZjA5YzYwNTg+XSAgICBOb3QgdGFpbnRlZCBWTEkKRUZMQUdTOiAwMDAxMDI4MiAg
ICgyLjYuMTYtcmM0LWxvY2FsICM4KSAKRUlQIGlzIGF0IDB4ZjA5YzYwNTgKZWF4OiBlYzIw
ZjQwMCAgIGVieDogZWMyMGY0MDAgICBlY3g6IGVjMjBmNGU4ICAgZWR4OiBmMDljNjA1OApl
c2k6IGI3ZjA0MTdjICAgZWRpOiAwMDAwMDAwMCAgIGVicDogZTYyN2EwMDAgICBlc3A6IGU2
MjdhZjU0CmRzOiAwMDdiICAgZXM6IDAwN2IgICBzczogMDA2OApQcm9jZXNzIG1vZHByb2Jl
IChwaWQ6IDEzNTksIHRocmVhZGluZm89ZTYyN2EwMDAgdGFzaz1lODI5MWFkMCkKU3RhY2s6
IDwwPmYwOWIyMGYyIGU2MjYxMGU4IGYwOWIzYzIwIGYwOWI1YmMwIGMwMTI2NTI5IDAwMDAw
MDAwIDVmNjQ2ZTczIDY1NmQ2OTc0IAogICAgICAgYzAxMzAwNzIgZmZmZmZmZmYgZTY1ZDMy
MmMgYjdmMTQwMDAgYzAxMzdmNmMgYjdmMTMwMDAgYjdmMTQwMDAgYjdmMTQwMDAgCiAgICAg
ICBlNjVkMzNlNCBlZjEyY2FlMCBlZjEyY2IxMCBmZmZmMDAwMSAwMDI3YTAwMCBjMDEzN2Zh
ZSAwODA1YzNmOCBiN2YwNDE3YyAKQ2FsbCBUcmFjZToKIFs8ZjA5YjIwZjI+XSBzbmRfdGlt
ZXJfZnJlZSsweDNiLzB4NDYgW3NuZF90aW1lcl0KIFs8ZjA5YjNjMjA+XSBhbHNhX3RpbWVy
X2V4aXQrMHgyNy8weDQyIFtzbmRfdGltZXJdCiBbPGMwMTI2NTI5Pl0gc3lzX2RlbGV0ZV9t
b2R1bGUrMHgxMmIvMHgxNTUKIFs8YzAxMzAwNzI+XSBfX3BkZmx1c2grMHgxOTYvMHgxYWMK
IFs8YzAxMzdmNmM+XSBkb19tdW5tYXArMHhlMi8weGVmCiBbPGMwMTM3ZmFlPl0gc3lzX211
bm1hcCsweDM1LzB4NGQKIFs8YzAxMDI1NTE+XSBzeXNjYWxsX2NhbGwrMHg3LzB4YgpDb2Rl
OiAgQmFkIEVJUCB2YWx1ZS4K
--------------080709070608060602050800--
