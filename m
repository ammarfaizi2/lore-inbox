Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTFMBCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbTFMBCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:02:32 -0400
Received: from fmr02.intel.com ([192.55.52.25]:62195 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265086AbTFMBCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:02:31 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e1000 performance hack for ppc64 (Power4)
Date: Thu, 12 Jun 2003 18:16:11 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D932@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 performance hack for ppc64 (Power4)
Thread-Index: AcMwkxVYLrJoUOxVTFqcysT4p1dQiAAsrZBw
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "David Gibson" <dwg@au1.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, "Anton Blanchard" <anton@samba.org>,
       "Nancy Milliner" <milliner@us.ibm.com>,
       "Herman Dierks" <hdierks@us.ibm.com>,
       "Ricardo Gonzalez" <ricardoz@us.ibm.com>
X-OriginalArrivalTime: 13 Jun 2003 01:16:13.0665 (UTC) FILETIME=[619E6510:01C33149]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, arch-specific code in the driver concerns me.  I would really
like to avoid any arch-specific code in the driver if at all possible.
Can we find a way to move this work to the arch-dependent areas?  This
doesn't seem to be an issue unique to e1000, so moving this up one level
should benefit other devices as well.  More questions below.

> Peculiarities in the PCI bridges on Power4 based ppc64 machines mean
> that unaligned DMAs are horribly slow.  This hits us hard on gigabit
> transfers, since the packets (starting from the MAC header) are
> usually only 2-byte aligned.

2-byte alignment is bad for ppc64, so what is minimum alignment that is
good?  (I hope it's not 2K!)  What could you do at a higher level to
present properly aligned buffers to the driver?

> The patch below addresses this by copying and realigning packets into
> nicely 2k aligned buffers.  As well as fixing the alignment that
> minimises the number of TCE lookups, and because we allocate the
> buffers pci_alloc_consistent(), we avoid setting up and tearing down
> the TCE mappings for each packet.

If I'm understanding the patch correctly, you're saying unaligned DMA +
TCE lookup is more expensive than a data copy?  If we copy the data, we
loss some of the benefits of TSO and Zerocopy and h/w checksum
offloading!  What is more expensive, unaligned DMA or TCE?

-scott
