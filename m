Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269563AbUJFVyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269563AbUJFVyc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269504AbUJFVq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:46:26 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:18377 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269511AbUJFVoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:44:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.9-rc3[+recent swsusp patches]: swsusp kernel-preemption-unfriendly?
Date: Wed, 6 Oct 2004 23:46:29 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410052314.25253.rjw@sisk.pl> <200410061206.56025.rjw@sisk.pl> <20041006101238.GD1255@elf.ucw.cz>
In-Reply-To: <20041006101238.GD1255@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410062346.29489.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 of October 2004 12:12, Pavel Machek wrote:
> Hi!
> 
> > > > > > It looks like there's a probel with the kernel preemption vs 
swsusp:
> > > > > 
> > > > > It is not in kernel preemption, see that NULL pointer dereference? 
Try
> > > > > this one...
> > > > [-- snip --]
> > > > 
> > > > Is it against -mm?  It does not apply cleanly to -rc3, so I've applied 
it 
> > > > manually.
> > > 
> > > It was against -suse... Did it help?
> > 
> > I just can't say it didn't right now.  The Oops was not readily 
reproducible 
> > anyway, so I need to do some more suspend/resume testing.  I'll let you 
> > know. ;-)
> 
> Ahha, thats likely another problem, then. The one this fixes is 100%
> reproducible...

You are right, it doesn't help.  Here's another trace for a non-preemptible 
kernel with the patch applied:

Stopping tasks: 
=================================================================|
Freeing 
memory: .....................................................................................................................|
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 
0x58c]...................................................................................................swsusp: 
Nees
suspend: (pages needed: 44159 + 512 free: 86720)
..<7>[nosave pfn 
0x58c].....................................................................................................swsusp: 
c)
Unable to handle kernel paging request at 000000ff9f2f9f09 RIP:
<ffffffff805693f7>{syscall_init+7}
PML4 0
Oops: 0000 [1]
CPU 0
Modules linked in: usbserial parport_pc lp parport joydev sg st sd_mod sr_mod 
scsi_mod usbhid snd_seq_oss snd_seq_midi_event snd_seq d
Pid: 16652, comm: hibernate.sh Not tainted 2.6.9-rc3
RIP: 0010:[<ffffffff805693f7>] <ffffffff805693f7>{syscall_init+7}
RSP: 0018:0000010003301e40  EFLAGS: 00010082
RAX: 0000000000000089 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000b1ff96ac RSI: 0000010003301e68 RDI: ffffffff80412190
RBP: 0000000000000004 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff80424fc0
R13: 0000000000000002 R14: 0000002a955a4000 R15: 0000000000000000
FS:  0000002a95d330a0(0000) GS:ffffffff8055eb40(0000) knlGS:0000000056055200
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000ff9f2f9f09 CR3: 0000000000101000 CR4: 00000000000006e0
Process hibernate.sh (pid: 16652, threadinfo 0000010003300000, task 
000001000f35c0f0)
Stack: ffffffff801209b9 0000000000000000 0000000000000004 8000894d50002080
       00000000ffffffff ffffffff804dafa0 ffffffff80120c28 0000000000000000
       ffffffff80161003 0000000000000000
Call Trace:<ffffffff801209b9>{fix_processor_context+137} 
<ffffffff80120c28>{__restore_processor_state+120}
       <ffffffff80161003>{swsusp_suspend+19} 
<ffffffff8016216a>{pm_suspend_disk+90}
       <ffffffff8015fd54>{enter_state+68} 
<ffffffff802adb4d>{acpi_system_write_sleep+100}
       <ffffffff80193854>{vfs_write+228} <ffffffff80193993>{sys_write+83}
       <ffffffff80110c72>{system_call+126}

Code: ff a6 a1 80 ff 9b 9c 75 ff 97 96 74 ff a1 a0 7e ff 9e 9c 7d
RIP <ffffffff805693f7>{syscall_init+7} RSP <0000010003301e40>
CR2: 000000ff9f2f9f09

It seems that I need to run X to reproduce it and it also seems that it's more 
likely to happen if I run some X apps and close them all before suspending.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
