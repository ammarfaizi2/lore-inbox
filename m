Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbSJFXJb>; Sun, 6 Oct 2002 19:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262261AbSJFXJb>; Sun, 6 Oct 2002 19:09:31 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:38904 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262260AbSJFXJW>; Sun, 6 Oct 2002 19:09:22 -0400
Date: Sun, 6 Oct 2002 19:15:11 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40-ac4  kernel BUG at slab.c:1477!
Message-ID: <20021006231511.GB1675@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3DA03B17.8010501@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA03B17.8010501@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 03:31:03PM +0200, Manfred Spraul wrote:
> > This happens at random during boot when loading modules.
> > About half of the time ide-scsi works fine.
> > The system continues to boot after the BUG with /dev/hdc unaccessible.
> 
> from mm/slab.c:
> 
> 1475 if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
> 1476     /* Either write before start, or a double free. */
> 1477     BUG();
> 
> You run an uniprocessor kernel, with slab debugging enabled, and the 
> red-zoning test notices a write before the beginning of the buffer 
> during scsi_probe_and_add_lun, with ide-scsi.
> 
> Andre: Do you know if ide-scsi makes any assumptions about memory 
> alignment of the input buffers? With slab debugging disabled, the 
> alignment is 32 or 64 bytes, with debugging enabled, it's just 4 byte 
> [actually sizeof(void*)] aligned.
> 
> Murray, could you apply the attached patch? It dumps the redzone value 
> during scsi_probe_and_add_lun. Hopefully this will help to find who 
> corrupts the buffers.
> 
After patch did a soft reboot and got a kernel oops.
I took a pic of it, but did a lousy job, so deciphering it is tricky - here's
what I can be sure is correct:

Mounting local filesystems:  Unable to handle kernel paging request at virtual address 00001124
*pde = 00000000
Oops: 0000
ide-scsi scsi_mod rtc
CPU:    0
EIP:    0060:[<fa8ebe82>]    Not tainted
EFLAGS: 00010296
EIP is at scsi_decide_disposition+0x12/0x160 [scsi_mod]

Call Trace:
 scsi_softirq+0x4b/0xd0 [scsi_mod]
 tasklet_hi_action+0x46/0x70
 do_softirq+0xb5/0xc0
 do_IRQ+0x109/0x130
 default_idle+0x0/0x40
 default_idle+0x0/0x40
 common_interrupt+0x10/0x20
 default_idle+0x0/0x40
 default_idle+0x0/0x40
 default_idle+0x24/0x40
 cpu_idle+0x3a/0x50
 stext+0x0/0x30
 
Code: f6 81 24 01 00 00 01 74 35 0f b6 83 3e 01 00 00 8b 93 3c 01
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

I'll save the pic in case you need the register or stack values

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

