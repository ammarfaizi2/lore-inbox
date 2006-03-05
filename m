Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752278AbWCEXur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbWCEXur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWCEXur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:50:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752281AbWCEXuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:50:46 -0500
Date: Sun, 5 Mar 2006 15:48:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: oops in choose_configuration()
Message-Id: <20060305154858.0fb0006a.akpm@osdl.org>
In-Reply-To: <20060304221810.GA20011@kroah.com>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	<Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	<20060304213447.GA4445@kroah.com>
	<20060304135138.613021bd.akpm@osdl.org>
	<20060304221810.GA20011@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Might as well cc the list on this, so there's a record...

For several days I've been getting repeatable oopses in the -mm kernel. 
They occur once per ~30 boots, during initscripts.

Two days of bisection searching shows that when this scheduler patch

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/sched-alter_uninterruptible_sleep_interactivity.patch

is included, the oopses start occurring.

I don't think the scheduler patch is the bug - I guess it just alters
timing.  The pipe code and the exec code are repeatedly implicated in the
oopses, and it's noteworthy that
sched-make_task_noninteractive_use_sleep_type.patch, which affects the pipe
wakeup handling does _not_ need to be present for this bug to manifest.

I tested current -linus with just these patches applied:

sched-fix-task-interactivity-calculation
sched-implement-smpnice
sched-smpnice-apply-review-suggestions
sched-smpnice-fix-average-load-per-run-queue-calculations
sched-cleanup_task_activated
sched-alter_uninterruptible_sleep_interactivity
sched-make_task_noninteractive_use_sleep_type
sched-dont_decrease_idle_sleep_avg
sched-include_noninteractive_sleep_in_idle_detect
sched-remove-on-runqueue-requeueing

and mainline oopses too.  So either there's a bug in mainline, or there's a
bug in one of these:

sched-fix-task-interactivity-calculation
sched-implement-smpnice
sched-smpnice-apply-review-suggestions
sched-smpnice-fix-average-load-per-run-queue-calculations
sched-cleanup_task_activated
sched-alter_uninterruptible_sleep_interactivity


The usual pattern of the oopses is that something has been overwritten with
some data which has been used as an environment string by the uevent code.

Example:

SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Unable to handle kernel paging request at virtual address 44535955
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: nvram ipw2200 ohci1394 ide_cd cdrom ieee1394 uhci_hcd sg ehci_hcd ieee80211 ieee80211_crypt joydev snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event i2c_i801 snd_seq i2c_core snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore piix hw_random snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c0242dd3>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc5-mm2 #298) 
EIP is at choose_configuration+0x58/0x13a
eax: 000000d2   ebx: f7724c00   ecx: 44535950   edx: 000001f4
esi: f77e3600   edi: 00000001   ebp: 00000000   esp: c1d7def8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 114, threadinfo=c1d7d000 task=c1d7ca90)
Stack: <0>00000000 0000d000 f7724c00 f7724c00 00000000 00000001 c0242f68 00000000 
       f7724c00 c1d410c0 c02440b8 00000000 0000000a f7c71214 f7055000 00000010 
       c1d410c0 00000001 f7055000 00000001 c024450f 00000001 00000000 f7c71200 
Call Trace:
 [<c0242f68>] usb_new_device+0xb3/0x129
 [<c02440b8>] hub_port_connect_change+0x1ad/0x343
 [<c024450f>] hub_events+0x2c1/0x3f1
 [<c024463f>] hub_thread+0x0/0xe6
 [<c0244649>] hub_thread+0xa/0xe6
 [<c0129bb3>] autoremove_wake_function+0x0/0x2d
 [<c0129bb3>] autoremove_wake_function+0x0/0x2d
 [<c01298a8>] kthread+0x9c/0xa1
 [<c012980c>] kthread+0x0/0xa1
 [<c01012e1>] kernel_thread_helper+0x5/0xb
