Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbULOG44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbULOG44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 01:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbULOG44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 01:56:56 -0500
Received: from ns.suse.de ([195.135.220.2]:27336 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261908AbULOG4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 01:56:51 -0500
Date: Wed, 15 Dec 2004 07:56:50 +0100
From: Andi Kleen <ak@suse.de>
To: mst@mellanox.co.il, linux-kernel@vger.kernel.org
Cc: pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com
Subject: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215065650.GM27225@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

There seems to be an unfixable module unload race in the current
register_ioctl32_conversion support. The problem is that
there is no way to wait for a conversion handler is blocked
in a sleeping *_user access before module unloading. The module
count is also not increase in this case.

I previously thought it could be avoided by always putting
the compat wrapper into the same module and using the reference
counting that is done by VFS on ->module of the char device or
file system converted. But that doesn't work because 
the ioctl32 lookup is independent from the file descriptor
and a conversion handler can be entered even after ->release
when the right number is passed.

One way to fix it would be to put a pointer to the module
into the compat ioctl hash table and increase the module count atomically
from the compat code. But that would bloat the hash table a lot
and I don't like it very much. Also you would either break the
register_ioctl32_conversion prototype or make it a macro
and assume all calls are from the same module, which is also 
quite ugly.

A better solution would be to switch the few users of 
register_ioctl32_conversion() over to a new ->ioctl32 method
in file_operations and do the conversion from there. This would
avoid the race because the VFS will take care of the module
count in open/release.

Michael did a patch for this some time ago for a different motivation -
he had some benchmarks where the hash table lookup hurt and it was
noticeable faster to use a O(1) ->ioctl32 lookup from the file_operations
for his application.

An useful side effect would be also to the ability to support 
a per device ioctl name space. While the core kernel doesn't have
much (any?) ioctls with duplicated numbers this mistake seems
to be quite common in out of tree drivers and it is hard to 
fix without breaking compatibility.

And it would be faster for this case of course too, so even performance
critical in kernel ioctls could be slowly converted to ioctl32
I wouldn't do it for all, because the current central tables work
reasonably well for them and most ioctls are not speed critical
anyways.

As for in kernel code it won't affect much code because near 
all conversion handlers in the main tree are not modular (alsa 
is one exception, there are a few others e.g. in some raid drivers). 
I expect it will be a bigger problem in the future though as ioctl 
emulation becomes more widespread and is done more in individual drivers.

averell:lsrc/v2.6/linux% gid register_ioctl32_conversion | wc -l
75
averell:lsrc/v2.6/linux% 

In tree users are alsa, aaraid, fusion, some s390 stuff, sisfb, alsa

My proposal would be to dust off Michael's patch and convert 
all users in tree over to ioctl32 and then deprecate and later remove
(un)register_ioctl32_conversion 

Comments?

-Andi
