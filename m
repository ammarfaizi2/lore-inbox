Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291390AbSBHDsQ>; Thu, 7 Feb 2002 22:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291391AbSBHDsG>; Thu, 7 Feb 2002 22:48:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291390AbSBHDru>;
	Thu, 7 Feb 2002 22:47:50 -0500
Message-ID: <3C634A63.75CAD844@mandrakesoft.com>
Date: Thu, 07 Feb 2002 22:47:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Weber <weber@nyc.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.4-pre3 and IDE changes
In-Reply-To: <3C634346.1010405@nyc.rr.com>
Content-Type: multipart/mixed;
 boundary="------------7E405F7EA66ABF8EF1F41517"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7E405F7EA66ABF8EF1F41517
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

John Weber wrote:
> 
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

According to another poster on lkml, the attached patch from Jens is
needed.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
--------------7E405F7EA66ABF8EF1F41517
Content-Type: text/plain; charset=us-ascii;
 name="ide-dma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-dma.patch"

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

--------------7E405F7EA66ABF8EF1F41517--

