Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWE0HHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWE0HHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 03:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWE0HHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 03:07:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38711 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751436AbWE0HHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 03:07:36 -0400
Date: Sat, 27 May 2006 09:07:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060527070724.GB24988@suse.de>
References: <20060526213915.GB7585@redhat.com> <20060526170013.67391a2b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526170013.67391a2b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26 2006, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > Was playing with googles new picasa toy, which hammered the disks
> > hunting out every image file it could find, when this popped out:
> > 
> > Slab corruption: (Not tainted) start=ffff810012b998c8, len=168
> > Redzone: 0x5a2cf071/0x5a2cf071.
> > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
> > 090: 10 bd 28 1b 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
> > Prev obj: start=ffff810012b99808, len=168
> > Redzone: 0x5a2cf071/0x5a2cf071.
> > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
> > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Next obj: start=ffff810012b99988, len=168
> > Redzone: 0x5a2cf071/0x5a2cf071.
> > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
> > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > 
> 
> Just to compare notes...
> 
> I hit the below a few times last week.  That was with the subsystem-trees
> part of the mm lineup applied, but it doesn't have much in the way of CFQ
> alterations.
> 
> 
> audit(1147884480.106:2): selinux=0 auid=4294967295
> general protection fault: 0000 [1]  ipv6 ppdev autofs4 hidp rfcomm l2cap bluetooth sunrpc dm_mirror dm_mod video sony_acpi button battery asus_acpi ac lp parport_pc parport nvram snd_hda_intel snd_hda_codec i2c_i801 sr_mod snd_seq_dummy i2c_core sg snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device ehci_hcd snd_pcm_oss ohci1394 ieee1394 snd_mixer_oss uhci_hcd snd_pcm snd_timer snd soundcore snd_page_alloc hw_random ext3 jbd ata_piix libata sd_mod scsi_mod
> Pid: 15, comm: kblockd/1 Not tainted 2.6.17-rc4-mm1 #3
> RIP: 0010:[<ffffffff802f0cc3>] <ffffffff802f0cc3>{cfq_dispatch_requests+816}
> RSP: 0018:ffff81012f4dfd48  EFLAGS: 00010087
> RAX: ffff81012c89ab58 RBX: ffff81012edd8060 RCX: 00000001009985e6
> RDX: 0000000000000001 RSI: ffff81012edd8068 RDI: 0000000000000000
> RBP: ffff81012edd8000 R08: ffff81012edd8088 R09: 0000000000000000
> R10: ffff81012f91d900 R11: ffff81012edd8000 R12: 0002000500030002
> R13: 0000000000000004 R14: 0000000000000000 R15: ffff81012f91d900
> FS:  0000000000000000(0000) GS:ffff81012fcb5cc0(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000003052576460 CR3: 0000000119422000 CR4: 00000000000006e0
> Process kblockd/1 (pid: 15, threadinfo ffff81012f4de000, task ffff81012f4d9080)
> Stack: ffffffff880027a8 0000000000000000 ffff81012f91d800 ffff81012eecb550 
>        ffff81012eecb550 ffff81012eecb748 ffff81012f91d900 ffffffff802e5e51 
>        ffff81012f91da30 ffff8101157030a8 
> Call Trace: <ffffffff880027a8>{:scsi_mod:scsi_done+0}
>        <ffffffff802e5e51>{elv_next_request+321} <ffffffff88008174>{:scsi_mod:scsi_request_fn+115}
>        <ffffffff802f1208>{cfq_kick_queue+0} <ffffffff802f1287>{cfq_kick_queue+127}
>        <ffffffff8023f269>{run_workqueue+159} <ffffffff8023fc51>{worker_thread+0}
>        <ffffffff802425b0>{keventd_create_kthread+0} <ffffffff8023fd5a>{worker_thread+265}
>        <ffffffff8022904d>{default_wake_function+0} <ffffffff802425b0>{keventd_create_kthread+0}
>        <ffffffff802425b0>{keventd_create_kthread+0} <ffffffff802428df>{kthread+254}
>        <ffffffff8020a14a>{child_rip+8} <ffffffff802425b0>{keventd_create_kthread+0}
>        <ffffffff8043fb47>{thread_return+0} <ffffffff802427e1>{kthread+0}
>        <ffffffff8020a142>{child_rip+0}
> 
> Code: 49 8b 54 24 20 83 7b 20 01 48 19 c0 48 83 e0 fc 8b 84 30 e8 

Pretty baffling... cfq has been hammered pretty thoroughly over the
last months and _nothing_ has shown up except some performance anomalies
that are now fixed. Since daves case (at least) seems to be
use-after-free, I'll see if I can reproduce with some contrived case.
I'm asuming that picasa forks and exits a lot with submitted io in
between than may not have finished at exit.

-- 
Jens Axboe

