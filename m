Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265795AbSJTJ5E>; Sun, 20 Oct 2002 05:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265796AbSJTJ5E>; Sun, 20 Oct 2002 05:57:04 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:14131 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S265795AbSJTJ5D>;
	Sun, 20 Oct 2002 05:57:03 -0400
Date: Sun, 20 Oct 2002 12:03:03 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@pld.org.pl>
X-X-Sender: dzimi@ep09.kernel.pl
To: Jens Axboe <axboe@suse.de>
cc: haoviet@tuluc.com, <linux-kernel@vger.kernel.org>
Subject: Re: ini9100u.c fixes ? (Was 2.5.44 compilation errors)
In-Reply-To: <20021020093648.GB24484@suse.de>
Message-ID: <Pine.LNX.4.44L.0210201158100.1912-100000@ep09.kernel.pl>
References: <33182.24.130.42.133.1035014240.squirrel@mail.tuluc.com>
 <20021019090637.GE871@suse.de> <Pine.LNX.4.44L.0210201103040.9210-300000@ep09.kernel.pl>
 <20021020093648.GB24484@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Jens Axboe wrote:

> On Sun, Oct 20 2002, Krzysiek Taraszka wrote:
> > The same problem exist with ini9100u.c, solution is:
> > 
> > [dzimi@cyborg scsi]$ diff -urN ini9100u.h.orig ini9100u.h
> > --- ini9100u.h.orig     Sun Oct 20 11:08:38 2002
> > +++ ini9100u.h  Sun Oct 20 11:08:56 2002
> > @@ -89,9 +89,6 @@
> >  #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 
> > 1.03g"
> > 
> >  #define INI9100U       { \
> > -       next:           NULL,                                           \
> > -       module:         NULL,                                           \
> > -       proc_name:      "INI9100U", \
> >         proc_info:      NULL,                           \
> >         name:           i91u_REVID, \
> >         detect:         i91u_detect, \
> 
> Please just kill any NULL assignments, they are not needed.
> 
> > but this is one of them.
> > Compilation problem still exist, because driver should be rewrite (using 
> > new DMA-mapping API).
> > I've prepared patch, witch build and possible work, but initio.o didn't 
> > see my partition table. Where is the bug ?
> > Correct me if I wrong.
> > 
> > Krzysiek Taraszka			(dzimi@pld.org.pl)
> > 
> > AD.
> > 
> > Here My patch for ini9100u.c :
> > 
> > [dzimi@cyborg scsi]$ diff -urN ini9100u.c.orig ini9100u.c
> > --- ini9100u.c.orig     Sun Oct 20 11:15:39 2002
> > +++ ini9100u.c  Sun Oct 20 11:18:33 2002
> > @@ -108,8 +108,6 @@
> > 
> >  #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
> > 
> > -#error Please convert me to Documentation/DMA-mapping.txt
> 
> First step, read this document!
> 
> >  #ifndef LINUX_VERSION_CODE
> >  #include <linux/version.h>
> >  #endif
> > @@ -491,8 +489,8 @@
> >         if (SCpnt->use_sg) {
> >                 pSrbSG = (struct scatterlist *) SCpnt->request_buffer;
> >                 if (SCpnt->use_sg == 1) {       /* If only one entry in the list *//*      treat it as regular I/O */
> > -                       pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(pSrbSG->address);
> > -                       TotalLen = pSrbSG->length;
> > +                       pSCB->SCB_BufPtr = (U32) sg_dma_address(pSrbSG);
> > +                       TotalLen = sg_dma_len(pSrbSG);
> >                         pSCB->SCB_SGLen = 0;
> >                 } else {        /* Assign SG physical address   */
> >                         pSCB->SCB_BufPtr = pSCB->SCB_SGPAddr;
> 
> You didn't read the document :). You are not mapping the scatterlist for
> dma before using sg_dma_address() on the element. So pSCB->SCB_BufPtr is
> now 0.

well, i read but this is my first contact with 2.5 tree, I need to read 
more documents and other scsi drivers! Now i know why doesn't work. :)
Thanks a lot.

Krzysiek Taraszka			(dzimi@pld.org.pl)

