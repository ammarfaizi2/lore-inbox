Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbULTWeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbULTWeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULTWeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:34:44 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:33420 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261670AbULTWeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:34:37 -0500
Date: Mon, 20 Dec 2004 23:34:35 +0100 (CET)
From: Bernhard Ager <ager@in.tum.de>
X-X-Sender: bernhard@tuvok.enterprise
To: Joshua Wise <joshua@joshuawise.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Joystick not found on Linux/amd64
In-Reply-To: <41C6420F.10109@joshuawise.com>
Message-ID: <Pine.LNX.4.58.0412202308520.8620@tuvok.enterprise>
References: <Pine.LNX.4.58.0412200235440.6947@tuvok.enterprise>
 <41C6420F.10109@joshuawise.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2831158017-840667041-1103582075=:8620"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2831158017-840667041-1103582075=:8620
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 19 Dec 2004, Joshua Wise wrote:

> As far as I can tell, the problem is that my code uses the joystick 
> ioctls to get the version, passing it a 32-bit address to return the 
> version into. 

I have a long night behind me, and here is, what I found out:

It's about the ioctls, because they need to be marked compatible for a 
32bit call or a wrapper has to be written, otherwise the ioctl handler 
will not even be called.

Marking compatible can be done with this <patch> 

diff -ur linux-2.6.9-gentoo-r1/arch/x86_64/ia32/ia32_ioctl.c linux-2.6.9-gentoo-r1-js/arch/x86_64/ia32/ia32_ioctl.c
--- linux-2.6.9-gentoo-r1/arch/x86_64/ia32/ia32_ioctl.c 2004-12-20 22:58:20.000000000 +0100
+++ linux-2.6.9-gentoo-r1-js/arch/x86_64/ia32/ia32_ioctl.c      2004-12-20 22:19:36.000000000 +0100
@@ -174,6 +174,10 @@
 COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain */
 COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
 COMPATIBLE_IOCTL(FIOQSIZE)
+COMPATIBLE_IOCTL(JSIOCGVERSION)
+COMPATIBLE_IOCTL(JSIOCGAXES)
+COMPATIBLE_IOCTL(JSIOCGBUTTONS)
+COMPATIBLE_IOCTL(JSIOCGNAME(0x200))  /* for X-Plane 8.03 */
 
 /* And these ioctls need translation */
 HANDLE_IOCTL(TIOCGDEV, tiocgdev)
diff -ur linux-2.6.9-gentoo-r1/fs/compat_ioctl.c linux-2.6.9-gentoo-r1-js/fs/compat_ioctl.c
--- linux-2.6.9-gentoo-r1/fs/compat_ioctl.c     2004-12-20 22:58:20.000000000 +0100
+++ linux-2.6.9-gentoo-r1-js/fs/compat_ioctl.c  2004-12-20 21:48:37.000000000 +0100
@@ -11,6 +11,7 @@
  */
 
 #ifdef INCLUDES
+#include <linux/joystick.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/compat.h>

</patch>

Making a special case for JSIOCGNAME(0x200) is very nasty (0x200 is the
return buffer length, coded into the ioctl number), but I don't know how
to work around this in an elegant way.

As my test program (attached) shows, the patch actually works. (Compile 
with -m32 or in a 32bit chroot/on a real x86). However, X-Plane does not 
work correctly yet: It recognizes a joystick and the buttons are working, 
but the axes don't. Joshua: if you send me your joystick code, I'll gladly 
take a look at it.


Greetings,
  Bernhard
