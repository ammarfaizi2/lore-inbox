Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSKSITC>; Tue, 19 Nov 2002 03:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSKSITC>; Tue, 19 Nov 2002 03:19:02 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:62914 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264631AbSKSITB>; Tue, 19 Nov 2002 03:19:01 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.48: compile with CONFIG_NET=n broken again
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 19 Nov 2002 17:25:53 +0900
Message-ID: <buon0o6vucu.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I haven't tried to compile without CONFIG_NET for a while, so I suppose
 this probably crept in earlier.]

With CONFIG_NET=n, I get two link errors:

  	v850e-elf-ld  -T arch/v850/vmlinux.lds.s arch/v850/kernel/head.o arch/v850/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/v850/kernel/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/v850/lib/lib.a  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o vmlinux
/proj/soft2/uclinux/uclinux/build/2.5.48-uc0-sim/net/socket.c:744: undefined reference to `dev_ioctl'
/proj/soft2/uclinux/uclinux/build/2.5.48-uc0-sim/include/net/xfrm.h:302: undefined reference to `__secpath_destroy'
make: *** [vmlinux] Error 1


(1) The `dev_ioctl' error is because of the added call in sock_ioctl
    (net/socket.c) to dev_ioctl #ifdefed on WIRELESS_EXT, which is defined
    in <linux/wireless.h>.  Since net/socket.c actually includes
    <linux/wireless.h> twice, once #ifdefed, and once not, I just got rid
    of the non-#ifdefed include, which seems to solve the problem:

--- ../orig/linux-2.5.48-uc0/net/socket.c	2002-11-19 10:11:55.000000000 +0900
+++ net/socket.c	2002-11-19 17:11:53.000000000 +0900
@@ -75,7 +75,6 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
-#include <linux/wireless.h>
 #include <linux/divert.h>
 #include <linux/mount.h>
 

(2) `__secpath_destroy' is used by the inline function `secpath_put',
    in <net/xfrm.h>, and net/core/skbuff.c calls secpath_put -- but
    __secpath_destroy is defined in net/ipv4/xfrm_input.c, and the
    net/ipv4 directory isn't even compiled if CONFIG_NET=n.

    [I didn't know what to do about this, so I just commented out the call
    to __secpath_destroy in secpath_put]

Thanks,

-Miles

-- 
A zen-buddhist walked into a pizza shop and
said, "Make me one with everything."
