Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSJTJ0R>; Sun, 20 Oct 2002 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJTJ0R>; Sun, 20 Oct 2002 05:26:17 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:11056 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S263228AbSJTJ0I>;
	Sun, 20 Oct 2002 05:26:08 -0400
Date: Sun, 20 Oct 2002 11:32:09 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@pld.org.pl>
X-X-Sender: dzimi@ep09.kernel.pl
To: Jens Axboe <axboe@suse.de>
cc: haoviet@tuluc.com, <linux-kernel@vger.kernel.org>
Subject: Re: ini9100u.c fixes ? (Was 2.5.44 compilation errors)
In-Reply-To: <20021019090637.GE871@suse.de>
Message-ID: <Pine.LNX.4.44L.0210201103040.9210-300000@ep09.kernel.pl>
References: <33182.24.130.42.133.1035014240.squirrel@mail.tuluc.com>
 <20021019090637.GE871@suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1473552907-352050700-1035106329=:9210"
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1473552907-352050700-1035106329=:9210
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 19 Oct 2002, Jens Axboe wrote:

> On Sat, Oct 19 2002, haoviet@tuluc.com wrote:
> > --------------------------------------------------------------------------
> > drivers/scsi/qla1280.c:5932: unknown field `next' specified in initializer
> > drivers/scsi/qla1280.c:5932: warning: missing braces around initializer
> > drivers/scsi/qla1280.c:5932: warning: (near initialization for
> > `driver_template.shtp_list')make[2]: *** [drivers/scsi/qla1280.o] Error 1
> > make[1]: *** [drivers/scsi] Error 2
> > make: *** [drivers] Error 2
> > ----------------------------------------------------------------------------
> 
> ===== drivers/scsi/qla1280.h 1.7 vs edited =====
> --- 1.7/drivers/scsi/qla1280.h	Mon Oct 14 19:00:37 2002
> +++ edited/drivers/scsi/qla1280.h	Sat Oct 19 11:05:46 2002
> @@ -1324,22 +1324,12 @@
>   */
>  
>  #define QLA1280_LINUX_TEMPLATE {				\
> -	next: NULL,						\
> -	module: NULL,						\
> -	proc_dir: NULL,						\
>  	proc_info: qla1280_proc_info,				\
>  	name: "Qlogic ISP 1280/12160",				\
>  	detect: qla1280_detect,					\
>  	release: qla1280_release,				\
>  	info: qla1280_info,					\
> -	ioctl: NULL,						\
> -	command: NULL,						\
>  	queuecommand: qla1280_queuecommand,			\
> -	eh_strategy_handler: NULL,				\
> -	eh_abort_handler: NULL,					\
> -	eh_device_reset_handler: NULL,				\
> -	eh_bus_reset_handler: NULL,				\
> -	eh_host_reset_handler: NULL,				\
>  /*	use_new_eh_code: 0, */					\
>  	abort: qla1280_abort,					\
>  	reset: qla1280_reset,					\
> 
> 
> -- 

The same problem exist with ini9100u.c, solution is:

[dzimi@cyborg scsi]$ diff -urN ini9100u.h.orig ini9100u.h
--- ini9100u.h.orig     Sun Oct 20 11:08:38 2002
+++ ini9100u.h  Sun Oct 20 11:08:56 2002
@@ -89,9 +89,6 @@
 #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 
1.03g"

 #define INI9100U       { \
-       next:           NULL,                                           \
-       module:         NULL,                                           \
-       proc_name:      "INI9100U", \
        proc_info:      NULL,                           \
        name:           i91u_REVID, \
        detect:         i91u_detect, \


but this is one of them.
Compilation problem still exist, because driver should be rewrite (using 
new DMA-mapping API).
I've prepared patch, witch build and possible work, but initio.o didn't 
see my partition table. Where is the bug ?
Correct me if I wrong.

Krzysiek Taraszka			(dzimi@pld.org.pl)

