Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSKNDiA>; Wed, 13 Nov 2002 22:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSKNDiA>; Wed, 13 Nov 2002 22:38:00 -0500
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:29577 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S261456AbSKNDh6>; Wed, 13 Nov 2002 22:37:58 -0500
Date: Thu, 14 Nov 2002 04:44:52 +0100
From: Arjan Opmeer <a.d.opmeer@student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Floppy zero based sector patch for 2.5.47
Message-ID: <20021114034452.GA1298@Ado.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just modified this patch http://fdutils.linux.lu/zeroBased.patch to apply
against 2.5.47. It is included below. As Alain doesn't seem to respond to
email I am asking the mailing list for advice.

Is this the correct way to include support for floppy disks whose sector
numbers start at 0 instead of 1? 

And if so, could this please be applied as it is necessary for extending the
ADFS driver with extra E format floppy support. (I have that patch waiting
to send to Russell King, but it won't do any good without the floppy driver
supporting this numbering scheme)

Could comments be CC'ed to me as I am not subscribed to the list?


Arjan



--- linux-2.5.47/drivers/block/floppy.c	2002-11-11 04:28:05.000000000 +0100
+++ linux/drivers/block/floppy.c	2002-11-14 03:19:55.000000000 +0100
@@ -2246,6 +2246,10 @@
 			}
 		}
 	}
+	if(_floppy->stretch & FD_ZEROBASED) {
+		for(count = 0; count < F_SECT_PER_TRACK; count++)
+			here[count].sect--;
+	}
 }
 
 static void redo_format(void)
@@ -2662,9 +2666,10 @@
 	}
 	HEAD = fsector_t / _floppy->sect;
 
-	if (((_floppy->stretch & FD_SWAPSIDES) || TESTF(FD_NEED_TWADDLE)) &&
-	    fsector_t < _floppy->sect)
-		max_sector = _floppy->sect;
+	if (((_floppy->stretch & (FD_SWAPSIDES | FD_ZEROBASED)) ||
+		TESTF(FD_NEED_TWADDLE)) &&
+		fsector_t < _floppy->sect)
+			max_sector = _floppy->sect;
 
 	/* 2M disks have phantom sectors on the first track */
 	if ((_floppy->rate & FD_2M) && (!TRACK) && (!HEAD)){
@@ -2692,7 +2697,8 @@
 	GAP = _floppy->gap;
 	CODE2SIZE;
 	SECT_PER_TRACK = _floppy->sect << 2 >> SIZECODE;
-	SECTOR = ((fsector_t % _floppy->sect) << 2 >> SIZECODE) + 1;
+	SECTOR = ((fsector_t % _floppy->sect) << 2 >> SIZECODE) +
+		((_floppy->stretch & FD_ZEROBASED) ? 0 : 1);
 
 	/* tracksize describes the size which can be filled up with sectors
 	 * of size ssize.
@@ -3322,7 +3328,7 @@
 	    g->track <= 0 ||
 	    g->track > UDP->tracks>>STRETCH(g) ||
 	    /* check if reserved bits are set */
-	    (g->stretch&~(FD_STRETCH|FD_SWAPSIDES)) != 0)
+	    (g->stretch&~(FD_STRETCH|FD_SWAPSIDES|FD_ZEROBASED)) != 0)
 		return -EINVAL;
 	if (type){
 		if (!capable(CAP_SYS_ADMIN))
@@ -3347,11 +3353,13 @@
 					      drive_state[cnt].fd_device));
 		}
 	} else {
+		int oldStretch;
 		LOCK_FDC(drive,1);
 		if (cmd != FDDEFPRM)
 			/* notice a disk change immediately, else
 			 * we lose our settings immediately*/
 			CALL(poll_drive(1, FD_RAW_NEED_DISK));
+		oldStretch = g->stretch;
 		user_params[drive] = *g;
 		if (buffer_drive == drive)
 			SUPBOUND(buffer_max, user_params[drive].sect);
@@ -3366,8 +3374,11 @@
 		 * whose number will change. This is useful, because
 		 * mtools often changes the geometry of the disk after
 		 * looking at the boot block */
-		if (DRS->maxblock > user_params[drive].sect || DRS->maxtrack)
-			invalidate_drive(bdev);
+		if (DRS->maxblock > user_params[drive].sect || 
+			DRS->maxtrack ||
+			((user_params[drive].sect ^ oldStretch) &
+			(FD_SWAPSIDES | FD_ZEROBASED)))
+				invalidate_drive(bdev);
 		else
 			process_fd_request();
 	}
--- linux-2.5.47/include/linux/fd.h	2002-11-11 04:28:30.000000000 +0100
+++ linux/include/linux/fd.h	2002-11-14 02:57:08.000000000 +0100
@@ -17,6 +17,7 @@
 			stretch;	/* !=0 means double track steps */
 #define FD_STRETCH 1
 #define FD_SWAPSIDES 2
+#define FD_ZEROBASED 4
 
 	unsigned char	gap,		/* gap1 size */
 
