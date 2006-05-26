Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWEZORJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWEZORJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEZORJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:17:09 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45586 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750768AbWEZORI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:17:08 -0400
Date: Fri, 26 May 2006 16:07:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [ANNOUNCE] Linux-2.4.32-hf32.5
Message-ID: <20060526140731.GC14725@w.ods.org>
References: <20060507131034.GA19198@exosec.fr> <20060525133427.GA22727@w.ods.org> <k2nd725cl0vocvb72boalj06tpjlita644@4ax.com> <20060526121623.GA14474@w.ods.org> <vvvd72p7mv2j9fet19evm807e0flonnugh@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vvvd72p7mv2j9fet19evm807e0flonnugh@4ax.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I removed Jari who told me yesterday he did not need to be Cc'd ]

On Fri, May 26, 2006 at 11:28:51PM +1000, Grant Coady wrote:
> On Fri, 26 May 2006 14:16:23 +0200, Willy Tarreau <willy@w.ods.org> wrote:
> 
> >Could you please pass it through ksymoops so that we get an idea about the
> >function causing this ? What was the last version not causing it ? hf32.4 ?
> 
> Yes, hf32.4 okay, see: <http://bugsplatter.mine.nu/test/linux-2.4/>
> 
> >This looks like a structure member gets accessed while a pointer is NULL,
> >if you always get 0x88... I would be it could come from
> >2.4.32-ext3-link-unlink-race-1, but that would be strange.
> 
> Good guess!  The previous version comment stripped .configs are 
> linked by machine name from the summary page above.

Hmmm that's bad, this one has been merged into mainline.
It would look like dentry->d_inode is NULL here :

  double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);

I don't know how this can be fixed, though ! My first guess would be to
quickly revert the patch.

Marcelo, do you have Vadim Egorov's address ? I think he can help us on this,
after all it is his patch and he found explained the bug !

Right now I will release -hf32.6 quickly.

> Localtime 23:28 so it will be overnight delay before I reply to 
> queries for further info ;) 
> 
> grant@sempro:~$ ksymoops -v ~/linux/linux-2.4.32-hf32.5/vmlinux -m /boot/System.map-2.4.32-hf32.5 oops
> ksymoops 2.4.11 on i686 2.6.16.17a.  Options used
>      -v /home/grant/linux/linux-2.4.32-hf32.5/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.6.16.17a/ (default)
>      -m /boot/System.map-2.4.32-hf32.5 (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> ksymoops: No such file or directory
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Unable to handle kernel NULL pointer dereference at virtual address 00000088 printing eip:
> c013ee43
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c013ee43>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000088   ebx: c19bb5c0   ecx: 00000088   edx: f7bf0005
> esi: f7e3c508   edi: c19bb5c0   ebp: f7e3c480   esp: f7e6bf18
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=f7e6b000)
> Stack: c19bb5c0 00000000 c19bb5c0 f7bf0000 f7e6bf3c c19bb5c0 c013f056 f7e3c480
>        c19bb5c0 c19bb440 c19ac140 f7bf0005 00000004 01c0d8cc 00000010 00000000
>        c013e727 00000803 c02a18f6 c0105000 0008e000 c0302bfb c02a18f6 f7bf0000
> Call Trace:    [<c013f056>] [<c013e727>] [<c0105000>] [<c013e890>] [<c01051f3>]
>   [<c0105085>] [<c010568b>] [<c0105070>]
> Code: ff 08 0f 88 8f 16 00 00 8b 5f 08 85 db 74 0c 8b 47 0c 39 68
> 
> 
> >>EIP; c013ee43 <vfs_unlink+33/190>   <=====
> 
> Trace; c013f056 <sys_unlink+b6/120>
> Trace; c013e727 <vfs_mknod+c7/120>
> Trace; c0105000 <_stext+0/0>
> Trace; c013e890 <sys_mknod+110/180>
> Trace; c01051f3 <prepare_namespace+73/140>
> Trace; c0105085 <init+15/110>
> Trace; c010568b <arch_kernel_thread+2b/40>
> Trace; c0105070 <init+0/110>
> 
> Code;  c013ee43 <vfs_unlink+33/190>
> 00000000 <_EIP>:
> Code;  c013ee43 <vfs_unlink+33/190>   <=====
>    0:   ff 08                     decl   (%eax)   <=====
> Code;  c013ee45 <vfs_unlink+35/190>
>    2:   0f 88 8f 16 00 00         js     1697 <_EIP+0x1697>
> Code;  c013ee4b <vfs_unlink+3b/190>
>    8:   8b 5f 08                  mov    0x8(%edi),%ebx
> Code;  c013ee4e <vfs_unlink+3e/190>
>    b:   85 db                     test   %ebx,%ebx
> Code;  c013ee50 <vfs_unlink+40/190>
>    d:   74 0c                     je     1b <_EIP+0x1b>
> Code;  c013ee52 <vfs_unlink+42/190>
>    f:   8b 47 0c                  mov    0xc(%edi),%eax
> Code;  c013ee55 <vfs_unlink+45/190>
>   12:   39 68 00                  cmp    %ebp,0x0(%eax)
> 
>  <0>Kernel panic: Attempted to kill init!
> 
> 1 error issued.  Results may not be reliable.
> 
> Thanks,
> Grant.

Thank you very much Grant,
Willy

