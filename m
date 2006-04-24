Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWDXV0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWDXV0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWDXV0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:26:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:2507 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751281AbWDXV0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:26:10 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com, akpm@osdl.org,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20060422005851.GA22917@MAIL.13thfloor.at>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	 <20060421110140.GC14841@MAIL.13thfloor.at>
	 <1145655097.15389.12.camel@linuxchandra>
	 <20060422005851.GA22917@MAIL.13thfloor.at>
Content-Type: text/plain
Organization: IBM
Date: Mon, 24 Apr 2006 14:26:07 -0700
Message-Id: <1145913967.1400.59.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 02:58 +0200, Herbert Poetzl wrote:

Herbert,

Thanks for the steps. With that i was able to reproduce the problem and
i found the bug.

While i go ahead and generate the patch, i wanted to hear if my
conclusion is correct.

The problem is due to the fact that most notifier registrations
incorrectly use __devinitdata to define the callback structure, as in:

static struct notifier_block __devinitdata hrtimers_nb = {
        .notifier_call = hrtimer_cpu_notify,
};

devinitdata'd  data is not _expected to be available_ after the
initialization(unless CONFIG_HOTPLUG is defined).

I do not know how it was working until now :), anybody has a theory that
can explain it (or my conclusion is wrong) ?

Thanks,

