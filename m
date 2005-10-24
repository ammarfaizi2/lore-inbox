Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVJXVQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVJXVQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVJXVQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:16:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751302AbVJXVQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:16:47 -0400
Date: Mon, 24 Oct 2005 14:16:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: 2.6.14-rc5-mm1
Message-Id: <20051024141646.6265c0da.akpm@osdl.org>
In-Reply-To: <1130186927.6831.23.camel@localhost.localdomain>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	<1130186927.6831.23.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@gmail.com> wrote:
>
> On Mon, 2005-10-24 at 01:48 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> > 
> 
> I can't seem to keep my AMD64 machine up with 2.6.14-rc5-mm1.
> Keep running into following. qlogic driver problem ?

I don't know why the qlogic driver has suddenly started doing this - were
there any earlier messages which might tell us?  Is it possible to increase
the debugging level?

I can spot one bug in there, but the lockup is just a symptom.

There are no qlogic changes in 2.6.14-rc5-mm1.

> Thanks,
> Badari
> 
> NMI Watchdog detected LOCKUP on CPU 0
> CPU 0
> Modules linked in: qlogicfc qla2300 qla2200 qla2xxx firmware_class
> ohci_hcd hw_r andom usbcore dm_mod
> Pid: 4414, comm: modprobe Not tainted 2.6.14-rc5-mm1 #3
> RIP: 0010:[<ffffffff80401d94>] <ffffffff80401d94>{.text.lock.spinlock
> +34}

That's a corrupted spinlock.

> RSP: 0000:ffff81019da91c28  EFLAGS: 00000086
> RAX: 0000000000000000 RBX: ffff81017991f288 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffff81017991f290
> RBP: ffff81019da91c28 R08: 0000000000000034 R09: 0000000000000000
> R10: ffff81019da91c08 R11: 0000000000000000 R12: ffff81017991f290
> R13: 00000000fffffff4 R14: ffff81017991c000 R15: 0000000000000100
> FS:  00002aaaaade36e0(0000) GS:ffffffff80649800(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000000000836018 CR3: 00000001bdf2a000 CR4: 00000000000006e0
> Process modprobe (pid: 4414, threadinfo ffff81019da90000, task
> ffff81019e3bb500)
> Stack: ffff81019da91cb8 ffffffff80400dec ffff81019da91c78
> ffffffff80142ed0
>        0000000000000000 0000000000000000 0000000000000001
> 0000000000000001
>        ffff81017991c000 0000000000000100
> Call Trace:<ffffffff80400dec>{wait_for_completion+28}
> <ffffffff80142ed0>{group_s end_sig_info+128}
>        <ffffffff80142f89>{kill_proc_info+73}
> <ffffffff8805753c>{:qla2xxx:qla2x00 _free_device+188}
>        <ffffffff8805880b>{:qla2xxx:qla2x00_probe_one+4187}
>        <ffffffff80132ce0>{set_cpus_allowed+336}
> <ffffffff8012dca3>{__wake_up_com mon+67}
>        <ffffffff8029741a>{kobject_get+26}
> <ffffffff8807c01d>{:qla2200:qla2200_pr obe_one+13}
>        <ffffffff802a516c>{pci_device_probe+252}
> <ffffffff80308d29>{driver_probe_ device+89}
>        <ffffffff80308da0>{__driver_attach+0}
> <ffffffff80308de2>{__driver_attach+ 66}
>        <ffffffff803086af>{bus_for_each_dev+79}
> <ffffffff80308bbc>{driver_attach+ 28}
>        <ffffffff80308108>{bus_add_driver+136}
> <ffffffff80308f0c>{driver_register +76}
>        <ffffffff802a4ebe>{pci_register_driver+158}
> <ffffffff8804d010>{:qla2200:q la2200_init+16}
>        <ffffffff80154072>{sys_init_module+274}
> <ffffffff8010dd2e>{system_call+12 6}

qla2x00_probe_one() has called qla2x00_free_device() and
qla2x00_free_device() has locked up in
wait_for_completion(&ha->dpc_exited);

Presumably, ha->dpc_exited is not initialised yet.

The first `goto probe_failed' in qla2x00_probe_one() will cause
qla2x00_free_device() to run wait_for_completion() against an uninitialised
completion struct.  Because ha->dpc_pid will be >= 0.

This patch might fix the lockup, but if so, qla2x00_iospace_config()
failed.  Please debug that a bit for us?

Andrew, this driver should be converted to use the kthread API - using
kill_proc() from within a driver to terminate a kernel thread is kinda
gross.


diff -puN drivers/scsi/qla2xxx/qla_os.c~qlogic-lockup-fix drivers/scsi/qla2xxx/qla_os.c
--- 25/drivers/scsi/qla2xxx/qla_os.c~qlogic-lockup-fix	Mon Oct 24 14:14:20 2005
+++ 25-akpm/drivers/scsi/qla2xxx/qla_os.c	Mon Oct 24 14:14:37 2005
@@ -1325,6 +1325,8 @@ int qla2x00_probe_one(struct pci_dev *pd
 	ha->brd_info = brd_info;
 	sprintf(ha->host_str, "%s_%ld", ha->brd_info->drv_name, ha->host_no);
 
+	ha->dpc_pid = -1;
+
 	/* Configure PCI I/O space */
 	ret = qla2x00_iospace_config(ha);
 	if (ret)
@@ -1448,7 +1450,6 @@ int qla2x00_probe_one(struct pci_dev *pd
 	 */
 	spin_lock_init(&ha->mbx_reg_lock);
 
-	ha->dpc_pid = -1;
 	init_completion(&ha->dpc_inited);
 	init_completion(&ha->dpc_exited);
 
_

