Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755139AbWKRRIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbWKRRIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbWKRRIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:08:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:48022 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1755139AbWKRRIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:08:23 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455F3DED.3070603@s5r6.in-berlin.de>
Date: Sat, 18 Nov 2006 18:07:57 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mattia Dongili <malattia@linux.it>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2 (Oops in class_device_remove_attrs during nodemgr_remove_host)
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de> <20061117071650.GA4974@inferi.kami.home> <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de> <20061118094706.GA17879@kroah.com> <455EEE17.4020605@s5r6.in-berlin.de>
In-Reply-To: <455EEE17.4020605@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Time for me to let -mm loose on my PC.

Small progress:

 - I get the oops already in nodemgr_remove_ne, unlike the original
   report where it happened a little later in driver core functions
   called by nodemgr_remove_ne.

 - I get it only if eth1394 is loaded when I unload ohci1394.

 - Like Mattia already found, this only happens on -mm, not on
   2.6.19-rc plus patched ieee1394 code which is 100% the same as
   in -mm except for Nigel Cunningham's
   add-include-linux-freezerh-and-move-definitions-from.patch
   which is of course not involved.


EIP is at nodemgr_remove_ne+0x40/0x90 [ieee1394]
eax: 00000000   ebx: f6af0c68   ecx: c02fcc20   edx: 0000003a
esi: f6af0c2c   edi: f8c14b60   ebp: f7395dd8   esp: f7395db8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4568, ti=f7394000 task=f69c3530 task.ti=f7394000)
Stack: f6af0c68 00000000 00000020 0000003a f8de0e00 00000000 00000000
f7395dfc
       f7395dec f8c14b8e f6af0c2c f73c20c4 f6af0c9c f7395e18 c02228e2
f6af0c68
       f73c20c4 f73c20c4 f73c20e4 f6af0c98 c02b4698 f73c20c4 f73c2000
f73c2000
Call Trace:
 [<c010400f>] show_trace_log_lvl+0x2f/0x50
 [<c01040f7>] show_stack_log_lvl+0x97/0xc0
 [<c0104355>] show_registers+0x1c5/0x340
 [<c010469a>] die+0x12a/0x220
 [<c0114649>] do_page_fault+0x369/0x660
 [<c02b697c>] error_code+0x7c/0x84
 [<f8c14b8e>] __nodemgr_remove_host_dev+0x2e/0x40 [ieee1394]
 [<c02228e2>] device_for_each_child+0x32/0x60
 [<f8c14bbe>] nodemgr_remove_host_dev+0x1e/0x90 [ieee1394]
 [<f8c169f7>] nodemgr_remove_host+0x37/0x40 [ieee1394]
 [<f8c111bc>] __unregister_host+0x8c/0xd0 [ieee1394]
 [<f8c11b16>] highlevel_remove_host+0x36/0x60 [ieee1394]
 [<f8c10c23>] hpsb_remove_host+0x43/0x70 [ieee1394]
 [<f8c07e08>] ohci1394_pci_remove+0x68/0x240 [ohci1394]
 [<c01f7f86>] pci_device_remove+0x46/0x50
 [<c0224cae>] __device_release_driver+0xae/0xc0
 [<c0224e38>] driver_detach+0x118/0x120
 [<c0224174>] bus_remove_driver+0x44/0x70
 [<c0225102>] driver_unregister+0x12/0x20
 [<c01f8305>] pci_unregister_driver+0x15/0x30
 [<f8c084d2>] ohci1394_cleanup+0x12/0x14 [ohci1394]
 [<c0142aa6>] sys_delete_module+0x156/0x180
 [<c01031f6>] sysenter_past_esp+0x5f/0x85
 =======================
Code: c7 85 c0 89 c3 74 60 8b 06 8b 56 04 89 44 24 10 89 54 24 14 0f b7
46 14 89 c2 83 e0 3f c1 ea 06 89 44 24 08 89 54 24 0c 8b 46 10 <8b> 80
b8 00 00 00 c7 04 24 84 bc c1 f8 89 44 24 04 e8 7a 9c 50
EIP: [<f8c14b10>] nodemgr_remove_ne+0x40/0x90 [ieee1394] SS:ESP
0068:f7395db8


In that way it is 100% reproducible here. I continue to debug this.
-- 
Stefan Richter
-=====-=-==- =-== =--=-
http://arcgraph.de/sr/
