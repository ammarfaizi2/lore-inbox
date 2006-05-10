Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWEJWEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWEJWEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWEJWEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:04:24 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:18481 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932496AbWEJWEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:04:22 -0400
X-IronPort-AV: i="4.05,111,1146466800"; 
   d="scan'208"; a="274766815:sNHT35615824"
To: Brice Goglin <bgoglin@myri.com>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>, <brice@myri.com>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
X-Message-Flag: Warning: May contain useful information
References: <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 May 2006 15:04:20 -0700
In-Reply-To: <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com> (Brice Goglin's message of "Wed, 10 May 2006 14:40:22 -0700 (PDT)")
Message-ID: <adahd3x7d0b.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 May 2006 22:04:21.0814 (UTC) FILETIME=[B1219560:01C6747D]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +typedef struct {
 > +	mcp_kreq_ether_recv_t __iomem *lanai;	/* lanai ptr for recv ring */
 > +	volatile uint8_t __iomem *wc_fifo;	/* w/c rx dma addr fifo address */
 > +	mcp_kreq_ether_recv_t *shadow;	/* host shadow of recv ring */
 > +	struct myri10ge_rx_buffer_state *info;
 > +	int cnt;
 > +	int alloc_fail;
 > +	int mask;			/* number of rx slots -1 */
 > +} myri10ge_rx_buf_t;

Why is wc_fifo volatile?  The only places you actually use it, you
seem to cast away the volatile anyway.

Also, again, no typedef of structures please.

 > +#define myri10ge_pio_copy(to,from,size) __iowrite64_copy(to,from,size/8)

Why do you need this wrapper?  Why not just call __iowrite64_copy()
without the obfuscation?  Anyone reading the code will just have to
search back to this define and mentally translate the size back and
forth all the time.

 > +int myri10ge_hyper_msi_cap_on(struct pci_dev *pdev)
 > +{
 > +	uint8_t cap_off;
 > +	int nbcap = 0;
 > +
 > +	cap_off = PCI_CAPABILITY_LIST - 1;
 > +	/* go through all caps looking for a hypertransport msi mapping */

This looks like something that should be fixed up in the general PCI
quirk handling rather than in every driver...

 > +static int
 > +myri10ge_use_msi(struct pci_dev *pdev)
 > +{
 > +	if (myri10ge_msi == 1 || myri10ge_msi == 0)
 > +		return myri10ge_msi;
 > +
 > +	/*  find root complex for our device */
 > +	while (pdev->bus && pdev->bus->self) {
 > +		pdev = pdev->bus->self;
 > +	}

Similarly looks like generic PCI code (if it's needed at all).  If I
understand correctly you're trying to check if MSI has a chance at
working on the system, but a network device driver has no business
walking up the PCI hierarchy.

 > +	buf = (mcp_cmd_t *) ((unsigned long)(buf_bytes + 7) & ~7UL);

ALIGN() from <linux/kernel.h>?

 - R.
