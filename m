Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTIAWgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTIAWgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:36:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:12941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263348AbTIAWgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:36:36 -0400
Date: Mon, 1 Sep 2003 15:36:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS][RESEND] 2.6.0-test4-mm4
Message-Id: <20030901153647.1ff6bf1d.akpm@osdl.org>
In-Reply-To: <E19tuSv-00059A-00@rammstein.mweb.co.za>
References: <E19tuSv-00059A-00@rammstein.mweb.co.za>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope <bonganilinux@mweb.co.za> wrote:
>
> I got the following oops when I was trying to load alsa drivers on
> the 2.6.0-test4-mm4 kernel.

Generally it's best to enable CONFIG_ALLSYMS and not bother running
ksymoops: the kernel does the decode for you.

The problem with ksymoops seems to be that it causes people to not send
important preceding messages.  In this case:

		printk(KERN_ERR "kfree_debugcheck: out of range ptr %lxh.\n",
			(unsigned long)objp);	


> 
> ksymoops 2.4.9 on i686 2.6.0-test4-mm3-1.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.6.0-test4-mm4 (specified)
>      -m /boot/System.map-2.6.0-test4-mm4 (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> kernel BUG at mm/slab.c:1623!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0147b8b>]    Not tainted VLI
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010086
> eax: 00000031   ebx: 000ab6b6   ecx: c04cde64   edx: c0406338
> esi: c0408920   edi: c04077f8   ebp: 6b6b6b6b   esp: cfc4def8
> ds: 007b   es: 007b   ss: 0068
> Stack: c03b8700 6b6b6b6b 0000006b cffe39f0 c0210f86 ce119b64 cffead14 00000202
>        ce119b68 c0408920 c04077f8 00000000 c0210f77 6b6b6b6b c40348e8 00000080
>        c016796a ce119b68 00000000 00000100 00000008 d38adb2f 00000074 d38adec7
> Call Trace:
>  [<c0210f86>] kobject_cleanup+0x56/0x60
>  [<c0210f77>] kobject_cleanup+0x47/0x60
>  [<c016796a>] unregister_chrdev+0x8a/0xa0
>  [<d38adb2f>] alsa_sound_exit+0x7f/0xb0 [snd]
>  [<c0138328>] sys_delete_module+0x158/0x1d0
>  [<c01511a3>] do_munmap+0x163/0x1f0

Anyway, you died in kobject_cleanup()'s call to kfree(kobj->k_name), which
was newly added as a part of kobject-unlimited-name-lengths.patch.

Is it repeatable?  Exactly which modules were you attempting to load at the
time?  And please send your .config.

Thanks.
