Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUD2Spg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUD2Spg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUD2Spg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:45:36 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:47567 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264922AbUD2Spc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:45:32 -0400
Date: Thu, 29 Apr 2004 14:45:30 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
cc: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Bogus "has no CRC" in external module builds
Message-ID: <Pine.LNX.4.58.0404291246220.7129@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-47850404-1083264330=:20280"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-47850404-1083264330=:20280
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

The recent fixes for the external module build have fixed the major
breakage, but they left one annoyance unfixed.  If CONFIG_MODVERSIONS is
disabled, a warning is printed for every exported symbol that is has no
CRC.  For instance, I see this when compiling the standalone Orinoco
driver on Linux 2.6.6-rc3:

*** Warning: "__orinoco_down" [/usr/local/src/orinoco/spectrum_cs.ko] has
no CRC!
*** Warning: "hermes_struct_init" [/usr/local/src/orinoco/spectrum_cs.ko]
has no CRC!
*** Warning: "free_orinocodev" [/usr/local/src/orinoco/spectrum_cs.ko] has
no CRC!
[further warnings skipped]

I have found that the "-i" option for modpost is used for external builds,
whereas the internal modules use "-o".  The "-i" option causes read_dump()
in modpost.c to be called.  This function sets "modversions" variable
under some conditions that I don't understand.  The comment before the
modversions declarations says: "Are we using CONFIG_MODVERSIONS?"

Apparently modpost fails to answer this question.  I think it's better to
use an explicit option rather than a kludge.

The attached patch adds a new option "-m" that is specified if and only if
CONFIG_MODVERSIONS is enabled.  The patch has been successfully tested
both with and without CONFIG_MODVERSIONS.

-- 
Regards,
Pavel Roskin
--8323328-47850404-1083264330=:20280
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="modpost_crc.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0404291445300.20280@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="modpost_crc.diff"

LS0tIGxpbnV4Lm9yaWcvc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0DQorKysg
bGludXgvc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0DQpAQCAtNTEsOCArNTEs
OCBAQA0KICMgIEluY2x1ZGVzIHN0ZXAgMyw0DQogcXVpZXRfY21kX21vZHBv
c3QgPSBNT0RQT1NUDQogICAgICAgY21kX21vZHBvc3QgPSBzY3JpcHRzL21v
ZHBvc3QgXA0KLQkkKGlmICQoS0JVSUxEX0VYVE1PRCksLWksLW8pICQoc3lt
dmVyZmlsZSkgXA0KLQkkKGZpbHRlci1vdXQgRk9SQ0UsJF4pDQorCSQoaWYg
JChDT05GSUdfTU9EVkVSU0lPTlMpLC1tKSAkKGlmICQoS0JVSUxEX0VYVE1P
RCksLWksLW8pIFwNCisJJChzeW12ZXJmaWxlKSAkKGZpbHRlci1vdXQgRk9S
Q0UsJF4pDQogDQogLlBIT05ZOiBfX21vZHBvc3QNCiBfX21vZHBvc3Q6ICQo
d2lsZGNhcmQgdm1saW51eCkgJChtb2R1bGVzOi5rbz0ubykgRk9SQ0UNCi0t
LSBsaW51eC5vcmlnL3NjcmlwdHMvbW9kcG9zdC5jDQorKysgbGludXgvc2Ny
aXB0cy9tb2Rwb3N0LmMNCkBAIC0zNDIsNyArMzQyLDYgQEAgaGFuZGxlX21v
ZHZlcnNpb25zKHN0cnVjdCBtb2R1bGUgKm1vZCwgcw0KIAkJCWNyYyA9ICh1
bnNpZ25lZCBpbnQpIHN5bS0+c3RfdmFsdWU7DQogCQkJYWRkX2V4cG9ydGVk
X3N5bWJvbChzeW1uYW1lICsgc3RybGVuKENSQ19QRlgpLA0KIAkJCQkJICAg
IG1vZCwgJmNyYyk7DQotCQkJbW9kdmVyc2lvbnMgPSAxOw0KIAkJfQ0KIAkJ
YnJlYWs7DQogCWNhc2UgU0hOX1VOREVGOg0KQEAgLTY0OCw3ICs2NDcsNiBA
QCByZWFkX2R1bXAoY29uc3QgY2hhciAqZm5hbWUpDQogDQogCQlpZiAoISht
b2QgPSBmaW5kX21vZHVsZShtb2RuYW1lKSkpIHsNCiAJCQlpZiAoaXNfdm1s
aW51eChtb2RuYW1lKSkgew0KLQkJCQltb2R2ZXJzaW9ucyA9IDE7DQogCQkJ
CWhhdmVfdm1saW51eCA9IDE7DQogCQkJfQ0KIAkJCW1vZCA9IG5ld19tb2R1
bGUoTk9GQUlMKHN0cmR1cChtb2RuYW1lKSkpOw0KQEAgLTY5NSwxMSArNjkz
LDE0IEBAIG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KIAljaGFyICpk
dW1wX3JlYWQgPSBOVUxMLCAqZHVtcF93cml0ZSA9IE5VTEw7DQogCWludCBv
cHQ7DQogDQotCXdoaWxlICgob3B0ID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJp
Om86IikpICE9IC0xKSB7DQorCXdoaWxlICgob3B0ID0gZ2V0b3B0KGFyZ2Ms
IGFyZ3YsICJpOm1vOiIpKSAhPSAtMSkgew0KIAkJc3dpdGNoKG9wdCkgew0K
IAkJCWNhc2UgJ2knOg0KIAkJCQlkdW1wX3JlYWQgPSBvcHRhcmc7DQogCQkJ
CWJyZWFrOw0KKwkJCWNhc2UgJ20nOg0KKwkJCQltb2R2ZXJzaW9ucyA9IDE7
DQorCQkJCWJyZWFrOw0KIAkJCWNhc2UgJ28nOg0KIAkJCQlkdW1wX3dyaXRl
ID0gb3B0YXJnOw0KIAkJCQlicmVhazsNCg==

--8323328-47850404-1083264330=:20280--
