Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWGHOJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWGHOJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWGHOJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:09:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:30709 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964843AbWGHOJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:09:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MBsNm5/SyHNPube4qdLP7Q2gbQ34Gwza4RAlPUDmF7uv7/FGtGuhpq0tBDB+TZsKJthiAX/f7tmRdX2vGO/jr1/1kIjejilnrtWF7vHVjtC6u4jjSiEWk9bCAaiv30+M9vONDne+ckZ8z8S6PgVSWTSRApzclR+jmaZ5RP+y15c=
Message-ID: <44AFBCB5.4040409@gmail.com>
Date: Sat, 08 Jul 2006 08:09:57 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patchset 0/3 -2.6.18-rc1]  pc8736x_gpio:  fix re-modprobe errors
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok,
>  the merge window for 2.6.18 is closed, and -rc1 is out there (git trees 
>   


The new pc8736x_gpio driver has at least 1 bug, which manifests when
module is rmmod'd then re-modprobe'd.  This 3 part patchset addresses it 
as follows:

1 - add constant defines - preparatory patch

- adds #define CONSTs  for max-pin,  gpio-addr-range (for reserving region)
- fix wrong max-pin check in gpio_open()
- add 'Winbond' to module description:  NSC sold the product, Winbond 
has us / lm-sensors

        pc-const-decl      - define several symbolic constants
        pc-open-const    - use reduced max-pin to what hardware supports
        pc-req-region-const        - can wait, but why
        pc-mod-desc-add-winbond    -

since this is just preparatory work, it still exhibits the bug:

soekris:~# rmmod pc8736x_gpio
soekris:~# modprobe pc8736x_gpio
[  498.970735] kobject_add failed for pc8736x_gpio.0 with -EEXIST, don't 
try to register things with the same name in the same directory.
[  498.985568]  [<c0102fbf>] show_trace_log_lvl+0x54/0xfd
[  498.991398]  [<c0103fba>] show_trace+0xd/0x10
[  498.996629]  [<c0103fd4>] dump_stack+0x17/0x1b
[  499.001759]  [<c01d1c6a>] kobject_add+0x17d/0x19c
[  499.014898]  [<c0203362>] device_add+0x7a/0x2cc
[  499.029917]  [<c020616d>] platform_device_add+0xdc/0x10c
[  499.045902]  [<c8820028>] pc8736x_gpio_init+0x28/0x258 [pc8736x_gpio]
[  499.053212]  [<c012a67a>] sys_init_module+0x1381/0x1463
[  499.061327]  [<c0102657>] syscall_call+0x7/0xb
FATAL: Error inserting pc8736x_gpio 
(/lib/modules/2.6.18-rc1-jimc-sk/kernel/drivers/char/pc8736x_gpio.ko): 
No such device


2 - pc-init-fix-undo-region-rollup

this patch fixes module-init-func by repairing usage of 
platform_device_del/put in module-exit-func,
ie it imitates Ingo's 'mishaps' patch, which fixed the 
module-init-func's undo handling.
Also fixes lack of release_region to undo the earlier registration.

Also included:
- add include <linux/cdev.h> - needed by next patches
and cuz theyre within the diff-context-window:
- remove include <linux/config.h>      everyone's doing it
- copyright updates - current date is 'wrong'

the patch fixes the above bug, reducing it to a different one; (which is 
fixed by 3rd patch)

soekris:~# rmmod pc8736x_gpio
soekris:~# modprobe pc8736x_gpio
[  283.618997] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver 
Initializing
[  283.626534] platform pc8736x_gpio.0: GPIO ioport 6600 reserved
[  283.633319] platform pc8736x_gpio.0: register-chrdev failed: -16
FATAL: Error inserting pc8736x_gpio 
(/lib/modules/2.6.18-rc1-jimc-sk/kernel/drivers/char/pc8736x_gpio.ko): 
Device or resource busy


3 - pc-init-fix-chrdev-region-rollup

- Switch from register_chrdev() to   (register|alloc)_chrdev_region().

- use a cdev.   This was intended for original patchset, but was overlooked.
We use a single cdev for all pins (minor device-numbers), as gleaned 
from cs5535_gpio,
and in contrast to whats currently done in scx200_gpio (which I'll fix soon)

By some reasoning, this patch should have been combined with patch 2; 
the fixes
are to the same 2 mod-init/exit functions, and both touch cdevs, 
regions, etc.
Despite this, I separated them (incompletely).  I'll combine them if 
thats better..


Given that this is a brand new driver, can I assume a bit more latitude to
clean up and normalize the code ?     For example, s/DEVNAME/DRVNAME/
would improve consistency with other drivers.  The scx200_gpio driver 
could also
stand some improvements; a single cdev, and same DRVNAME normalization.

Whats the right way to mark this as (NEW/EXPERIMENTAL) ?
Is either appropriate for a reworked / existing driver (scx200_gpio)

cc'g  AKPM since (I think) he pushed this driver to mainline.

thanks
Jim Cromie
