Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUFJTd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUFJTd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUFJTd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:33:56 -0400
Received: from smtp.terra.es ([213.4.129.129]:10973 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S262744AbUFJTds convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:33:48 -0400
Date: Thu, 10 Jun 2004 19:43:21 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: shemminger@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
Message-Id: <20040610194321.7c67c854.diegocg@teleline.es>
In-Reply-To: <1086794282.1706.2.camel@teapot.felipe-alfaro.com>
References: <1086722310.1682.1.camel@teapot.felipe-alfaro.com>
	<20040608124215.291a7072@dell_ss3.pdx.osdl.net>
	<1086725369.1806.1.camel@teapot.felipe-alfaro.com>
	<20040608140200.2ddaa6f4@dell_ss3.pdx.osdl.net>
	<1086794282.1706.2.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 09 Jun 2004 17:18:02 +0200 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> escribió:

I'm seeing the same with a ppp link: pppd can't be killed even with SIGKILL (it
eats 100% of cpu - all in sys time, readprofile attached) and the kernel spits
out those messages:

unregister_netdevice: waiting for ppp0 to become free. Usage count = 1
unregister_netdevice: waiting for ppp0 to become free. Usage count = 1
unregister_netdevice: waiting for ppp0 to become free. Usage count = 1
etc...

It doesn't happen always. i've seen it a couple of times, right now
I'm trying to reproduce it with the patch felipe provided (this is plain
-rc3 too)


This is the trace of the looping pppd:

pppd          S C140E820     0   721      1 18063         17268 (NOTLB)
004d8032 7a6e2f0b 00000f8c c140e820 00000001 ddce8170 dd749e18 dd749e18 
       00000000 00000001 c032bc08 0000000a dd749e64 c011f454 00000046 00000001 
       c03500a4 00000046 c03500a8 c0110f66 ddce8170 ddce8170 010bdf60 dd749eec 
Call Trace:
 [<c011f454>] __do_softirq+0xb4/0xc0
 [<c0110f66>] smp_apic_timer_interrupt+0xe6/0x150
 [<c0104b1a>] apic_timer_interrupt+0x1a/0x20
 [<c02a42d1>] schedule+0x71/0x640
 [<c0104b1a>] apic_timer_interrupt+0x1a/0x20
 [<c0123ad0>] process_timeout+0x0/0x10
 [<c0123218>] del_singleshot_timer_sync+0x8/0x30
 [<c02a4f79>] schedule_timeout+0x69/0xc0
 [<c0104a98>] common_interrupt+0x18/0x20
 [<c0123ad0>] process_timeout+0x0/0x10
 [<c0259d15>] netdev_wait_allrefs+0x55/0x110
 [<c0259efc>] netdev_run_todo+0x12c/0x240
 [<e08aa1a0>] ppp_asynctty_close+0x0/0x100 [ppp_async]
 [<e08b4c5b>] ppp_shutdown_interface+0x8b/0xf0 [ppp_generic]
 [<e08b2082>] ppp_release+0x52/0x60 [ppp_generic]
 [<c0152a56>] __fput+0x106/0x120
 [<c015129f>] filp_close+0x4f/0x80
 [<c01040d9>] sysenter_past_esp+0x52/0x71


profile (it's a dual box, the bug only keeps 100% one cpu, i reseted the
profile and let it run 5-10 seconds before getting this)

 23165 total                                      0,0134
 11517 default_idle                             179,9531
  4099 schedule                                   2,5619
  3572 __mod_timer                                6,3786
  1867 del_timer                                 11,6687
  1202 sched_clock                                8,3472
   508 schedule_timeout                           2,6458
   194 netdev_wait_allrefs                        0,7132
   157 del_singleshot_timer_sync                  3,2708
    13 __copy_user_intel                          0,0739


Diego Calleja
