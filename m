Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRAPDpU>; Mon, 15 Jan 2001 22:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRAPDpK>; Mon, 15 Jan 2001 22:45:10 -0500
Received: from Cantor.suse.de ([194.112.123.193]:53510 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130241AbRAPDpF>;
	Mon, 15 Jan 2001 22:45:05 -0500
Date: Tue, 16 Jan 2001 04:45:04 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: up_read/up_write redefinitions in asm/semaphore.h and linux/usbdevice_fs.h
Message-ID: <20010116044504.A12009@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just asked on the linuxppc-dev list, but here is proably the better
place to ask.

We had a linuxppc_2_3 tree which had the #defines below disabled. 
The fresh linuxppc_2_4 tree doesn't have it anymore.

The 2.4.0-ac9 patch has the current status of
linclude/asm-ppc/semaphore.h:

...
#define up_read(sem) \
        do { \
                unsigned long flags; \
                                                                        \
                CHECK_MAGIC((sem)->__magic); \
                                                                        \
                spin_lock_irqsave(&(sem)->lock, flags); \
                if (!--(sem)->rd && waitqueue_active(&(sem)->wait)) \
                        wake_up(&(sem)->wait); \
                spin_unlock_irqrestore(&(sem)->lock, flags); \
        } while (0)
...


What needs to be changed, the ppc/semaphore.h file or the
linux/usbdevice_fs.h to avoid this conflict?


Gruss Olaf


----- Forwarded message from Olaf Hering <olh@suse.de> -----

Date: Tue, 16 Jan 2001 04:17:43 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: up_read/up_write redefinitions in asm/semaphore.h and linux/usbdevice_fs.h


Hi,

I have some redefinitions when I compile usbdevfs:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0.SuSE/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring    -c -o inode.o inode.c
In file included from inode.c:41:
/usr/src/linux-2.4.0.SuSE/include/linux/usbdevice_fs.h:173: warning:
`up_read' redefined
/usr/src/linux-2.4.0.SuSE/include/asm/semaphore.h:186: warning: this is
the location of the previous definition
/usr/src/linux-2.4.0.SuSE/include/linux/usbdevice_fs.h:174: warning:
`up_write' redefined


We had this patch in the linuxppc_2_3 tree:

diff -urN linux-2.4.0-ac4/include/linux/usbdevice_fs.h
linux-2.4.0-ac4-ppc/include/linux/usbdevice_fs.h
--- linux-2.4.0-ac4/include/linux/usbdevice_fs.h        Thu Jan  4
23:52:32 2001
+++ linux-2.4.0-ac4-ppc/include/linux/usbdevice_fs.h    Mon Jan  8
10:44:29 2001
@@ -166,13 +166,14 @@
  * sigh. rwsemaphores do not (yet) work from modules
  */

+#if 0
 #define rw_semaphore semaphore
 #define init_rwsem init_MUTEX
 #define down_read down
 #define down_write down
 #define up_read up
 #define up_write up
-
+#endif

 struct dev_state {
        struct list_head list;      /* state list */


It is gone in linuxppc_2_4 tree.

The USB layer should proably not use these generic names.
How can we fix that?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


----- End forwarded message -----

-- 



-- 
 $ man clone

BUGS
       Main feature not yet implemented...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
