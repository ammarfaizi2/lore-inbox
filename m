Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVBAJX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVBAJX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVBAJX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:23:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33209 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261895AbVBAJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:23:39 -0500
Date: Tue, 1 Feb 2005 09:23:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
Message-ID: <20050201092335.GB28575@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	matthew@wil.cx, B.Zolnierkiewicz@elka.pw.edu.pl
References: <20050103140938.GA20070@infradead.org> <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 04:45:05PM -0600, Pat Gefre wrote:
> 
> I've updated this patch with suggestions from the reviews. And moved it
> up the latest 2.6 (since it has been awhile...). I'm also adding
> Bartlomiej as a CC since there are IDE mods involved.

This looks much better, thanks.

Please kill ioc4_ide_init as it's completely unused and make ioc4_serial_init
a normal module_init() handler in ioc4_serial, there's no need to call
them from the generic driver.

Also yo should need to implement ioc4_remove_one (yet) as the ide driver
can't be removed yet.  It might make sense to keep it and
ioc4_serial_remove_one around #if 0'ed as that might be implemented soon.

Do you need to use ide_pci_register_driver?  IOC4 doesn't have the legacy
IDE problems, and it's never used together with such devices in a system,
so a plain pci_register_driver should do it.

In ioc4_ide_attach_one you can kill the if and return pci_init_sgiioc4(..)
directly.

In ioc4.c please include <asm/sn/ioc4_common.h> after <linux/ide.h>.

Also ioc4_common.h should probably move to include/linux as ioc4 is more
or less just a pci device and not that SN-specific.

The ioc4_serial driver looks more or less good to me, but you seem to
miss __iomem annotation and there's a few things that it'd have cought,
like casting the return value from ioremap (it's a void __iomem * so it
can be assigned to any pointer directly  (or any __iomem pointer in sparse).

ioc4_soft.is_intr_type[].is_intr_ents_free should be an unsigned long
so test_and_clear_bit can operate on it directly.  But I fail to see where
we set bits in at all (?)

ioc4_serial_attach_one has various resource leaks when parts of the
initialization fail.  Try to follow the goto-based cleanup model most pci
drivers use instead of returning directly on failures.

