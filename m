Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966568AbWKOEOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966568AbWKOEOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966570AbWKOEOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:14:22 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:31019 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S966568AbWKOEOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:14:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Nov 2006 20:14:19 -0800
In-Reply-To: <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org> (Linus Torvalds's message of "Tue, 14 Nov 2006 19:54:38 -0800 (PST)")
Message-ID: <adalkmdz6qs.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 04:14:20.0164 (UTC) FILETIME=[8609FC40:01C7086C]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Now, I think that a MSI thing should look like a PCI write to a magic 
 > address (I'm really not very up on it, so correct me if I'm wrong), and 
 > thus maybe bridges are bound to get it right, and the only thing we really 
 > need to worry about is the host bridge. Maybe.

Yes, an MSI message really is just a PCI write cycle (which is why it
obeys all the PCI ordering as DaveM pointed out, and also can travel
on different PCIe VCs, etc).  So it's hard to see how a bridge could
mess it up without screwing up lots of other stuff.  The big thing is
the host bridge that has to turn the PCI write into an interrupt, and
that's where all the chipset problems that I know of are.

But on the other hand I don't think we have much experience with
MSI-capable devices below multiple levels of bridges, so you're right,
there is an unknown risk here.

 > But right now I'm not convinced we really know what all goes wrong. Maybe 
 > it's just broken NVidia and AMD bridges. But maybe it's also individual 
 > devices that continue to (for example) raise _both_ the legacy IRQ line 
 > _and_ send an MSI request.

Well, since we now require drivers to "opt in" to MSI, I'm not
convinced that broken devices are a huge issue.  We can take things
case-by-case and, obviously, if some random subset of devices are
broken, then clearly the driver should be really careful about
enabling MSI.  But usually there's something like a device ID,
revision, FW version, etc. that we can test.

 > together with certain Intel MSI-capable chips (ie e1000, Intel HDA etc). 

Just for the record -- many e1000 chips that have an MSI capability in
their PCI config actually do not have working MSI.  Hence the

	if (adapter->hw.mac_type > e1000_82547_rev_2) {
		adapter->have_msi = TRUE;

in the e1000 driver I guess.

BTW, at the end of the day I agree with the "MSI off by default"
policy, especially for the sound driver where the only realy gain is
saving IRQ routing hassles as you said.  Even for the mthca InfiniBand
driver, where MSI-X with multiple vectors is a huge performance win, I
still have the user explicitly enable it.

 - R.
