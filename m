Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRCWBcX>; Thu, 22 Mar 2001 20:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRCWBcQ>; Thu, 22 Mar 2001 20:32:16 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:48904 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132296AbRCWBbo>; Thu, 22 Mar 2001 20:31:44 -0500
Message-Id: <200103230131.f2N1Uos09088@aslan.scsiguy.com>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: Version 6.1.8 of the aic7xxx driver availalbe 
Date: Thu, 22 Mar 2001 18:30:50 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As always, the latest version of this driver is availalbe here:

http://people.FreeBSD.org/~gibbs/linux/

Complete CHANGELOG is now available at the above URL.

I try to filter though LK as often as I can, but for
best response, please email issues regarding this driver to
me directly.

Changes since 6.1.6:

Change 168 on 2001/03/22 by gibbs@overdrive

	Bump version to 6.1.8.

Change 167 on 2001/03/22 by gibbs@overdrive

	aic7xxx_linux.c:
	aic7xxx_linux.h:
		Add support for switching from full to basic
		command queuing.  Flags in the ahc_linux_device
		structure indicate what kind of queuing to performed.
	
		In the past, we issued an ordered tag every 250
		transactions.  We now issue an ordered tag every
		250 transactions issued without the device queue
		going empty.
	
	aic7xxx_proc.c:
		Use an unsigned long for total number of commands
		sent to a device.  %q and %lld don't seem to work
		under Linux or I'd have used a uint64_t.

Change 166 on 2001/03/22 by gibbs@overdrive

	aic7770.c:
	aic7xxx_pci.c:
		Don't map our interrupt until after we are fully setup to
		handle interrupts.  Our interrupt line may be shared so
		an interrupt could occur at any time.
	
	aic7xxx.h:
	aic7xxx.c:
		Add support for switching from fully blown tagged queing
		to just using simple queue tags should the device reject
		an ordered tag.
	
		Remove per-target "current" disconnect and tag queuing
		enable flags.  These should be per-device and are not
		referenced internally be the driver, so we let the OSM
		track this state if it needs to.
	
		Use SCSI-3 message terminology.

Change 165 on 2001/03/19 by gibbs@overdrive

	aic7770.c:
		ahc_reset() leaves the card in a paused state.
		Re-arrange the code so we reset the chip earlier
		so we can avoid a manual pause during setup.
	
		Setup the controller without enabling card interrupts.
	
	aic7xxx.c:
		Fix a bug in ahc_lookup_phase_entry().  We never traversed
		past the first entry.  This routine is only used in
		diagnostics so this had only a limited effect.
	
		Start out life with card interrupts disabled.  The bus
		code will enable the interrupts once setup is complete
		and our handler is in place.
	
		Initialize our softc unit to -1 so that code such as
		ahc_linux_next_unit() can traverse the list looking for
		coliding unit numbers without tripping over entries that
		have not yet had their unit number set.
	
		Enhance ahc_dump_card_state().  OSMs should be able to
		rely on this to dump any controller specific data of
		interest.  Most of the additional registers printed
		used to be printed in the FreeBSD timeout handler.
	
		Add a function pointer in our softc for a bus specific
		interrupt handler.  This removes some dependencies on
		the PCI code so that bus attachments can be compiled
		as modules separate from the core.
	
	aic7xxx.reg:
		Use the naming for bit 5 of DFSTATUS in the data book,
		FIFOQWDEMP.
	
	aic7xxx.seq:
		In our idle loop, use an or instruction to set PRELOADEN
		rather than rewriting the contents of DMAPARAMS to
		DFCNTRL.  The later may re-enable the DMA engine if
		the idle loop is called to complete the preload of at
		least one segment when a target disconnects on an S/G
		segment boundary but before we have completed fetching
		the next segment.  This correts a hang, usually in
		message out phase, when this situation occurs.  This
		bug has been here for a long time, so the situation
		is rare, but not impossible to reproduce.
	
		Wait for at least 8 bytes in the FIFO before testing to
		see if the DMA fetch of an SCB has stalled.  The old
		code used FIFOEMP, which goes false on a single byte.
		Since we drain the FIFO 8 bytes at a time, using FIFOQWDEMP
		is safer.
	
		If a device happens to be exceptionally slow in asserting
		HDONE, our workaround for a stalled SCB dma can be triggered.
		Make this situation non-fatal by terminating our FIFO
		emptying should we complete the transfer.
	
	aic7xxx_inline.h:
		ahc_pci_intr() -> ahc->bus_intr()
	
	aic7xxx_pci.c:
		Setup ahc->bus_intr().
	
		Enable board interrupts at the appropriate time.

Change 164 on 2001/03/19 by gibbs@overdrive

	aic7xxx_linux.c:
		Format to 80 columns.
	
		Break after finding a matching entry in the token
		table during aic7xxx_setup.
	
		print the correct name of a function in a diagnostic.

Change 163 on 2001/03/10 by gibbs@overdrive

	Bump version to 6.1.7.  The too leanient interpretation
	of the seeprom signature could result in improper
	termination settings on some MBs, and this is a big
	enough bug to warant a new release.

Change 162 on 2001/03/10 by gibbs@overdrive

	Handle cross builds.

Change 161 on 2001/03/10 by gibbs@overdrive

	We now generate a header file for the db include
	under linux to handle the build on more distribution
	types.

Change 160 on 2001/03/10 by gibbs@overdrive

	aic7xxx.h:
		Add a definition for the 3.X BIOS signature.
	
	aic7xxx_inline.h:
		We must setup queuestat before processing
		command complete interrupts in case target
		mode is enabled.
	
	aic7xxx_pci.c:
		Be more selective in the BIOS signatures we
		support.  Some seeproms have a signature of
		0xFFFF, so testing greater than 0x250 resulted
		in false positives.

Change 159 on 2001/03/09 by gibbs@overdrive

	To be compatible with older kernels, our setup routine
	must be called aic7xxx_setup().

Change 158 on 2001/03/09 by gibbs@overdrive

	aicasm/Makefile:
		Play some games so we have a better chance of actually
		building on more systems.

Change 157 on 2001/03/09 by gibbs@overdrive

	aic7770_linux.c:
	aic7xxx_linux.h:
		Adjust aic7770_map_int() to not rely on a passed in "shared"
		argument.  We can now look at ahc->flags to see whether the
		interrupt source is edge or level.
	
	aic7xxx_linux.c:
		Only adjust our goal negotiation settings if the device
		is actually present.  This prevents a disconnected lun
		that does not claim to support negotiations from messing
		up the settings for a successfully probed lun whose inquiry
		data properly reflects the abilities of the device.
	
		Set the device structure as releasable should the inquiry
		come back with anything other than lun connected.  We
		should also do this if the device goes away as evidenced
		by a selection timeout, but as we can't know if this
		condition is persistant and there is no guarantee that
		the mid-layer will reissue the inquiry command we use
		to validate the device, I've simply added a comment
		this effect.
