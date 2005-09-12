Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVILRXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVILRXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVILRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:23:04 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:10184 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932111AbVILRXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:23:02 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Douglas Gilbert <dougg@torque.net>, Christoph Hellwig <hch@infradead.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050912164548.GB11455@us.ibm.com>
References: <1126308304.4799.45.camel@mulgrave>
	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>
	 <1126537041.4825.28.camel@mulgrave>  <20050912164548.GB11455@us.ibm.com>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 12:21:20 -0500
Message-Id: <1126545680.4825.40.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 09:45 -0700, Patrick Mansfield wrote:
> On Mon, Sep 12, 2005 at 09:57:21AM -0500, James Bottomley wrote:
> > be free to increase it if necessary.  Note: you do actually need either
> > an array with more than two levels of nesting actually to need the
> > increase and no-one actually seems to have one of these yet.
> 
> That is not correct, I posted before on this, the address method is in the
> high bits of the 8 byte LUN and tells how to "interpret" the LUN value.
> You can't convert from an int to 8 byte LUN (without any other
> information) and set these bits. See SAM-4 in (or near) section 4.9.7.
> 
> So some storage devices that want to use addressing methods other than 00b
> don't because we do not have 8 byte LUN support in linux, and then we have
> other problems because of this.

Well, as long as we represent the u32 (or u64) as

scsilun[1] | (scsilun[0] << 8) | (scsilun[3] << 16) | (scsilun[2] << 24)

I think we cover all 2 level lun bases, don't we (obviously we ignore
levels 3 and 4 [and 6 and 8 byte extended luns])?

That representation works transparently for type 00b which is what SPI
and other legacy expects, since our lun variable is equal to the actual
numeric lun.  Although SAM allows type 01b for arrays with < 256 LUNs it
does strongly suggest you use type 00b which hopefully will cover us for
a while longer...

fc already uses int_to_scsilun and 8 byte LUN addressing, so it will
work even in the 01b case (the numbers that the mid-layer prints will
look odd, but at least the driver will work).

James


