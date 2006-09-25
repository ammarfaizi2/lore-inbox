Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWIYQVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWIYQVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWIYQVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:21:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38116 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751218AbWIYQVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:21:30 -0400
Date: Mon, 25 Sep 2006 17:21:20 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv
Message-ID: <20060925162120.GK29920@ftp.linux.org.uk>
References: <1159199184.11049.93.camel@localhost.localdomain> <20060925142016.GI29920@ftp.linux.org.uk> <1159186771.11049.63.camel@localhost.localdomain> <1159183568.11049.51.camel@localhost.localdomain> <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <5578.1159183668@warthog.cambridge.redhat.com> <7276.1159186684@warthog.cambridge.redhat.com> <20660.1159195152@warthog.cambridge.redhat.com> <22596.1159200250@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22596.1159200250@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 05:04:10PM +0100, David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Ack Al Viro's changes but with IRQ set to zero.
> 
> The PCI bus has special mappings.  You may not address it with those numbers.
> Any of those numbers.  Al's patch is 100% incorrect.  Sorry.

Oh, for fuck sake...  2.6.18 drivers/scsi/libata-core.c:

                if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
                        struct ata_ioports *ioaddr = &ap->ioaddr;

                        if (ioaddr->cmd_addr == 0x1f0)
                                release_region(0x1f0, 8);
                        else if (ioaddr->cmd_addr == 0x170)
                                release_region(0x170, 8);
                }

current drivers/ata/libata-core.c:
                if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
                        struct ata_ioports *ioaddr = &ap->ioaddr;

                        /* FIXME: Add -ac IDE pci mods to remove these special cases */
                        if (ioaddr->cmd_addr == ATA_PRIMARY_CMD)
                                release_region(ATA_PRIMARY_CMD, 8);
                        else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
                                release_region(ATA_SECONDARY_CMD, 8);
                }

Patch in question restores the situation prior to libata merge.  That's
what FRV had been doing all along if SATA had been enabled.  No more,
mo less.

Now, if you want to change that behaviour, more power to you.  But that's
a separate patch, obviously, and all issues related to that exist in vanilla
2.6.18 just as in the current tree.
