Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129674AbRCFXR7>; Tue, 6 Mar 2001 18:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRCFXRt>; Tue, 6 Mar 2001 18:17:49 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:10217 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129674AbRCFXRc>; Tue, 6 Mar 2001 18:17:32 -0500
Date: Tue, 06 Mar 2001 15:13:18 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
To: Peter Zaitcev <zaitcev@redhat.com>, "David S. Miller" <davem@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <023301c0a693$087591e0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010306004454.A12846@devserv.devel.redhat.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyways, is this the end of the discussion regarding my patch?

I think one of the maintainers for usb-uhci (Georg) said he'd
want the general fix ...

> Manfred said plainly "usb-uhci is broken", Alan kinda
> manuevered around my small problem, Dave Brownell looks
> unconvinced. So?

There are two problems I see.

(1) CONFIG_SLAB_DEBUG breaks the documented
requirement that the slab cache return adequately aligned
data ... which the appended patch should probably handle
nicely (something like it sure did :-) and with less danger
than the large patch you posted.

(2) The USB host controller drivers all need something
like a pci_consistent slab cache, which doesn't currently
exist.  I have something like that in the works, and David
Miller noted one driver that I may steal from.

- Dave


--- slab.c-orig Tue Mar  6 15:01:26 2001
+++ slab.c Tue Mar  6 15:05:58 2001
@@ -676,12 +676,10 @@
  }
  
 #if DEBUG
+ /* redzoning would break cache alignment requirements */
+ if (flags & SLAB_HWCACHE_ALIGN)
+  flags &= ~SLAB_RED_ZONE;
  if (flags & SLAB_RED_ZONE) {
-  /*
-   * There is no point trying to honour cache alignment
-   * when redzoning.
-   */
-  flags &= ~SLAB_HWCACHE_ALIGN;
   size += 2*BYTES_PER_WORD; /* words for redzone */
  }
 #endif


