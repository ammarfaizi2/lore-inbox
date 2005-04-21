Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVDUXz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDUXz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDUXz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:55:56 -0400
Received: from 26.mail-out.ovh.net ([213.186.42.179]:34527 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP id S261548AbVDUXzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:55:31 -0400
Subject: Re: x86_64: Bug in new out of line put_user()
From: Nicolas Boichat <nicolas@boichat.ch>
To: Alexander Nyberg <alexn@telia.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1114038609.500.2.camel@localhost.localdomain>
References: <1114038609.500.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 01:55:15 +0200
Message-Id: <1114127715.11183.21.camel@dudule>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-Ovh-Remote: 84.226.142.72 (adsl-84-226-142-72.adslplus.ch)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.0|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,

I have other kind of problems with this patch...

With 2.6.12-rc2 + your patch, when I run OpenOffice (a 32-bit
application), I get this in dmesg :

Unable to handle kernel paging request at 00002aaaad9280b0 RIP: 
<ffffffff801f5d70>{__put_user_4+32}
PGD 0 
Oops: 0002 [1] SMP 
CPU 0 
Modules linked in: cpufreq_ondemand sch_sfq sch_htb ipt_CONNMARK
ipt_ipp2p ipt_connmark ipt_mark ipt_tos ipt_length ipt_MARK
iptable_filter iptable_mangle ip_tables powernow_k8 tun nvidia
snd_pcm_oss snd_mixer_oss snd_via82xx snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd cx8800
v4l1_compat v4l2_common cx88xx i2c_algo_bit video_buf ir_common
btcx_risc tveeprom videodev tuner usbhid w83627hf i2c_sensor i2c_isa
i2c_core usb_storage uhci_hcd ehci_hcd usbcore sd_mod scsi_mod
Pid: 11236, comm: soffice.bin Tainted: P      2.6.12-rc2
RIP: 0010:[<ffffffff801f5d70>] <ffffffff801f5d70>{__put_user_4+32}
RSP: 0000:ffff81001d32fea0  EFLAGS: 00010202
RAX: 0000000000000003 RBX: ffff8100255b0f70 RCX: 00002aaaad9280b0
RDX: 0000000000000000 RSI: ffff810033534940 RDI: 00002aaaad9280b0
RBP: 0000000000000000 R08: ffff81001d32e000 R09: 0000000000000002
R10: ffff81001d32e000 R11: 00000000558740dc R12: 0000000000000000
R13: ffff810033534940 R14: 0000000000000001 R15: 0000000000000000
FS:  00002aaaae0ff820(0000) GS:ffffffff80489840(0000)
knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00002aaaad9280b0 CR3: 0000000025150000 CR4: 00000000000006e0
Process soffice.bin (pid: 11236, threadinfo ffff81001d32e000, task
ffff8100255b0f70)
Stack: ffffffff80133414 ffff810019f11138 ffff810033534940
ffff8100255b0f70 
       ffff8100255b0f70 0000000000000000 ffffffff80137c0a
0000000000000000 
       0000000000000000 ffff8100255b15a4 
Call Trace:<ffffffff80133414>{mm_release+116} <ffffffff80137c0a>{exit_mm
+42} 
       <ffffffff8013802f>{do_exit+351} <ffffffff80138b8c>{do_group_exit
+252} 
       <ffffffff80122ab1>{ia32_sysret+0} 

It is easily reproducible on my system, I just have to start and exit
OpenOffice 1.1.4.

I got similar messages with 2.6.12-rc3 + your patch (please tell me if
you also want these messages).
I also had one system freeze and one reboot (when I clicked on a link in
Firefox (32-bit app too), I don't know if it is related). But I was
unable to reproduce these crashes, so I'm not sure whether it is caused
by rc3 or by your patch.

Please note that these problems did not occur with 2.6.12-rc2 + these
patches reverted:
 - x86_64-give-out-of-line-get_user-better-calling.patch
 - x86_64-move-put_user-out-of-line.patch
 - x86_64-remove-stale-unused-file.patch

Best regards,

Nicolas

On Thu, 2005-04-21 at 01:10 +0200, Alexander Nyberg wrote: 
> The new out of line put_user() assembly on x86_64 changes %rcx without
> telling GCC about it causing things like:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4515 
> 
> See to it that %rcx is not changed (made it consistent with get_user()).
> 
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: test/arch/x86_64/lib/getuser.S
> ===================================================================
> --- test.orig/arch/x86_64/lib/getuser.S	2005-04-20 23:55:35.000000000 +0200
> +++ test/arch/x86_64/lib/getuser.S	2005-04-21 00:54:16.000000000 +0200
> @@ -78,9 +78,9 @@
>  __get_user_8:
>  	GET_THREAD_INFO(%r8)
>  	addq $7,%rcx
> -	jc bad_get_user
> +	jc 40f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae	bad_get_user
> +	jae	40f
>  	subq	$7,%rcx
>  4:	movq (%rcx),%rdx
>  	xorl %eax,%eax
> Index: test/arch/x86_64/lib/putuser.S
> ===================================================================
> --- test.orig/arch/x86_64/lib/putuser.S	2005-04-21 00:50:24.000000000 +0200
> +++ test/arch/x86_64/lib/putuser.S	2005-04-21 01:02:15.000000000 +0200
> @@ -46,36 +46,45 @@
>  __put_user_2:
>  	GET_THREAD_INFO(%r8)
>  	addq $1,%rcx
> -	jc bad_put_user
> +	jc 20f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae	 bad_put_user
> -2:	movw %dx,-1(%rcx)
> +	jae 20f
> +2:	decq %rcx
> +	movw %dx,(%rcx)
>  	xorl %eax,%eax
>  	ret
> +20:	decq %rcx
> +	jmp bad_put_user
>  
>  	.p2align 4
>  .globl __put_user_4
>  __put_user_4:
>  	GET_THREAD_INFO(%r8)
>  	addq $3,%rcx
> -	jc bad_put_user
> +	jc 30f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae bad_put_user
> -3:	movl %edx,-3(%rcx)
> +	jae 30f
> +3:	subq $3,%rcx
> +	movl %edx,(%rcx)
>  	xorl %eax,%eax
>  	ret
> +30:	subq $3,%rcx
> +	jmp bad_put_user
>  
>  	.p2align 4
>  .globl __put_user_8
>  __put_user_8:
>  	GET_THREAD_INFO(%r8)
>  	addq $7,%rcx
> -	jc bad_put_user
> +	jc 40f
>  	cmpq threadinfo_addr_limit(%r8),%rcx
> -	jae	bad_put_user
> -4:	movq %rdx,-7(%rcx)
> +	jae 40f
> +4:	subq $7,%rcx
> +	movq %rdx,(%rcx)
>  	xorl %eax,%eax
>  	ret
> +40:	subq $7,%rcx
> +	jmp bad_put_user
>  
>  bad_put_user:
>  	movq $(-EFAULT),%rax
> 
> 
> 

