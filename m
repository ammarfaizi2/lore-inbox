Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbUCEQL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUCEQL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:11:26 -0500
Received: from ns.suse.de ([195.135.220.2]:63616 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262624AbUCEQLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:11:24 -0500
Date: Fri, 5 Mar 2004 17:11:21 +0100
From: Olaf Hering <olh@suse.de>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.4rc1, exception in setfont, con_set_unimap()
Message-ID: <20040305161121.GA22115@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

we get an oops on ppc64, matroxfb, the installer runs setfont. backtrace
is below.
Should I just add a if(!p) return -ENODEV; or is there a better fix?


1:mon> t
c00000003f573be0  c00000000022858c  .con_font_op+0x2f4/0x43c
c00000003f573cd0  c00000000002746c  .do_unimap_ioctl+0xc4/0x154
c00000003f573d70  c0000000000eb278  .compat_sys_ioctl+0x174/0x324
c00000003f573e30  c00000000000f0e4  ret_from_syscall_1
exception: c00 (System Call) regs c00000003f573ea0
                  000000000ff77e0c
<Stack drops into userspace 00000000ffffe280>
1:mon> e
cpu 1: Vector: 300 (Data Access) at [c00000003f573960]
    pc: c0000000002224c8 (.con_set_unimap+0x74/0x29c)
    lr: c00000000002746c (.do_unimap_ioctl+0xc4/0x154)
    sp: c00000003f573be0
   msr: a000000000009032
   dar: 130
 dsisr: 40000000
  current = 0xc00000000abfad80
  paca    = 0xc000000000426000
    pid   = 303, comm = setfont

------- Additional Comments From olh@suse.de  2004-03-05 16:59 -------
it dies here:
con_set_unimap(int con, ushort ct, struct unipair *list)
{
        int err = 0, err1, i;
        struct uni_pagedir *p, *q;
        struct vc_data *conp = vc_cons[con].d;

        p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
        if (p->readonly) return -EIO;

p == r25 == NULL.
con == 0
ct == 0000000000000221
list == 0000000010027710

vc_cons[] == c000000000731040

1:mon> d c000000000731040
c000000000731040 c0000000008a5500 c00000013ee6dc00  |......U.....>...|
c000000000731050 c00000000a5ba000 c00000000a5ba200  |.....[.......[..|
c000000000731060 c00000000a5c6e00 c000000003f98200  |.....\n.........|
c000000000731070 0000000000000000 0000000000000000  |................|

1:mon> d c0000000008a5680 (c0000000008a5500+0x180)
c0000000008a5680 c0000000008a5678 0000000000000000  |......Vx........|
c0000000008a5690 0000000000000000 0000000000000000  |................|
c0000000008a56a0 0000000000000000 0000000000000000  |................|
c0000000008a56b0 0000000000000000 0000000000000000  |................|

1:mon> d c0000000008a5678
c0000000008a5678 0000000000000000 c0000000008a5678  |..............Vx|
c0000000008a5688 0000000000000000 0000000000000000  |................|
c0000000008a5698 0000000000000000 0000000000000000  |................|
c0000000008a56a8 0000000000000000 0000000000000000  |................|


----- End forwarded message -----

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
