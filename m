Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbVH0CRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbVH0CRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 22:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbVH0CRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 22:17:53 -0400
Received: from pat.qlogic.com ([198.70.193.2]:59501 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1751629AbVH0CRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 22:17:52 -0400
Date: Fri, 26 Aug 2005 19:17:48 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc7 qla2xxx unaligned accesses
Message-ID: <20050827021748.GU22320@plap.qlogic.org>
References: <20050824182252.GC8205@plap.qlogic.org> <11857.1124913939@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11857.1124913939@ocs3.ocs.com.au>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 27 Aug 2005 02:17:48.0193 (UTC) FILETIME=[84AD2110:01C5AAAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Keith Owens wrote:
> On Wed, 24 Aug 2005 11:22:52 -0700, 
> Andrew Vasquez <andrew.vasquez@qlogic.com> wrote:
> >On Wed, 24 Aug 2005, Keith Owens wrote:
> >
> >> 2.6.13-rc7 + kdb on ia64.  The qla2xxx drivers are getting unaligned
> >> accesses at startup.
> >> 
> >> qla2300 0000:01:02.0: Found an ISP2312, irq 66, iobase 0xc00000080f300000
> >> qla2300 0000:01:02.0: Configuring PCI space...
> >> PCI: slot 0000:01:02.0 has incorrect PCI cache line size of 0 bytes, correcting to 128
> >> qla2300 0000:01:02.0: Configure NVRAM parameters...
> >> qla2300 0000:01:02.0: Verifying loaded RISC code...
> >> qla2300 0000:01:02.0: Waiting for LIP to complete...
> >> qla2300 0000:01:02.0: Cable is unplugged...
> >> scsi1 : qla2xxx
> >> kernel unaligned access to 0xe00000300667800c, ip=0xa0000001005cd0b1
> >
> >Yes, I have a fix for this in my patch-queue.  I'll attach it here for
> >reference.  I'll forward onto linux-scsi post 2.6.13.
> >
> >--
> >av
> >
> >---
> >
> >On some platforms the hard-casting of the 8 byte node_name
> >and port_name arrays to an u64 would cause unaligned-access
> >warnings.  Generalize the conversions with consistent
> >shifting of WWN bytes.
> >
> >Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
> >---
> >
> > drivers/scsi/qla2xxx/qla_attr.c |   27 +++++++++++++++++----------
> > 1 files changed, 17 insertions(+), 10 deletions(-)
> >
> >24e16c86578498fd71a3e33bebbd8be7323a03c6
> >diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
> >--- a/drivers/scsi/qla2xxx/qla_attr.c
> >+++ b/drivers/scsi/qla2xxx/qla_attr.c
> >@@ -345,6 +345,15 @@ struct class_device_attribute *qla2x00_h
> > 
> > /* Host attributes. */
> > 
> >+static u64
> >+wwn_to_u64(uint8_t *wwn)
> >+{
> >+	return (u64)wwn[0] << 56 | (u64)wwn[1] << 48 |
> >+	    (u64)wwn[2] << 40 | (u64)wwn[3] << 32 |
> >+	    (u64)wwn[4] << 24 | (u64)wwn[5] << 16 |
> >+	    (u64)wwn[6] <<  8 | (u64)wwn[7];
> >+}
> >+
> 
> Any reason you defined your own function instead of using the standard
> get_unaligned()?

I was unaware there was even such a helper.  Anyway, the wwn_to_u64()
function adds another benefit -- clarity, were converting a 8 byte
WWN array to it's endian-agnosting 64bit value.  I suppose, we could
make it inline.

--
AV
