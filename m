Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVIOCEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVIOCEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVIOCEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:04:44 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46816 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030336AbVIOCEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:04:43 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: Sergey Panov <sipan@sipan.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <ltuikov@yahoo.com>, Christoph Hellwig <hch@infradead.org>,
       Douglas Gilbert <dougg@torque.net>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>
In-Reply-To: <1126723396.4588.3.camel@mulgrave>
References: <1126308304.4799.45.camel@mulgrave>
	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>
	 <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com>
	 <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com>
	 <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com>
	 <20050913203611.GH32395@parisc-linux.org>
	 <1126673844.26050.24.camel@sipan.sipan.org>
	 <1126723396.4588.3.camel@mulgrave>
Content-Type: text/plain
Organization: Home
Date: Wed, 14 Sep 2005 22:04:39 -0400
Message-Id: <1126749879.11188.49.camel@sipan.sipan.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 14:43 -0400, James Bottomley wrote:
> On Wed, 2005-09-14 at 00:57 -0400, Sergey Panov wrote: 
> > LUN id should be presented to the management layers in a way similar to
> > MAC addresses or FC/SAS/... WWN . E.g. the usual LUN 4  on some FC
> > device will be identified by something like (in 00b, or "Peripheral
> > device addressing"):
> > 
> > WWPN = 22:00:00:0c:50:05:df:6d
> > LUN  = 00:04:00:00:00:00:00:00
> > 
> > 
> > Interestingly enough, the following is also LUN = 4 device, but in a
> > different addressing mode (01b, AKA "Logical unit addressing"):
                                  "Flat space addressing"               
> > 
> > WWPN = 22:00:00:0c:50:05:df:6d
> > LUN  = 40:04:00:00:00:00:00:00
> 
> Firstly, those two LUNs are actually not equivalent (according to SAM-3
> section 4.9.1) because two luns are defined to be different if expressed
> in different representations.

I was not saying those are two different addresses of the same LUN, but
those two are LUN 4 in 00b and LUN 4 in 01b addressing mode.

 But according to 4.9.4 a target with more then 255 LUNs may use 00b
addressing for LUNs 0-255 and 01b addressing for LUNs 256 and higher.

In your integer representation those would be lun=4 and lun=16388 ,
because in that integer representation 00b LUNs occupy range  0-255 and
01b LUNs cover range 16384-32768 (while LU numbers are actually
0-16383). 

It is my understanding that "lun" values in ranges 256-16383 and
32769-65535 do not represent any LUN at all if target supports only
single level addressing.  

> Secondly, The idea of using u64 is that all transports that don't use
> hierarchical LUNs can simply copy the number as they do today.  This
> idea rests on the assumption that arrays responding to REPORT_LUNS on
> these transports always reply with type 00b.

It is recommended to use 00b  if target has no more then 256 LUNs. But
there are arrays which support more then 256 LUNs and those arrays have
to use 01b addressing when configured with such big sets of LUNs.

>   This assumption is
> suggested (but not mandated) in SAM. If they violate this assumption,
> we'll just reject all the LUNs and I'll get a bug report.

Nice! Actually, I do believe the 01b addressing is interpreted correctly
in in code which processes response from the REPORT_LUN.

----------------------------------------

The point I was trying to make is that it would be a simplification if
SCSI code was using byte array as a LUN identifier internally. No
translation is needed when processing REPORT_LUN response and no
translation is needed in queuecommand. LLDD for non-conforming HBAs will
have to replace lun with lun[1].

The only time you want to present lun[]={0,LUN,0,0,0,0,0} as just LUN is
when that number has to be reported to the user space.  


Sergey Panov

======================================================================
Any opinions are personal and not necessarily those of my former,
present, or future employers.



