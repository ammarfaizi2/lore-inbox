Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUJGRqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUJGRqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267469AbUJGRl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:41:59 -0400
Received: from ms-smtp-02-qfe0.socal.rr.com ([66.75.162.134]:41414 "EHLO
	ms-smtp-02-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S267591AbUJGRhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:37:11 -0400
Subject: Re: 2.6.9-rc3-mm3: `risc_code_addr01' multiple definition
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041007165849.GA4493@stusta.de>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	 <20041007165849.GA4493@stusta.de>
Content-Type: multipart/mixed; boundary="=-igVIb8qgt5xTzhDr6XRC"
Organization: QLogic Corporation
Date: Thu, 07 Oct 2004 10:29:05 -0700
Message-Id: <1097170149.12535.27.camel@praka>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-igVIb8qgt5xTzhDr6XRC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-10-07 at 18:58 +0200, Adrian Bunk wrote:
> On Thu, Oct 07, 2004 at 01:51:39AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.9-rc3-mm2:
> >...
> >  bk-scsi.patch
> >...
> 
> This causes the following compile error:
> 
> 
> <--  snip  -->
> 
> ...
>   LD      drivers/scsi/built-in.o
> drivers/scsi/qla1280.o(.data+0xe65c): multiple definition of `risc_code_addr01'
> drivers/scsi/qlogicfc.o(.data+0x0): first defined here
> make[2]: *** [drivers/scsi/built-in.o] Error 1
> 

Hmm, seems the additional 1040 support in qla1280.c is causing name
clashes with the firmware image in qlogicfc_asm.c.  Try out the attached
patch (not tested) which provides the 1040 firmware image unique
variable names.

Looks like there would be some name clashes in qlogicfc and qlogicisp.

--
av

> <--  snip  -->
> 
> 
> cu
> Adrian
> 

--=-igVIb8qgt5xTzhDr6XRC
Content-Disposition: attachment; filename=fixup_fw_variables.diff
Content-Type: text/plain; name=fixup_fw_variables.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.9-rc3-mm3/drivers/scsi/ql1040_fw.h~	2004-10-07 10:15:19.275258120 -0700
+++ linux-2.6.9-rc3-mm3/drivers/scsi/ql1040_fw.h	2004-10-07 10:17:51.292148040 -0700
@@ -28,15 +28,15 @@
  *	Firmware Version 7.65.00 (14:17 Jul 20, 1999)
  */
 
-unsigned short risc_code_version = 7*1024+65;
+unsigned short fw1040_version = 7*1024+65;
 
-unsigned char firmware_version[] = {7,65,0};
+unsigned char fw1040_version_str[] = {7,65,0};
 
 #define FW_VERSION_STRING "7.65.0"
 
-unsigned short risc_code_addr01 = 0x1000 ;
+unsigned short fw1040_addr01 = 0x1000 ;
 
-unsigned short risc_code01[] = { 
+unsigned short fw1040_code01[] = { 
 	0x0078, 0x103a, 0x0000, 0x4057, 0x0000, 0x2043, 0x4f50, 0x5952,
 	0x4947, 0x4854, 0x2031, 0x3939, 0x3520, 0x514c, 0x4f47, 0x4943,
 	0x2043, 0x4f52, 0x504f, 0x5241, 0x5449, 0x4f4e, 0x2049, 0x5350,
@@ -2097,5 +2097,5 @@ unsigned short risc_code01[] = { 
 	0x0014, 0x878e, 0x0016, 0xa21c, 0x1035, 0xa8af, 0xa210, 0x3807,
 	0x300c, 0x817e, 0x872b, 0x8772, 0xa8a8, 0x0000, 0xdf21
 };
-unsigned short   risc_code_length01 = 0x4057;
+unsigned short   fw1040_length01 = 0x4057;
 
--- linux-2.6.9-rc3-mm3/drivers/scsi/qla1280.c~	2004-10-07 10:21:47.552231048 -0700
+++ linux-2.6.9-rc3-mm3/drivers/scsi/qla1280.c	2004-10-07 10:22:56.828699424 -0700
@@ -659,8 +659,8 @@ static struct qla_boards ql1280_board_tb
 	/* Name ,  Number of ports, FW details */
 	{"QLA12160", 2, &fw12160i_code01[0], &fw12160i_length01,
 	 &fw12160i_addr01, &fw12160i_version_str[0]},
-	{"QLA1040", 1, &risc_code01[0], &risc_code_length01,
-	 &risc_code_addr01, &firmware_version[0]},
+	{"QLA1040", 1, &fw1040_code01[0], &fw1040_length01,
+	 &fw1040_addr01, &fw1040_version_str[0]},
 	{"QLA1080", 1, &fw1280ei_code01[0], &fw1280ei_length01,
 	 &fw1280ei_addr01, &fw1280ei_version_str[0]},
 	{"QLA1240", 2, &fw1280ei_code01[0], &fw1280ei_length01,

--=-igVIb8qgt5xTzhDr6XRC--

