Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269495AbUI3U4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269495AbUI3U4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269515AbUI3Uy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:54:58 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:17555 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269474AbUI3UtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:49:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc3: USB OHCI failure on suspend on AMD64
Date: Thu, 30 Sep 2004 22:51:30 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409302251.30903.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems there's a problem with USB OHCI driver that causes these traces to 
appear on suspend on an AMD64-based box:

 ..<7>PM: Image restored successfully.
 PCI: Setting latency timer of device 0000:00:02.0 to 64
 ohci_hcd 0000:00:02.0: HC died; cleaning up
 usb 1-2: USB disconnect, address 3
 Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1310

 Call Trace:<7>Losing some ticks... checking if CPU frequency changed.
 <ffffffff803455fb>{hcd_endpoint_disable+107} 
<ffffffff80346729>{usb_disable_endpoint+41}
        <ffffffff803468aa>{usb_disable_device+26} 
<ffffffff803422fc>{usb_disconnect+188}
        <ffffffff803441b0>{hcd_panic+0} <ffffffff803441fa>{hcd_panic+74}
        <ffffffff8015824d>{worker_thread+733} 
<ffffffff80137c00>{default_wake_function+0}
        <ffffffff80137c00>{default_wake_function+0} 
<ffffffff80157f70>{worker_thread+0}
        <ffffffff8015f51d>{kthread+205} <ffffffff80111b43>{child_rip+8}
        <ffffffff8015f450>{kthread+0} <ffffffff80111b3b>{child_rip+0}

[-- several times the above --]

 Call Trace:<ffffffff80345c3e>{hcd_unlink_urb+494} 
<ffffffff803463dc>{usb_kill_urb+380}
        <ffffffff80345a37>{hcd_endpoint_disable+1191} 
<ffffffff8019ed6e>{invalidate_inode_buffers+14}
        <ffffffff80346729>{usb_disable_endpoint+41} 
<ffffffffa022374c>{:usbhid:hid_disconnect+44}
        <ffffffff8033f4e9>{usb_unbind_interface+73} 
<ffffffff8030b95e>{device_release_driver+94}
        <ffffffff8030baf4>{bus_remove_device+164} 
<ffffffff8030a898>{device_del+88}
        <ffffffff8034690b>{usb_disable_device+123} 
<ffffffff803422fc>{usb_disconnect+188}
        <ffffffff803441b0>{hcd_panic+0} <ffffffff803441fa>{hcd_panic+74}
        <ffffffff8015824d>{worker_thread+733} 
<ffffffff80137c00>{default_wake_function+0}
        <ffffffff80137c00>{default_wake_function+0} 
<ffffffff80157f70>{worker_thread+0}
        <ffffffff8015f51d>{kthread+205} <ffffffff80111b43>{child_rip+8}
        <ffffffff8015f450>{kthread+0} <ffffffff80111b3b>{child_rip+0}

[-- once again the above --]

The workaround is to explicitly unload the driver before suspend and reload it 
after resume.  It is possible that it's fixed in -mm kernels, as I haven't 
seen such symptoms there, recently (since 2.6.9-rc2-mm1 at least).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
