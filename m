Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWGAXg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWGAXg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWGAXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:36:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62436 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932112AbWGAXg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:36:26 -0400
Message-ID: <44A706C4.7070908@zytor.com>
Date: Sat, 01 Jul 2006 16:35:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Miles Lane <miles.lane@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com> <1151788673.3195.58.camel@laptopd505.fenrus.org> <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com> <1151789342.3195.60.camel@laptopd505.fenrus.org> <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com> <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com> <20060701230635.GA19114@mars.ravnborg.org>
In-Reply-To: <20060701230635.GA19114@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------070506030503040206020404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070506030503040206020404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sam Ravnborg wrote:
> 
> For klibc you need to patch scripts/Kbuild.klibc
> 
> Appending it to KLIBCWARNFLAGS seems the right place.
> 
> Do you know from what gcc version we can start using -fno-stack-protector?
> 

Here is a patch for klibc.  Miles, could you try it out and see if it 
does what you need?

	-hpa


--------------070506030503040206020404
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/scripts/Kbuild.klibc b/scripts/Kbuild.klibc
index ac0439e..d30ada2 100644
--- a/scripts/Kbuild.klibc
+++ b/scripts/Kbuild.klibc
@@ -48,7 +48,7 @@ include $(srctree)/scripts/Kbuild.includ
 # Defines used when compiling early userspace (klibc programs)
 # ---------------------------------------------------------------------------
 
-KLIBCREQFLAGS     :=
+KLIBCREQFLAGS     := $(call cc_option, -fno-stack-protector, )
 KLIBCARCHREQFLAGS :=
 KLIBCOPTFLAGS     :=
 KLIBCWARNFLAGS    := -W -Wall -Wno-sign-compare -Wno-unused-parameter
diff --git a/usr/klibc/arch/arm/MCONFIG b/usr/klibc/arch/arm/MCONFIG
index 0023eee..fa3ada2 100644
--- a/usr/klibc/arch/arm/MCONFIG
+++ b/usr/klibc/arch/arm/MCONFIG
@@ -12,7 +12,7 @@ CPU_TUNE := strongarm
 
 KLIBCOPTFLAGS = -Os -march=$(CPU_ARCH) -mtune=$(CPU_TUNE)
 KLIBCBITSIZE  = 32
-KLIBCREQFLAGS = -fno-exceptions
+KLIBCREQFLAGS += -fno-exceptions
 KLIBCSTRIPFLAGS += -R .ARM.exidx
 
 ifeq ($(CONFIG_KLIBC_THUMB),y)

--------------070506030503040206020404--
