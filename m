Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTLSLoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 06:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTLSLoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 06:44:15 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59652 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262730AbTLSLoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 06:44:05 -0500
Date: Fri, 19 Dec 2003 11:43:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031219114328.A26526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <200312190259.hBJ2xput004244@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200312190259.hBJ2xput004244@fsgi900.americas.sgi.com>; from pfg@sgi.com on Thu, Dec 18, 2003 at 08:59:50PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 08:59:50PM -0600, Pat Gefre wrote:
> I have created a patchset at ftp://oss.sgi.com/projects/sn2/sn2-update/
> 
> It contains all the updates for our sn I/O code. The large patch that I
> had originally sent has been broken down into 70+ smaller patches.

Thanks, this looks much better already. Comments for the patches still not
OK below. 

000-hwgfs-update.patch.inprogress

	Mostly ok, except for reintroducing hwgraph_path_lookup().

004-fakeprom-update.patch

	OK, but why is fakeprom in the kernel at all?

006-kill-big-endian-stuff.patch

	This makes merging with the IP27 I/O code much much harder
	and doesn't buy you much, so I'd prefer if it doesn't go
	in.  (Note that this isn't a really strong no), if you just
	want to get rid of the EXTRA_FLAGS using the endianess tests
	from <linux/endian.h> would be a much better idea.  (I can
	cook up a patch for that for you)

014-cleanup-pci.c.patch

	Mostly OK.  Reintroducing snia64_pci_find_bios is bogus, but
	you kill it in a later patch anyway..

016-remove-non-pic.patch

	As above I'm not too happy with this, as I'm working on a
	pcibr driver that's usable for both IP27 and SN2.  Again
	this isn't exactly a strong no, it just makes life much
	harder.  Also note that if you define IS_PIC to 1 always
	and the Bridge / XBridge test to 0 always gcc will optimize
	away the code for you.

017-remove-non-pic1.patch

	Dito.

030-pciio-cleanup.patch

	pcibr_businfo_get() with the assorted new enums looks bogus,
	else OK.

036-shub-redirect.patch

	Wrong opening placement of first opening brace in
	sn_shub_redirect_intr :)

037-shub-redirect1.patch

	What's the point point of these pcireq stuff?  And what's the
	relation to the shub redirection?

048-pci_provider.patch

	At least better than the previous variant.. :)
	set_sn_pci64() is bogus, I'm certain the qla2x00 driver
	uses the right dma interface and if qlogicfc doesn't either
	fix it or (better) don't use that broken old driver..

051-cbrick.type.patch

	Code is ok, but wrong brace placement again..

065-sn_pci_find_bios-del.patch

	Shouldn't be needed after getting 014-cleanup-pci.c.patch right.

071-xswitch.devfunc.patch

	The whole indirection was develeted on a purpose.  Do you really
	have different xswitches now?  (Don't seem to be in this patchkit).
	If yes we'd better come up with a btter abstraction.

075-rename-reorg.patch

	BRIDGE_TYPE_AND_PTR_GET is totally bogus..
	Moving pcibr_attach2 to pic_attach2 is bogus and really wrong.
	Even if _you_ don't support Bridge/Xbridge anyore it's still
	common code for all of those.  While you're at it pic.c
	really should move to the pcibr dir.
	bridge.h -> pcibr_asic move seems really pointless to me, but
	if you really want it..
	BUT: Please remove the random renamaing of the include/asm/sn/pci
	constants froms the patch, else it looks mostly okay (although
	that's hard with such a large patch doing just code reorganization),
	dito for the struct typedef names.  This really breaks anyone
	doing work on Bridge/Xbridge without any purpose.

