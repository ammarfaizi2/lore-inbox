Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVCIT6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVCIT6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCIT6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:58:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:35513 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261170AbVCITn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:43:26 -0500
Date: Wed, 9 Mar 2005 11:42:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org,
       suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
Message-Id: <20050309114234.6598f486.akpm@osdl.org>
In-Reply-To: <1110395783.24286.207.camel@dyn318077bld.beaverton.ibm.com>
References: <20050309032832.159e58a4.akpm@osdl.org>
	<20050308170107.231a145c.akpm@osdl.org>
	<1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	<18744.1110364438@redhat.com>
	<20050309110404.GA4088@in.ibm.com>
	<1110366469.6280.84.camel@laptopd505.fenrus.org>
	<4175.1110370343@redhat.com>
	<1110395783.24286.207.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>  I am not sure if this is related to your patch. But I ran into
>  BUG() with sysrq-t with your patch.
> 
>  Thanks,
>  Badari
> 
>  BUG: soft lockup detected on CPU#1!
>                                      
>  Modules linked in: joydev sg st floppy usbserial parport_pc lp parport
>  ipv6 ohci_hcd i2c_amd756 i2c_core evdev usbcore raid0 dm_mod nls_utf8
>  Pid: 15433, comm: bash Not tainted 2.6.11-mm1n
>  RIP: 0010:[<ffffffff8013d094>] <ffffffff8013d094>{__do_softirq+84}
>  RSP: 0018:ffff8101dff83f68  EFLAGS: 00000206
>  RAX: ffffffff80651880 RBX: 0000000000000002 RCX: 0000000000000004
>  RDX: 0000000000000002 RSI: 0000000000000103 RDI: ffff8101d7c77680
>  RBP: ffff810177ffbe48 R08: 0000000000000002 R09: 0000000000000100
>  R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
>  R13: 00002aaaaaafb000 R14: 000000000000000a R15: 0000000000000001
>  FS:  00002aaaab2890a0(0000) GS:ffffffff80651880(0000)
>  knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>  CR2: 00002aaaaaafb000 CR3: 00000001bb2a0000 CR4: 00000000000006e0
>                                                                    
>  Call Trace:<IRQ> <ffffffff8013d165>{do_softirq+53}
>  <ffffffff8010ef59>{apic_timer_interrupt+133}
>          <EOI> <ffffffff80403055>{_spin_unlock_irqrestore+5}
>         <ffffffff801bd357>{write_sysrq_trigger+55}
>  <ffffffff80183579>{vfs_write+233}
>         <ffffffff80183713>{sys_write+83}
>  <ffffffff8010e5ce>{system_call+126}

That's probably just a false positive in Ingo's soft-lockup detector.  Long
streams of irq-context serial console output will do that.

Ingo, we already have a touch_nmi_watchdog() in the sysrq code.  It might be
worth adding a touch_softlockup_watchdog() wherever we have a
touch_nmi_watchdog().
