Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWDZD22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWDZD22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWDZD21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:28:27 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:41442 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750895AbWDZD21 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:28:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kUpgNkAzyanOljF6DwkO3EJz+llcc/lsxpJ/6252iqwUdKZP0sdVZwU1R20xZ6dpA8F16GTU5FJNN+UzpkJah6BoazzT2W9JtauD36tMVg3NUGNp46FWxi8rxlEv3gT2gXArTPcCvdyBhbene0y8DqmDqx7I3TKiARafXYd7k68=
Message-ID: <21d7e9970604252028k2cb302fdr78cfc894b4678b02@mail.gmail.com>
Date: Wed, 26 Apr 2006 13:28:26 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
Cc: "Andrew Morton" <akpm@osdl.org>, "Matthew Reppert" <arashi@sacredchao.net>,
       linux-kernel@vger.kernel.org, "Dave Airlie" <airlied@linux.ie>,
       "Antonino A. Daplas" <adaplas@pol.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0604240949330.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145851361.3375.20.camel@minerva>
	 <20060423222122.498a3dd2.akpm@osdl.org>
	 <Pine.LNX.4.64.0604240949330.3701@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see quite why it would do it (yes, ROM's are prefetchable, but the
> old location was _valid_, and I don't see why we didn't re-use it), but it
> _really_ shouldn't matter.
>
> I would expect some silly interaction with X, as usual. It would be nice
> to see the whole dmesg, especially with the debugging messages - I suspect
> the remapping of the ROM happens only when X starts up, and that your
> dmesg is from just the kernel boot from before that?
>
> But it might be that I just missed it (or that we don't have good debug
> output for that case).

Just on my own system I'm seeing something of an issue while debugging
the dual-head issue,

my secondary head is being assigned non-prefetchable resources outside
the bridge,
PCI: Transparent bridge - 0000:00:1e.0

PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: ff900000-ff9fffff
  PREFETCH window: e8000000-efffffff
is the bridge,

02:02.0 VGA compatible controller: ATI Technologies Inc Radeon RV100
QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd: Unknown device 2049
        Flags: stepping, medium devsel, IRQ 255
        Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
        I/O ports at b000 [disabled] [size=256]
        Memory at ffff0000 (32-bit, non-prefetchable) [disabled] [size=64K]
        Expansion ROM at ff900000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2

is the device,

when I modprobe radeon which does pci_enable_device, the bars are enabled...

However when X starts it tries to reassign the memory at 0xffff0000
down into the bridge memory... at 0xfff90000,  should the kernel do
this? or does it actually matter if the memory is behind the bridge as
its transparent... maybe I can at least patch X to check for
transparent bridges...

Dave.
