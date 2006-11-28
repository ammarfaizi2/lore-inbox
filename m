Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936027AbWK1THM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936027AbWK1THM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936028AbWK1THM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:07:12 -0500
Received: from qb-out-0506.google.com ([72.14.204.233]:2374 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S936027AbWK1THK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:07:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TQKhw56MVX+s/wOblbo2gmkBFeFDTAz2o52vQTSRvdPAuUpRHa9y1G3if0VgqlTTwTHEqctMYaeoPWLSe3uwOp70YjEsrR+LaoNEAD8YaBB7VW7lBL8bTN7kYvpwOMQlW9uR2k8wUm2nrj9oZW/2G+vL4MzsIwRzByJoVCqyf8k=
Message-ID: <e6babb600611281107j2f03d5a7ld0214b2e82b305b8@mail.gmail.com>
Date: Tue, 28 Nov 2006 12:07:08 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <456B680D.2000703@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
	 <4564C4C7.5060403@s5r6.in-berlin.de>
	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>
	 <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>
	 <456B1C52.4040305@s5r6.in-berlin.de>
	 <e6babb600611270946o738327feqd7a18f2f1ff8fccd@mail.gmail.com>
	 <456B2DD0.4060500@s5r6.in-berlin.de>
	 <e6babb600611271234u5bb09ef1j1e26d68548770e88@mail.gmail.com>
	 <456B680D.2000703@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Posted writes are still enabled. phys_dma=0 disables only the physical
> response unit. You have to change the source if you want to disable
> posted writes. See the top of ohci_initialize. Should this be a module
> load parameter too?

Er.  I misspoke.  What I need is for write requests directed to
address 0 to be directed to the asynchronous unit so that I can treat
them as regular asynchronous write requests.  As the OHCI 1.1 spec
says:

"Physical requests that are rejected by the PhysicalRequestFilter
shall be sent to the AR Request DMA context if the AR Request DMA
context is enabled". (5.14.2, page 58)

That does appear to be happening: I have an ARM mapping set to begin
at 0 and extend some ways along, and I do receive write requests.  At
first I was simply changing the lines:

reg_write(ohci,OHCI1394_PhyReqFilterHiSet, 0xffffffff);
reg_write(ohci,OHCI1394_PhyReqFilterLoSet, 0xffffffff);

to be 0x0000 0000 instead, but then I paid more attention to the
source and saw the phys_dma parameter, which does the same. .... Well,
*did*, in 2.6.16.  I see that 2.6.18 doesn't write 0 if !phys_dma, it
just leaves the values alone, but I guess that's okay since they are
set to 0 on reset.  Same difference.

So that's okay.  Uhm, mostly.  You should really see the horrors I
have created in order to be able to have 5 hosts map the same address
range (the custom protocol we're using doesn't use the destination
address at all, so it's 0 for everybody).

So long ways round, I think the phys_dma parameter is the proper thing for me.

And I will try and do some actual thinking about what is happening.  I
was hoping to offload that work to you and simply perform mechanical
changes to the source!  Rats!

-- 
Robert Crocombe
rcrocomb@gmail.com