Code: 00 58 39 fd c7 04 24 00 00 00 00 7d 53 0f b6 46 08 8b 8e 90 00 00 00 0f b7 93 18 02 00 00 01 c0 83 c1 08 39 d0 7f 2e 85 ed 75 0a <80> 79 05 02 0f 84 bf 00 00 00 80 bb 7c 01 00 00 ff 74 0a 80 79 
 <7>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460300efc55d]

Here, the faulting address is ascii "UYSD".  Ignore the "D" because it was
offset a bit by pointer indexing.  That YSD appears in
drivers/base/core.c:dev_uevent().


Previously I've seen corruption of the local linux_binprm storage in
do_execve().  Often I've seen oopses like this:


audit(1141477276.672:3): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
*pde = 00000000
Oops: 0002 [#1]
last sysfs file: /block/hda/removable
Modules linked in: ide_cd cdrom ipw2200 ohci1394 ieee1394 ehci_hcd uhci_hcd ieee80211 sg ieee80211_crypt joydev snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm i2c_i801 snd_timer snd i2c_core piix soundcore hw_random snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c0129011>]    Not tainted VLI
EFLAGS: 00010046   (2.6.16-rc5-mm2 #287) 
EIP is at add_wait_queue+0xd/0x1d
eax: f76dc000   ebx: 00000000   ecx: f768a018   edx: f768a00c
esi: 00000246   edi: f7f6b200   ebp: f7106764   esp: f7763ea0
ds: 007b   es: 007b   ss: 0068
Process udevd (pid: 1005, threadinfo=f7763000 task=f7729ab0)
Stack: <0>f76dc000 f7763f0c c015e6a7 f7f6b200 00000000 00000008 00000145 c0163c6e 
       00000000 00000000 00000000 00000003 00000008 00000000 00000000 00000008 
       f705bf6c f705bf68 f705bf64 f705bf74 f705bf70 f705bf6c 00000003 f7763f0c 
Call Trace:
 <c015e6a7> pipe_poll+0x24/0x94   <c0163c6e> do_select+0x2d1/0x2d5
 <c016385f> __pollwait+0x0/0x94   <c0163e49> core_sys_select+0x1c4/0x2f8
 <c0164007> sys_select+0x8a/0x18f   <c0102a9b> sysenter_past_esp+0x54/0x75
Code: 11 c0 e8 af e1 ff ff eb c2 89 d8 e8 28 dd fe ff eb af 8d 06 e8 55 72 19 00 eb a6 90 90 90 56 53 83 22 fe 9c 5e fa 8b 18 8d 4a 0c <89> 4b 04 89 5a 0c 89 41 04 89 08 56 9d 5b 5e c3 56 53 83 0a 01 
 <1>BUG: unable to handle kernel paging request at virtual address 464c457f
 printing eip:
c0117418
*pde = 3e427067
Oops: 0000 [#2]
last sysfs file: /class/firmware/0000:06:0b.0/loading
Modules linked in: ide_cd cdrom ipw2200 ohci1394 ieee1394 ehci_hcd uhci_hcd ieee80211 sg ieee80211_crypt joydev snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm i2c_i801 snd_timer snd i2c_core piix soundcore hw_random snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c0117418>]    Not tainted VLI
EFLAGS: 00010092   (2.6.16-rc5-mm2 #287) 
EIP is at __wake_up_common+0x12/0x57
eax: 464c457f   ebx: 00000202   ecx: 00000001   edx: 00000001
esi: 00000001   edi: f76dc000   ebp: f7eb1f1c   esp: f7eb1f04
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 1013, threadinfo=f7eb1000 task=f7ebe570)
Stack: <0>00000006 c0339118 00000001 00000202 c17e9f40 00000006 f7eb1f30 c011746e 
       00000000 00000000 f76dc000 00000001 c015e4e8 00000000 f76dc000 f76dc010 
       00000000 00000001 00000006 f76dc000 f7106764 f7eb1f78 f7f6b740 00000006 
Call Trace:
 <c011746e> __wake_up+0x11/0x1a   <c015e4e8> pipe_writev+0x273/0x38a
 <c015e61b> pipe_write+0x1c/0x20   <c0154386> vfs_write+0xb1/0x151
 <c01544c6> sys_write+0x3c/0x64   <c0102a9b> sysenter_past_esp+0x54/0x75
Code: c0 89 f0 e8 df f6 ff ff e9 f4 fd ff ff 55 89 e5 8b 40 04 5d e9 95 f8 ff ff 55 89 e5 57 89 c7 56 89 ce 53 83 ec 0c 89 55 f0 8b 00 <8b> 10 39 f8 89 55 ec 74 34 8d 58 f4 8b 55 f0 8b 40 f4 ff 75 0c 
 <1>BUG: unable to handle kernel paging request at virtual address 6f732e6f
 printing eip:
c0163033
*pde = 00000000
Oops: 0000 [#3]


Note that in oops #2, the faulting address is ascii "\7fELF".  We think
that kernel_read() has read an elf file on top of *(inode->i_pipe) in
pipe_writev.  Note that i_pipe and linux_binprm both use the size-512 slab,
and the offsets into that memory is 0x00 in both cases.

But the management of do_execve():bprm is super-simple.


Here's another pipe-got-overwritten-by-ELF oops:

audit(1141524105.698:3): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
BUG: unable to handle kernel paging request at virtual address 464c457f
 printing eip:
*pde = 3eeb0067
Oops: 0000 [#1]
last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb5/5-0:1.0/modalias
Modules linked in: ipw2200 ohci1394 ieee1394 ehci_hcd uhci_hcd sg ieee80211 ieee80211_crypt joydev snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm i2c_i801 snd_timer piix snd i2c_core soundcore hw_random snd_page_alloc generic ext3 jbd ide_disk ide_core
CPU:    0
EIP:    0060:[<c011741a>]    Not tainted VLI
EFLAGS: 00010092   (2.6.16-rc5-mm2 #293) 
EIP is at __wake_up_common+0x12/0x57
eax: 464c457f   ebx: 00000202   ecx: 00000001   edx: 00000001
esi: 00000001   edi: f76fde00   ebp: f7f7af1c   esp: f7f7af04
ds: 007b   es: 007b   ss: 0068
Process sh (pid: 994, threadinfo=f7f7a000 task=f776a030)
Stack: <0>0000000f c0338128 00000001 00000202 c17d5b60 0000000f f7f7af30 c0117470 
       00000000 00000000 f76fde00 00000001 c015e00c 00000000 f76fde00 f76fde10 
       00000000 00000001 0000000f f76fde00 f706b320 f7f7af78 f7702900 0000000f 
Call Trace:
 <c0117470> __wake_up+0x11/0x1a   <c015e00c> pipe_writev+0x273/0x38a
 <c015e13f> pipe_write+0x1c/0x20   <c0153eae> vfs_write+0xb1/0x151
 <c0153fee> sys_write+0x3c/0x64   <c0102a9b> sysenter_past_esp+0x54/0x75
Code: c0 89 f0 e8 d9 f6 ff ff e9 f4 fd ff ff 55 89 e5 8b 40 04 5d e9 95 f8 ff ff 55 89 e5 57 89 c7 56 89 ce 53 83 ec 0c 89 55 f0 8b 00 <8b> 10 39 f8 89 55 ec 74 34 8d 58 f4 8b 55 f0 8b 40 f4 ff 75 0c 
 <1>BUG: unable to handle kernel paging request at virtual address 0064777f


It takes maybe an hour of rebooting to reproduce this.  Kernel is uniproc,
voluntary preempt
(http://www.zip.com.au/~akpm/linux/patches/stuff/config-sony).

The next stage in brute-forcing is to start bisecting Linus's tree,
applying the sched patches at each stage.  At a few hours per step I don't
relish that.

Ingo, could you please take a real close look at the above six sched
patches, see if you can spot anything in there which might cause this?

I have a feeling that this bug has been there for a while - I have seen a
couple of funny oopses booting this machine over the past couple of months.
Those sched patches have been in -mm for a couple of months too.

Enabling CONFIG_SLAB_DEBUG or CONFIG_DEBUG_PAGEALLOC seems to make the bug
go away (naturally).   I'll retest that now.
