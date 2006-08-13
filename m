Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWHMBJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWHMBJj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 21:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWHMBJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 21:09:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932644AbWHMBJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 21:09:38 -0400
Date: Sat, 12 Aug 2006 18:09:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in close when exiting fsx
Message-Id: <20060812180934.01ad25c9.akpm@osdl.org>
In-Reply-To: <44DE2EA6.4060809@austin.rr.com>
References: <44DE2EA6.4060809@austin.rr.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2006 14:40:22 -0500
Steve French <smfrench@austin.rr.com> wrote:

> ctl-c exiting fsx after a few hours with 2.6.18-rc4 got the following 
> oops - anyone recognize it?
> Although I didn't see cifs symbols on the call stack it is running on a 
> cifs mount, but it is not
> one I have seen before.

CIFS is in the trace.

> BUG: unable to handle kernel NULL pointer dereference at virtual address 
> 0000000 0
>  printing eip:
> c133064f
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in: cifs nfsd exportfs lockd nfs_acl ipv6 sunrpc 
> snd_pcm_oss snd_ mixer_oss snd_seq snd_seq_device af_packet edd ibm_acpi 
> snd_intel8x0 snd_ac97_co dec snd_ac97_bus snd_pcm snd_timer snd 
> soundcore snd_page_alloc
> CPU:    0
> EIP:    0060:[<c133064f>]    Not tainted VLI
> EFLAGS: 00210002   (2.6.18-rc4-default #1)
> EIP is at __down+0x56/0xc5
> eax: f7708b6c   ebx: f7708b64   ecx: 00000000   edx: f5f77f04
> esi: f5f5e030   edi: 00200246   ebp: 00000000   esp: f5f77ed8
> ds: 007b   es: 007b   ss: 0068
> Process fsx-linux (pid: 4038, ti=f5f76000 task=f5f5e030 task.ti=f5f76000)
> Stack: 00000000 00000000 00000000 00000000 00000000 f76e24a0 00000000 
> c1038908
>        00000001 f5f5e030 c1013678 f7708b6c 00000000 f7708b40 f609f600 
> f7708b64
>        c132ed37 dff49a40 f5f76000 fa2da685 f611f8c0 f5a5406c 03240e72 
> 00000008
> Call Trace:
>  [<c1038908>] mempool_free+0x43/0x46
>  [<c1013678>] default_wake_function+0x0/0xc
>  [<c132ed37>] __down_failed+0x7/0xc
>  [<fa2da685>] .text.lock.file+0x87/0x9a [cifs]

That's the out-of-line lock section for fs/cifs/file.c

>  [<c104e807>] __fput+0xab/0x148
>  [<c104c453>] filp_close+0x4e/0x54
>  [<c101773a>] put_files_struct+0x64/0xa6
>  [<c1018581>] do_exit+0x1c7/0x675
>  [<c10052b0>] do_syscall_trace+0x12b/0x172
>  [<c1018a8b>] sys_exit_group+0x0/0xd
>  [<c1002abf>] syscall_call+0x7/0xb

I'd say that cifs_close() is doing down() on a corrupted semaphore structure.

