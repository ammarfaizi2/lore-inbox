Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbTL3UIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbTL3UHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:07:49 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:56844 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265918AbTL3UHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:07:40 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: oops with 2.6.0 on IBM 600X
Date: Tue, 30 Dec 2003 23:02:10 +0300
User-Agent: KMail/1.5.3
Cc: Adam Belay <ambx1@neo.rr.com>, nplanel@mandrakesoft.com,
       Lonnie Borntreger <cooker@borntreger.com>, linux-kernel@vger.kernel.org
References: <20031219212249.32461180.akpm@osdl.org> <20031228115349.7e4947d5.akpm@osdl.org> <1072795322.5759.438.camel@pc>
In-Reply-To: <1072795322.5759.438.camel@pc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312302302.10834.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I added lkml as it is seems to be of general interest]

On Tuesday 30 December 2003 17:42, Brian J. Murrell wrote:
> [ Nicolas, I added you to this thread as this issue prevents your
> Mandrake 2.6.0 kernel from booting IBM 600* laptops.  Until it's fixed,
> perhaps it should be disabled?
>
> Lonnie, I added you as you are also a Mandrake user experiencing the
> same problem. ]
>
> On Sun, 2003-12-28 at 14:53, Andrew Morton wrote:
> > Don't know.   Brian, does the crash happen if CONFIG_BLK_DEV_IDEPNP
> > is disabled?
>
> Nope.  Not at all.  Good job Andrew and Andrey.
>

looking more closely: apparently we have IDE (PCI?) chipset; additionally BIOS 
export PnP information about IDE controller. Brian, could you do lspnp to 
verify and dmesg of system boot?

