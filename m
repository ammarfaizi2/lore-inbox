Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSJTJhu>; Sun, 20 Oct 2002 05:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbSJTJh3>; Sun, 20 Oct 2002 05:37:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27604 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263270AbSJTJa6>;
	Sun, 20 Oct 2002 05:30:58 -0400
Date: Sun, 20 Oct 2002 11:36:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Krzysiek Taraszka <dzimi@pld.org.pl>
Cc: haoviet@tuluc.com, linux-kernel@vger.kernel.org
Subject: Re: ini9100u.c fixes ? (Was 2.5.44 compilation errors)
Message-ID: <20021020093648.GB24484@suse.de>
References: <33182.24.130.42.133.1035014240.squirrel@mail.tuluc.com> <20021019090637.GE871@suse.de> <Pine.LNX.4.44L.0210201103040.9210-300000@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210201103040.9210-300000@ep09.kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20 2002, Krzysiek Taraszka wrote:
> The same problem exist with ini9100u.c, solution is:
> 
> [dzimi@cyborg scsi]$ diff -urN ini9100u.h.orig ini9100u.h
> --- ini9100u.h.orig     Sun Oct 20 11:08:38 2002
> +++ ini9100u.h  Sun Oct 20 11:08:56 2002
> @@ -89,9 +89,6 @@
>  #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 
> 1.03g"
> 
>  #define INI9100U       { \
> -       next:           NULL,                                           \
> -       module:         NULL,                                           \
> -       proc_name:      "INI9100U", \
>         proc_info:      NULL,                           \
>         name:           i91u_REVID, \
>         detect:         i91u_detect, \

Please just kill any NULL assignments, they are not needed.

> but this is one of them.
> Compilation problem still exist, because driver should be rewrite (using 
> new DMA-mapping API).
> I've prepared patch, witch build and possible work, but initio.o didn't 
> see my partition table. Where is the bug ?
> Correct me if I wrong.
> 
> Krzysiek Taraszka			(dzimi@pld.org.pl)
> 
> AD.
> 
> Here My patch for ini9100u.c :
> 
> [dzimi@cyborg scsi]$ diff -urN ini9100u.c.orig ini9100u.c
> --- ini9100u.c.orig     Sun Oct 20 11:15:39 2002
> +++ ini9100u.c  Sun Oct 20 11:18:33 2002
> @@ -108,8 +108,6 @@
> 
>  #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
> 
> -#error Please convert me to Documentation/DMA-mapping.txt

First step, read this document!

>  #ifndef LINUX_VERSION_CODE
>  #include <linux/version.h>
>  #endif
> @@ -491,8 +489,8 @@
>         if (SCpnt->use_sg) {
>                 pSrbSG = (struct scatterlist *) SCpnt->request_buffer;
>                 if (SCpnt->use_sg == 1) {       /* If only one entry in the list *//*      treat it as regular I/O */
> -                       pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(pSrbSG->address);
> -                       TotalLen = pSrbSG->length;
> +                       pSCB->SCB_BufPtr = (U32) sg_dma_address(pSrbSG);
> +                       TotalLen = sg_dma_len(pSrbSG);
>                         pSCB->SCB_SGLen = 0;
>                 } else {        /* Assign SG physical address   */
>                         pSCB->SCB_BufPtr = pSCB->SCB_SGPAddr;

You didn't read the document :). You are not mapping the scatterlist for
dma before using sg_dma_address() on the element. So pSCB->SCB_BufPtr is
now 0.

> @@ -500,8 +498,9 @@
>                         for (i = 0, TotalLen = 0, pSG = 
> &pSCB->SCB_SGList[0];   /* 1.01g */
>                              i < SCpnt->use_sg;
>                              i++, pSG++, pSrbSG++) {
> -                               pSG->SG_Ptr = (U32) VIRT_TO_BUS(pSrbSG->address);
> -                               TotalLen += pSG->SG_Len = pSrbSG->length;
> +                               pSG->SG_Ptr = (U32) sg_dma_address(pSrbSG);
> +                               pSG->SG_Len = (U32) sg_dma_len(pSrbSG);
> +                               TotalLen += (U32) sg_dma_len(pSrbSG);

Ditto

-- 
Jens Axboe

