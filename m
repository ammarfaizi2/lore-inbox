Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVIMK0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVIMK0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVIMK0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:26:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24526 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750714AbVIMKZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:25:59 -0400
Date: Tue, 13 Sep 2005 11:25:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Douglas Gilbert <dougg@torque.net>
Cc: Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050913102555.GB30865@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Douglas Gilbert <dougg@torque.net>,
	Luben Tuikov <ltuikov@yahoo.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43251D8C.7020409@torque.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 04:17:48PM +1000, Douglas Gilbert wrote:
> FreeBSD threw out their original SCSI design and replaced it
> with CAM circa 1998. CAM has its problems but I would guess
> a modern SAS LLDD would have less "impedance mismatch" (sorry
> about the gibberish) than what Luben is now facing.

Their code doesn't scale well to current needs at all.  Please look
at the freebsd-scsi list and all the problems they have with things
like FC or iSCSI.  Or no support for REPORT_LUNs at all.  While I
wouldn't say we have the best thing since slided bread it's certainly
not as bad as some people would like to make it.

> If we look at our (im)famous <h:c:i:l> addressing string,
> the first 2 elements (i.e. "h:c") are about kernel device
> addressing (i.e. which (part of a) HBA to be initiator); the
> contentious "i" is about addressing the target and is
> transport dependent, and the "l" is for addressing within
> the target. Only the last element is true SCSI and is
> defined in SAM (to be 64 bits, not 32). In iSCSI the "i"
> is actually an adorned IP address.
> 
> So the kernel "discovers" at the "h:c" level at powerup
> (and at runtime with hotplug events); leaving the SCSI
> subsystem to do discovery at the "i" and the "l" level.

That's not true at all.  Neither is 100% mandatory in the
scsi level.  As Luben's code shows you can just call scsi_add_device
and do everything yourself.  That is nice for LLDDs that don't
fit into SAM at all like integrated RAID HBAs.  Besides that we
support a library function to do the "l" part that can be used by
transport classes or drivers.  There's a library function to do
the "i" part brute-force for SPI and modelled after SPI devices that
is still in scsi_mod.ko but isn't integrated with the core code
in any way.  Before 2.6 the predessor to this function
"scsi_scan_host" was called for every registered host, but we
fortunately got rid of that.

