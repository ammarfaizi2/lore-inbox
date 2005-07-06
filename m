Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVGFQSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVGFQSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVGFQSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:18:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:20611 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262204AbVGFMBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:01:44 -0400
Date: Wed, 6 Jul 2005 17:40:53 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Chris Mason <mason@suse.com>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: aio-stress regressions in 2.6.12 narrowed down to AIC7xxx
Message-ID: <20050706121053.GA4765@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050701075600.GC4625@in.ibm.com> <200507051000.25591.mason@suse.com> <20050706103729.GA4600@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706103729.GA4600@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I think I have narrowed it down to aic7xxx driver, because when
I specify CONFIG_SCSI_AIC7XXX_OLD, it does not regress. 

The regression occurs from 2.6.11 to 2.6.12  (from 17MB/s it goes down to
11MB/s)

The regression is still there in 2.6.13-rc1 +  the "speed fix" patch(discussed
in the recent aic7xxx regression thread on linux-scsi)

Recreate by running: aio-stress -O -o3 <1 GB testfile>

Config options:
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y


Comparing dmesg outputs
On 2.6.11
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
...

On 2.6.12
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
 target0:0:0: Ending Domain Validation
  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
...


On 2.6.13-rc1 + "speed fix"
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

 target0:0:0: asynchronous.
  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 63)
 target0:0:0: Ending Domain Validation
target0:0:1: asynchronous.
  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
...

Regards
Suparna


On Wed, Jul 06, 2005 at 04:07:29PM +0530, Suparna Bhattacharya wrote:
> On Tue, Jul 05, 2005 at 10:00:24AM -0400, Chris Mason wrote:
> > On Friday 01 July 2005 03:56, Suparna Bhattacharya wrote:
> > > Has anyone else noticed major throughput regressions for random
> > > reads/writes with aio-stress in 2.6.12 ?
> > > Or have there been any other FS/IO regressions lately ?
> > >
> > > On one test system I see a degradation from around 17+ MB/s to 11MB/s
> > > for random O_DIRECT AIO (aio-stress -o3 testext3/rwfile5) from 2.6.11
> > > to 2.6.12. It doesn't seem filesystem specific. Not good :(
> > >
> > > BTW, Chris/Ben, it doesn't look like the changes to aio.c have had an
> > > impact (I copied those back to my 2.6.11 tree and tried the runs with no
> > > effect) So it is something else ...
> > >
> > > Ideas/thoughts/observations ?
> > 
> > Lets try to narrow it down a bit:
> > 
> > aio-stress -o 3 -d 1 will set the depth to 1, (io_submit then wait one request 
> This doesn't regress - the problem really happens when we don't wait one
> at a time.
> 
> > at a time).  This doesn't take the aio subsystem out of the picture, but it 
> > does make the block layer interaction more or less the same as non-aio 
> > benchmarks.  If this is slow, I would suspect something in the block layer, 
> > and iozone -I -i 2 -w -f testext3/rwfile5 should also show the regression.
> > 
> > If it doesn't regress, I would suspect something in the aio core.  My first 
> > attempts at the context switch reduction patches caused this kind of 
> > regression.  There was too much latency in sending the events up to userland.
> > 
> > Other options:
> > 
> > Try different elevators
> 
> Still regresses (I tried noop instead of as)
> 
> > Try O_SYNC aio random writes
> > Try aio random reads
> > Try buffers random reads
> 
> Again all these end up waiting one at a time with mainline because it
> forces buffered AIO to be synchronous, so we the regression doesn't
> show up. But, when I apply my patches to make buffered fsAIO async,
> so we aren't waiting one at a time -- there is a similar regression.
> In fact it was this regression that made me go back and check if it
> was happening with AIO-DIO as well.
> 
> Regards
> Suparna
> 
> > 
> > -chris
> 
> -- 
> Suparna Bhattacharya (suparna@in.ibm.com)
> Linux Technology Center
> IBM Software Lab, India
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