First chipset is initialized; next (last one) IDE PnP is called. It goes 
idepnp_probe -> ide_register_hw which finds matching (already registered) 
interface and calls ide_unregister on it:

                for (index = 0; index < MAX_HWIFS; ++index) {
                        hwif = &ide_hwifs[index];
                        if (hwif->hw.io_ports[IDE_DATA_OFFSET] == 
hw->io_ports[IDE_DATA_OFFSET])
                                goto found;
[...]
found:
        if (hwif->present)
                ide_unregister(index);

the devfs warning results from the fact that devfs path is first created in 
device-specific driver (in block layer for block devices) but is removed in 
ide_unregister. It is annoying but relatively harmless. The oops is likely to 
have the same reason, it attempts to remove structures that have not yet been 
setup at this point. It is likely to be this:

void ide_unregister (unsigned int index)
{
[...] first warning
        for (i = 0; i < MAX_DRIVES; ++i) {
                drive = &hwif->drives[i];
                if (drive->devfs_name[0] != '\0') {
                        devfs_remove(drive->devfs_name);
                        drive->devfs_name[0] = '\0';
                }
[...] second oops
               drive->present = 0;
                /* Messed up locking ... */
                spin_unlock_irq(&ide_lock);
                blk_cleanup_queue(drive->queue);
                device_unregister(&drive->gendev);

may be testing for drive->driver != idedefault_driver would stop the second 
oops but I am not sure which steps should be skipped.
  
Anyway the whole is rather absurd. IMHO PnP should not attempt to take over 
existing interface for which chipset-specific driver exists. Adding

if (hwif->chipset != ide_unknown)
   return -1;

looks like possible solution but I must admit rather surface knowledge of IDE 
subsystem here.

-andrey

> Now, _the_ question... is this issue resolvable other than disabling
> CONFIG_BLK_DEV_IDEPNP?  i.e. is this something that can/will be fixed
> any time soon?
>
> I don't think I particularly need CONFIG_BLK_DEV_IDEPNP, however it
> would seem that my distro (Mandrake) are enabling it and I would like to
> continue using their kernel rather than having to build my own all the
> time.  Life is too short to maintain kernels when somebody else is
> (usually) doing a satisfactory job of it.
>
> b.
>
> > Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > > On Saturday 20 December 2003 08:22, Andrew Morton wrote:
> > > > Andrey, are you still interested in devfs things??
> > >
> > > yes. sorry for silence but I have been busy with "real" work recently.
> > >
> > > > Begin forwarded message:
> > > >
> > > > Date: Fri, 19 Dec 2003 08:22:09 -0500
> > > > From: "Brian J. Murrell" <brian@interlinx.bc.ca>
> > > > To: linux-kernel@vger.kernel.org
> > > > Subject: oops with 2.6.0 on IBM 600X
> > > >
> > > >
> > > > Trying to boot 2.6.0 on an IBM 600X (I have seen a report of the same
> > > > with a 600E as well) I get the following 100% reproducable error and
> > > > stack trace:
> > >
> > > I do not think it directly relates to devfs, rather it relates to IDE
> > > PNP driver. I do not understand what it does and how it is supposed to
> > > work. But several problems with IDE I have seen all had IDE PNP driver
> > > in common.
> > >
> > > Does it happen without IDE PNP driver (CONFIG_BLK_DEV_IDEPNP)?
> > >
> > > -regards
> > >
> > > > devfs_remove: ide/host0/bus0/target0/lun0 not found, cannot remove
> > > > Call Trace:
> > > >  [<c01916b8>] devfs_remove+0x78/0x80
> > > >  [<c02235ff>] ide_hwif_release_regions+0x3f/0xc0
> > > >  [<c0223d4c>] ide_unregister+0x6cc/0x840
> > > >  [<c011dbd9>] recalc_task_prio+0xf9/0x200
> > > >  [<c011dd88>] try_to_wake_up+0xa8/0x140
> > > >  [<c011eb36>] __wake_up_common+0x26/0x50
> > > >  [<c0128a7c>] update_process_times+0x2c/0x40
> > > >  [<c0122473>] profile_hook+0x13/0x18
> > > >  [<c0119e1d>] smp_local_timer_interrupt+0xd/0xb0
> > > >  [<c0128a7c>] update_process_times+0x2c/0x40
> > > >  [<c0122473>] profile_hook+0x13/0x18
> > > >  [<c0119e1d>] smp_local_timer_interrupt+0xd/0xb0
> > > >  [<c0110f36>] timer_interrupt+0xb6/0xe0
> > > >  [<c013d1aa>] __rmqueue+0xda/0x140
> > > >  [<c013d243>] rmqueue_bulk+0x33/0x60
> > > >  [<c013d54d>] buffered_rmqueue+0xad/0x120
> > > >  [<c013d652>] __alloc_pages+0x92/0x320
> > > >  [<c014022b>] cache_init_objs+0x4b/0x80
> > > >  [<c013d54d>] buffered_rmqueue+0xad/0x120
> > > >  [<c013d652>] __alloc_pages+0x92/0x320
> > > >  [<c014022b>] cache_init_objs+0x4b/0x80
> > > >  [<c01403f9>] cache_grow+0x169/0x260
> > > >  [<c022406a>] ide_register_hw+0x14a/0x170
> > > >  [<c022ae41>] idepnp_probe+0x61/0x90
> > > >  [<c0185125>] sysfs_new_inode+0x55/0x90
> > > >  [<c01df316>] compare_pnp_id+0x86/0xa0
> > > >  [<c01df35d>] match_device+0x2d/0x50
> > > >  [<c01df452>] pnp_device_probe+0x72/0x90
> > > >  [<c02013df>] bus_match+0x2f/0x70
> > > >  [<c02014ff>] driver_attach+0x3f/0x90
> > > >  [<c020174e>] bus_add_driver+0x5e/0xa0
> > > >  [<c0201b4f>] driver_register+0x2f/0x40
> > > >  [<c01df50a>] pnp_register_driver+0x2a/0x60
> > > >  [<c039eada>] probe_for_hwifs+0x1a/0x20
> > > >  [<c039eae8>] ide_init_builtin_drivers+0x8/0x20
> > > >  [<c039eb3f>] ide_init+0x3f/0x50
> > > >  [<c0384742>] do_initcalls+0x22/0x90
> > > >  [<c0105089>] init+0x29/0xe0
> > > >  [<c0105060>] init+0x0/0xe0
> > > >  [<c0109275>] kernel_thread_helper+0x5/0x10
> > > >
> > > > Followed by the following oops:
> > > >
> > > >
> > > > Unable to handle kernel NULL pointer dereference at virtual address
> > > > 00000008 printing eip:
> > > > c0185278
> > > > *pde = 00000000
> > > > Oops: 0000 [#1]
> > > > CPU:    0
> > > > EIP:    0060:[<c0185278>]    Not tainted
> > > > EFLAGS: 00010286
> > > > EIP is at sysfs_hash_and_remove+0x8/0x69
> > > > eax: 00000000   ebx: c03f993c   ecx: c03f9968   edx: 00000000
> > > > esi: 00000000   edi: c03f97a0   ebp: cbf997d0   esp: cbf997c8
> > > > ds: 007b   es: 007b   ss: 0068
> > > > Process swapper (pid: 1, threadinfo=cbf98000 task=cbe2b8c0)
> > > > Stack: c03f993c c034bb18 cbf997e8 c020156c 00000000 c03f9968 c03f993c
> > > > c03f9ce8 cbf997fc c02016b4 c03f993c c03f993c c03f9ce8 cbf99810
> > > > c0200734 c03f993c c03f993c c03f984c cbf99820 c020078d c03f993c
> > > > c03f97a0 cbf99e58 c0223d1c Call Trace:
> > > >  [<c020156c>] device_release_driver+0x1c/0x60
> > > >  [<c02016b4>] bus_remove_device+0x44/0x80
> > > >  [<c0200734>] device_del+0x54/0xa0
> > > >  [<c020078d>] device_unregister+0xd/0x20
> > > >  [<c0223d1c>] ide_unregister+0x69c/0x840
> > > >  [<c011dbd9>] recalc_task_prio+0xf9/0x200
> > > >  [<c011dd88>] try_to_wake_up+0xa8/0x140
> > > >  [<c011eb36>] __wake_up_common+0x26/0x50
> > > >  [<c0128a7c>] update_process_times+0x2c/0x40
> > > >  [<c0122473>] profile_hook+0x13/0x18
> > > >  [<c0119e1d>] smp_local_timer_interrupt+0xd/0xb0
> > > >  [<c0128a7c>] update_process_times+0x2c/0x40
> > > >  [<c0122473>] profile_hook+0x13/0x18
> > > >  [<c0119e1d>] smp_local_timer_interrupt+0xd/0xb0
> > > >  [<c0110f36>] timer_interrupt+0xb6/0xe0
> > > >  [<c013d1aa>] __rmqueue+0xda/0x140
> > > >  [<c013d243>] rmqueue_bulk+0x33/0x60
> > > >  [<c013d54d>] buffered_rmqueue+0xad/0x120
> > > >  [<c013d652>] __alloc_pages+0x92/0x320
> > > >  [<c014022b>] cache_init_objs+0x4b/0x80
> > > >  [<c013d54d>] buffered_rmqueue+0xad/0x120
> > > >  [<c013d652>] __alloc_pages+0x92/0x320
> > > >  [<c014022b>] cache_init_objs+0x4b/0x80
> > > >  [<c01403f9>] cache_grow+0x169/0x260
> > > >  [<c022406a>] ide_register_hw+0x14a/0x170
> > > >  [<c022ae41>] idepnp_probe+0x61/0x90
> > > >  [<c0185125>] sysfs_new_inode+0x55/0x90
> > > >  [<c01df316>] compare_pnp_id+0x86/0xa0
> > > >  [<c01df35d>] match_device+0x2d/0x50
> > > >  [<c01df452>] pnp_device_probe+0x72/0x90
> > > >  [<c02013df>] bus_match+0x2f/0x70
> > > >  [<c02014ff>] driver_attach+0x3f/0x90
> > > >  [<c020174e>] bus_add_driver+0x5e/0xa0
> > > >  [<c0201b4f>] driver_register+0x2f/0x40
> > > >  [<c01df50a>] pnp_register_driver+0x2a/0x60
> > > >  [<c039eada>] probe_for_hwifs+0x1a/0x20
> > > >  [<c039eae8>] ide_init_builtin_drivers+0x8/0x20
> > > >  [<c039eb3f>] ide_init+0x3f/0x50
> > > >  [<c0384742>] do_initcalls+0x22/0x90
> > > >  [<c0105089>] init+0x29/0xe0
> > > >  [<c0105060>] init+0x0/0xe0
> > > >  [<c0109275>] kernel_thread_helper+0x5/0x10
> > > >
> > > > Code: 8b 46 08 8d 48 68 ff 48 68 78 56 8b 4d 0c 51 56 e8 83 ff ff
> > > >  <0>Kernel panic: Attempted to kill init!

