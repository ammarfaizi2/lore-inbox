Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWGMKcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWGMKcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWGMKcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:32:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751511AbWGMKcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:32:20 -0400
Date: Thu, 13 Jul 2006 03:32:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arne Ahrend <aahrend@web.de>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 NULL pointer dereference
Message-Id: <20060713033211.3e9da061.akpm@osdl.org>
In-Reply-To: <20060712210850.74f34327.aahrend@web.de>
References: <20060712210850.74f34327.aahrend@web.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 21:08:50 +0200
Arne Ahrend <aahrend@web.de> wrote:

> 2.6.18-rc1-mm1 dereferences a NULL pointer while setting up the DVB-T card and mentions sysfs.
> 
> Normally (2.6.17) it would go on loading bt878, dvb_core and a couple of frontents:
> mt352 (the one I need), nxt6000, dvb_pll, sp887x, dst_ca, dst, cx24110, or51211, lgdt330x.
> 
> I applied this patch to get it to compile on the Athlon64:
> 
> --- 2.6.18-rc1-mm1-64.orig/arch/x86_64/kernel/vsyscall.c
> +++ 2.6.18-rc1-mm1-64/arch/x86_64/kernel/vsyscall.c
> @@ -253,13 +253,14 @@ void __cpuinit vsyscall_set_cpu(int cpu)
>  #ifdef CONFIG_NUMA
>  	node = cpu_to_node[cpu];
>  #endif
> +#ifdef CONFIG_SMP
>  	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
>  		/* the notifier is unfortunately not executed on the
>  		   target CPU */
>  		void *info = (void *)((node << 12) | cpu);
>  		smp_call_function_single(cpu, write_rdtscp_cb, info, 0, 1);
>  	}
> -
> +#endif
>  	/* Store cpu number in limit so that it can be loaded quickly
>  	   in user space in vgetcpu.
>  	   12 bits for the CPU and 8 bits for the node. */
> 
> from 
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115249660716416&w=4
> 

Hopefully Andi will have a new version uploaded when I do -mm2.

> and this to make Debians make-kpkg happy:
> 
> --- linux-2.6.18-rc1-mm1-orig/Makefile	2006-07-12 21:05:36.000000000 +0200
> +++ linux-2.6.18-rc1-mm1/Makefile	2006-07-10 23:44:55.000000000 +0200
> @@ -859,6 +859,7 @@
>  # needs to be updated, so this check is forced on all builds
>  
>  uts_len := 64
> +
>  define filechk_utsrelease.h
>  	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
>  	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2;    \
> @@ -867,10 +868,21 @@
>  	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\";)
>  endef
>  
> +# define filechk_version.h
> +# 	(echo \#define LINUX_VERSION_CODE $(shell                             \
> +# 	expr $(VERSION) \* 65536 + $(PATCHLEVEL) \* 256 + $(SUBLEVEL));     \
> +# 	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
> +# endef
> +
>  define filechk_version.h
> -	(echo \#define LINUX_VERSION_CODE $(shell                             \
> -	expr $(VERSION) \* 65536 + $(PATCHLEVEL) \* 256 + $(SUBLEVEL));     \
> -	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
> +	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
> +	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
> +	  exit 1; \
> +	fi; \
> +	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"; \
> +	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
> +	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
> +	)
>  endef
>  
>  include/linux/version.h: $(srctree)/Makefile FORCE

Thanks, I'll forward this to Sam.

> bttv0: using: AVerMedia AVerTV DVB-T 771 [card=123,autodetected]
> bttv0: using tuner=4
> bttv0: registered device video0
> Unable to handle kernel NULL pointer dereference at 00000000000000d9 RIP: 
>  [<ffffffff801cb377>] sysfs_add_file+0x20/0x88
> PGD 3ee37067 PUD 3edec067 PMD 0 
> Oops: 0000 [1] PREEMPT 
> last sysfs file: /devices/pci0000:00/0000:00:10.4/usb1/idVendor
> CPU 0 
> Modules linked in: tuner snd_via82xx snd_ice17xx_ak4xxx snd_via82xx_modem snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_ac97_bus snd_i2c snd_mpu401_uart snd_pcm snd_timer bttv video_buf firmware_class snd_rawmidi snd_seq_device ir_common uhci_hcd sr_mod sk98lin compat_ioctl32 btcx_risc tveeprom videodev v4l2_common snd_page_alloc 8139too mii ehci_hcd usbcore snd soundcore ohci1394 ieee1394 cdrom psmouse k8_edac pcspkr
> Pid: 545, comm: modprobe Not tainted 2.6.18-rc1-mm1 #1
> RIP: 0010:[<ffffffff801cb377>]  [<ffffffff801cb377>] sysfs_add_file+0x20/0x88
> RSP: 0018:ffff81003ee3fd48  EFLAGS: 00010296
> RAX: 00000000ffffff00 RBX: ffffffff881106a0 RCX: ffff81003fde37f0
> RDX: 0000000000000004 RSI: ffffffff88107d20 RDI: 0000000000000001
> RBP: ffff81003ee3fd78 R08: 0000000000008040 R09: 0000000000000000
> R10: ffffffff8015c243 R11: ffffffff8015c243 R12: ffffffff88107d20
> R13: 0000000000000001 R14: 00000000ffffffef R15: 0000000000000000
> FS:  00002ad53d5b96d0(0000) GS:ffffffff80628000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00000000000000d9 CR3: 000000003ebd2000 CR4: 00000000000006a0
> Process modprobe (pid: 545, threadinfo ffff81003ee3e000, task ffff81003fde30c0)
> Stack:  000000043ee3fd58 ffffffff881106a0 0000000000000000 ffff81003ff78000
>  ffffffff88110e68 0000000000000000 ffff81003ee3fd88 ffffffff801cb414
>  ffff81003ee3fd98 ffffffff80265b91 ffff81003ee3fdd8 ffffffff880f2c90
> Call Trace:
>  [<ffffffff801cb414>] sysfs_create_file+0x35/0x37
>  [<ffffffff80265b91>] class_device_create_file+0x17/0x19
>  [<ffffffff880f2c90>] :bttv:bttv_probe+0x5c2/0x7a1
>  [<ffffffff801fd9b8>] pci_device_probe+0x4c/0x74
>  [<ffffffff8026501b>] driver_probe_device+0x5c/0xb7
>  [<ffffffff802650e9>] __driver_attach+0x0/0x98
>  [<ffffffff80265138>] __driver_attach+0x4f/0x98
>  [<ffffffff80264a34>] bus_for_each_dev+0x49/0x7a
>  [<ffffffff80264f45>] driver_attach+0x1c/0x1e
>  [<ffffffff80264648>] bus_add_driver+0x89/0x138
>  [<ffffffff80265391>] driver_register+0x8f/0x93
>  [<ffffffff801fdb96>] __pci_register_driver+0x63/0x86
>  [<ffffffff880f1ac8>] :bttv:bttv_init_module+0xb3/0xb5
>  [<ffffffff801909aa>] sys_init_module+0xb0/0x203
>  [<ffffffff8015854e>] system_call+0x7e/0x83
> 
> 
> Code: 4c 8b bf d8 00 00 00 48 8b 7f 50 8b 5e 10 48 81 c7 00 01 00 
> RIP  [<ffffffff801cb377>] sysfs_add_file+0x20/0x88
>  RSP <ffff81003ee3fd48>
> CR2: 00000000000000d9

Yours is the third report of this.  Mauro is on vacation, it's not known to
be a v4l bug and nobody knows what's causing it.  Not a happy story.
