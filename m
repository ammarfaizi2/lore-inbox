Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263602AbUD0AX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbUD0AX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 20:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUD0AX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 20:23:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263602AbUD0AX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 20:23:26 -0400
Date: Tue, 27 Apr 2004 01:23:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
Message-ID: <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk>
References: <20040426013944.49a105a8.akpm@osdl.org> <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net> <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net> <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net> <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net> <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 02:04:40AM +0200, Grzegorz Kulewski wrote:
> Apr 27 01:49:23 polb01 claim: 22:68 c0407320 -> 0
> Apr 27 01:49:23 polb01 release: 22:68

grabbed and released hdd4

> Apr 27 01:49:23 polb01 claim: 22:68 c0407aa0 -> 0

grabbed hdd4

> Apr 27 01:49:23 polb01 kjournald starting.  Commit interval 5 seconds
> Apr 27 01:49:23 polb01 EXT3-fs: mounted filesystem with ordered data mode.
> Apr 27 01:49:23 polb01 VFS: Mounted root (ext3 filesystem) readonly.
> Apr 27 01:49:23 polb01 Freeing unused kernel memory: 132k freed
> Apr 27 01:49:23 polb01 NET: Registered protocol family 1
> Apr 27 01:49:23 polb01 EXT3 FS on hdd4, internal journal

... and that was apparently done by mount()

> Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
> Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
> Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
> Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
> Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
> Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0

whee... 6 claims of hda - all by the same owner.

> Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16
> Apr 27 01:49:23 polb01 device-mapper: : dm-linear: Device lookup failed
> Apr 27 01:49:23 polb01
> Apr 27 01:49:23 polb01 device-mapper: error adding target to table
> Apr 27 01:49:23 polb01 claim: 22:64 e08e223e -> -16

[several times]

a bunch of attempts to claim hdd for the same guy - failed since hdd4 is
claimed already.

> Apr 27 01:49:23 polb01 claim: 3:5 c0407aa0 -> -16
> Apr 27 01:49:23 polb01 claim: 3:2 e0947800 -> -16

... and failing attempts to claim hda5 and hda2, since hda had been claimed and
never released.


IOW, dm.c doesn't release what it'd claimed, even after it gives up on probing.
