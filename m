Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425430AbWLHL6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425430AbWLHL6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425434AbWLHL6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:58:14 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:45970 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425430AbWLHL6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:58:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EcN3atbDX7lceIOIRbAReKZJcJ4Pfm2qP4b7acPCiek7WJiWP4UxQeV+cPncbVM0Z81nKHI6JYE1llaIT4ZDahGBHyZAsRPG60N7KOLhSe5k/g81lQ8VmieEnzYYJA0QzKCoL9+Fk+rgLZLzzq9K76/ifI8gye1s6N94Hohp2fM=
Message-ID: <653402b90612080358y66e72554wd3b55e8af83f7357@mail.gmail.com>
Date: Fri, 8 Dec 2006 12:58:12 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: Display class
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       Luming.yu@intel.com, zap@homelink.ru, randy.dunlap@oracle.com,
       kernel-discuss@handhelds.org
In-Reply-To: <Pine.LNX.4.64.0612071439040.31668@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206194442.422c60d3.maxextreme@gmail.com>
	 <Pine.LNX.4.64.0612071439040.31668@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > P.S.
> >
> >   When I was working at 2.6.19-rc6-mm2 it worked all fine, but now
> >   I have copied it to git7 I'm getting some weird segmentation faults
> >   (oops) when at cfag12864bfb_init, at mutex_lock() in
> >   display_device_unregister module... I think unrelated (?), but I will
> >   look for some mistake I made.
>
> Did you solve the problem?
>
>

Ok, found it. It was at cfag12864bfb_init:

	cfag12864bfb_device = display_device_register(&cfag12864bfb_driver,
		NULL, NULL);
	if (!cfag12864bfb_device) {
		printk(KERN_ERR CFAG12864BFB_NAME ": ERROR: "
			"can't register display device\n");
		ret = -ENODEV;
		goto fbregistered;
	}

	/*cfag12864bfb_device->name = cfag12864bfb_name;
	cfag12864bfb_device->request_state = 1;*/

	cfag12864bfb_power = 1;
	cfag12864b_power_on();

The commented code. I have exchange it to pass the name through probe
as you suggested, still, it brokes when rmmoding it at
display_device_unregister:

root@morfeo:/usr/src/git/linux-2.6.19-git12# dmesg
[ 1593.770774] BUG: unable to handle kernel paging request at virtual
address ff fffffc
[ 1593.770780]  printing eip:
[ 1593.770782] c02e3f3f
[ 1593.770784] *pde = 00003067
[ 1593.770787] Oops: 0002 [#1]
[ 1593.770788] PREEMPT SMP
[ 1593.770791] Modules linked in: cfag12864bfb display cfag12864b
ks0108 ppdev n ls_utf8 ntfs ipv6 md_mod af_packet tsdev snd_intel8x0
snd_ac97_codec snd_ac97_bu s snd_pcm_oss snd_mixer_oss sk98lin psmouse
snd_pcm snd_timer snd soundcore parp ort_pc parport skge floppy
snd_page_alloc serio_raw pcspkr rtc intel_agp agpgart  evdev dm_mirror
dm_mod ide_generic ide_disk ide_cd cdrom piix generic vga16fb v
gastate
[ 1593.770829] CPU:    1
[ 1593.770829] EIP:    0060:[<c02e3f3f>]    Not tainted VLI
[ 1593.770831] EFLAGS: 00010282   (2.6.19-git12 #1)
[ 1593.770838] EIP is at mutex_lock+0x0/0xb
[ 1593.770841] eax: fffffffc   ebx: fffffff4   ecx: 00000002   edx: f9955f00
[ 1593.770844] esi: 00000000   edi: fffffffc   ebp: e2ae6000   esp: e2ae7f48
[ 1593.770847] ds: 007b   es: 007b   ss: 0068
[ 1593.770850] Process rmmod (pid: 13348, ti=e2ae6000 task=dfd6f030
task.ti=e2ae 6000)
[ 1593.770852] Stack: f9952114 f9955e00 00000000 00000003 f9955066
c01374a1 6761 6663 36383231
[ 1593.770860]        62666234 b7eec000 f7d68780 c014f67b ffffffff
b7eed000 f7d6 8784 e2616aac
[ 1593.770868]        b7eed000 e2616ab8 e2616aac f7d68780 00d687b4
f9955e00 0000 0880 e2ae7fa8
[ 1593.770877] Call Trace:
[ 1593.770879]  [<f9952114>] display_device_unregister+0x13/0x51 [display]
[ 1593.770888]  [<f9955066>] cfag12864bfb_exit+0xa/0x23 [cfag12864bfb]
[ 1593.770893]  [<c01374a1>] sys_delete_module+0x11d/0x189
[ 1593.770902]  [<c014f67b>] do_munmap+0x177/0x1d0
[ 1593.770913]  [<c0102d76>] sysenter_past_esp+0x5f/0x85
[ 1593.770922]  [<c02e0033>] atm_dev_ioctl+0x35f/0x655
[ 1593.770929]  =======================
[ 1593.770931] Code: c0 8d 54 24 08 8d 4c 24 1c 89 4c 24 1c 89 4c 24
20 8b 4c 24  38 89 0c 24 89 e9 8b 44 24 04 e8 3f ff ff ff 83 c4 24 5b
5e 5f 5d c3 <f0> ff 08  79 05 e8 1b 01 00 00 c3 f0 ff 00 7f 05 e8 34
00 00 00
[ 1593.770973] EIP: [<c02e3f3f>] mutex_lock+0x0/0xb SS:ESP 0068:e2ae7f48
[ 1593.770979]

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
