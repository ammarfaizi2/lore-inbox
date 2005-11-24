Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbVKXTnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbVKXTnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVKXTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:43:14 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:30114 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932649AbVKXTnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:43:12 -0500
Date: Thu, 24 Nov 2005 11:44:59 -0800
From: thockin@hockin.org
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124194459.GA4069@hockin.org>
References: <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de> <20051124192414.GA3670@hockin.org> <20051124192953.GT20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124192953.GT20775@brahms.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 08:29:53PM +0100, Andi Kleen wrote:
> > We implemented AMD's reference algorithm, and made it work in the presence
> > of a hardware IO hole.  It seems to work beautifully, but the last step is
> > turning a (node:chip-select) into a (node:dimm).  Simple boards will use
> > simple mappings, but we can't know that without board specific info.
> > Especially with quad-rank DIMMs. :)
> 
> If you get something working it would be good if you could share the code
> (even if it still needs to be tweaked) 

The below code works for us.  Note that I did not implement the
node-interleaving parts of the AMD algorithm.  If that matters, it should
be simple enough to do.  The BKDG has good pseudo-code.  The only thing it
gets absolutely wrong is the IO hole.

Let me know if you see any problems here.  This is a userspace tool, but
should be trivial to adapt.


#include <stdio.h>
#include <stdlib.h>
#include "pci.h"

#define MAX_NODES	8
#define MAX_CS		8
#define NODE_DEV(n)	(24+(n))
#define FOUR_GIG	0x01000000	// shifted to hold address[39..8]

static char *progname;

static void
usage(void)
{
	fprintf(stderr, "usage: %s <address>\n", progname);
}

/*
 * Map a CS to a pair of DIMM slots (for 128 bit operation).  This mapping
 * is board-specific, and has the potential to be very ugly.
 */
static int cs_to_pair[MAX_CS][2] = {
	{ 0, 1 }, { 0, 1 },
	{ 2, 3 }, { 2, 3 },
	{ 4, 5 }, { 4, 5 },
	{ 6, 7 }, { 6, 7 },
};

int
main(int argc, char *argv[])
{
	unsigned long long raw_addr;
	uint32_t address;
	char *endp;
	int node;

	progname = argv[0];

	if (argc != 2) {
		usage();
		exit(1);
	}
	raw_addr = strtoull(argv[1], &endp, 0);
	if (endp == argv[1]) {
		usage();
		exit(2);
	}

	/*
	 * The address space is 40 bits (for now).  We want to use 32 bit
	 * values, so we convert the input address to hold address[39..8].
	 * We'll use this format everywhere.  This loses the
	 * low-order bits, so we keep a raw copy around.
	 */
	address = (raw_addr & 0xffffffffff) >> 8;

	/* find the node that holds this address */
	for (node = 0; node < MAX_NODES; node++) {
		int pci_dev;
		uint32_t tmp;
		int dram_en;
		uint32_t dram_base;
		uint32_t dram_limit;
		int hole_en;
		uint32_t hole_base;
		uint32_t hole_size;
		int cs;

		/*
		 * The DRAM map and IO hole info are in function 1 of each
		 * node.
		 */
		pci_dev = pci_open(0, NODE_DEV(node), 1);
		if (pci_dev < 0) {
			/* node does not exist */
			break;
		}

		/*
		 * DRAM_BASE and DRAM_LIMIT already hold address[39..8].
		 */
		tmp = pci_read32(pci_dev, 0x40+(node*8));
		dram_en = tmp & 0x3;
		dram_base = tmp & 0xffff0000;

		tmp = pci_read32(pci_dev, 0x44+(node*8));
		dram_limit = tmp | 0x0000ffff;

		/*
		 * HOLE_BASE holds address[35..4], so we convert it to hold
		 * address[39..8].
		 */
		tmp = pci_read32(pci_dev, 0xf0);
		hole_en = tmp & 0x1;
		hole_base = (tmp & 0xff000000) >> 8;
		hole_size = FOUR_GIG - hole_base;

		pci_close(pci_dev);

		if (!dram_en) {
			/* no DRAM here */
			continue;
		}

		if (address > dram_limit) {
			/* keep looking */
			continue;
		}

		/*
		 * The address must be on this node.
		 */

		/* is the address in the IO hole? */
		if (hole_en && address >= hole_base && address < FOUR_GIG) {
			/* no DRAM in the IO hole */
			break;
		}

		/* is the address >= 4GB on a node with a hole? */
		if (hole_en && address >= FOUR_GIG) {
			/* adjust address for the IO hole */
			address -= hole_size;
		}

		/* adjust address to be node-relative */
		address -= dram_base;

		/* store addr[35..4] */
		address <<= 4;

		/* The chip-select map is in function 2 of each node. */
		pci_dev = pci_open(0, NODE_DEV(node), 2);

		/* find the chip-select that has this address */
		for (cs = 0; cs < MAX_CS; cs++) {
			uint32_t cs_base;
			uint32_t cs_mask;

			/*
			 * CS_BASE and CS_MASK hold address[35..0], so we
			 * convert them to hold address[39..8].
			 */
			tmp = pci_read32(pci_dev, 0x40+(cs*4));
			if ((tmp & 0x1) == 0) {
				/* this CS is not enabled */
				continue;
			}
			cs_base = tmp & 0xffe0fe00;

			tmp = pci_read32(pci_dev, 0x60+(cs*4));
			cs_mask = (tmp | 0x001f01ff) & 0x3fffffff;

			/* this should handle interleaving, too */
			if ((address & ~cs_mask) == (cs_base & ~cs_mask)) {
				int *pair = cs_to_pair[cs];
				int dimm;

				/* which DIMM is this address on? */
				if ((raw_addr & (1<<3)) == 0) {
					dimm = pair[0];
				} else {
					dimm = pair[1];
				}

				printf("node %d, CS %d, DIMM %d\n",
				       node, cs, dimm);
				break;
			}
		}
		pci_close(pci_dev);
		break;
	}
	return 0;
}
