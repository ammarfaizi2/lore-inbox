Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTLZNAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 08:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbTLZNAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 08:00:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55815 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265176AbTLZNAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 08:00:35 -0500
Date: Fri, 26 Dec 2003 13:00:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: (irda) Badness in local_bh_enable at kernel/softirq.c:121
Message-ID: <20031226130031.A14007@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	irda-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just been testing w83977af_ir with ircomm on a NetWinder (ARM) and
a Nokia mobile phone, and, while closing down the connection by exiting
minicom, I saw this which looks particularly evil.  I'm not sure exactly
when this occurred because I was running minicom over ssh.

ircomm_param_service_type(), services in common=04
ircomm_param_service_type(), resulting service type=0x04
ircomm_param_port_type(), port type=1
ircomm_param_port_type(), port type=1
ircomm_param_xon_xoff(), XON/XOFF = 0x11,0x13
ircomm_param_enq_ack(), ENQ/ACK = 0x13,0x11
ircomm_tty_check_modem_status()
ircomm_tty_check_modem_status()
ircomm_tty_check_modem_status()
ircomm_tty_check_modem_status()
ircomm_tty_close()
ircomm_tty_shutdown()
ircomm_tty_detach_cable()
Badness in local_bh_enable at kernel/softirq.c:121
[<c00429c4>] (local_bh_enable+0x0/0x84) from [<c014d1b4>] (dev_queue_xmit+0x108/0x20c)
[<c014d0ac>] (dev_queue_xmit+0x0/0x20c) from [<bf00ee68>] (irlap_send_data_primary_poll+0xdc/0x1c4 [irda])
[<bf00ed8c>] (irlap_send_data_primary_poll+0x0/0x1c4 [irda]) from [<bf00babc>] (irlap_state_xmit_p+0x1a4/0x308 [irda])
[<bf00b918>] (irlap_state_xmit_p+0x0/0x308 [irda]) from [<bf00a78c>] (irlap_do_event+0xd8/0x1f0 [irda])
[<bf00a6b4>] (irlap_do_event+0x0/0x1f0 [irda]) from [<bf008938>] (irlap_data_request+0x174/0x1a8 [irda])
[<bf0087c4>] (irlap_data_request+0x0/0x1a8 [irda]) from [<bf006f80>] (irlmp_state_dtr+0x17c/0x328 [irda])
[<bf006e04>] (irlmp_state_dtr+0x0/0x328 [irda]) from [<bf005fcc>] (irlmp_do_lsap_event+0xb8/0xe8 [irda])
[<bf005f14>] (irlmp_do_lsap_event+0x0/0xe8 [irda]) from [<bf003bc8>] (irlmp_disconnect_request+0x138/0x2f0 [irda])
[<bf003a90>] (irlmp_disconnect_request+0x0/0x2f0 [irda]) from [<bf0149bc>] (irttp_disconnect_request+0x220/0x274 [irda])
[<bf01479c>] (irttp_disconnect_request+0x0/0x274 [irda]) from [<bf035100>] (ircomm_state_conn+0xbc/0xf0 [ircomm])
[<bf035044>] (ircomm_state_conn+0x0/0xf0 [ircomm]) from [<bf0351a0>] (ircomm_do_event+0x6c/0x88 [ircomm])
[<bf035134>] (ircomm_do_event+0x0/0x88 [ircomm]) from [<bf034a40>] (ircomm_disconnect_request+0x94/0xc0 [ircomm])
[<bf0349ac>] (ircomm_disconnect_request+0x0/0xc0 [ircomm]) from [<bf03d838>] (ircomm_tty_state_ready+0x58/0xfc [ircomm_tty])
[<bf03d7e0>] (ircomm_tty_state_ready+0x0/0xfc [ircomm_tty]) from [<bf03d99c>] (ircomm_tty_do_event+0xc0/0xf4 [ircomm_tty])
[<bf03d8dc>] (ircomm_tty_do_event+0x0/0xf4 [ircomm_tty]) from [<bf03c4fc>] (ircomm_tty_detach_cable+0xcc/0x10c [ircomm_tty])
[<bf03c430>] (ircomm_tty_detach_cable+0x0/0x10c [ircomm_tty]) from [<bf03b5d8>] (ircomm_tty_shutdown+0x128/0x178 [ircomm_tty])
[<bf03b4b0>] (ircomm_tty_shutdown+0x0/0x178 [ircomm_tty]) from [<bf03a9c0>] (ircomm_tty_close+0x15c/0x240 [ircomm_tty])
[<bf03a864>] (ircomm_tty_close+0x0/0x240 [ircomm_tty]) from [<c00d7bd4>] (release_dev+0x1d8/0x5a4)
[<c00d79fc>] (release_dev+0x0/0x5a4) from [<c00d831c>] (tty_release+0x14/0x1c)
[<c00d8308>] (tty_release+0x0/0x1c) from [<c0072d6c>] (__fput+0x58/0x13c)
[<c0072d14>] (__fput+0x0/0x13c) from [<c007175c>] (filp_close+0x84/0x90)
[<c00716d8>] (filp_close+0x0/0x90) from [<c0028a40>] (ret_fast_syscall+0x0/0x2c)
ircomm_close()

Obviously, uniprocessor configuration, irda built completely modular.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
