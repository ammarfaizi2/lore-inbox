Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWQch>; Thu, 23 Nov 2000 11:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKWQc1>; Thu, 23 Nov 2000 11:32:27 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:13061 "EHLO
        tellus.mine.nu") by vger.kernel.org with ESMTP id <S129091AbQKWQcP>;
        Thu, 23 Nov 2000 11:32:15 -0500
Date: Thu, 23 Nov 2000 17:02:10 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: netdev@oss.sgi.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Too long network device names corrupts kernel
Message-ID: <Pine.LNX.4.21.0011231642110.32263-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2.4.0-test11, but probably every version)

The name member of the net_device struct is fixed to IFNAMSIZ (16) bytes,
and is accessed using strcpy, strcmp and friends all over the place, which
suggests that the last byte of the name must be a null character. This
must be verified when the name is set. I haven't looked very hard, but
this seems not to be the case.

It is, to my knowledge, not possible for a normal user to create/name a
device, so only root can cause the corruption. Bad enough, but not
catastrophic.

As I see it, one (or both) of the following must be done:

1. Find all places where the device name is set and use length checking
   functions such as strncpy.

2. Find all places where a device name is used, and use special methods to
   copy and add a null character, or use strncpy, strncmp, etc.

...where number one is probably the only realistic solution.

I discovered this when I tried to create a tunnel using more than
IFNAMSIZ-1 (15) characters. It's quite hard to remove that tunnel. I'll go
for the Windows solution and reboot. Sigh!

Btw, does anyone know of a C function that works like strncpy, but does
add a terminating null character, event if the string does not fit, ro
does one have to do str[5]=0 first, and then strncpy(str,src,4)?

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
