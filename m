Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291394AbSBHD7h>; Thu, 7 Feb 2002 22:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291393AbSBHD7T>; Thu, 7 Feb 2002 22:59:19 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:14815 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S291392AbSBHD7E>; Thu, 7 Feb 2002 22:59:04 -0500
Date: Thu, 7 Feb 2002 22:56:40 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.4-pre3 and IDE changes
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C634346.1010405@nyc.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C634346.1010405@nyc.rr.com>; from weber@nyc.rr.com on Thu, Feb 07, 2002 at 10:17:26PM -0500
Message-Id: <20020208035851.KOPJ10804.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

John Weber wrote:
> The address member of struct scatterlist appears to have been changed to 
> dma_address.
> 
> A simple s/\.address/\.dma_address/ should fix this compile error.
> 
> ide-dma.c: In function `ide_raw_build_sglist':
> ide-dma.c:269: structure has no member named `address'
> ide-dma.c:276: structure has no member named `address'
> make[3]: *** [ide-dma.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
> make[1]: *** [_subdir_ide] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.4/drivers'
> make: *** [_dir_drivers] Error 2

This is the patch that Jens posted, though he posted it before this
kernel was even released.  His post said it fixed a compile error
in pre2, but pre2 compiled fine.  It _does_ fix the compile error in
pre3 though.

-- 
Skip

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-dma.patch"

diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Thu Feb  7 09:44:56 2002
+++ b/drivers/ide/ide-dma.c	Thu Feb  7 09:44:56 2002
@@ -266,14 +266,16 @@
 #if 1	
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 		sg[nents].length = 128  * SECTOR_SIZE;
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
 	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].address = virt_addr;
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
  #endif

--/04w6evG8XlLl3ft--
