Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWJLNe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWJLNe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 09:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWJLNe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 09:34:27 -0400
Received: from twin.jikos.cz ([213.151.79.26]:39148 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751402AbWJLNe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 09:34:26 -0400
Date: Thu, 12 Oct 2006 15:33:11 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, khali@linux-fr.org,
       i2c@lm-sensors.org, v4l-dvb-maintainer@linuxtv.org
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: lockdep warning in i2c_transfer() with dibx000 DVB - input tree
 merge plans?
Message-ID: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Andi on CC because of the DWARF2 unwinder stuck message)

when hotplugging AverTV DVB-T tuner, I get:

=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc1-mm1 #4
---------------------------------------------
khubd/451 is trying to acquire lock:
(&adap->bus_lock){--..}, at: [<f8902177>] i2c_transfer+0x23/0x40 
[i2c_core]

but task is already holding lock:
(&adap->bus_lock){--..}, at: [<f8902177>] i2c_transfer+0x23/0x40 
[i2c_core]

other info that might help us debug this:
1 lock held by khubd/451:
#0: (&adap->bus_lock){--..}, at: [<f8902177>] i2c_transfer+0x23/0x40 
[i2c_core]

stack backtrace:
[<c0103b69>] dump_trace+0x65/0x1a2
[<c0103cb6>] show_trace_log_lvl+0x10/0x20
[<c0103f84>] show_trace+0xa/0xc
[<c0103f99>] dump_stack+0x13/0x15
[<c0132ea4>] __lock_acquire+0x7bd/0xa05
[<c01333c1>] lock_acquire+0x5c/0x7b
[<c034b683>] __mutex_lock_slowpath+0xab/0x1de
[<f8902177>] i2c_transfer+0x23/0x40 [i2c_core]
[<f88fa1bf>] dibx000_i2c_gated_tuner_xfer+0x166/0x185 [dibx000_common]
[<f8902183>] i2c_transfer+0x2f/0x40 [i2c_core]
[<f891f04b>] mt2060_readreg+0x4b/0x69 [mt2060]
[<f891f45e>] mt2060_attach+0x40/0x1ea [mt2060]
[<f895f468>] dibusb_dib3000mc_tuner_attach+0x126/0x16c 
[dvb_usb_dibusb_common]
[<d10ea000>] 0xd10ea000
DWARF2 unwinder stuck at 0xd10ea000
Leftover inexact backtrace:
[<f88f3f7f>] dvb_usb_adapter_frontend_init+0xb9/0xd7 [dvb_usb]
[<f88f36e5>] dvb_usb_device_init+0x383/0x46e [dvb_usb]
[<f895c08a>] a800_probe+0x11/0x13 [dvb_usb_a800]
[<c02bde12>] usb_probe_interface+0x5c/0x7e
[<c0257384>] really_probe+0x5e/0xbd
[<c02576c7>] __device_attach+0x0/0x5
[<c02569ba>] bus_for_each_drv+0x35/0x5d
[<c0257453>] device_attach+0x60/0x74
[<c02576c7>] __device_attach+0x0/0x5
[<c0256a2f>] bus_attach_device+0x1e/0x41
[<c0255d49>] device_add+0x347/0x4f1
[<c015ed9d>] kfree+0xb5/0xbc
[<c02bd07d>] usb_set_configuration+0x30d/0x35e
[<c02c25ec>] generic_probe+0x154/0x188
[<c02bd8cc>] usb_probe_device+0x32/0x37
[<c0257384>] really_probe+0x5e/0xbd
[<c02576c7>] __device_attach+0x0/0x5
[<c02569ba>] bus_for_each_drv+0x35/0x5d
[<c0257453>] device_attach+0x60/0x74
[<c02576c7>] __device_attach+0x0/0x5
[<c0256a2f>] bus_attach_device+0x1e/0x41
[<c0255d49>] device_add+0x347/0x4f1
[<c02b8236>] __usb_new_device+0x118/0x14a
[<c02ba166>] hub_thread+0x636/0x974
[<c012c656>] autoremove_wake_function+0x0/0x2d
[<c02b9b30>] hub_thread+0x0/0x974
[<c012c607>] kthread+0xc1/0xee
[<c012c546>] kthread+0x0/0xee
[<c01038a3>] kernel_thread_helper+0x7/0x10
=======================                                   

This could be easily solved, as this is recursive locking situation with 
child-parent hierarchy.

I would like to use the same approach we used with Peter Zijlstra to fix 
lockdep warnings in drivers/input/serio.c - i.e. taking advantage of newly 
introduced lockdep_set_subclass(), to do it in a clean way.

However the patch introducing lockdep_set_subclass() is currently only in 
Dmitry's input tree (commit 4dfbb9d8c6cbfc32faa5c71145bd2a43e1f8237c) - 
but the fix for DVB/I2C hardly belongs to input tree, so I am quite stuck.

What are the merge plans of input tree? Is it going in some short time 
into mainline or into -mm?

Thanks,

-- 
Jiri Kosina
