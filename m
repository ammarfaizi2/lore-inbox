Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289540AbSBEOdz>; Tue, 5 Feb 2002 09:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289537AbSBEOdp>; Tue, 5 Feb 2002 09:33:45 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:5540 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289523AbSBEOde>; Tue, 5 Feb 2002 09:33:34 -0500
Message-ID: <XFMail.20020205153210.R.Oehler@GDAmbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 05 Feb 2002 15:32:10 +0100 (MET)
From: Ralf Oehler <R.Oehler@GDAmbH.com>
To: Scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: one-line-patch against SCSI-Read-Error-BUG()
Cc: Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, List

I think, I found a very simple solution for this annoying BUG().

Since at least kernel 2.4.16 there is a BUG() in pci.h,
that crashes the kernel on any attempt to read a SCSI-Sector
from an erased MO-Medium and on any attempt to read
a sector from a SCSI-disk, which returns "Read-Error".

There seems to be a thinko in the corresponding code, which 
does not take into account the case where a SCSI-READ
does not return any data because of a "sense code: read error"
or a "sense code: blank sector".

I simply commented out this BUG() statement (see below)
and everything worked well from there on. The BUG()
seems to be inadequate.

Please could you check if I'm right and apply this change to the
current kernel? Again I want to stress that in my
oppinion it is dangerous for the stability of a production
machine if it crashes on the next SCSI-Read-Error it sees.
Most SCSI-Hardware today shows very few read errors, but 
please let's not rely on that. That'd be playing vabanque.


If there are tests to do, I can offer my time and hardware
(SCSI-MO drives and media with various sector sizes) to
test and in case to provide stack traces.

Regards,
        Ralf




include/asm/pci.h:
static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
                             int nents, int direction)
{
        int i;

        if (direction == PCI_DMA_NONE)
                BUG();
 
        /*
         * temporary 2.4 hack
         */
        for (i = 0; i < nents; i++ ) {
                if (sg[i].address && sg[i].page)
                        BUG();
    -------->   else if (!sg[i].address && !sg[i].page)
    -------->         BUG();
 
                if (sg[i].address)
                        sg[i].dma_address = virt_to_bus(sg[i].address);
                else
                        sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
        }
 
        flush_write_buffers();
        return nents;
}




 --------------------------------------------------------------------------
|  Ralf Oehler                          
|                                       
|  GDA - Gesellschaft fuer Digitale                              _/
|        Archivierungstechnik mbH & CoKG                        _/
|  Ein Unternehmen der Bechtle AG               #/_/_/_/ _/_/_/_/ _/_/_/_/
|                                              _/    _/ _/    _/       _/
|  E-Mail:      R.Oehler@GDAmbH.com           _/    _/ _/    _/ _/    _/
|  Tel.:        +49 6182-9271-23             _/_/_/_/ _/_/_/#/ _/_/_/#/
|  Fax.:        +49 6182-25035                    _/
|  Mail:        GDA, Bensbruchstraﬂe 11,   _/_/_/_/
|               D-63533 Mainhausen      
|  HTTP:        www.GDAmbH.com         
 --------------------------------------------------------------------------

time is a funny concept
