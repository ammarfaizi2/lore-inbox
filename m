Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbQLLBpe>; Mon, 11 Dec 2000 20:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131685AbQLLBpZ>; Mon, 11 Dec 2000 20:45:25 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:43802 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131444AbQLLBpM>;
	Mon, 11 Dec 2000 20:45:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Fr d ric L. W. Meunier" <0@pervalidus.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: warning during make modules 
In-Reply-To: Your message of "Mon, 11 Dec 2000 21:42:14 -0200."
             <20001211214214.B1245@pervalidus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Dec 2000 12:14:28 +1100
Message-ID: <3350.976583668@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000 21:42:14 -0200, 
Fr d ric L . W . Meunier <0@pervalidus.net> wrote:
>Is this a 2.4.0 issue? Because I see the warnings on 2.2.18
>too, and also building alsa-driver. I use modutils 2.3.22.
>binutils 2.10.1.0.2. glibc 2.2.

The kernel is trying to fudge the section flags for .modinfo to prevent
.modinfo being loaded as part of a module.  This works on older
toolchains, it even works on recent toolchains but now you get an
annoying warning.  modutils >= 2.3.19 has special case code for
.modinfo so the kernel fudge is no longer required.

The 2.4 kernel will be patched to remove the warning in my next set of
module changes, probably 2.4.1.  The 2.2 kernel will _not_ be patched
because that would force all 2.2 users to upgrade their user space
tools which is a no-no for 2.2.  But if you have already upgraded your
user space tools, you can patch 2.2 linux/module.h yourself to remove
the warning.  Against 2.2.18-pre27.

Index: 18-pre27.1/include/linux/module.h
--- 18-pre27.1/include/linux/module.h Tue, 12 Sep 2000 13:37:17 +1100 kaos (linux-2.2/F/51_module.h 1.1.7.2 644)
+++ 18-pre27.1(w)/include/linux/module.h Tue, 12 Dec 2000 12:12:48 +1100 kaos (linux-2.2/F/51_module.h 1.1.7.2 644)
@@ -190,11 +190,6 @@ const char __module_parm_desc_##var[]		\
 __attribute__((section(".modinfo"))) =		\
 "parm_desc_" __MODULE_STRING(var) "=" desc
 
-/* The attributes of a section are set the first time the section is
-   seen; we want .modinfo to not be allocated.  */
-
-__asm__(".section .modinfo\n\t.previous");
-
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
