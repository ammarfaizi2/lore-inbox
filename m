Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313641AbSDPJKS>; Tue, 16 Apr 2002 05:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313644AbSDPJKR>; Tue, 16 Apr 2002 05:10:17 -0400
Received: from ip77-36.sjsbc.org ([209.66.77.36]:12960 "EHLO tbdnetworks.com.")
	by vger.kernel.org with ESMTP id <S313641AbSDPJKQ>;
	Tue, 16 Apr 2002 05:10:16 -0400
Date: Tue, 16 Apr 2002 02:09:57 -0700 (PDT)
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Message-Id: <200204160909.g3G99vEK025678@enterprise.tbdnetworks.com>
To: dalecki@evision-ventures.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 IDE 36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while trying to understand recent kernel changes I stumbled over
the following patch to
 
diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8/drivers/ide/ide.c	Tue Apr 16 06:01:07 2002
+++ linux/drivers/ide/ide.c	Tue Apr 16 05:38:37 2002

...
 while (i > 0) {
-		u32 buffer[16];
-		unsigned int wcount = (i > 16) ? 16 : i;
-		i -= wcount;
-		ata_input_data (drive, buffer, wcount);
+		u32 buffer[SECTOR_WORDS];
+		unsigned int count = (i > 1) ? 1 : i;
+
+		ata_read(drive, buffer, count * SECTOR_WORDS);
+		i -= count;
 	}
 }
...

While the old code called ata_input_read() with [0:16] as last param,
the new code calls the (renamed) ata_read() with either 0 or 16. Also,
the new code loops "i" times while the old code looped "i/16+1" times.
Was this intended or should the patch better read like:

...
 while (i > 0) {
-               u32 buffer[16];
-               unsigned int wcount = (i > 16) ? 16 : i;
-               i -= wcount;
-               ata_input_data (drive, buffer, wcount);
+               u32 buffer[SECTOR_WORDS];
+               unsigned int count = max(i, SECTOR_WORDS);
+
+               ata_read(drive, buffer, count);
+               i -= count;
        }
 }
...

so long
  Norbert

