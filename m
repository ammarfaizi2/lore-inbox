Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945923AbWJSAmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945923AbWJSAmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWJSAmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:42:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945923AbWJSAmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:42:13 -0400
Date: Wed, 18 Oct 2006 17:41:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <gregkh@suse.de>, aarranz@pegaso.ls.fi.upm.es,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [GIT PATCH] PCI and PCI hotplug fixes for 2.6.19-rc2
In-Reply-To: <20061018151556.7113728c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610181729270.3962@g5.osdl.org>
References: <20061018200238.GA29443@kroah.com> <20061018151556.7113728c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Oct 2006, Andrew Morton wrote:
> 
> pccard: CardBus card inserted into slot 0
> PCI: Failed to allocate mem resource #0:1000000@6c000000 for 0000:07:00.2

That seems to be a 16MB memory resource. But we already totally filled up 
the memory space we reserved for cardbus with the memory resources needed 
for 7:0.0 and 7:0.1

That cardbus card seems to have three sub-functions, and it looks like 
they _all_ want a 16MB memory region. We "only" allocated 32MB total for 
it, so the third subfunction gets left out.

(There's another 32MB of memory allocated for the cardbus bridge at 
0x6a000000, but it's prefetchable, so we don't allow a non-prefetchable 
resourc to use it).

I don't think this has _ever_ worked. 

Hmm. I guess the Alvaro could try increasing "BRIDGE_MEM_MAX" in 
drivers/pcmcia/yenta_socket.c. It's currently at 4MB, but I think we gave 
him 32MB exactly because there was a huge memory hole, so we decided to 
extend it further a bit:

                size = BRIDGE_MEM_MAX;
                if (size > avail/8) {
                        size=(avail+1)/8;
                        /* round size down to next power of 2 */
                        i = 0;
                        while ((size /= 2) != 0)
                                i++;
                        size = 1 << i;
                }


but it migth be worth testing with "BRIDGE_MEM_MAX" set to 64MB instead of 
the current 4MB.

Alvaro?

		Linus
