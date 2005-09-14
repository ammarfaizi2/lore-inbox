Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVINTl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVINTl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVINTl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:41:58 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:62177 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932694AbVINTl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:41:57 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Sergey Panov <sipan@sipan.org>
Cc: Matthew Wilcox <matthew@wil.cx>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <ltuikov@yahoo.com>, Christoph Hellwig <hch@infradead.org>,
       Douglas Gilbert <dougg@torque.net>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>
In-Reply-To: <1126673844.26050.24.camel@sipan.sipan.org>
References: <1126308304.4799.45.camel@mulgrave>
	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>
	 <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com>
	 <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com>
	 <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com>
	 <20050913203611.GH32395@parisc-linux.org>
	 <1126673844.26050.24.camel@sipan.sipan.org>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:43:15 -0400
Message-Id: <1126723396.4588.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 00:57 -0400, Sergey Panov wrote: 
> Because set of valid LUN id represented by 8 byte combinations is not
> isomorphic to the set of unsigned int values from 0 to UINT64_MAX. While

The transformation we're using is an isomorphism that happens to have
the important property that single level type 00b LUNs are numerically
equal to the legacy uses of the lun value.

> scsilun_to_int() will convert legal LUN id into some integer, the
> int_to_scsilun() function will not produce legal  LUN id for any
> arbitrary integer lun value. 

No that's what I said.  We limit the integer scanned luns to < 256 and
use representation 00b

> For example, sequential LUN scanning should be stopped at int lun = 255
> because result of converting value 256 by int_to_scsilun() will be
> either illegal(best case) or equivalent to int lun  = 0.

It is.  That's this bit of the code:

@@ -965,6 +964,13 @@ static void scsi_sequential_lun_scan(str
                max_dev_lun = min(8U, max_dev_lun);
 
        /*
+        * regardless of what parameters we derived above, on no
+        * account scan further than SCSI_SCAN_LIMIT_LUNS
+        */
+       if (max_dev_lun > SCSI_SCAN_LIMIT_LUNS + 1)
+               max_dev_lun = SCSI_SCAN_LIMIT_LUNS + 1;
+


> LUN id should be presented to the management layers in a way similar to
> MAC addresses or FC/SAS/... WWN . E.g. the usual LUN 4  on some FC
> device will be identified by something like (in 00b, or "Peripheral
> device addressing"):
> 
> WWPN = 22:00:00:0c:50:05:df:6d
> LUN  = 00:04:00:00:00:00:00:00
> 
> 
> Interestingly enough, the following is also LUN = 4 device, but in a
> different addressing mode (01b, AKA "Logical unit addressing"):
> 
> WWPN = 22:00:00:0c:50:05:df:6d
> LUN  = 40:04:00:00:00:00:00:00

Firstly, those two LUNs are actually not equivalent (according to SAM-3
section 4.9.1) because two luns are defined to be different if expressed
in different representations.

Secondly, The idea of using u64 is that all transports that don't use
hierarchical LUNs can simply copy the number as they do today.  This
idea rests on the assumption that arrays responding to REPORT_LUNS on
these transports always reply with type 00b.  This assumption is
suggested (but not mandated) in SAM. If they violate this assumption,
we'll just reject all the LUNs and I'll get a bug report.

James

