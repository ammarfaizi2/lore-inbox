Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283349AbRK2Rpx>; Thu, 29 Nov 2001 12:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283353AbRK2Rpo>; Thu, 29 Nov 2001 12:45:44 -0500
Received: from ids.big.univali.br ([200.169.51.11]:18065 "HELO
	mail.big.univali.br") by vger.kernel.org with SMTP
	id <S283349AbRK2Rpb>; Thu, 29 Nov 2001 12:45:31 -0500
Message-Id: <5.1.0.14.1.20011129153953.00aaea68@mail.big.univali.br>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 29 Nov 2001 15:45:35 -0200
To: linux-kernel@vger.kernel.org
From: Marcus Grando <marcus@big.univali.br>
Subject: [PATCH] compile pc_key.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	After apply the patch-2.5.1-pre3 occur this errors:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.x/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o pc_keyb.o pc_keyb.c
pc_keyb.c:423:71: macro "spin_unlock" passed 2 arguments, but takes just 1
pc_keyb.c: In function `pckbd_pm_resume':
pc_keyb.c:423: `spin_unlock' undeclared (first use in this function)
pc_keyb.c:423: (Each undeclared identifier is reported only once
pc_keyb.c:423: for each function it appears in.)
pc_keyb.c:1059:57: macro "spin_unlock_irqrestore" requires 2 arguments, but only 1 given
pc_keyb.c:1079:57: macro "spin_unlock_irqrestore" requires 2 arguments, but only 1 given
pc_keyb.c: In function `release_aux':
pc_keyb.c:1059: `spin_unlock_irqrestore' undeclared (first use in this function)
pc_keyb.c: In function `open_aux':
pc_keyb.c:1079: `spin_unlock_irqrestore' undeclared (first use in this function)
make[3]: *** [pc_keyb.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.x/drivers/char'

	Fix:

--- v2.5.1-pre3/drivers/char/pc_keyb.c  Thu Nov 29 15:43:16 2001
+++ linux/drivers/char/pc_keyb.c        Thu Nov 29 15:26:13 2001
@@ -420,7 +420,7 @@
                               kbd_write_command(KBD_CCMD_WRITE_MODE);
                               kb_wait();
                               kbd_write_output(AUX_INTS_OFF);
-                              spin_unlock(&kbd_controller_lock, flags);
+                              spin_unlock(&kbd_controller_lock);
                       }
                       spin_unlock_irqrestore( &aux_count_lock,flags );
               }
@@ -1056,7 +1056,7 @@
        fasync_aux(-1, file, 0);
        spin_lock_irqsave( &aux_count, flags );
        if ( --aux_count ) {
-               spin_unlock_irqrestore( &aux_count_lock );
+               spin_unlock_irqrestore( &aux_count_lock, flags );
                return 0;
        }
        spin_unlock_irqrestore( &aux_count_lock, flags );
@@ -1076,7 +1076,7 @@
        int flags;
        spin_lock_irqsave( &aux_count_lock, flags );
        if ( aux_count++ ) {
-               spin_unlock_irqrestore( &aux_count_lock );
+               spin_unlock_irqrestore( &aux_count_lock, flags );
                return 0;
        }
        queue->head = queue->tail = 0;          /* Flush input queue */


Regards,

Marcus Grando

