Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319227AbSHUWUI>; Wed, 21 Aug 2002 18:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319229AbSHUWUH>; Wed, 21 Aug 2002 18:20:07 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:56263 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S319227AbSHUWUD>; Wed, 21 Aug 2002 18:20:03 -0400
Message-Id: <5.1.1.6.1.20020821230820.00a71798@mail.force9.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 21 Aug 2002 23:19:58 +0100
To: linux-kernel@vger.kernel.org
From: Darkhorse WinterWolf <dh@winterwolf.co.uk>
Subject: Re: PROBLEM: Devfs root breaks with some devices in 2.4.19
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to reply to my own post, but I think I've managed to isolate the 
problem of not being able to boot from certain devfs device names. It would 
only be a problem if the first character was in the range a through to f 
(or a number), when the kernel would incorrectly consider the "root=" line 
to be a device ID.

Here's a few lines from the original problem report to set things in context:

>[2.] Full description of the problem:
>When passing "root=" parameters to the kernel, certain device strings 
>referring to devfs devices that used to work in 2.4.18 now no longer work 
>in 2.4.19. For example, using "root=/dev/discs/disc2/part6" worked as 
>expected in 2.4.18, and allowed me to move my discs around on the 
>controllers so long as I maintained the order. However, using the same 
>command line in 2.4.19 fails completely.
>
>[3.] Keywords:
>devfs, root, kernel, boot parameters, init

It was all do do with assumptions that I don't think should have been 
taken. The assumption in this case is that if nothing matches the idea of a 
device on the "root=" line according to the structure in init/do_mounts.c, 
it would have been a device ID in hexadecimal.

Okay, so there are 65536 combinations, so you don't really want to test for 
all of them at this point, so some sort of assumption is probably required. 
However, this assumption is applied after stripping "/dev/" if it's present 
at the beginning of the line, so it was interpreting "discs/disc2/part6" or 
whatever as a hex number, and the conversion routine changed this into 
device "00:0d", stopping at the first non-hex character.

There's a simple test I'm applying to get unknown (to init/do_mounts.c) 
"root=" devices to work. After applying the patch, the kernel not accepting 
that a hexadecimal device ID could be present in the "root=" parameter if 
it starts with "/dev/". If this should ever happen, please let me know and 
I'll try to find another way of resolving this problem.

Instead, I'll set ROOT_DEV to 0, so that by the time the call to 
devfs_find_handle() in function create_dev() is placed, the test 
"dev?NULL:devfs_name" will return devfs_name and not NULL. After that 
change, devfs_find_handle() will find the device as expected, and the boot 
process will continue as normal.

The changes haven't been tested thoroughly, but it does seem to work in my 
case for "root=/dev/discs/disc2/part6", "root=/dev/hdg6" and "root=2206", 
all of which refer to the same disc and partition. Testing from anyone else 
would be greatly appreciated. Does anyone know who I should contact about 
the possibility of getting this minor change included in future kernel 
releases?

Could any comments relating to this please by CCd to me at 
<dh@winterwolf.co.uk>, please. Thanks.

Here's a diff to show the changes I've made.

---Begin kernel diff---
diff -uBr linux-2.4.19-orig/init/do_mounts.c linux-2.4.19/init/do_mounts.c
--- linux-2.4.19-orig/init/do_mounts.c  Sat Aug  3 01:39:46 2002
+++ linux-2.4.19/init/do_mounts.c       Wed Aug 21 23:08:16 2002
@@ -243,6 +243,13 @@
                         }
                         dev++;
                 } while (dev->name);
+
+               /* Remove the chance of unknown /dev/... lines being
+               * interpreted as the root device number
+               * David Headland <dh@winterwolf.co.uk>
+               */
+               if(!(dev->name))
+                       return to_kdev_t(0);
         }
         return to_kdev_t(base + simple_strtoul(line,NULL,base?10:16));
  }
---End kernel diff---

All the best,
-David Headland.