-- 
Isn't making a smoking section in a restaurant like making a peeing
section in a swimming pool?
--2831158017-840667041-1103582075=:8620
Content-Type: TEXT/x-csrc; charset=US-ASCII; name="joystick.c"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="joystick.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNs
dWRlIDxzeXMvaW9jdGwuaD4NCiNpbmNsdWRlIDxsaW51eC9qb3lzdGljay5o
Pg0KDQovKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnVuY3Rp
b24gICAgICAgICAgICAgICAgICAgICAzcmQgYXJnICAgKi8NCi8qICAgICAg
ICNkZWZpbmUgSlNJT0NHQVhFUyAgICAgICBnZXQgbnVtYmVyIG9mIGF4ZXMg
ICAgICAgICAgIGNoYXIgICAgICAqLw0KLyogICAgICAgI2RlZmluZSBKU0lP
Q0dCVVRUT05TICAgIGdldCBudW1iZXIgb2YgYnV0dG9ucyAgICAgICAgY2hh
ciAgICAgICovDQovKiAgICAgICAjZGVmaW5lIEpTSU9DR1ZFUlNJT04gICAg
Z2V0IGRyaXZlciB2ZXJzaW9uICAgICAgICAgICBpbnQgICAgICAgKi8NCi8q
ICAgICAgICNkZWZpbmUgSlNJT0NHTkFNRShsZW4pICBnZXQgaWRlbnRpZmll
ciBzdHJpbmcgICAgICAgIGNoYXIgICAgICAqLw0KLyogICAgICAgI2RlZmlu
ZSBKU0lPQ1NDT1JSICAgICAgIHNldCBjb3JyZWN0aW9uIHZhbHVlcyAgICAg
ICAgJmpzX2NvcnIgICovDQovKiAgICAgICAjZGVmaW5lIEpTSU9DR0NPUlIg
ICAgICAgZ2V0IGNvcnJlY3Rpb24gdmFsdWVzICAgICAgICAmanNfY29yciAg
Ki8NCg0KDQppbnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KSB7DQog
IGNoYXIgbnVtYmVyX29mX2F4ZXMsIG51bWJlcl9vZl9idXR0b25zLCBqc19u
YW1lWzB4MjAwXTsNCiAgaW50IHZlcnNpb247DQogIHN0cnVjdCBqc19ldmVu
dCBlOw0KICBzaXplX3Qgc2l6ZTsgDQogIGludCBqczsNCg0KLyogICBwcmlu
dGYgKCJWYWx1ZSBvZiBKU0lPQ0dBWEVTID0gJXVcbiIsIEpTSU9DR0FYRVMp
OyAqLw0KLyogICBwcmludGYgKCJWYWx1ZSBvZiBKU0lPQ0dCVVRUT05TID0g
JXVcbiIsIEpTSU9DR0JVVFRPTlMpOyAqLw0KLyogICBwcmludGYgKCJWYWx1
ZSBvZiBKU0lPQ0dWRVJTSU9OID0gJXVcbiIsIEpTSU9DR1ZFUlNJT04pOyAq
Lw0KLyogICBwcmludGYgKCJWYWx1ZSBvZiBKU0lPQ0dOQU1FKDB4MjAwKSA9
ICV4XG4iLCBKU0lPQ0dOQU1FKDB4MjAwKSk7ICovDQoNCiAganMgPSBvcGVu
ICgiL2Rldi9qczAiLCBPX1JET05MWSk7DQogIA0KICBpZiAoaW9jdGwgKGpz
LCBKU0lPQ0dBWEVTLCAmbnVtYmVyX29mX2F4ZXMpID09IC0xKSB7DQogICAg
cGVycm9yKCJKU0lPQ0dBWEVTIik7DQogICAgbnVtYmVyX29mX2F4ZXMgPSAt
MTsNCiAgfQ0KICBpZiAoaW9jdGwgKGpzLCBKU0lPQ0dCVVRUT05TLCAmbnVt
YmVyX29mX2J1dHRvbnMpID09IC0xKSB7DQogICAgcGVycm9yKCJKU0lPQ0dC
VVRUT05TIik7DQogICAgbnVtYmVyX29mX2J1dHRvbnMgPSAtMTsNCiAgfQ0K
ICBpZiAoaW9jdGwgKGpzLCBKU0lPQ0dWRVJTSU9OLCAmdmVyc2lvbikgPT0g
LTEpIHsNCiAgICBwZXJyb3IoIkpTSU9DR1ZFUlNJT04iKTsNCiAgICB2ZXJz
aW9uID0gLTE7DQogIH0NCiAgaWYgKGlvY3RsIChqcywgSlNJT0NHTkFNRSgw
eDIwMCksIGpzX25hbWUpID09IC0xKSB7DQogICAgcGVycm9yKCJKU0lPQ0dO
QU1FKDB4MjAwKSIpOw0KICAgIHN0cmNweSAoanNfbmFtZSwgIlVua25vd24i
KTsNCiAgfQ0KDQogIHByaW50ZiAoIkF4ZXM6ICUzZCAgQnV0dG9uczogJTNk
ICBWZXJzaW9uOiAlZCAgTmFtZTogJXNcbiIsDQogICAgICAgICAgbnVtYmVy
X29mX2F4ZXMsIG51bWJlcl9vZl9idXR0b25zLCB2ZXJzaW9uLCBqc19uYW1l
KTsNCg0KICB3aGlsZSAoc2l6ZSA9IHJlYWQgKGpzLCAmZSwgc2l6ZW9mKHN0
cnVjdCBqc19ldmVudCkpKSB7DQogICAgaWYgKHNpemUgIT0gc2l6ZW9mKHN0
cnVjdCBqc19ldmVudCkpIHsNCiAgICAgIHByaW50ZiAoInJlYWQgZmFpbGVk
LCBkYXRhIHRvbyBzbWFsbCIpOw0KICAgICAgYnJlYWs7DQogICAgfQ0KICAg
IHByaW50ZigidGltZTogJTl1ICB2YWx1ZTogJTZkICB0eXBlOiAlM3UgIG51
bWJlcjogICUydVxyIiwNCiAgICAgICAgICAgZS50aW1lLCBlLnZhbHVlLCBl
LnR5cGUsIGUubnVtYmVyKTsNCiAgICBmZmx1c2goc3Rkb3V0KTsNCiAgfQ0K
ICANCiAgY2xvc2UoanMpOw0KDQp9DQo=

--2831158017-840667041-1103582075=:8620--
