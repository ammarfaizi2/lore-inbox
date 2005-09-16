Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbVIPRlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbVIPRlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbVIPRlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:41:04 -0400
Received: from mail.portrix.net ([212.202.157.208]:64202 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1161206AbVIPRlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:41:02 -0400
Message-ID: <432B0394.8030907@ppp0.net>
Date: Fri, 16 Sep 2005 19:40:36 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Thunderbird/1.0.6 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.14-rc1 load average calculation broken?
References: <Pine.LNX.4.44L0.0509161214490.4972-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0509161214490.4972-100000@iolanthe.rowland.org>
Content-Type: multipart/mixed;
 boundary="------------020005080000020102050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005080000020102050000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Alan Stern wrote:
> On Fri, 16 Sep 2005, Jan Dittmer wrote:
> 
> 
>>>Can you post a stack dump for those two threads?  Normally they are idle,
>>>in an interruptible wait, so they shouldn't be in D state.  Since they
>>>are, maybe there's some sort of error recovery attempt going on.  Like
>>>hald doing its periodic checking of hotpluggable storage devices while
>>>your monitor is off.
>>
>>They don't appear in lsusb or /proc/scsi/scsi anymore, so I don't know what
>>you mean.
>>
>>[4327082.342000] usb-storage   D 000F4261     0  3308      1          4671
>>2487 (L-TLB)
>>[4327082.342000] ded95f0c c9185a70 c04ae888 000f4261 00000010 ded94000
>>00000000 cd393840
>>[4327082.342000]        000f4261 dfabcb98 dfabca70 ce5b2300 000f4261 ded94000
>>09c67100 00000000
>>[4327082.342000]        c0410b24 00000286 c0410b2c dfabca70 c03adb5d 00000001
>>dfabca70 c011a2f0
>>[4327082.342000] Call Trace:
>>[4327082.342000]  [<c03adb5d>] __down+0xdd/0x140
>>[4327082.342000]  [<c011a2f0>] default_wake_function+0x0/0x20
>>[4327082.342000]  [<c03ac35f>] __down_failed+0x7/0xc
>>[4327082.342000]  [<c02c5050>] scsi_host_dev_release+0x0/0x90
>>[4327082.342000]  [<c0134dd4>] .text.lock.kthread+0xb/0x27
>>[4327082.342000]  [<c02c5087>] scsi_host_dev_release+0x37/0x90
>>[4327082.342000]  [<c020a4be>] kobject_cleanup+0x4e/0xa0
>>[4327082.342000]  [<c020a510>] kobject_release+0x0/0x10
>>[4327082.342000]  [<c020af3f>] kref_put+0x2f/0x80
>>[4327082.342000]  [<c020a53e>] kobject_put+0x1e/0x30
>>[4327082.342000]  [<c020a510>] kobject_release+0x0/0x10
>>[4327082.342000]  [<e0869288>] usb_stor_control_thread+0x68/0x240 [usb_storage]
>>[4327082.342000]  [<c010322e>] ret_from_fork+0x6/0x14
>>[4327082.342000]  [<e0869220>] usb_stor_control_thread+0x0/0x240 [usb_storage]
>>[4327082.342000]  [<e0869220>] usb_stor_control_thread+0x0/0x240 [usb_storage]
>>[4327082.342000]  [<c01013ad>] kernel_thread_helper+0x5/0x18
> 
> 
> I recognize the problem.  This experimental patch should fix it:

It fixes the described problem but introduces some others:

[4294822.152000] ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 17 (level, low) ->
IRQ 18
[4294822.781000] libata version 1.12 loaded.
[4294822.795000] sata_via version 1.1
[4294822.795000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) ->
IRQ 17
[4294822.796000] PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
[4294822.798000] sata_via(0000:00:0f.0): routed to hard irq line 1
[4294822.800000] Unable to handle kernel NULL pointer dereference at virtual
address 00000048
[4294822.801000]  printing eip:
[4294822.803000] e5c4d384
[4294822.805000] *pde = 00000000
[4294822.806000] Oops: 0000 [#1]
[4294822.806000] PREEMPT
[4294822.806000] Modules linked in: sata_via libata snd_bt87x pl2303 usbserial
usblp usbhid snd_via82xx snd_mpu401_uart w83627hf w83781d i2c_viapro tun vfat
fat loop via_agp intel_agp agpgart lp parport_pc parport tuner tvaudio msp3400
bttv video_buf firmware_class v4l2_common btcx_risc tveeprom videodev eeprom
asb100 hwmon_vid hwmon i2c_dev i2c_isa i2c_i801 snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss
snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_ac97_bus
snd_page_alloc snd_util_mem snd_hwdep snd soundcore usb_storage ehci_hcd
uhci_hcd usbcore button processor ac e100 rtc
[4294822.806000] CPU:    0
[4294822.806000] EIP:    0060:[<e5c4d384>]    Not tainted VLI
[4294822.806000] EFLAGS: 00010282   (2.6.14-rc1-git1-via)
[4294822.806000] EIP is at ata_scsi_error+0x14/0x30 [libata]
[4294822.806000] eax: dfabb254   ebx: dfabb000   ecx: df8de000   edx: 00000000
[4294822.806000] esi: deb82000   edi: dfabb000   ebp: c02c8310   esp: deb83fa8
[4294822.806000] ds: 007b   es: 007b   ss: 0068
[4294822.806000] Process scsi_eh_5 (pid: 6417, threadinfo=deb82000 task=df5fda70)
[4294822.806000] Stack: dfabb254 dfabb000 c02c836d dfabb000 fffffffc df8dfde0
c0134bb6 dfabb000
[4294822.806000]        deb83fd0 00000000 ffffffff ffffffff c0134b00 00000000
00000000 00000000
[4294822.806000]        c01013ad df8dfde0 00000000 00000000 00000000 00000000
[4294822.806000] Call Trace:
[4294822.806000]  [<c02c836d>] scsi_error_handler+0x5d/0xa0
[4294822.806000]  [<c0134bb6>] kthread+0xb6/0xc0
[4294822.806000]  [<c0134b00>] kthread+0x0/0xc0
[4294822.806000]  [<c01013ad>] kernel_thread_helper+0x5/0x18
[4294822.806000] Code: 83 bd 63 da 83 c4 08 31 c0 5b c3 8d b6 00 00 00 00 8d
bf 00 00 00 00 53 83 ec 04 8b 5c 24 0c 8d 83 54 02 00 00 8b 50 04 89 04 24
<ff> 52 48 8d 43 38 ff 4b 60 89 43 38 89 43 3c 83 c4 04 5b 31 c0
[4294822.806000]  <6>ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma
0xDC00 irq 17
[4294822.845000] Unable to handle kernel NULL pointer dereference at virtual
address 00000048
[4294822.846000]  printing eip:
[4294822.848000] e5c4d384
[4294822.850000] *pde = 00000000
[4294822.851000] Oops: 0000 [#2]
[4294822.851000] PREEMPT
[4294822.851000] Modules linked in: sata_via libata snd_bt87x pl2303 usbserial
usblp usbhid snd_via82xx snd_mpu401_uart w83627hf w83781d i2c_viapro tun vfat
fat loop via_agp intel_agp agpgart lp parport_pc parport tuner tvaudio msp3400
bttv video_buf firmware_class v4l2_common btcx_risc tveeprom videodev eeprom
asb100 hwmon_vid hwmon i2c_dev i2c_isa i2c_i801 snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss
snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_ac97_bus
snd_page_alloc snd_util_mem snd_hwdep snd soundcore usb_storage ehci_hcd
uhci_hcd usbcore button processor ac e100 rtc
[4294822.851000] CPU:    0
[4294822.851000] EIP:    0060:[<e5c4d384>]    Not tainted VLI
[4294822.851000] EFLAGS: 00010282   (2.6.14-rc1-git1-via)
[4294822.851000] EIP is at ata_scsi_error+0x14/0x30 [libata]
[4294822.851000] eax: df1c6254   ebx: df1c6000   ecx: df8de000   edx: 00000000
[4294822.851000] esi: deb82000   edi: df1c6000   ebp: c02c8310   esp: deb83fa8
[4294822.851000] ds: 007b   es: 007b   ss: 0068
[4294822.851000] Process scsi_eh_6 (pid: 6418, threadinfo=deb82000 task=df5fda70)
[4294822.851000] Stack: df1c6254 df1c6000 c02c836d df1c6000 fffffffc df8dfde0
c0134bb6 df1c6000
[4294822.851000]        deb83fd0 00000000 ffffffff ffffffff c0134b00 00000000
00000000 00000000
[4294822.851000]        c01013ad df8dfde0 00000000 00000000 00000000 00000000
[4294822.851000] Call Trace:
[4294822.851000]  [<c02c836d>] scsi_error_handler+0x5d/0xa0
[4294822.851000]  [<c0134bb6>] kthread+0xb6/0xc0
[4294822.851000]  [<c0134b00>] kthread+0x0/0xc0
[4294822.851000]  [<c01013ad>] kernel_thread_helper+0x5/0x18
[4294822.851000] Code: 83 bd 63 da 83 c4 08 31 c0 5b c3 8d b6 00 00 00 00 8d
bf 00 00 00 00 53 83 ec 04 8b 5c 24 0c 8d 83 54 02 00 00 8b 50 04 89 04 24
<ff> 52 48 8d 43 38 ff 4b 60 89 43 38 89 43 3c 83 c4 04 5b 31 c0
[4294822.851000]  <6>ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma
0xDC08 irq 17
[4294823.096000] ata1: no device found (phy stat 00000000)
[4294823.098000] scsi5 : sata_via
[4294823.302000] ata2: no device found (phy stat 00000000)
[4294823.304000] scsi6 : sata_via

I attached your message for reference

-- 
Jan

--------------020005080000020102050000
Content-Type: text/x-patch;
 name="fix_kthread_exit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_kthread_exit.patch"

James:

This patch (as561) fixes the error handler's thread-exit code.  The 
kthread_stop call won't wake the thread from a down_interruptible, so 
the patch gets rid of the semaphore and simply does

	set_current_state(TASK_INTERRUPTIBLE);

Can you please check that the

	if (shost->host_busy == shost->host_failed ...

condition for waking up is really correct?  Thanks.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: usb-2.6/drivers/scsi/scsi_error.c
===================================================================
--- usb-2.6.orig/drivers/scsi/scsi_error.c
+++ usb-2.6/drivers/scsi/scsi_error.c
@@ -50,7 +50,7 @@
 void scsi_eh_wakeup(struct Scsi_Host *shost)
 {
 	if (shost->host_busy == shost->host_failed) {
-		up(shost->eh_wait);
+		wake_up_process(shost->ehandler);
 		SCSI_LOG_ERROR_RECOVERY(5,
 				printk("Waking error handler thread\n"));
 	}
@@ -69,9 +69,6 @@ int scsi_eh_scmd_add(struct scsi_cmnd *s
 	struct Scsi_Host *shost = scmd->device->host;
 	unsigned long flags;
 
-	if (shost->eh_wait == NULL)
-		return 0;
-
 	spin_lock_irqsave(shost->host_lock, flags);
 
 	scmd->eh_eflags |= eh_flag;
@@ -1582,37 +1579,33 @@ int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = (struct Scsi_Host *) data;
 	int rtn;
-	DECLARE_MUTEX_LOCKED(sem);
 
 	current->flags |= PF_NOFREEZE;
-	shost->eh_wait = &sem;
-
-	/*
-	 * Wake up the thread that created us.
-	 */
-	SCSI_LOG_ERROR_RECOVERY(3, printk("Wake up parent of"
-					  " scsi_eh_%d\n",shost->host_no));
 
 	while (1) {
-		/*
-		 * If we get a signal, it means we are supposed to go
-		 * away and die.  This typically happens if the user is
-		 * trying to unload a module.
-		 */
 		SCSI_LOG_ERROR_RECOVERY(1, printk("Error handler"
 						  " scsi_eh_%d"
 						  " sleeping\n",shost->host_no));
 
 		/*
-		 * Note - we always use down_interruptible with the semaphore
-		 * even if the module was loaded as part of the kernel.  The
-		 * reason is that down() will cause this thread to be counted
-		 * in the load average as a running process, and down
-		 * interruptible doesn't.  Given that we need to allow this
-		 * thread to die if the driver was loaded as a module, using
-		 * semaphores isn't unreasonable.
-		 */
-		down_interruptible(&sem);
+		 * Note - we always use TASK_INTERRUPTIBLE even if the
+		 * module was loaded as part of the kernel.  The reason
+		 * is that UNINTERRUPTIBLE would cause this thread to be
+		 * counted in the load average as a running process, and
+		 * an interruptible wait doesn't.
+		 */
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (shost->host_busy == shost->host_failed ||
+					kthread_should_stop()) {
+				set_current_state(TASK_RUNNING);
+				break;
+			}
+
+			/* Even though we are INTERRUPTIBLE, ignore signals */
+			flush_signals(current);
+			schedule();
+		}
 		if (kthread_should_stop())
 			break;
 
@@ -1648,10 +1641,6 @@ int scsi_error_handler(void *data)
 	SCSI_LOG_ERROR_RECOVERY(1, printk("Error handler scsi_eh_%d"
 					  " exiting\n",shost->host_no));
 
-	/*
-	 * Make sure that nobody tries to wake us up again.
-	 */
-	shost->eh_wait = NULL;
 	return 0;
 }
 
Index: usb-2.6/include/scsi/scsi_host.h
===================================================================
--- usb-2.6.orig/include/scsi/scsi_host.h
+++ usb-2.6/include/scsi/scsi_host.h
@@ -465,8 +465,6 @@ struct Scsi_Host {
 
 	struct list_head	eh_cmd_q;
 	struct task_struct    * ehandler;  /* Error recovery thread. */
-	struct semaphore      * eh_wait;   /* The error recovery thread waits
-					      on this. */
 	struct semaphore      * eh_action; /* Wait for specific actions on the
                                           host. */
 	unsigned int            eh_active:1; /* Indicates the eh thread is awake and active if

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--------------020005080000020102050000--
