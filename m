Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbQKRCPD>; Fri, 17 Nov 2000 21:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131250AbQKRCOt>; Fri, 17 Nov 2000 21:14:49 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:45985 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131123AbQKRCOi>; Fri, 17 Nov 2000 21:14:38 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Nov 2000 17:44:32 -0800
Message-Id: <200011180144.RAA06953@adam.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, willy@meta-x.org,
        wtarreau@yahoo.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am willing to consider adding __devxxx only when other __devxxx
>entries already exist.

>These conversions to _devxxx are too late in the freeze, and only have
>value for isolated cases --which you admit you don't even know exist--. 
>Linus Rule 1: Don't overdesign.

	Even ignoring CardBus, there apparently are docking
stations that have PCI busses, such as shown in
http://www.pangolin.com/LD2000/dock/gateway.htm ("Each supports hot
docking, so you can attach or detach your system without turning it
off"), and a web search turns up plenty of hits, at least for mobile
chipsets apparently designed for this.  It looks like this is a
pretty standard capability.

	Even if we were unsure, the more conservative approach would
be to use __devinitdata.  The only cost of incorrectly using __devinitdata
instead of __initdata, would be to make the effected kernel module
use ~100 bytes more unswappable kernel memory when CONFIG_HOTPLUG is
defined and the module is loaded (28 bytes per entry, including a null
entry).  On the other side that risk comparison, the cost of incorrectly
using __initdata when __devinitdata was correct is that the user's
KERNEL WILL CRASH when the notebook is inserted or removed from such a
docking station, even when the kernel is built with CONFIG_HOTPLUG.

	Although I'm not into quoting any programmer like some religious
figure, I will say that I think you're misinterpreting the meaning of
an admonition like "Don't overdesign."  We are not talking about designing
some new abstraction or making the code more complex, but rather
selecting rather a choice between two words, one of which is the more
conservatively crash resistant __devinitdata, the other of which would
save 28 bytes in CONFIG_HOTPLUG kernels only, and at the expense of
probably causing kernel crashes.

>Even if such cases do exist, and this
>is a need, it should be addressed some other way.

	1. Why?
	2. What other way did you have in mind?

	By the way, although I do not have the PCI standard here, I do
see from _PCI System Architecture_, 4th edition, chapter 19,
"Configuration Registers", in the "Device ID Register" section that
devices "designed around the same third party core logic" are allowed
to have the same device ID (and they are even complaint to PCI 2.2 if
they have different Subsystem ID values).  So, my approach also has
the minor advantage that if a vendor wants to ship a hot pluggable
version of their PCI card in the future with the same device ID
(a likely decision), then there may not need to coordinate a new
release of the Linux driver.  (This is a really small benefit; the
kernel crashes that you want to change my existing patches to produce
is the big issue.)

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