chandra
> On Fri, Apr 21, 2006 at 02:31:37PM -0700, Chandra Seetharaman wrote:
> > Hi Herbert,
> > 
> > I am not able to reproduce the problem you are seeing. 
> > Need some help from you in reproducing it.
> 
> okay, no problem ...
> 
> > Do you have any unique hardware/driver/kernel component ?
> 
> hmm, you got my config, so that's it from the
> kernel side (no modules, no special settings)
> 
> > Did you try without QEMU (to see if it isolats the problem) ?
> 
> nope, have no test system available to test it atm
> but I'm using QEMU for a long time now to do kernel
> debugging and it would really surprise me if that
> was a QEMU bug (it's pretty stable on x86 nowadays,
> but you never know)
> 
> here is how to reproduce it (with QEMU)
> 
> - get qemu 0.8 (or later) 
> - get TEST_32M_public2.img.bz2, TEST_256M_empty.img.bz2
> - get the kernel QEMU_2.6.17-rc2.config
> 
> - build the kernel on x86 for x86 (gcc 3.3.5 here)
> - unpack the disk images (bunzip2)
> - run qemu like this:
> 
>   qemu -nographic -m 256 -snapshot -hda TEST_32M_public2.img -hdc TEST_256M_empty.img -kernel /path/to/your/linux-2.6.17-rc2/arch/i386/boot/bzImage -append "rw root=/dev/hda1"
> 
>   (on non x86 use qemu-system-i386 instead)
> 
> - then, on the prompt enter:
> 
>   # mkfs.xfs -f /dev/hdc1
>   # mount /dev/hdc1 /mnt/
> 
> - *bang*
> 
> you can get all the beforementioned stuff including 
> a prebuilt kernel image from here:
> 
>   http://vserver.13thfloor.at/Stuff/MAINLINE/linux-2.6.17_xfs/
> 
> HTH,
> Herbert
> 
> > regards,
> > 
> > chandra
> > On Fri, 2006-04-21 at 13:01 +0200, Herbert Poetzl wrote:
> > > On Tue, Apr 18, 2006 at 08:27:37PM -0700, Linus Torvalds wrote:
> > > > 
> > > > Instead of the normal one-week release schedule, there was now two weeks 
> > > > between 2.6.17-rc1 and -rc2, partly because I was travelling for one of 
> > > > those weeks, but partly because it was really quiet for a while. Likely a 
> > > > lot of people are concentrating on 2.6.16 and vendor releases.
> > > 
> > > [rest zapped]
> > > 
> > > here is the 'updated' bug report on the xfs issue which
> > > seems to have been introduced with 2.6.17-rc1
> > > 
> > > note: 2.6.16.8 does not have this issue
> > > 
> > > best,
> > > Herbert
> > > 
> > > 
> > > Linux (none) 2.6.17-rc2 #1 SMP Fri Apr 21 11:52:19 CEST 2006 i686 unknown
> > > 
> > > / # mkfs.xfs -f /dev/hdc1
> > > meta-data=/dev/hdc1              isize=256    agcount=8, agsize=8189 blks
> > > data     =                       bsize=4096   blocks=65512, imaxpct=25
> > >          =                       sunit=0      swidth=0 blks, unwritten=0
> > > naming   =version 2              bsize=4096  
> > > log      =internal log           bsize=4096   blocks=1200
> > > realtime =none                   extsz=65536  blocks=0, rtextents=0
> > > / # mount /dev/hdc1 /mnt/
> > > 
> > > 
> > > [   64.289157] BUG: unable to handle kernel paging request at virtual address c056a680
> > > [   64.290085]  printing eip:
> > > [   64.290402] c0129290
> > > [   64.290686] *pde = 005bd027
> > > [   64.291037] *pte = 0056a000
> > > [   64.291504] Oops: 0000 [#1]
> > > [   64.291823] SMP DEBUG_PAGEALLOC
> > > [   64.292820] Modules linked in:
> > > [   64.293453] CPU:    0
> > > [   64.293485] EIP:    0060:[<c0129290>]    Not tainted VLI
> > > [   64.293529] EFLAGS: 00000286   (2.6.17-rc2 #1) 
> > > [   64.295055] EIP is at notifier_chain_register+0x20/0x50
> > > [   64.295648] eax: c056a678   ebx: cf5e23f8   ecx: 00000000   edx: c04bea9c
> > > [   64.296362] esi: cf5e23f8   edi: cffc5000   ebp: cf5e2800   esp: cffdad5c
> > > [   64.297140] ds: 007b   es: 007b   ss: 0068
> > > [   64.297613] Process mount (pid: 34, threadinfo=cffda000 task=cff7e570)
> > > [   64.298258] Stack: <0>c04bea80 c0129454 c04bea9c cf5e23f8 cf5e2000 cf5e2000 c01367f7 c04bea80 
> > > [   64.299558]        cf5e23f8 c02d4b26 cf5e23f8 00000404 cf5e2000 cfd1f520 cffc5000 c02d1f53 
> > > [   64.300700]        cf5e2000 00000001 c02e65ef 00000424 00000001 cffc5000 cfd1f520 c02f2880 
> > > [   64.301841] Call Trace:
> > > [   64.302278]  <c0129454> blocking_notifier_chain_register+0x54/0x90   <c01367f7> register_cpu_notifier+0x17/0x20
> > > [   64.303684]  <c02d4b26> xfs_icsb_init_counters+0x46/0xb0   <c02d1f53> xfs_mount_init+0x23/0x160
> > > [   64.304844]  <c02e65ef> kmem_zalloc+0x1f/0x50   <c02f2880> bhv_insert_all_vfsops+0x10/0x50
> > > [   64.305940]  <c02f1f65> xfs_fs_fill_super+0x35/0x1f0   <c0313e97> snprintf+0x27/0x30
> > > [   64.307124]  <c01a24f4> disk_name+0x64/0xc0   <c0168f1f> sb_set_blocksize+0x1f/0x50
> > > [   64.308140]  <c0168869> get_sb_bdev+0x109/0x160   <c02f2150> xfs_fs_get_sb+0x30/0x40
> > > [   64.309129]  <c02f1f30> xfs_fs_fill_super+0x0/0x1f0   <c0168b10> do_kern_mount+0xa0/0x160
> > > [   64.310156]  <c0181187> do_new_mount+0x77/0xc0   <c018184f> do_mount+0x1bf/0x230
> > > [   64.311177]  <c03f4a68> iret_exc+0x3d4/0x6ab   <c0181633> copy_mount_options+0x63/0xc0
> > > [   64.312246]  <c03f427f> lock_kernel+0x2f/0x50   <c0181c5f> sys_mount+0x9f/0xe0
> > > [   64.313237]  <c0102b27> syscall_call+0x7/0xb  
> > > [   64.313917] Code: 90 90 90 90 90 90 90 90 90 90 90 53 8b 54 24 08 8b 5c 24 0c 8b 02 85 c0 74 31 8b 4b 08 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 <3b> 48 08 7f 1b 8d 50 04 8b 40 04 85 c0 75 f1 31 c0 eb 0d 90 90 
> > > [   64.318371] EIP: [<c0129290>] notifier_chain_register+0x20/0x50 SS:ESP 0068:cffdad5c
> > > 
> > > 
> > > Linux (none) 2.6.16.8 #1 SMP Fri Apr 21 12:45:31 CEST 2006 i686 unknown
> > > / # mkfs.xfs -f /dev/hdc1
> > > meta-data=/dev/hdc1              isize=256    agcount=8, agsize=8189 blks
> > > data     =                       bsize=4096   blocks=65512, imaxpct=25
> > >          =                       sunit=0      swidth=0 blks, unwritten=0
> > > naming   =version 2              bsize=4096  
> > > log      =internal log           bsize=4096   blocks=1200
> > > realtime =none                   extsz=65536  blocks=0, rtextents=0
> > > / # mount /dev/hdc1 /mnt/
> > > [   24.627530] XFS mounting filesystem hdc1
> > > 
> > -- 
> > 
> > ----------------------------------------------------------------------
> >     Chandra Seetharaman               | Be careful what you choose....
> >               - sekharan@us.ibm.com   |      .......you may get it.
> > ----------------------------------------------------------------------
> > 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


