Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSLASy2>; Sun, 1 Dec 2002 13:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSLASy2>; Sun, 1 Dec 2002 13:54:28 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:41940
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262373AbSLASy1>; Sun, 1 Dec 2002 13:54:27 -0500
Date: Sun, 1 Dec 2002 14:04:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Adam Belay <ambx1@neo.rr.com>
cc: Greg Kroah-Hartmann <greg@kroah.com>, "" <perex@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, "" <pelaufer@adelphia.net>
Subject: Re: [PATCH][2.5] ALSA ISAPNP update for sound/isa/opl3sa2.c
In-Reply-To: <20021201130715.GB333@neo.rr.com>
Message-ID: <Pine.LNX.4.50.0212011358150.10730-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0211300443090.2495-100000@montezuma.mastecende.com>
 <20021201013004.GA333@neo.rr.com> <Pine.LNX.4.50.0212010139460.1628-100000@montezuma.mastecende.com>
 <20021201130715.GB333@neo.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Adam Belay wrote:

> It caused an oops?  I'll bet the pnp layer got confused by it.  I'll add
> some busy flags to prevent drivers from calling this when the device is
> being used by the driver through the conventional driver-model style.
> Thanks for pointing this out.

Here is what the stack looked like;

 EIP is at kfree+0xcd/0xe0
 [<c024228d>] pnp_free_ids+0x1d/0x30
 [<c0241beb>] pnp_release_device+0x1b/0x30
 [<c02555a5>] device_release+0x15/0x20
 [<c02390e3>] kobject_cleanup+0x73/0x80
 [<c0241dac>] pnp_remove_device+0x1c/0xcd

We were releasing an already freed block of memory (this one was slab
poisoned).

> I see now.  The problem is that when the remove function is called, the pnp
> layer expects the device's resources to be freed and not in use.  I should
> add some checks for this as well.  The pnp layer will disable the device
> and this could cause big problems if the driver is used in between the time
> of the ALSA remove code path and this driver removal.  Furthermore, if there
> is more than one sound card and the driver-model wants to remove one, a
> problem would occur.  Perhaps this aspect of ALSA needs to be changed.
> Any ideas?

Hmm i thought ->remove was per device or do you iterate internally over
all registered driver devices? Thats why i originally did the
pnp_remove_device in the driver's card removal path. How about only
disabling registered devices on final driver unregister?

As an aside where does this fit in with the whole pci_dev business?

Cheers,
	Zwane
-- 
function.linuxpower.ca
