Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVCNTCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVCNTCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCNTCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:02:39 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27888 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261687AbVCNTCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:02:25 -0500
Date: Mon, 14 Mar 2005 14:02:14 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503141349440.3763@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu>  <1108789704.8411.9.camel@krustophenia.net>
  <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> 
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> 
 <20050311095747.GA21820@elte.hu>  <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
  <20050311101740.GA23120@elte.hu>  <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
  <20050311024322.690eb3a9.akpm@osdl.org>  <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
  <20050311153817.GA32020@elte.hu>  <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
  <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
 <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I've found something that is very interesting and I can't explain it.


On Mon, 14 Mar 2005, Steven Rostedt wrote:
>
>
> On Mon, 14 Mar 2005, Steven Rostedt wrote:
> >
> > On Mon, 14 Mar 2005, Steven Rostedt wrote:
> > >
> > > I just downloaded -40 and applied my patch, compiled it with
> > > PREEMPT_DESKTOP and data=ordered, ran it and everything seems OK, except
> > > I'm getting the following...
> > >
> > > BUG: Unable to handle kernel NULL pointer dereference at virtual address
> > > 00000000
> > >  printing eip:
> > > c0213438
> > > *pde = 00000000
> >
> > [snip]
> >
> > >

All I did now was to add this patch to your -40-00 kernel:

diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h	2005-03-02 02:38:19.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h	2005-03-14 13:22:04.000000000 -0500
@@ -324,6 +324,8 @@
 	return bh->b_private;
 }

+BUFFER_FNS(JournalHead,journalhead)
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
 	bit_spin_lock(BH_State, &bh->b_state);



And I get the following output:

BUG: Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0213118
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ipv6 af_packet tsdev mousedev evdev floppy psmouse
pcspkr snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc shpchp pci_hotplug ehci_hcd
intel_agp agpgart uhci_hcd usbcore e100 mii ide_cd cdrom unix
CPU:    0
EIP:    0060:[<c0213118>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11-RT-V0.7.40-00)
EIP is at vt_ioctl+0x18/0x1ab0
eax: 00000000   ebx: 00005603   ecx: 00005603   edx: cee14d80
esi: c0213100   edi: cb4bd000   ebp: cc03bf18   esp: cc03be48
ds: 007b   es: 007b   ss: 0068   preempt: 00000000
Process XFree86 (pid: 4709, threadinfo=cc03a000 task=cf0d5020)
Stack: cf0d5170 cc03a000 cf0d5020 c03448ec cf0d5020 00000246 cc03be7c
c0117267
       c03448f4 00000006 00000001 00000000 00000000 cc03bebc cf1b81ec
ce820600
       ce94a9b8 00000000 00000000 cc03bed4 c01704f1 ce94a9b8 00000007
00000000
Call Trace:
 [<c0103cdf>] show_stack+0x7f/0xa0 (28)
 [<c0103e95>] show_registers+0x165/0x1d0 (56)
 [<c0104088>] die+0xc8/0x150 (64)
 [<c01153c6>] do_page_fault+0x356/0x6c4 (216)
 [<c0103973>] error_code+0x2b/0x30 (268)
 [<c020e5fb>] tty_ioctl+0x34b/0x490 (52)
 [<c016807f>] do_ioctl+0x4f/0x70 (32)
 [<c0168282>] vfs_ioctl+0x62/0x1d0 (40)
 [<c0168451>] sys_ioctl+0x61/0x90 (40)
 [<c0102ec3>] syscall_call+0x7/0xb (-8124)
Code: ff ff 8d 05 28 4d 34 c0 e8 f6 60 0a 00 e9 3a ff ff ff 90 55 89 e5 57
56 53 81 ec c4 00 00 00 8b 7d 08 8b 5d 10 8b 87 7c 09 00 00 <8b> 30 89 34
24 8b 04 b5 e0 b7 3c c0 89 45 8c e8 a4 6a 00 00 85



I don't know why. BUFFER_FNS is just defined as:

#define BUFFER_FNS(bit, name)						\
static inline void set_buffer_##name(struct buffer_head *bh)		\
{									\
	set_bit(BH_##bit, &(bh)->b_state);				\
}									\
static inline void clear_buffer_##name(struct buffer_head *bh)		\
{									\
	clear_bit(BH_##bit, &(bh)->b_state);				\
}									\
static inline int buffer_##name(const struct buffer_head *bh)		\
{									\
	return test_bit(BH_##bit, &(bh)->b_state);			\
}

So all it does is make three function that are never used.

set_buffer_journalhead(...)
clear_buffer_journalhead(...)
buffer_journalhead(...)

Unless, some macro uses it, but I don't know why adding that line causes
the bug output that I showed.  If I remove that line, I don't get that
output.  And this is consistent. I've recompiled the kernel several
times, and everytime I compile it with this added patch I get that output.
And everytime without it, it runs fine.

Oh, please note that this only happens with PREEMPT_DESKTOP, and not with
PREEMPT_RT.

I really think this is a symptom of something else and not the cause of
the bug. What do you think?


-- Steve

