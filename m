Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUAGR7C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUAGR7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:59:00 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:10219 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265538AbUAGR6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:58:13 -0500
Date: Wed, 7 Jan 2004 09:58:02 -0800
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Cc: jeremy@sgi.com
Subject: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040107175801.GA4642@sgi.com>
Mail-Followup-To: linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, jeremy@sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already talked with Grant a little about this, but I'm having
second thoughts about the approach we discussed.  PCI-X allows PIO read
responses to 'pass' DMA writes to system memory when the relaxed
ordering bit is set in the PCI-X command word _and_ the transaction has
the relaxed ordering bit set (so called "Relaxed Read Ordering" in
section 11.2 of the PCI-X addendum).  This effectively 'unserializes'
PIO vs. DMA transactions so that PIO reads doesn't get stuck behind an
unrelated DMA writes from the same device; something which can
potentially take awhile since cacheline ownership has to be acquired,
etc.

I'd like Linux to support relaxed read ordering in some way since on
large systems having PIO reads stuck behind DMA writes can end up eating
into CPU time and limit IOPS (do I have this right, Jeremy?).

The proposal I gave to Grant added a new readX() variant,
readX_relaxed(), that drivers could use when they don't need strict
ordering semantics (this may actually be the majority of cases, but it's
safer to be strict by default than create a read_ordered and open a
window for data corruption).  It might be confusing, however, to add yet
another readX() routine, and there are other ways we might go about it.
One suggestion was to overload the pci_sync_* calls so that they'd
explicitly flush DMA writes to system memory, implying that all reads on
some platforms would use relaxed semantics, but that we'd have to modify
drivers to add in pci_sync_* calls where needed.

Thoughts?

Thanks,
Jesse
