Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSITRiE>; Fri, 20 Sep 2002 13:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbSITRiE>; Fri, 20 Sep 2002 13:38:04 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:59666 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S263143AbSITRiB> convert rfc822-to-8bit; Fri, 20 Sep 2002 13:38:01 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: TPC-C benchmark used standard RH kernel
Date: Fri, 20 Sep 2002 12:43:00 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106402D09E49@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TPC-C benchmark used standard RH kernel
Thread-Index: AcJgyev5fdnZVlzFRR+6+25odA9togAACyRA
From: "Bond, Andrew" <Andrew.Bond@hp.com>
To: "Mike Anderson" <andmike@us.ibm.com>, "Dave Hansen" <haveblue@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Sep 2002 17:43:01.0001 (UTC) FILETIME=[2A0F6790:01C260CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Mike Anderson [mailto:andmike@us.ibm.com]
> Sent: Friday, September 20, 2002 1:21 PM
> To: Dave Hansen
> Cc: Bond, Andrew; linux-kernel@vger.kernel.org
> Subject: Re: TPC-C benchmark used standard RH kernel
> 
> 
> 
> Dave Hansen [haveblue@us.ibm.com] wrote:
> > Bond, Andrew wrote:
> > > This isn't as recent as I would like, but it will give 
> you an idea.
> > > Top 75 from readprofile.  This run was not using bigpages though.
> > >
> > > 00000000 total                                      7872   0.0066
> > > c0105400 default_idle                               1367  21.3594
> > > c012ea20 find_vma_prev                               462   2.2212
> 
> > > c0142840 create_bounce                               378   1.1250
> > > c0142540 bounce_end_io_read                          332   0.9881
> 
> .. snip..
> > 
> > Forgive my complete ignorane about TPC-C...  Why do you 
> have so much 
> > idle time?  Are you I/O bound? (with that many disks, I 
> sure hope not 
> > :) )  Or is it as simple as leaving profiling running for a 
> bit before 
> > or after the benchmark was run?
> 
> The calls to create_bounce and bounce_end_io_read are indications that
> some of your IO is being bounced and will not be running a peak
> performance. 
> 
> This is avoided by using the highmem IO changes which I 
> believe are not
> in the standard RH kernel. Unknown if that would address your 
> idle time
> question.
> 
> -andmike
> 
> -- 
> Michael Anderson
> andmike@us.ibm.com
> 
> 

Yes, bounce buffers were definitely a problem and could be contributing to our idle time issues. Highmem IO is in the RH Advanced Server kernel.  Our problem was that 64-bit DMA for SCSI devices wasn't working, so all our IO to memory >4GB still required bounce buffers since the Qlogic controllers use the SCSI layer to present their drives.  So we weren't paying the full penalty as we would without any highmem support, but since 3/4 of our memory was above 4GB it was still a heavy penalty.

If we had used block device IO with our HP cciss driver, we could have done 64-bit DMA in the RHAS 2.1 environment.  However, we needed shared storage capability for the cluster.  Hence, a fibre channel HBA.

The problem was more of a "what can we support in this benchmark timeframe" issue rather than a technical one.  The technical problems are already solved.

Regards,
Andy
