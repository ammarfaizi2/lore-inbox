Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWJDCBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWJDCBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030703AbWJDCBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:01:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3034 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030702AbWJDCBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:01:22 -0400
Message-ID: <452315ED.3050407@in.ibm.com>
Date: Tue, 03 Oct 2006 19:01:17 -0700
From: Suzuki Kp <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sfrost@snowman.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops under 2.6.17 in tty_write?
References: <20060913174118.GJ5441@kenobi.snowman.net>
In-Reply-To: <20060913174118.GJ5441@kenobi.snowman.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen Frost wrote:
> Greetings,
> 
>   I'm getting a pretty consistant oops under 2.6.17 which looks to be
>   associated with tty_write.  Same box works just perfectly under
>   2.6.16.  Technically these are stock Debian kernels but I don't expect
>   it's something in the Debian patches.  It could be a vserver issue but
>   that also seems unlikely to me.
> 
>   The kernel command-line would have looked something like this:
>   Kernel command line: 
> 	root=/dev/md0 ro earlyprintk=serial,ttyS0,9600,keep console=tty0 console=ttyS0,9600
> 
>   Note that I modified that command-line a number of times and continued 
>   to get an oops (I don't know for sure that it was always the *same* tho,
>   and I only have serial-console access, but it didn't come all the way up
>   when booted w/o earlyprintk= or console= arguments, of course, that
>   could have been due to something else too).
> 
>   Unfortunately, I didn't grab the full boot log.  If that's necessary then
>   I can look into finding a time to do that (it's a production server tho,
>   so folks aren't exactly keen on my rebooting it a bunch).
> 
>   Here's the oops:
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
>  printing eip:
> c02087be
> *pde = 00000000
> Oops: 0000 [#1]
> SMP 
> Modules linked in: i810_audio ac97_codec intel_agp agpgart hw_random psmouse snd_intel8x0 i82875p_edac snd_ac97_codec snd_ac97_bus evdev pcspkr serio_raw edac_mc i2c_i801 floppy snd_pcm snd_timer snd 8250_pnp shpchp pci_hotplug i2c_core soundcore snd_page_alloc parport_pc parport rtc ext3 jbd mbcache dm_mirror dm_snapshot dm_mod raid1 md_mod ide_generic ide_disk generic piix ehci_hcd uhci_hcd ata_piix libata usbcore ide_core scsi_mod e1000 thermal processor fan
> CPU:    0
> EIP:    0060:[<c02087be>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.17-2-vserver-686 #1) 
> EIP is at uart_write_room+0x9/0x16



I am suspecting the following situation:

During the uart_add_one_port, we would remove the existing port using
uart_remove_one_port(), which would eventually free up the state->info
allocated during uart_get() called from uart_open(). And, when we add
the port, we don't allocate the state->info again.

So, this would cause the state->info having a NULL pointer which can
OOPS cause in uart_write_room().

Comments ?


> eax: dff61000   ebx: 00000006   ecx: c19df030   edx: 00000000
> esi: df89a000   edi: dfc47400   ebp: 00000006   esp: df8dbf18
> ds: 007b   es: 007b   ss: 0068
> Process S03udev (pid: 2111[#0], threadinfo=df8da000 task=c19df030)
> Stack: c01fcab1 dfc47400 dfa2dd40 00000282 00000000 c19df030 c0116bbf df89a138 
>        df89a138 00000006 df89a000 00000006 00000006 c01fa69b 00000006 080f6408 
>        dfa2dd40 c01fc9d0 df89a00c df89a3e8 00000000 c01fb02c dfa2dd40 dfa2dd40 
> Call Trace:
>  <c01fcab1> write_chan+0xe1/0x293  <c0116bbf> default_wake_function+0x0/0xc        
>  <c01fa69b> tty_write+0x147/0x1d8  <c01fc9d0> write_chan+0x0/0x293 
>  <c01fb02c> redirected_tty_write+0x1c/0x6c  <c01fb010> redirected_tty_write+0x0/0x6c
>  <c0159e05> vfs_write+0xa1/0x140  <c015a3ef> sys_write+0x3c/0x63
>  <c0102ae7> sysenter_past_esp+0x54/0x75 
> Code: 09 08 8b 40 10 74 09 81 60 10 ff ff ff fd eb 07 81 48 10 00 00 00 02 8b 5e 68 89 f0 ff 53 2c 5b 5e c3 8b 80 80 01 00 00 8b 50 10 <8b> 42 0c 2b 42 08 48 25 ff 0f 00 00 c3 8b 80 80 01 00 00 8b 50 
> EIP: [<c02087be>] uart_write_room+0x9/0x16 SS:ESP 0068:df8dbf18
> 
> 
> 	Thanks,
> 
> 		Stephen




Thanks,
Suzuki K P   <suzuki@in.ibm.com>
Linux Technology Center
IBM Systems & Technology Labs.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


