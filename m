Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWALArQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWALArQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWALArQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:47:16 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:40882 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964874AbWALArP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:47:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lW1+1lN8duU1zshGqZuXAOYXqRC+Skw9qM0n1Wb+kZDyY3tpiQ7v40H3bQXET+CjwdqQv9C4UvYgMWO8ehKbuqFXMzpf5NTqPO175AfKdCiHs21ywMzFepsW2OgzTcHkU6W1wn0rvYhsjFXo6Kzq+sglF794x8fy7zBcc0LjWh8=
Message-ID: <5a4c581d0601111647i62f8c625q51a420ba9a9175e5@mail.gmail.com>
Date: Thu, 12 Jan 2006 01:47:14 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.15-git6,-git7] hard lockup on FC4 exiting X (Intel I915)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell Latitude D610, Pentium M @ 1.86Ghz, 2GB RAM
 running uptodate FC4. 100% reproducable since
 2.6.15-git6, no problem up to -git5. Log in to VT1, run
 startx, fire up a gnome-terminal, exit it, Desktop->Logout...
 at this point the mouse arrow stills and the box locks up,
 keyboard dead, no response to pings.

Card is, according to lspci -v,

00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00
[VGA])
        Subsystem: Dell: Unknown device 0182
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at dff00000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at ec38 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at dfec0000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2

Doesn't happen on -git6 on my older laptop (Latitude C640,
 Pentium IV @ 1.8Ghz, 1GB RAM, Radeon Mobility 7500), so
 it definitely is hardware-related.

Diff'ing the dmesg boot log and the Xorg log from the latest
 working version to the latest available version, the relevant
 lines would seem to be these:

[root@sandman ~]# diff /tmp/dmesg-2615git* | grep -v audit
1c1
< Linux version 2.6.15-git5 (asuardi@sandman) (gcc version 4.0.2
20051125 (Red Hat 4.0.2-8)) #1 Thu Jan 12 01:01:05 CET 2006
---
> Linux version 2.6.15-git7 (asuardi@sandman) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 Thu Jan 12 00:48:04 CET 2006
[...]
78a79
> PCI: Bus #04 (-#07) may be hidden behind transparent bridge #03 (-#04) (try 'pci=assign-busses')
145c146
---
157,159c158,160
< Allocate Port Service[pcie00]
< Allocate Port Service[pcie02]
< Allocate Port Service[pcie03]
---
> Allocate Port Service[0000:00:1c.0:pcie00]
> Allocate Port Service[0000:00:1c.0:pcie02]
> Allocate Port Service[0000:00:1c.0:pcie03]
[...]

[root@sandman ~]# diff /tmp/Xorg-2615git*
6c6
< Current Operating System: Linux sandman 2.6.15-git5 #1 Thu Jan 12
01:01:05 CET 2006 i686
---
> Current Operating System: Linux sandman 2.6.15-git7 #1 Thu Jan 12 00:48:04 CET 2006 i686
[...]
2101,2103c2101,2103
< (II) I810(0): Allocated 4 kB for HW cursor at 0xffff000 (0x37c27000)
< (II) I810(0): Allocated 16 kB for HW (ARGB) cursor at 0xfffb000 (0x35b28000)
< (II) I810(0): Allocated 4 kB for Overlay registers at 0xfffa000 (0x35ae5000).
---
> (II) I810(0): Allocated 4 kB for HW cursor at 0xffff000 (0x36b84000)
> (II) I810(0): Allocated 16 kB for HW (ARGB) cursor at 0xfffb000 (0x36bf0000)
> (II) I810(0): Allocated 4 kB for Overlay registers at 0xfffa000 (0x36b87000).
2121,2122c2121,2122
< (II) I810(0): [drm] added 8192 byte SAREA at 0xf8a5a000
< (II) I810(0): [drm] mapped SAREA 0xf8a5a000 to 0xb7f55000
---
> (II) I810(0): [drm] added 8192 byte SAREA at 0xf8af0000
> (II) I810(0): [drm] mapped SAREA 0xf8af0000 to 0xb7f77000

Something to do with the PCI Express stuff ?


Available for more detailed info and/or testing to interested parties :)

Thanks in advance, ciao,

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
