Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291091AbSBGDJe>; Wed, 6 Feb 2002 22:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291092AbSBGDJZ>; Wed, 6 Feb 2002 22:09:25 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:24298 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291091AbSBGDJJ>; Wed, 6 Feb 2002 22:09:09 -0500
Subject: [PATCH] Fix floppy io ports reservation
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Feb 2002 03:09:08 +0000 (GMT)
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16Yevs-00054g-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is a patch that fixes the io ports reservation of the floppy driver
as the one in the driver is actually incorrect and this clashes with the
(correct) reservation by the PNPBIOS driver.

I asked a friend to check and on his Windows 2000 system the port
reservation was 0x3f2-0x3f5 + 0x3f7, i.e. it just excludes ports
0x3f0-0x3f1, which are NOT used anywhere in the driver anyway.

This patch works for me on ia32 (Pentium 4), however I am not 100% sure it
will work on all architectures. From a quick look I would say it will work
but I may have missed something...

Before I get flamed for this patch being a hack, yes it is a bit of a
hack, but the full solution involving changing of the actual base
address and all the offsets to the base is a huge patch and involves
changing quite a bit of architecture specific code in non-obvious ways.
(Most non-obvious are the changes to Sparc, Sparc64, mips, mips64 and
m68k, the rest of the arch are a piece of cake.)

I would suggest that people give this patch a go, especially on non-ia32
arch and let us all know if it doesn't work. Perhaps best would be to
include it in the next -pre kernels and see if anyone screams. (-:

Almost forgot, patch is against 2.4.18-pre7-ac2 but I would think it will
apply to any 2.4 and probably 2.5 kernel.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

---floppy.diff---
--- l/drivers/block/floppy.c	Thu Jan 31 18:16:20 2002
+++ linux-2.4.18-pre7-ac2-vanilla/drivers/block/floppy.c	Thu Feb  7 02:35:07 2002
@@ -129,6 +129,12 @@
  * floppy controller (lingering task on list after module is gone... boom.)
  */
 
+/*
+ * 2002/02/07 -- Anton Altaparmakov - Fix io ports reservation to correct range
+ * (0x3f2-0x3f5, 0x3f7). This fix is a bit of a hack but the proper fix
+ * requires many non-obvious changes in arch dependent code.
+ */
+
 #define FLOPPY_SANITY_CHECK
 #undef  FLOPPY_SILENT_DCL_CLEAR
 
@@ -4229,7 +4235,7 @@
 		FDCS->rawcmd = 2;
 		if (user_reset_fdc(-1,FD_RESET_ALWAYS,0)){
  			/* free ioports reserved by floppy_grab_irq_and_dma() */
- 			release_region(FDCS->address, 6);
+ 			release_region(FDCS->address+2, 4);
  			release_region(FDCS->address+7, 1);
 			FDCS->address = -1;
 			FDCS->version = FDC_NONE;
@@ -4239,7 +4245,7 @@
 		FDCS->version = get_fdc_version();
 		if (FDCS->version == FDC_NONE){
  			/* free ioports reserved by floppy_grab_irq_and_dma() */
- 			release_region(FDCS->address, 6);
+ 			release_region(FDCS->address+2, 4);
  			release_region(FDCS->address+7, 1);
 			FDCS->address = -1;
 			continue;
@@ -4318,11 +4324,11 @@
 
 	for (fdc=0; fdc< N_FDC; fdc++){
 		if (FDCS->address != -1){
-			if (!request_region(FDCS->address, 6, "floppy")) {
-				DPRINT("Floppy io-port 0x%04lx in use\n", FDCS->address);
+			if (!request_region(FDCS->address+2, 4, "floppy")) {
+				DPRINT("Floppy io-port 0x%04lx in use\n", FDCS->address + 2);
 				goto cleanup1;
 			}
-			if (!request_region(FDCS->address + 7, 1, "floppy DIR")) {
+			if (!request_region(FDCS->address+7, 1, "floppy DIR")) {
 				DPRINT("Floppy io-port 0x%04lx in use\n", FDCS->address + 7);
 				goto cleanup2;
 			}
@@ -4350,12 +4356,12 @@
 	irqdma_allocated = 1;
 	return 0;
 cleanup2:
-	release_region(FDCS->address, 6);
+	release_region(FDCS->address + 2, 4);
 cleanup1:
 	fd_free_irq();
 	fd_free_dma();
 	while(--fdc >= 0) {
-		release_region(FDCS->address, 6);
+		release_region(FDCS->address + 2, 4);
 		release_region(FDCS->address + 7, 1);
 	}
 	MOD_DEC_USE_COUNT;
@@ -4422,7 +4428,7 @@
 	old_fdc = fdc;
 	for (fdc = 0; fdc < N_FDC; fdc++)
 		if (FDCS->address != -1) {
-			release_region(FDCS->address, 6);
+			release_region(FDCS->address+2, 4);
 			release_region(FDCS->address+7, 1);
 		}
 	fdc = old_fdc;

