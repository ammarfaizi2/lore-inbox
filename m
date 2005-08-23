Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVHWGjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVHWGjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 02:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHWGjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 02:39:10 -0400
Received: from 204.11.225.161.ip.etheric.net ([204.11.225.161]:21396 "EHLO
	nitrous.truxton.com") by vger.kernel.org with ESMTP
	id S1750791AbVHWGjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 02:39:09 -0400
From: Truxton Fulton <trux@truxton.com>
To: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] : fix reboot via keyboard controller reset
X-Prognosticator: 42
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAElBMVEUSDgpyVTOTZDz
 JooRMMRkrIRJCKOHSAAACaklEQVR4nE1Twa7jIAxkpeZeU3J/GN79NeTdS2vu6Qr//6/smCT
 a0laVGOyZMYNzY02t11spWVU3d6zJvq9KMZVSFnWTuo9FnJIBpazb9rHfn1z2/VJ+PyouzyU
 x81HzPf0v4OQr+7PmcbKr3GINRLzvL+uxP2lNOUglOkr8QT89yQvWjY6KGA5vniK13oWtIhW
 mYCXbpJFzqG2ug+O+RPKDXiXgI+9eD/Is1E2qe9faQdFP7hjmL+ulOTSpIvXwsXAIX9UA9Gn
 Yj8ynqJYfaLbR39717TnxXpLD49vUXqTpdKmebRnEQauNC8fbBElYy+i2RAk24U314Trthwd
 NCEH/ON0EQKVz6KZ3fm3NXVRa09HpMFh4Yr061wRJGNTnJfrvvD0ww9ZVPMd5CDDM1/yYcB2
 QJQwlT3kykwRmyS/MRHtvOBs9BUrxLdFzjj9fbuvtYgBHIl/uwccbB57hXFTbLgoECypLEf8
 LjqaY+QmUIU78fXMKoH0CkCW1uVGx+4inda5JTJS+dTfoD+vpnuKEkfSmOgAIHZBf0y+mrip
 b340w30Yr5h8DWhtA8MdElsWvEUmHDRD5KGKdFksDZ0ykty6bAUSERODq73BiwDyA4T0SIyt
 MfENIYEIeEEB7GgCkFSm7OsHQobdbTMjMxLT+DWV2YkPEK5YjQMEvqMATQWj7FZigGaBYfQx
 AnAHWyv4QFa5PjhZx54KomccPSK2RYp4ly8PZI9vUmLS/PbRFuXZ5NWdJh2K068i9j0xtDoF
 WABjWBRWWIrA889xXqWWQ64SKJr1KothuaP4qzp5rt2sfK3CVNRvwD3ipzBvlIAzfAAAAAEl
 FTkSuQmCC
Date: Mon, 22 Aug 2005 23:39:07 -0700
Message-ID: <m21x4l9myc.fsf@truxton.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a system (Biostar IDEQ210M mini-pc with a VIA chipset)
which will not reboot unless a keyboard is plugged in to it.
I have tried all combinations of the kernel "reboot=x,y"
flags to no avail.  Rebooting by any method will leave the
system in a wedged state (at the "Restarting system" message).

I finally tracked the problem down to the machine's refusal to
fully reboot unless the keyboard controller status register
had bit 2 set.  This is the "System flag" which when set,
indicates successful completion of the keyboard controller
self-test (Basic Assurance Test, BAT).

I suppose that something is trying to protect against sporadic
reboots unless the keyboard controller is in a good state
(a keyboard is present), but I need this machine to be
headless.

I found that setting the system flag (via the command byte)
before giving the "pulse reset line" command will allow the
reboot to proceed.  The patch is simple, and I think it
should be fine for everybody whether they have this type
of machine or not.  This affects the "hard" reboot (as done
when the kernel boot flags "reboot=c,h" are used).

Here is a patch against include/asm-i386/mach-default/mach_reboot.h :

--- mach_reboot.h.orig  2005-08-22 22:23:13.000000000 -0700
+++ mach_reboot.h       2005-08-22 23:18:36.000000000 -0700
@@ -22,6 +22,14 @@
        for (i = 0; i < 100; i++) {
                kb_wait();
                udelay(50);
+               outb(0x60, 0x64);         /* write Controller Command Byte */
+               udelay(50);
+               kb_wait();
+               udelay(50);
+               outb(0x14, 0x60);         /* set "System flag" */
+               udelay(50);
+               kb_wait();
+               udelay(50);
                outb(0xfe, 0x64);         /* pulse reset low */
                udelay(50);
        }

Thanks,

-Truxton
