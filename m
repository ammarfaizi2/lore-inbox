Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUHFNS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUHFNS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUHFNS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:18:57 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26124 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268131AbUHFNSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:18:40 -0400
Date: Fri, 6 Aug 2004 14:18:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code reorganization
Message-ID: <20040806141836.A9854@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Aug 04, 2004 at 03:14:08PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 03:14:08PM -0500, Pat Gefre wrote:
> o added new hardware support
> o code cleanup (typedefs, include files, etc.)
> o simplified the directory structure (all files were arch/ia64/sn/io/
>    are now under arch/ia64/sn/ioif/)
> o code size reduced by >50%
> o major reorg of the code itself
> o copyright updates

Yikes, this is truely horrible.  First your patch ordering doesn't make
any sense, with just the first patch applied the system won't work at all.
Please submit a series of _small_ patches going from A to B keeping the code
working everywhere inbetween.

Your new directory structure is very bad.  Just stick all files into
arch/ia64/sn/io/ instead of adding subdirectories for often just a single
file.

Now to the contents:

002-pci-fixups:
  you're adding tons of non-standard SAL calls for who knows what.  In
  fact this pretty much looks like you're just moving the existing crappy
  code into the prom so the bad Linux guys can't complain about it anymore.
  Please switch to the standard ACPI PCI probing mechanism all other IA64
  machines support and you can get rid of all that.
  You're duplicating the kernel's PCI to PCI bridge support, with the normal
  IA64 pci code it would just work..

003-pci-support:
  The PCI DMA implementation is still ubercomplicated.  See the PCI DMA code
  I sent you long ago.
  Of the code in pci_extensions.c only two are actually used in the kernel
  (snia_pcibr_rrb_alloc and snia_pcidev_endian_set), please remove the unused
  other ones.

004-pci-bridge_drivers:
  You still have code dealing with all kinds of PCIIO_ and PCIBR_ flags
  that will never be set through the Linux interfaces.  Again see the DMA
  mapping code I sent you.

006-bte:
  Please merge bte_error.c into the existing bte.c

007-io-hub-provider:
  tio_provider and hub_provider have exactly the same methods, no need to
  keep the xtalk_provider_t abstraction at all

008-kdb-support-funtions:
  kdb isn't in mainline, please add the two files to the kdb patch instead


