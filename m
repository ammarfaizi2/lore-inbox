Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUAMAZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUAMAZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:25:17 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:40849 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261879AbUAMAZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:25:08 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave> 
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave> 
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jan 2004 19:25:03 -0500
Message-Id: <1073953504.2078.92.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 18:04, Linus Torvalds wrote:
> 		for (i = 0; i < 6; i++) {
> 			if (!pci_resource_start(dev, i))
> 				continue;
> 			if (!pci_resource_len(dev, i))
> 				continue;

Unfortunately this won't work because of the properties of insert
resource.  The BAR covers the second IO APIC at fec01000-fec013ff. 
However, this sits right in the middle of the fixmap region:

fec00000-fec08fff : reserved

This check in insert_resource makes sure that the resource being
inserted has to end beyond the resource it is replacing:

	/* existing resource overlaps end of new resource */
	if (next->end > new->end)
		goto out;

I could hack up another insert resource function that would put the
resource *under* anything else it finds (i.e. the reserved region).

Otherwise, everything will work since the i386 pci code assumes that if
the resource already has a parent, it has already been correctly
assigned, so won't try to reassign it.

James


