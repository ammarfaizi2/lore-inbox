Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284761AbRLKAfM>; Mon, 10 Dec 2001 19:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284765AbRLKAfD>; Mon, 10 Dec 2001 19:35:03 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:3849 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S284762AbRLKAeu>;
	Mon, 10 Dec 2001 19:34:50 -0500
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [PATCH] agpgart chipset knowledge encapsulation
Date: Mon, 10 Dec 2001 17:38:40 -0700
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_GSL5KQYFN7XXNVTHNIT1"
Message-Id: <20011211003445.2E63B403C@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_GSL5KQYFN7XXNVTHNIT1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

The point of this patch is to remove a chipset dependency from DRM so it 
can cleanly support both the Intel 460GX and an HP IA64 chipset.  I would 
normally send this to Jeff Hartmann, but he seems to have disappeared, 
leaving agpgart without an obvious maintainer.

DRM needs to know the physical addresses of pages bound into the AGP 
aperture, and today that information is communicated from agpgart to DRM 
in the memory[] array of the agp_memory structure.  The problem is that 
the values in the array are not simple physical addresses.  Rather, they 
are the physical addresses mangled to be suitable for direct insertion 
into the GATT (the hardware-visible translation table).

Hence, DRM needs a way to unmangle these values to get the physical 
address back.  Today, agpgart exports a "page_mask" value, so DRM does the 
equivalent of this:

    paddr = agpmem->memory->memory[offset] & dev->agp->page_mask;

This isn't sufficient for the 460GX, because its mangling function 
requires a shift as well as a mask.  The 460GX code (which is still in the 
ia64 patch, not in the mainstream kernel) looks like this:

    paddr = (agpmem->memory->memory[offset] & 0xffffff) << 12;

So DRM currently has this chipset-specific code in it to unmangle the 
values in memory[], while there's no reason I know of for the mangled 
values to ever be exported from agpgart.

The attached patch against 2.4.16 remedies this by leaving the plain 
physical addresses in memory[].  The chipset-specific mangling is then 
done at the point where it is needed, when those values are inserted into 
the GATT.

It's a little tricky because the DRM code is distributed with XFree86 as 
well as with the kernel.  All the combinations (old DRM + new kernel; new 
DRM + old kernel; new DRM + new kernel) should still work, but DRM has to 
check the kernel version it's compiled against, so there are three 
KERNEL_VERSION(...)  instances in the patch that need to be adjusted to 
reflect the first version containing these changes.

Any feedback is welcome, especially if you can test it.  I've been able to 
test 460GX & ATI Radeon, HP & ATI Radeon, and Serverworks HE & MGA G400, 
but obviously that's not exhaustive.

Bjorn Helgaas
--
Linux Systems Operation R&D
Hewlett-Packard Company
Fort Collins, CO

--------------Boundary-00=_GSL5KQYFN7XXNVTHNIT1
Content-Type: application/x-gzip;
  name="pagemask.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pagemask.diff.gz"

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
+IsLv+WLrswbFo1kQ3/nfxFsJXnRJAAA

--------------Boundary-00=_GSL5KQYFN7XXNVTHNIT1--
