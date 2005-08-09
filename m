Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVHIQQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVHIQQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVHIQQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:16:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3568 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964859AbVHIQQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:16:28 -0400
Subject: Re: Soft lockup in e100 driver ?
From: Daniel Walker <dwalker@mvista.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050809133647.GK22165@mea-ext.zmailer.org>
References: <20050809133647.GK22165@mea-ext.zmailer.org>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 09:16:21 -0700
Message-Id: <1123604182.15991.40.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like this might be an SMP race , it seem that both processors
are in e100_down(). There is a while loop in e100_clean_cbs() that
appears to have an unsafe looping condition . 

It looks like cbs_avail might jump over params.cbs.count , then you
would have to wait for a rollover . Is this a PREEMPT_NONE kernel?


This patch may help, but it's not a complete fix.

--- linux-2.6.12.orig/drivers/net/e100.c        2005-08-05 16:45:59.000000000 +0000
+++ linux-2.6.12/drivers/net/e100.c     2005-08-09 16:14:45.000000000 +0000
@@ -1393,7 +1393,7 @@ static inline int e100_tx_clean(struct n
 static void e100_clean_cbs(struct nic *nic)
 {
        if(nic->cbs) {
-               while(nic->cbs_avail != nic->params.cbs.count) {
+               while(nic->cbs_avail < nic->params.cbs.count) {
                        struct cb *cb = nic->cb_to_clean;
                        if(cb->skb) {
                                pci_unmap_single(nic->pdev,



On Tue, 2005-08-09 at 16:36 +0300, Matti Aarnio wrote:
> Running very recent Fedora Core Development kernel I can following
> soft-oops..   ( 2.6.12-1.1455_FC5smp )
> 
> 
> e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
> BUG: soft lockup detected on CPU#0!
> 
> Pid: 10743, comm:             ifconfig
> EIP: 0060:[<f88bf2f9>] CPU: 0
> EIP is at e100_clean_cbs+0x2f/0x12b [e100]
>  EFLAGS: 00000293    Not tainted  (2.6.12-1.1455_FC5smp)
> EAX: 495c7c2b EBX: 495c7c2b ECX: f6c311a0 EDX: 00000000
> ESI: 00000040 EDI: f6c30000 EBP: f71a4b20 DS: 007b ES: 007b
> CR0: 8005003b CR2: 0804a544 CR3: 01e9cd80 CR4: 000006f0
>  [<f88c0708>] e100_down+0x66/0x9a [e100]
>  [<f88c1623>] e100_close+0xa/0xd [e100]
>  [<c02b7adb>] dev_close+0x40/0x7e
>  [<c02b8f59>] dev_change_flags+0x46/0xf5
>  [<c02f76b3>] devinet_ioctl+0x564/0x5df
>  [<c02af22c>] sock_ioctl+0xc3/0x250
>  [<c02af169>] sock_ioctl+0x0/0x250
>  [<c01762ef>] do_ioctl+0x1f/0x6d
>  [<c017648f>] vfs_ioctl+0x50/0x1c6
>  [<c0176662>] sys_ioctl+0x5d/0x6f
>  [<c010394d>] syscall_call+0x7/0xb
>  [<c014473f>] softlockup_tick+0x6f/0x80
>  [<c01085b8>] timer_interrupt+0x2d/0x75
>  [<c01448dd>] handle_IRQ_event+0x2e/0x5a
>  [<c01449cb>] __do_IRQ+0xc2/0x127
>  [<c0105f7e>] do_IRQ+0x4e/0x86
>  =======================
>  [<c01160cc>] smp_apic_timer_interrupt+0xc1/0xca
>  [<c0104382>] common_interrupt+0x1a/0x20
>  [<f88bf2f9>] e100_clean_cbs+0x2f/0x12b [e100]
>  [<f88c0708>] e100_down+0x66/0x9a [e100]
>  [<f88c1623>] e100_close+0xa/0xd [e100]
>  [<c02b7adb>] dev_close+0x40/0x7e
>  [<c02b8f59>] dev_change_flags+0x46/0xf5
>  [<c02f76b3>] devinet_ioctl+0x564/0x5df
>  [<c02af22c>] sock_ioctl+0xc3/0x250
>  [<c02af169>] sock_ioctl+0x0/0x250
>  [<c01762ef>] do_ioctl+0x1f/0x6d
>  [<c017648f>] vfs_ioctl+0x50/0x1c6
>  [<c0176662>] sys_ioctl+0x5d/0x6f
>  [<c010394d>] syscall_call+0x7/0xb
> 
> 
> 
> Preconditions for this are:
> 
> - E100 card stopped working for some reason (no idea why, it just
>   does sometimes at this oldish 2x P-III machine)
> - There are active datastreams running in and out
>   (around 0.2 Mbps out, multiple megabits in.)
> - Commanding then "ifconfig eth0 down" results in what feels like 
>   system freezing, but it does recover in about 30-60 seconds
>   (it takes long enough for me to sweat bullets...)
> - While in freeze state, keyboard can go crazy, but mouse does
>   respond, as well as tvtime shows bt848 captured live video.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

