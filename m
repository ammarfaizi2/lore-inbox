Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWE3T2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWE3T2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWE3T2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:28:37 -0400
Received: from mail.parknet.jp ([210.171.160.80]:45830 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932434AbWE3T2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:28:36 -0400
X-AuthUser: hirofumi@parknet.jp
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
References: <20060526170013.67391a2b.akpm@osdl.org>
	<20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com>
	<20060530131728.GX4199@suse.de> <20060530161232.GA17218@redhat.com>
	<20060530164917.GB4199@suse.de> <20060530165649.GB17218@redhat.com>
	<20060530170435.GC4199@suse.de> <20060530184911.GD4199@suse.de>
	<20060530185158.GG4199@suse.de> <20060530191126.GJ4199@suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 31 May 2006 04:28:25 +0900
In-Reply-To: <20060530191126.GJ4199@suse.de> (Jens Axboe's message of "Tue, 30 May 2006 21:11:28 +0200")
Message-ID: <87slmrwbvq.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Tue, May 30 2006, Jens Axboe wrote:
>> On Tue, May 30 2006, Jens Axboe wrote:
>> > On Tue, May 30 2006, Jens Axboe wrote:
>> > > On Tue, May 30 2006, Dave Jones wrote:
>> > > > On Tue, May 30, 2006 at 06:49:18PM +0200, Jens Axboe wrote:
>> > > > 
>> > > >  > > List corruption. next->prev should be f74a5e2c, but was ea7ed31c
>> > > >  > > Pointing at cfq_set_request.
>> > > >  > 
>> > > >  > I think I'm missing a piece of this - what list was corrupted, in what
>> > > >  > function did it trigger?
>> > > > 
>> > > > If you look at the attachment in the bugzilla url in my previous msg,
>> > > > you'll see this:
>> > > > 
>> > > > ay 30 05:31:33 mandril kernel: List corruption. next->prev should be f74a5e2c, but was ea7ed31c
>> > > > May 30 05:31:33 mandril kernel: ------------[ cut here ]------------
>> > > > May 30 05:31:33 mandril kernel: kernel BUG at include/linux/list.h:58!
>> > > > May 30 05:31:33 mandril kernel: invalid opcode: 0000 [#1]
>> > > > May 30 05:31:33 mandril kernel: SMP
>> > > > May 30 05:31:33 mandril kernel: last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/pwm3
>> > > > May 30 05:31:33 mandril kernel: Modules linked in: iptable_filter ipt_DSCP iptable_mangle ip_tables x_tables eeprom lm85 hwmon_vid hwmon i2c_isa ipv6 nls_utf8 loop dm_mirror dm_mod video button battery ac lp parport_pc parport ehci_hcd uhci_hcd floppy snd_intel8x0 snd_ac97_codec snd_ac97_bus sg snd_seq_dummy matroxfb_base snd_seq_oss snd_seq_midi_event matroxfb_DAC1064 snd_seq matroxfb_accel matroxfb_Ti3026 3w_9xxx matroxfb_g450 snd_seq_device g450_pll matroxfb_misc snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd e1000 soundcore snd_page_alloc i2c_i801 i2c_core ext3 jbd 3w_xxxx ata_piix libata sd_mod scsi_mod
>> > > > May 30 05:31:33 mandril kernel: CPU:    0
>> > > > May 30 05:31:33 mandril kernel: EIP:    0060:[<c04e3310>]    Not tainted VLI
>> > > > May 30 05:31:33 mandril kernel: EFLAGS: 00210292   (2.6.16-1.2227_FC6 #1)
>> > > > May 30 05:31:33 mandril kernel: EIP is at cfq_set_request+0x202/0x3ff
>> > > 
>> > > Just do a l *cfq_set_request+0x202 from gdb if you have
>> > > CONFIG_DEBUG_INFO enabled in your vmlinux.
>> > 
>> > Doh, found it. Dave, please try and reproduce with this applied:
>> 
>> Nevermind, that's not it either. Damn. Stay tuned.
>
> Try this instead, please.

Umm.. don't we need this line?

static void cfq_free_io_context(struct io_context *ioc)
{
	struct cfq_io_context *__cic;
	struct rb_node *n;
	int freed = 0;

	while ((n = rb_first(&ioc->cic_root)) != NULL) {
		__cic = rb_entry(n, struct cfq_io_context, rb_node);
		rb_erase(&__cic->rb_node, &ioc->cic_root);
                list_del(&__cic->queue_list);
		^^^^^^^^   <---- this line
		kmem_cache_free(cfq_ioc_pool, __cic);
		freed++;
	}

	if (atomic_sub_and_test(freed, &ioc_count) && ioc_gone)
		complete(ioc_gone);
}
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
