Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSFMCSK>; Wed, 12 Jun 2002 22:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSFMCSJ>; Wed, 12 Jun 2002 22:18:09 -0400
Received: from host194.steeleye.com ([216.33.1.194]:2313 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317404AbSFMCSH>; Wed, 12 Jun 2002 22:18:07 -0400
Message-Id: <200206130218.g5D2Hx302994@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Roland Dreier <roland@topspin.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4 use __dma_buffer in scsi.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jun 2002 22:17:59 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Use __dma_buffer macro to align sense_buffer member of Scsi_Cmnd.
[...]

> -       unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];              /* obtained by REQUEST SENSE
> +       unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE] __dma_buffer;         /* obtained by REQUEST SENSE

This is actually unnecessary.  We've already had this discussion on the parisc 
mailing lists (over a year ago, I think).

The SCSI subsystem is designed with this type of cache incoherency problem in 
mind.  The Scsi_Cmnd structure has an ownership model to forestall cache line 
bouncing.  The idea is that when you want to dma to/from components of a 
Scsi_Cmnd, you can only do it when the ownership is SCSI_OWNER_LOW_LEVEL, 
which guarantees that nothing in the mid layer will touch the command and 
trigger an incoherency (at least until it times out).  The low level driver is 
supposed to know about the cache incoherency problem, and so avoids touching 
the structure between cache line invalidation/writeback and DMA completion, 
thus, with a correctly implemented driver, there should be no possibility of 
DMA corruption.

Each of the Scsi_Cmnd blocks is individually allocated with kmalloc, so 
they're guaranteed to be non-interfering when it comes to DMA.

Incidentally, if you're really going to insist on padding the structure, some 
drivers also use the cmnd element to DMA the command from, so that should be 
aligned as well.  But I think the best course of action is to fix any low 
level drivers that are not following the cache rules rather than expanding 
Scsi_Cmnd.

James Bottomley