AD.

Here My patch for ini9100u.c :

[dzimi@cyborg scsi]$ diff -urN ini9100u.c.orig ini9100u.c
--- ini9100u.c.orig     Sun Oct 20 11:15:39 2002
+++ ini9100u.c  Sun Oct 20 11:18:33 2002
@@ -108,8 +108,6 @@

 #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)

-#error Please convert me to Documentation/DMA-mapping.txt
-
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
 #endif
@@ -491,8 +489,8 @@
        if (SCpnt->use_sg) {
                pSrbSG = (struct scatterlist *) SCpnt->request_buffer;
                if (SCpnt->use_sg == 1) {       /* If only one entry in the list *//*      treat it as regular I/O */
-                       pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(pSrbSG->address);
-                       TotalLen = pSrbSG->length;
+                       pSCB->SCB_BufPtr = (U32) sg_dma_address(pSrbSG);
+                       TotalLen = sg_dma_len(pSrbSG);
                        pSCB->SCB_SGLen = 0;
                } else {        /* Assign SG physical address   */
                        pSCB->SCB_BufPtr = pSCB->SCB_SGPAddr;
@@ -500,8 +498,9 @@
                        for (i = 0, TotalLen = 0, pSG = 
&pSCB->SCB_SGList[0];   /* 1.01g */
                             i < SCpnt->use_sg;
                             i++, pSG++, pSrbSG++) {
-                               pSG->SG_Ptr = (U32) VIRT_TO_BUS(pSrbSG->address);
-                               TotalLen += pSG->SG_Len = pSrbSG->length;
+                               pSG->SG_Ptr = (U32) sg_dma_address(pSrbSG);
+                               pSG->SG_Len = (U32) sg_dma_len(pSrbSG);
+                               TotalLen += (U32) sg_dma_len(pSrbSG);
                        }
                        pSCB->SCB_SGLen = i;
                }


--1473552907-352050700-1035106329=:9210
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ini9100u.c.dma-mapping.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L.0210201132090.9210@ep09.kernel.pl>
Content-Description: DMA-mapping
Content-Disposition: attachment; filename="ini9100u.c.dma-mapping.patch"

LS0tIGluaTkxMDB1LmMub3JpZwlTdW4gT2N0IDIwIDExOjE1OjM5IDIwMDIN
CisrKyBpbmk5MTAwdS5jCVN1biBPY3QgMjAgMTE6MTg6MzMgMjAwMg0KQEAg
LTEwOCw4ICsxMDgsNiBAQA0KIA0KICNkZWZpbmUgQ1ZUX0xJTlVYX1ZFUlNJ
T04oVixQLFMpICAgICAgICAoViAqIDY1NTM2ICsgUCAqIDI1NiArIFMpDQog
DQotI2Vycm9yIFBsZWFzZSBjb252ZXJ0IG1lIHRvIERvY3VtZW50YXRpb24v
RE1BLW1hcHBpbmcudHh0DQotDQogI2lmbmRlZiBMSU5VWF9WRVJTSU9OX0NP
REUNCiAjaW5jbHVkZSA8bGludXgvdmVyc2lvbi5oPg0KICNlbmRpZg0KQEAg
LTQ5MSw4ICs0ODksOCBAQA0KIAlpZiAoU0NwbnQtPnVzZV9zZykgew0KIAkJ
cFNyYlNHID0gKHN0cnVjdCBzY2F0dGVybGlzdCAqKSBTQ3BudC0+cmVxdWVz
dF9idWZmZXI7DQogCQlpZiAoU0NwbnQtPnVzZV9zZyA9PSAxKSB7CS8qIElm
IG9ubHkgb25lIGVudHJ5IGluIHRoZSBsaXN0ICovLyogICAgICB0cmVhdCBp
dCBhcyByZWd1bGFyIEkvTyAqLw0KLQkJCXBTQ0ItPlNDQl9CdWZQdHIgPSAo
VTMyKSBWSVJUX1RPX0JVUyhwU3JiU0ctPmFkZHJlc3MpOw0KLQkJCVRvdGFs
TGVuID0gcFNyYlNHLT5sZW5ndGg7DQorCQkJcFNDQi0+U0NCX0J1ZlB0ciA9
IChVMzIpIHNnX2RtYV9hZGRyZXNzKHBTcmJTRyk7DQorCQkJVG90YWxMZW4g
PSBzZ19kbWFfbGVuKHBTcmJTRyk7DQogCQkJcFNDQi0+U0NCX1NHTGVuID0g
MDsNCiAJCX0gZWxzZSB7CS8qIEFzc2lnbiBTRyBwaHlzaWNhbCBhZGRyZXNz
ICAgKi8NCiAJCQlwU0NCLT5TQ0JfQnVmUHRyID0gcFNDQi0+U0NCX1NHUEFk
ZHI7DQpAQCAtNTAwLDggKzQ5OCw5IEBADQogCQkJZm9yIChpID0gMCwgVG90
YWxMZW4gPSAwLCBwU0cgPSAmcFNDQi0+U0NCX1NHTGlzdFswXTsJLyogMS4w
MWcgKi8NCiAJCQkgICAgIGkgPCBTQ3BudC0+dXNlX3NnOw0KIAkJCSAgICAg
aSsrLCBwU0crKywgcFNyYlNHKyspIHsNCi0JCQkJcFNHLT5TR19QdHIgPSAo
VTMyKSBWSVJUX1RPX0JVUyhwU3JiU0ctPmFkZHJlc3MpOw0KLQkJCQlUb3Rh
bExlbiArPSBwU0ctPlNHX0xlbiA9IHBTcmJTRy0+bGVuZ3RoOw0KKwkJCQlw
U0ctPlNHX1B0ciA9IChVMzIpIHNnX2RtYV9hZGRyZXNzKHBTcmJTRyk7DQor
CQkJCXBTRy0+U0dfTGVuID0gKFUzMikgc2dfZG1hX2xlbihwU3JiU0cpOw0K
KwkJCQlUb3RhbExlbiArPSAoVTMyKSBzZ19kbWFfbGVuKHBTcmJTRyk7DQog
CQkJfQ0KIAkJCXBTQ0ItPlNDQl9TR0xlbiA9IGk7DQogCQl9DQo=
--1473552907-352050700-1035106329=:9210
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ini9100u.h.compilation-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L.0210201132091.9210@ep09.kernel.pl>
Content-Description: compilation fix
Content-Disposition: attachment; filename="ini9100u.h.compilation-fix.patch"

LS0tIGluaTkxMDB1Lmgub3JpZwlTdW4gT2N0IDIwIDExOjA4OjM4IDIwMDIN
CisrKyBpbmk5MTAwdS5oCVN1biBPY3QgMjAgMTE6MDg6NTYgMjAwMg0KQEAg
LTg5LDkgKzg5LDYgQEANCiAjZGVmaW5lIGk5MXVfUkVWSUQgIkluaXRpbyBJ
TkktOVgwMFUvVVcgU0NTSSBkZXZpY2UgZHJpdmVyOyBSZXZpc2lvbjogMS4w
M2ciDQogDQogI2RlZmluZSBJTkk5MTAwVQl7IFwNCi0JbmV4dDoJCU5VTEws
CQkJCQkJXA0KLQltb2R1bGU6CQlOVUxMLAkJCQkJCVwNCi0JcHJvY19uYW1l
OgkiSU5JOTEwMFUiLCBcDQogCXByb2NfaW5mbzoJTlVMTCwJCQkJXA0KIAlu
YW1lOgkJaTkxdV9SRVZJRCwgXA0KIAlkZXRlY3Q6CQlpOTF1X2RldGVjdCwg
XA0K
--1473552907-352050700-1035106329=:9210--

