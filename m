Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRLBO2x>; Sun, 2 Dec 2001 09:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279467AbRLBO2o>; Sun, 2 Dec 2001 09:28:44 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:43940 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279313AbRLBO2Z>; Sun, 2 Dec 2001 09:28:25 -0500
Date: Sun, 2 Dec 2001 16:32:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Eric Lammerts <eric@lammerts.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] floppy.c #defines
In-Reply-To: <Pine.LNX.4.43.0112021455570.30813-100000@ally.lammerts.org>
Message-ID: <Pine.LNX.4.33.0112021605150.3767-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Eric Lammerts wrote:

>
> On Sun, 2 Dec 2001, Zwane Mwaikambo wrote:
>
> > -#define ECALL(x) if ((ret = (x))) return ret;
> > +#define ECALL(x) if ((ret = (x))) return ret
>
> To prevent a dangling else problem, better make that
>
> #define ECALL(x) do { if ((ret = (x))) return ret; } while(0)
>
> Eric
>

hmm in that case, there are all sorts of other ones in there... Most
of them are for cutting down on typing instead of an internal API of
sorts.

--- linux-2.5.1-pre5/drivers/block/floppy.c	Sun Dec  2 14:26:22 2001
+++ linux-2.5.1-pre5-test/drivers/block/floppy.c	Sun Dec  2 16:26:56 2001
@@ -495,8 +495,8 @@
 static DECLARE_WAIT_QUEUE_HEAD(command_done);

 #define NO_SIGNAL (!interruptible || !signal_pending(current))
-#define CALL(x) if ((x) == -EINTR) return -EINTR
-#define ECALL(x) if ((ret = (x))) return ret;
+#define CALL(x) do {if ((x) == -EINTR) return -EINTR;} while(0)
+#define ECALL(x) do {if ((ret = (x))) return ret;} while(0)
 #define _WAIT(x,i) CALL(ret=wait_til_done((x),i))
 #define WAIT(x) _WAIT((x),interruptible)
 #define IWAIT(x) _WAIT((x),1)
@@ -549,7 +549,7 @@
  * reset doesn't need to be tested before sending commands, because
  * output_byte is automatically disabled when reset is set.
  */
-#define CHECK_RESET { if (FDCS->reset){ reset_fdc(); return; } }
+#define CHECK_RESET do { if (FDCS->reset){ reset_fdc(); return; } } while(0)
 static void reset_fdc(void);

 /*
@@ -663,23 +663,8 @@
 	timeout_message = message;
 }

-static int maximum(int a, int b)
-{
-	if (a > b)
-		return a;
-	else
-		return b;
-}
-#define INFBOUND(a,b) (a)=maximum((a),(b));
-
-static int minimum(int a, int b)
-{
-	if (a < b)
-		return a;
-	else
-		return b;
-}
-#define SUPBOUND(a,b) (a)=minimum((a),(b));
+#define INFBOUND(a,b) ((a)=max((a),(b)))
+#define SUPBOUND(a,b) ((a)=min((a),(b)))


 /*
@@ -899,7 +884,7 @@
 #define lock_fdc(drive,interruptible) _lock_fdc(drive,interruptible, __LINE__)

 #define LOCK_FDC(drive,interruptible) \
-if (lock_fdc(drive,interruptible)) return -EINTR;
+do {if (lock_fdc(drive,interruptible)) return -EINTR;} while(0)


 /* unlocks the driver */
@@ -1176,7 +1161,7 @@
 	}
 	return -1;
 }
-#define LAST_OUT(x) if (output_byte(x)<0){ reset_fdc();return;}
+#define LAST_OUT(x) do {if (output_byte(x)<0){ reset_fdc();return;}} while(0)

 /* gets the response from the fdc */
 static int result(void)
@@ -2474,12 +2459,12 @@
 	int size;

 	max_sector = transfer_size(ssize,
-				   minimum(max_sector, max_sector_2),
+				   min(max_sector, max_sector_2),
 				   CURRENT->nr_sectors);

 	if (current_count_sectors <= 0 && CT(COMMAND) == FD_WRITE &&
 	    buffer_max > fsector_t + CURRENT->nr_sectors)
-		current_count_sectors = minimum(buffer_max - fsector_t,
+		current_count_sectors = min(buffer_max - fsector_t,
 						CURRENT->nr_sectors);

 	remaining = current_count_sectors << 9;
@@ -2497,7 +2482,7 @@
 	}
 #endif

-	buffer_max = maximum(max_sector, buffer_max);
+	buffer_max = max(max_sector, buffer_max);

 	dma_buffer = floppy_track_buffer + ((fsector_t - buffer_min) << 9);

@@ -2653,7 +2638,7 @@
 	if ((_floppy->rate & FD_2M) && (!TRACK) && (!HEAD)){
 		max_sector = 2 * _floppy->sect / 3;
 		if (fsector_t >= max_sector){
-			current_count_sectors = minimum(_floppy->sect - fsector_t,
+			current_count_sectors = min(_floppy->sect - fsector_t,
 							CURRENT->nr_sectors);
 			return 1;
 		}
@@ -3506,7 +3491,7 @@
 	/* copyin */
 	CLEARSTRUCT(&inparam);
 	if (_IOC_DIR(cmd) & _IOC_WRITE)
-		ECALL(fd_copyin((void *)param, &inparam, size))
+		ECALL(fd_copyin((void *)param, &inparam, size));

 	switch (cmd) {
 		case FDEJECT:

