Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTB0KI4>; Thu, 27 Feb 2003 05:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTB0KI4>; Thu, 27 Feb 2003 05:08:56 -0500
Received: from cal003100.student.utwente.nl ([130.89.160.36]:23021 "EHLO
	margo.student.utwente.nl") by vger.kernel.org with ESMTP
	id <S262821AbTB0KIy>; Thu, 27 Feb 2003 05:08:54 -0500
Date: Thu, 27 Feb 2003 11:19:12 +0100
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030227101912.GA4006@margo.student.utwente.nl>
Mail-Followup-To: simon, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva> <3E5DDCE7.2040100@linux.org.hk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <3E5DDCE7.2040100@linux.org.hk>
User-Agent: Mutt/1.4i
From: Simon Oosthoek <simon@margo.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2003 at 05:39:51PM +0800, Ben Lau wrote:
> Hi,
> 
>    I have tried to compile the -pre5 with IEEE1394
> support and i got the following error:
> 
>  gcc -D__KERNEL__ -I/usr/src/2.4.21pre5/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i386
> -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=raw1394  -c
> -o raw1394.o raw1394.c
>  In file included from raw1394.c:50:
>  raw1394.h:167: field `tq' has incomplete type
>  raw1394.c: In function `__alloc_pending_request':
>  raw1394.c:110: warning: implicit declaration of function `HPSB_INIT_WORK'
>  raw1394.c:118: confused by earlier errors, bailing out
>  make[2]: *** [raw1394.o] Error 1
>  make[2]: Leaving directory `/usr/src/2.4.21pre5/drivers/ieee1394'
>  make[1]: *** [_modsubdir_ieee1394] Error 2
>  make[1]: Leaving directory `/usr/src/2.4.21pre5/drivers'
>  make: *** [_mod_drivers] Error 2
> 
> The definition of hpsb_queue_struct was missing
> in the -pre5. I found that it did exist on -pre4
> 
> /usr/src/2.4.21pre4/drivers/ieee1394/ieee1394_types.h:45:#define
> hpsb_queue_struct tq_struct

Same here...

here's a patch that should work to fix this.

Cheers

Simon
--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ieee1394.patch-2.4.21-pre5"

--- linux-2.4.21-pre5/drivers/ieee1394/ieee1394_types.h	2003-02-27 11:04:08.000000000 +0100
+++ linux-2.4.21-pre4-ac4/drivers/ieee1394/ieee1394_types.h	2003-02-17 20:37:10.000000000 +0100
@@ -10,6 +10,27 @@
 #include <asm/byteorder.h>
 
 
+/* The great kdev_t changeover in 2.5.x */
+#include <linux/kdev_t.h>
+#ifndef minor
+#define minor(dev) MINOR(dev)
+#endif
+
+#ifndef __devexit_p
+#define __devexit_p(x) x
+#endif
+
+#include <linux/spinlock.h>
+
+#ifndef list_for_each_safe
+#define list_for_each_safe(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; pos != (head); \
+		pos = n, n = pos->next)
+
+#endif
+
+#define pte_offset_kernel pte_offset
+
 #ifndef MIN
 #define MIN(a,b) ((a) < (b) ? (a) : (b))
 #endif
@@ -19,6 +40,15 @@
 #endif
 
 
+/* Use task queue */
+#include <linux/tqueue.h>
+#define hpsb_queue_struct tq_struct
+#define hpsb_queue_list list
+#define hpsb_schedule_work(x) schedule_task(x)
+#define HPSB_INIT_WORK(x,y,z) INIT_TQUEUE(x,y,z)
+#define HPSB_PREPARE_WORK(x,y,z) PREPARE_TQUEUE(x,y,z)
+
+
 typedef u32 quadlet_t;
 typedef u64 octlet_t;
 typedef u16 nodeid_t;

--zhXaljGHf11kAtnf--
