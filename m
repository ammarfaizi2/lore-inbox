Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWDTWbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWDTWbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWDTWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:31:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932069AbWDTWbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:31:03 -0400
Date: Thu, 20 Apr 2006 15:29:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ken Witherow <ken@krwtech.com>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.6.16] scsi: clean up warnings in Advansys driver
Message-Id: <20060420152958.32f6e99a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604201735100.2044@death>
References: <Pine.LNX.4.64.0604191444200.1841@death>
	<20060419163247.6986a87c.akpm@osdl.org>
	<20060419224202.3e2f99f5.akpm@osdl.org>
	<Pine.LNX.4.64.0604200242410.3134@death>
	<20060420004915.45cd34be.akpm@osdl.org>
	<Pine.LNX.4.64.0604201735100.2044@death>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Witherow <ken@krwtech.com> wrote:
>
> Fix typecast warnings and switch from check_region to request_region
> 
> Signed-off-by: Ken Witherow <ken@krwtech.com>
> 
> ---
>   drivers/scsi/advansys.c |   17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> 
> 
> --- linux-2.6.16/drivers/scsi/advansys.c	2006-03-20 00:53:29.000000000 -0500
> +++ linux/drivers/scsi/advansys.c	2006-04-20 17:27:43.000000000 -0400
> @@ -2056,11 +2056,11 @@ STATIC ASC_DCNT  AscGetMaxDmaCount(ushor
>   /*
>    * Define Adv Library required memory access macros.
>    */
> -#define ADV_MEM_READB(addr) readb(addr)
> -#define ADV_MEM_READW(addr) readw(addr)
> -#define ADV_MEM_WRITEB(addr, byte) writeb(byte, addr)
> -#define ADV_MEM_WRITEW(addr, word) writew(word, addr)
> -#define ADV_MEM_WRITEDW(addr, dword) writel(dword, addr)
> +#define ADV_MEM_READB(addr) readb((void *) addr)
> +#define ADV_MEM_READW(addr) readw((void *) addr)
> +#define ADV_MEM_WRITEB(addr, byte) writeb(byte, (void *) addr)
> +#define ADV_MEM_WRITEW(addr, word) writew(word, (void *) addr)
> +#define ADV_MEM_WRITEDW(addr, dword) writel(dword,(void *) addr)

Yes, I already did that, only I stuck a new #warning in there as well,
because this isn't the right fix.

>   #define ADV_CARRIER_COUNT (ASC_DEF_MAX_HOST_QNG + 15)
> 
> @@ -4415,7 +4415,7 @@ advansys_detect(struct scsi_host_templat
>                           ASC_DBG1(1,
>                                   "advansys_detect: probing I/O port 0x%x...\n",
>                               iop);
> -                        if (check_region(iop, ASC_IOADR_GAP) != 0) {
> +			if (!request_region(iop, ASC_IOADR_GAP, "advansys")){
>                               printk(
>   "AdvanSys SCSI: specified I/O Port 0x%X is busy\n", iop);
>                               /* Don't try this I/O port twice. */
> @@ -4425,6 +4425,7 @@ advansys_detect(struct scsi_host_templat
>                               printk(
>   "AdvanSys SCSI: specified I/O Port 0x%X has no adapter\n", iop);
>                               /* Don't try this I/O port twice. */
> +			    release_region(iop, ASC_IOADR_GAP);
>                               asc_ioport[ioport] = 0;
>                               goto ioport_try_again;
>                           } else {
> @@ -4445,6 +4446,7 @@ advansys_detect(struct scsi_host_templat
>                                    ioport++;
>                                    goto ioport_try_again;
>                               }
> +			    release_region(iop, ASC_IOADR_GAP);
>                           }
>                           /*
>                            * This board appears good, don't try the I/O port
> @@ -9752,13 +9754,14 @@ AscSearchIOPortAddr11(
>       }
>       for (; i < ASC_IOADR_TABLE_MAX_IX; i++) {
>           iop_base = _asc_def_iop_base[i];
> -        if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
> +	if (!request_region(iop_base, ASC_IOADR_GAP, "advansys")){
>               ASC_DBG1(1,
>                  "AscSearchIOPortAddr11: check_region() failed I/O port 0x%x\n",
>                        iop_base);
>               continue;
>           }
>           ASC_DBG1(1, "AscSearchIOPortAddr11: probing I/O port 0x%x\n", iop_base);
> +	release_region(iop_base, ASC_IOADR_GAP);
>           if (AscFindSignature(iop_base)) {
>               return (iop_base);
>           }

OK, thanks.  But I added this fixup on top:


--- devel/drivers/scsi/advansys.c~scsi-clean-up-warnings-in-advansys-driver-fix	2006-04-20 15:28:07.000000000 -0700
+++ devel-akpm/drivers/scsi/advansys.c	2006-04-20 15:28:07.000000000 -0700
@@ -4445,9 +4445,9 @@ advansys_detect(struct scsi_host_templat
                                   * 'ioport' past this board.
                                   */
                                  ioport++;
+				 release_region(iop, ASC_IOADR_GAP);
                                  goto ioport_try_again;
                             }
-			    release_region(iop, ASC_IOADR_GAP);
                         }
                         /*
                          * This board appears good, don't try the I/O port
_

