Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285147AbRLMUMX>; Thu, 13 Dec 2001 15:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285151AbRLMUMO>; Thu, 13 Dec 2001 15:12:14 -0500
Received: from zok.sgi.com ([204.94.215.101]:5787 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285147AbRLMUMK>;
	Thu, 13 Dec 2001 15:12:10 -0500
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: Steve Lord <lord@sgi.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Jens Axboe <axboe@suse.de>, LBJM <LB33JM16@yahoo.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200112101950.fBAJoxg54527@aslan.scsiguy.com>
In-Reply-To: <200112101950.fBAJoxg54527@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.13.08.57 (Preview Release)
Date: 13 Dec 2001 14:10:20 -0600
Message-Id: <1008274220.22093.3.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 13:50, Justin T. Gibbs wrote:
> >Ok I decided to try and trace this.
> 
> ...
> 
> >		/*
> >		 * The sg_count may be larger than nseg if
> >		 * a transfer crosses a 32bit page.
> >		 */ 
> >
> >hmm, here it already starts to smell fishy...
> >
> >		scb->sg_count = 0;
> >		while(cur_seg < end_seg) {
> >			bus_addr_t addr;
> >			bus_size_t len;
> >			int consumed;
> >
> >			addr = sg_dma_address(cur_seg);
> >			len = sg_dma_len(cur_seg);
> >			consumed = ahc_linux_map_seg(ahc, scb, sg, addr, len);
> >
> >ahc_linux_map_seg checks if scb->sg_count gets bigger than AHC_NSEG, in
> >fact the test is
> >
> >	if (scb->sg_count + 1 > AHC_NSEC)
> >		panic()
> >
> >What am I missing here?? I see nothing preventing hitting this panic in
> >some circumstances.
> 
> If you don't cross a 4GB boundary, this is the same as a static test
> that you never have more than AHC_NSEG segments.
> 
> >	if (scb->sg_count + 2 > AHC_NSEG)
> >		panic()
> >
> >weee, we crossed a 4gb boundary and suddenly we have bigger problems
> >yet. Ok, so what I think the deal is here is that AHC_NSEG are two
> >different things to your driver and the mid layer.
> >
> >Am I missing something? It can't be this obvious.
> 
> You will never cross a 4GB boundary on a machine with only 2GB of
> physical memory.  This report and another I have received are for
> configurations with 2GB or less memory.  This is not the cause of the
> problem.  Further, after this code was written, David Miller made the
> comment that an I/O that crosses a 4GB boundary will never be generated
> for the exact same reason that this check is included in the aic7xxx
> driver - you can't cross a 4GB page in a single PCI DAC transaction.  
> I should go verify that this is really the case in recent 2.4.X kernels.
> 
> Saying that AHC_NSEG and the segment count exported to the mid-layer are
> too differnt things is true to some extent, but if the 4GB rule is not
> honored by the mid-layer implicitly, I would have to tell the mid-layer
> I can only handle half the number of segments I really can.  This isn't
> good for the memory footprint of the driver.  The test was added to
> protect against a situation that I don't believe can now happen in Linux.
> 
> In truth, the solution to these kinds of problems is to export alignment,
> boundary, and range restrictions on memory mappings from the device
> driver to the layer creating the mappings.  This is the only way to
> generically allow a device driver to export a true segment limit.


Another data point on this problem, In 2.5.1-pre11 running XFS I can now
hit this panic 100% of the time running bonnie++. And I do not have
HIGHMEM, I have 128M of memory.

It looks to me like request merging has got too efficient for its own
good!

This is the scsi info printed at startup:

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST39175LW         Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >

And this is the scb:
0xc7f945b0 c7f90040 c7f943dc 00000000 00000000   @.yG\CyG........
0xc7f945c0 c7f945f0 c7f5e000 c7fb0800 00000000   pEyG.`uG..{G....
0xc7f945d0 c7bd38c0 c7bd3900 c530c000 0530c008   @8=G.9=G.@0E.@0.
0xc7f945e0 00000080 c7f90140 c7f94478 00000000   ....@.yGxDyG....
0xc7f945f0 00000000 c7f94554 c7f58000 c7fb0800   ....TEyG..uG..{G
0xc7f94600 00004000 c7bd38a0 c7bd3900 c530c400   .@.. 8=G.9=G.D0E
0xc7f94610 0530c408 00000080 c7f90080 c7f94478   .D0.......yGxDyG
0xc7f94620 00000000 c7f9464c c7f94a00 c7f59c00   ....LFyG.JyG..uG

I have the system in a debugger and can look at memory for you
if you want.


Steve


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
