Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUFQTTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUFQTTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUFQTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:19:31 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:2419 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S261976AbUFQTRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:17:20 -0400
Message-ID: <40D1EE39.5020701@ThinRope.net>
Date: Fri, 18 Jun 2004 04:17:13 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: [BUG?] "bad: scheduling while atomic!" after modprobe -r aic7xxx
References: <40D1D522.3050806@ThinRope.net>
In-Reply-To: <40D1D522.3050806@ThinRope.net>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> I was testing 2.6.7, now with LOCAL_APIC and it seems to be working 
> (though my SATA disk is not connected).
> 
> However when trying to remove aic7xxx a lot of badness is outputed. 
> Trying to isolate the problem I tested without the APIC (in BIOS and 
> kernel) but the results were the same.
> 
> I am running on ASUS A7N8X-Deluxe (v2.0) MB with Nforce2 chipset.
> Apart from the badness, no crash or freeze is happening.
> I can reproduce it as many times as I try (=everytime).
> 
[snip the long debug output, see original MSG]

I forgot to mention that with 2.6.6 this same hardware and mostly the same .config was working steadily for quite a long time.
If .config is relevant will post it or send it on request.

I looked at `diff -Nru linux-2.6.{6,7}/drivers/scsi/aic7xxx/`, but is really big :-(

Looking closely at the log MSG, it is basicly:

bad: scheduling while atomic!
 [<c03222fc>] schedule+0x47c/0x490
 [<c0119858>] __wake_up_common+0x38/0x60
 [<c03223d8>] wait_for_completion+0x78/0xd0
 [<c0119800>] default_wake_function+0x0/0x20
 [<c0119800>] default_wake_function+0x0/0x20
 [<c012b233>] call_usermodehelper+0xb3/0xc0
 [<c012b110>] __call_usermodehelper+0x0/0x70
 [<c02261f7>] vsprintf+0x27/0x30
 [<c022621f>] sprintf+0x1f/0x30
 [<c0223426>] kset_hotplug+0x226/0x290
 [<c016bfc2>] iput+0x62/0x80
 [<c02234ea>] kobject_hotplug+0x5a/0x60
 [<c022382b>] kobject_del+0x1b/0x40
 [<e1f0c222>] sr_remove+0x22/0x4f [sr_mod]
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271fc5>] bus_remove_device+0x55/0xa0
 [<c0270f2d>] device_del+0x5d/0xa0
 [<e1f23026>] scsi_remove_device+0x56/0xc0 [scsi_mod]
 [<e1f22334>] scsi_forget_host+0x44/0x90 [scsi_mod]
 [<e1f1c0bb>] scsi_remove_host+0x2b/0x60 [scsi_mod]
 [<e1f785f1>] ahc_platform_free+0x141/0x160 [aic7xxx]
 [<e1f6b4bf>] ahc_free+0xbf/0x130 [aic7xxx]
 [<e1f7dde9>] ahc_linux_pci_dev_remove+0x69/0xa0 [aic7xxx]
 [<c023187b>] pci_device_remove+0x3b/0x40
 [<c0271e94>] device_release_driver+0x64/0x70
 [<c0271ec0>] driver_detach+0x20/0x30
 [<c02720fd>] bus_remove_driver+0x3d/0x80
 [<c0272583>] driver_unregister+0x13/0x28
 [<c0231ae6>] pci_unregister_driver+0x16/0x30
 [<e1f7e00f>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
 [<e1f7d2bd>] ahc_linux_exit+0x4d/0x59 [aic7xxx]
 [<c0130b8c>] sys_delete_module+0x12c/0x180
 [<c01465e8>] do_munmap+0x148/0x190
 [<c0106087>] syscall_call+0x7/0xb

repeated a lot of times...

Kalin.

P.S. CCing Justin T. Gibbs, as `modinfo aic7xxx |grep author`

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
