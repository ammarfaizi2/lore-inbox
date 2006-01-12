Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWALRVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWALRVD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWALRVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:21:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751462AbWALRVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:21:01 -0500
Date: Thu, 12 Jan 2006 09:20:06 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, oliver@neukum.org,
       zaitcev@redhat.com
Subject: Re: need for packed attribute
Message-Id: <20060112092006.6a9f4509.zaitcev@redhat.com>
In-Reply-To: <200601121227.k0CCRCB8016162@alkaid.it.uu.se>
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 13:27:12 +0100 (MET), Mikael Pettersson <mikpe@csd.uu.se> wrote:

> [...] Do you have any
> information about why gcc is doing this on ARM/Linux?

Russell forgot to explain it, but the reason for this weirdness is real.
It is so you can do things like this:

struct foo {
	char x, y;
};

struct bar {
	long g;
};

	char *p;
	struct bar *bp;
	p = kmalloc(sizeof(struct foo)+sizeof(struct bar));
	bp = p + sizeof(struct foo);

Notice that sizes are aligned even in sensible ABIs whenever you
have anything bigger than a char inside a struct, in order to let
arrays of structures work properly. As a side effect, the construct
above would be aligned whenever struct foo contained a long. So most
of the time we see the same result, ARM or not.

So this is not really a question of whatever some silly document
specifies, but what is workable in real life C programming.

Funnily enough, you are not safe depending on the ABI to make this
sort of padding (so our favourite alloc_netdev() and alloc_ieee80211
only work by accident with the trailing u8 priv[]). For example, on
sparc(32) the ABI alignes to 32 bits only, but the ldd instruction
traps if a 64-bit value is not aligned to 64 bits, so if the struct
bar in the above example had a long long, it would still trap.

Another funny thing about the above is that once you mark struct foo
packed, the example breaks. So, nobody should do use packed structs
in such constructs ... unless everything is packed. The pack attribute
has significant properties of cancer.

-- Pete

P.S. I am repeating myself as Katon, but I am yet to see why any of
this matters. Neither Russell nor Oliver ever presented a case where
an unpacked struct caused breakage in USB.

P.P.S. The USB stack was careful to use correct sizes historically.
One grep of the source will tell you that all this stench emanates from
the newer code, in particular the gadget and its attendant components,
such as usbtest. Guess who wrote it: same gentleman who advocated adding
((packed)) to _all_ structures "used to talk to hardware". He just has
no respect for coding practices, that's all. And some other gentleman,
otherwise highly respected for his sharp eye for races and locking
problems, is only too happy to copy-paste and to forward patches which
offer no justification.
