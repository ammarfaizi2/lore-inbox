Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSJGBqA>; Sun, 6 Oct 2002 21:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262331AbSJGBqA>; Sun, 6 Oct 2002 21:46:00 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60178
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262304AbSJGBp7>; Sun, 6 Oct 2002 21:45:59 -0400
Date: Sun, 6 Oct 2002 18:48:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Murray J. Root" <murrayr@brain.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40-ac4  kernel BUG at slab.c:1477!
In-Reply-To: <3DA03B17.8010501@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10210061845320.23945-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Only that if it is SG it must conform the ATA/ATAPI DMA on 64kb on 4b
boundaries.  Some what basic stuff iirc, but remember this is piped via
scsi and the eh-stratagy/joke leaves something to be desired.

One concern could be crossing SG lists with the device in PIO, that could
get hairy.

On Sun, 6 Oct 2002, Manfred Spraul wrote:

>  > This happens at random during boot when loading modules.
>  > About half of the time ide-scsi works fine.
>  > The system continues to boot after the BUG with /dev/hdc unaccessible.
> 
> from mm/slab.c:
> 
> 1475 if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
> 1476     /* Either write before start, or a double free. */
> 1477     BUG();
> 
> You run an uniprocessor kernel, with slab debugging enabled, and the 
> red-zoning test notices a write before the beginning of the buffer 
> during scsi_probe_and_add_lun, with ide-scsi.
> 
> Andre: Do you know if ide-scsi makes any assumptions about memory 
> alignment of the input buffers? With slab debugging disabled, the 
> alignment is 32 or 64 bytes, with debugging enabled, it's just 4 byte 
> [actually sizeof(void*)] aligned.
> 
> Murray, could you apply the attached patch? It dumps the redzone value 
> during scsi_probe_and_add_lun. Hopefully this will help to find who 
> corrupts the buffers.
> 
> --
> 	Manfred
> 

Andre Hedrick
LAD Storage Consulting Group

