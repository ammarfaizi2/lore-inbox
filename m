Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318394AbSGRXVP>; Thu, 18 Jul 2002 19:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318408AbSGRXVP>; Thu, 18 Jul 2002 19:21:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22286 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318394AbSGRXVO>; Thu, 18 Jul 2002 19:21:14 -0400
Date: Thu, 18 Jul 2002 19:24:13 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
Message-ID: <20020718192413.A28163@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
References: <200207181700.g6IH03U02415@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207181700.g6IH03U02415@localhost.localdomain>; from James.Bottomley@HansenPartnership.com on Thu, Jul 18, 2002 at 12:00:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 12:00:02PM -0500, James Bottomley wrote:
> In the meantime, if you want to try, the trick looks to be to use 
> pci_map_single in BusLogic_CreateInitialCCBs; but then set up a reverse 
> mapping table for them in BusLogic_InitializeCCBs so that Bus_to_Virtual will 
> still work (its only use is to convert bus physical CCB addresses into CPU 
> virtual ones).
> 
> Next, in BusLogic_QueueCommand you need to use pci_map_single for non-sg 
> transformations, and pci_map_sg for sg plus in the loop over segments, use the 
> macros
> 
> sg_dma_address(&ScatterList[Segment]) in place of ScatterList[Segment].address
> sg_dma_len(&ScatterList[Segment]) in place ofScatterList[Segment].length
> 
> Initially, don't worry about unmapping, but this should get the thing working.
> 
> There are probably other places in the driver I've missed (like sense 
> buffers), but that should be the core of the necessary changes.

There are.  I'm currently writing a patch (hopefully a first test version 
will be out in an hour or so).  It's not quite as easy as it looks at 
first mainly because this driver supports PCI, EISA, VLB, MCA, and ISA 
cards :-/

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
