Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWF0TIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWF0TIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWF0TIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:08:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7599 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932534AbWF0TH7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:07:59 -0400
Message-Id: <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Tue, 27 Jun 2006 19:23:53 +0200."
             <Pine.LNX.4.64.0606271919450.17704@scrub.home>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271903320.12900@scrub.home>
            <Pine.LNX.4.64.0606271919450.17704@scrub.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151435266_2887P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 15:07:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151435266_2887P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Jun 2006 19:23:53 +0200, Roman Zippel said:

I finished bisecting - the problem code is somewhere in
fix-and-optimize-clock-source-update.patch (which should narrow things
down a bunch).

> Could you please try the patch below? This should better locate which of 
> the values goes wrong.


> +	if (ts->tv_nsec < 0 || nsecs < 0)
> +		printk("unexpected nsec: %ld,%Ld\n", ts->tv_nsec, nsecs);
>  	timespec_add_ns(ts, nsecs);

I changed it slightly to also do a dump_stack() in case that mattered. I get:

[   22.562394] Time: tsc clocksource has been installed.

(Does the clocksource matter here?)

[   25.241589] audit(1151434000.4294965869:2): policy loaded auid=4294967295
[   25.260931] audit(1151434020.4294967250:3): avc:  granted  { load_policy } for  pid=1 comm="init" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=security
[   25.326263] unexpected nsec: -925155963,1574943831
[   25.346995]  <c01031ff> show_trace_log_lvl+0x54/0x174  <c01037bd> show_trace+0xd/0x10
[   25.368300]  <c010385a> dump_stack+0x19/0x1b  <c011a4f6> getnstimeofday+0x99/0xd0
[   25.389785]  <c0125428> ktime_get_ts+0x14/0x3f  <c0110ba2> copy_process+0x39f/0x10d8
[   25.411587]  <c0111b17> do_fork+0x8d/0x16a  <c0100a24> kernel_thread+0x6c/0x74
[   25.433731]  <c011fc35> __call_usermodehelper+0x2b/0x44  <c0120186> run_workqueue+0x94/0xe9
[   25.456400]  <c0120668> worker_thread+0xe1/0x115  <c0122ace> kthread+0xb0/0xdc
[   25.479234]  <c01006c5> kernel_thread_helper+0x5/0xb
[   25.551830] unexpected nsec: -347554993,1412474976
[   25.574337]  <c01031ff> show_trace_log_lvl+0x54/0x174  <c01037bd> show_trace+0xd/0x10
[   25.597459]  <c010385a> dump_stack+0x19/0x1b  <c011a4f6> getnstimeofday+0x99/0xd0
[   25.620925]  <c0125428> ktime_get_ts+0x14/0x3f  <c0110ba2> copy_process+0x39f/0x10d8
[   25.644923]  <c0111b17> do_fork+0x8d/0x16a  <c0100998> sys_clone+0x25/0x2a
[   25.669118]  <c010224d> sysenter_past_esp+0x56/0x79
[   25.693213] unexpected nsec: -1276931327,751175871
[   25.717404]  <c01031ff> show_trace_log_lvl+0x54/0x174  <c01037bd> show_trace+0xd/0x10
[   25.742269]  <c010385a> dump_stack+0x19/0x1b  <c011a4f6> getnstimeofday+0x99/0xd0
[   25.767382]  <c0125428> ktime_get_ts+0x14/0x3f  <c0110ba2> copy_process+0x39f/0x10d8
[   25.792768]  <c0111b17> do_fork+0x8d/0x16a  <c0100998> sys_clone+0x25/0x2a
[   25.818386]  <c010224d> sysenter_past_esp+0x56/0x79
[   74.653939] Real Time Clock Driver v1.12ac

(Later on, during udev processing, we get:

[   92.087113] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   92.087122] ACPI: Processor [CPU0] (supports 8 throttling states)
[   92.120270] ACPI: Thermal Zone [THM] (70 C)
[   72.242000] Time: acpi_pm clocksource has been installed.

and the timestamps steps back about 20 seconds.... 

That help any?


--==_Exmh_1151435266_2887P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEoYIBcC3lWbTT17ARAqr9AKC0aFF9wvGiDbPkdyKcJfJA0VZRogCffgRd
/9hul+/nBqybDdFv0ACBGMo=
=qteS
-----END PGP SIGNATURE-----

--==_Exmh_1151435266_2887P--
