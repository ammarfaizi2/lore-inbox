Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVBFTWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVBFTWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVBFTTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:19:51 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:29146 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261267AbVBFTPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:15:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Date: Sun, 6 Feb 2005 20:15:56 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20050204103350.241a907a.akpm@osdl.org> <200502051548.26729.rjw@sisk.pl> <20050205190700.GA2323@elte.hu>
In-Reply-To: <20050205190700.GA2323@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502062015.56458.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 5 of February 2005 20:07, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > I've attached a patch for touch_softlockup_watchdog() below - but i think
> > > what we really need is another mechanism. I'm wondering what the primary
> > > reason for the lockup-detection is - did swsuspend stop the the softlockup
> > > threads? 
> > 
> > If my understanding is correct, the time between suspend (ie the
> > creation of the image) and resume (ie the resotration of the image) is
> > considered as spent in the kernel, so it triggers softlockup as soon
> > as its threads are woken up (is that correct, Pavel?).
> 
> ah, ok. Could you try my patch and add touch_softlockup_watchdog() to
> the resume code (before interrupts are re-enabled)?

I did:

--- /home/rafael/tmp/kernel/testing/linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-05 20:57:03.000000000 +0100
+++ linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-06 19:07:39.000000000 +0100
@@ -871,6 +869,7 @@
 	restore_processor_state();
 	restore_highmem();
 	device_power_up();
+	touch_softlockup_watchdog();
 	local_irq_enable();
 	return error;
 }

and it still complains, but the call trace is now different:

BUG: soft lockup detected on CPU#0!
Feb  6 19:50:02 albercik kernel:
Feb  6 19:50:03 albercik kernel: Modules linked in: snd_seq snd_seq_device usbserial parport_pc lp parport thermal processor fan button battery ac snd_pc
m_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_TOS ipt_LOG ipt_limit ipt_pkttype af_packet ipt_state
ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 p
cmcia binfmt_misc joydev sg st sd_mod sr_mod scsi_mod ide_cd cdrom ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core sk98lin usbhid ehci_hcd i2c_
nforce2 i2c_core ohci_hcd dm_mod evdev
Feb  6 19:50:05 albercik kernel: Pid: 8679, comm: do_acpi_sleep Not tainted 2.6.11-rc3-mm1
Feb  6 19:50:07 albercik kernel: RIP: 0010:[<ffffffff802b6dd8>] <ffffffff802b6dd8>{acpi_ut_find_allocation+50}
Feb  6 19:50:11 albercik kernel: RSP: 0000:ffff81000d8af818  EFLAGS: 00000202
Feb  6 19:50:14 albercik kernel: RAX: ffff81001c91fa80 RBX: ffff8100123caeb0 RCX: ffff8100123caeb0
Feb  6 19:50:16 albercik kernel: RDX: ffff81001ed73878 RSI: ffff8100123caeb0 RDI: 0000000000000000
Feb  6 19:50:17 albercik kernel: RBP: ffffffff803ea5b8 R08: 00000000000021e7 R09: ffffffff803f478a
Feb  6 19:50:19 albercik kernel: R10: 000000000000ffff R11: 000000000000ffff R12: ffffffff803ea6b9
Feb  6 19:50:21 albercik kernel: R13: ffffffff00000400 R14: 0000000000000246 R15: 00000000000021e7
Feb  6 19:50:22 albercik kernel: FS:  00002aaaab28b800(0000) GS:ffffffff80567800(0000) knlGS:0000000000000000
Feb  6 19:50:24 albercik kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Feb  6 19:50:25 albercik kernel: CR2: 00002aaaaac4e642 CR3: 000000000d876000 CR4: 00000000000006e0
Feb  6 19:50:27 albercik kernel:
Feb  6 19:50:28 albercik kernel: Call Trace:<ffffffff802b6db3>{acpi_ut_find_allocation+13} <ffffffff802b6e8f>{acpi_ut_track_allocation+169}
Feb  6 19:50:28 albercik kernel:        <ffffffff802b71ed>{acpi_ut_callocate_and_track+95}
Feb  6 19:50:29 albercik kernel:        <ffffffff802b7259>{acpi_ut_acquire_from_cache+62} <ffffffff802b8a22>{acpi_ut_create_generic_state+17}
Feb  6 19:50:32 albercik kernel:        <ffffffff8029901f>{acpi_ds_result_stack_push+42} <ffffffff80299100>{acpi_ds_create_walk_state+152}
Feb  6 19:50:37 albercik kernel:        <ffffffff802b8e2d>{acpi_ut_create_thread_state+106}
Feb  6 19:50:39 albercik kernel:        <ffffffff802afb08>{acpi_ps_delete_parse_tree+113} <ffffffff802aea13>{acpi_ps_complete_this_op+476}
Feb  6 19:50:39 albercik kernel:        <ffffffff802af194>{acpi_ps_parse_loop+1897} <ffffffff802988f8>{acpi_ds_delete_walk_state+297}
Feb  6 19:50:41 albercik kernel:        <ffffffff802af5da>{acpi_ps_parse_aml+237} <ffffffff802b0266>{acpi_psx_execute+546}
Feb  6 19:50:42 albercik kernel:        <ffffffff802a5d77>{acpi_ex_enter_interpreter+114} <ffffffff802aae99>{acpi_ns_execute_control_method+260}
Feb  6 19:50:44 albercik kernel:        <ffffffff802aafb3>{acpi_ns_evaluate_by_handle+249}
Feb  6 19:50:45 albercik kernel:        <ffffffff802ab2de>{acpi_ns_evaluate_relative+400} <ffffffff802b3b2a>{acpi_rs_set_srs_method_data+250}
Feb  6 19:50:45 albercik kernel:        <ffffffff80176f90>{check_poison_obj+48} <ffffffff802b2687>{acpi_set_current_resources+122}

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
