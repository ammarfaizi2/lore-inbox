Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263420AbVCJXQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbVCJXQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbVCJXOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:14:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:38874 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263384AbVCJXK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:26 -0500
Date: Thu, 10 Mar 2005 15:09:49 -0800
From: Greg KH <greg@kroah.com>
To: rl@hellgate.ch, olof@austin.ibm.com, jgarzik@pobox.com, netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [11/11] [VIA RHINE] older chips oops on shutdown
Message-ID: <20050310230949.GL22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------


Kernel 2.6.11, hardware is a MSI KT333-based board with an XP1800.

I'm oopsing on shutdown on a machine that has a Via Rhine adapter in it:

Unable to handle kernel paging request at virtual address e0803003
  printing eip:
c01f262c
*pde = 014dc067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in: cpufreq_userspace cpufreq_powersave cpufreq_ondemand
CPU:    0
EIP:    0060:[<c01f262c>]    Not tainted VLI
EFLAGS: 00010292   (2.6.11)
EIP is at ioread8+0x2c/0x40
eax: e0803003   ebx: e0803003   ecx: c026b430   edx: e0803003
esi: dff90260   edi: e0802f80   ebp: dd117e74   esp: dd117e74
ds: 007b   es: 007b   ss: 0068
Process reboot (pid: 5769, threadinfo=dd117000 task=dfafa080)
Stack: dd117e8c c026b490 dff90040 c151ccd4 c044a1a8 b7fdc078 dd117ea4 
c0253ad9
        c151ccd4 00000042 fee1dead 00000001 dd117fbc c012461c c04d72a8 00000001
        00000000 00010800 00000000 dd117ed8 c013b40b dffe7380 00030800 00000000
Call Trace:
  [<c0103d5f>] show_stack+0x7f/0xa0
  [<c0103efa>] show_registers+0x15a/0x1c0
  [<c01040ce>] die+0xce/0x150
  [<c0113406>] do_page_fault+0x356/0x692
  [<c01039ff>] error_code+0x2b/0x30
  [<c026b490>] rhine_shutdown+0x60/0x140
  [<c0253ad9>] device_shutdown+0x89/0x8b
  [<c012461c>] sys_reboot+0xac/0x200
  [<c0102f71>] sysenter_past_esp+0x52/0x75
Code: 3d ff ff 03 00 89 c2 89 e5 77 20 66 31 c0 3d 00 00 01 00 75 0c 
81 e2 ff ff 00 00 ec 0f b6 c0 c9 c3 0f 0b 37 00 7b 65 3b c0 eb ea <0f> 
b6 00 eb ec eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 55

Seems like it is the ioread8 in:

         /* Hit power state D3 (sleep) */
         iowrite8(ioread8(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);

that fails. StickyHW is 0x83. lspci says:

0000:00:07.0 Ethernet controller: VIA Technologies, Inc. VT86C100A 
[Rhine] (rev 06)
         Flags: bus master, medium devsel, latency 32, IRQ 18
         I/O ports at ec00 [size=128]
         Memory at dfffff80 (32-bit, non-prefetchable) [size=128]

In other words, it's trying to read outside of the I/O range (0x80),
which matches the fauling address.

I'm guessing my chip revision doesn't support WOL, it's a crappy noname
card.

It does seem as if rhine_power_init checks quirks for rqWOL before
touching any registers. Should rhine_shutdown do the same? Proposed
patch below, which resolves the problem on my system.


Check to make sure WOL is supported before setting it up in 
rhine_shutdown.


Signed-off-by: Olof Johansson <olof@austin.ibm.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.11.orig/drivers/net/via-rhine.c	2005-03-02 01:38:32.000000000 -0600
+++ linux-2.6.11/drivers/net/via-rhine.c	2005-03-05 12:25:34.000000000 
-0600
@@ -1899,6 +1899,9 @@
 	struct rhine_private *rp = netdev_priv(dev);
 	void __iomem *ioaddr = rp->base;

+	if (!(rp->quirks & rqWOL))
+		return; /* Nothing to do for non-WOL adapters */
+
 	rhine_power_init(dev);

 	/* Make sure we use pattern 0, 1 and not 4, 5 */

