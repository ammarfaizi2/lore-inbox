Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSLNKQR>; Sat, 14 Dec 2002 05:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267587AbSLNKQR>; Sat, 14 Dec 2002 05:16:17 -0500
Received: from angband.namesys.com ([212.16.7.85]:40082 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265012AbSLNKQP>; Sat, 14 Dec 2002 05:16:15 -0500
Date: Sat, 14 Dec 2002 13:24:06 +0300
From: Oleg Drokin <green@namesys.com>
To: Philippe Gramoull? <philippe.gramoulle@mmania.com>
Cc: nfs <nfs@lists.sourceforge.net>, Chris Mason <mason@suse.com>,
       linux-kernel@vger.kernel.org
Subject: kmalloc returning bogus values? Re: Kernel Oops  in 2.4.20 
Message-ID: <20021214132406.A13490@namesys.com>
References: <20021214024428.1e496afb.philippe.gramoulle@mmania.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20021214024428.1e496afb.philippe.gramoulle@mmania.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Looking at the trace it seems that either kmalloc returned bogus value
   or kmalloc returned good value, but it got corrupted somehow corrupted
   almost immediately in register.

   No, I do not know how that might happen. Also this oops seems to have
   nothing to do with NFS either, NFS code happened to be active at the moment
   when interrupt from network card have happened.

   I am CCing this to lkml in hopes that somebody there might have some ideas.

Bye,
    Oleg
On Sat, Dec 14, 2002 at 02:44:28AM +0100, Philippe Gramoull? wrote:
> Hi,
> 
> Scope: NFS server is a DELL 2550, SMP , 1Go RAM with a PowerVault RAID5 array
> controlled by a PERC3/QC ( megaraid driver) with about 600Go of data
> with plenty of directories and lots of small files.
> NIC is Intel eepro100
> 
> The server is used for serving web pages as well as FTP accounts for
> members of our online service. Filesystem is Reiserfs 3.6 format.
> 
> As for software, we use a plain 2.4.20 kernel with patches from Oleg Drokin
> and Chris Mason to enable data logging as well as quota V2.
> No single patch related to NFS was applied.
> 
> All clients use NFSV3 udp with standard mount options (rsize=8192,wsize=8192,hard,intr)
> and all 80 clients kernels mostly use 2.4.19-pre3 , (with nfs fixes at the time of its release)
> few with 2.4.18-pre[23]. There are 285 mounts from this server.
> 
> The NFS server is very busy, running 256 NFS threads with a usual load average of ~ 4/5.
> 
> With the help of Reiserfs developper, we tried to chase down a bug that would cause the kernel
> to crash , and that first seemed to be related to the data logging feature ( partition is mounted
> with data=orderd option) each time that quotacheck was run
> 
> After several fixes provided, latest quotacheck made the kernel oops and decoded oops doesn't
> show anything related to reiserfs but more likely something to do with NFS.
> 
> Decoded oops is provided below. The oops will almost happen each time quotacheck is run,
> sometimes it can take many hours for the bug to be triggered.
> Kernel doesn't seem to oops if quotacheck is not run.
> 
> I can provide more information if needed, just let me know.
> 
> Thanks,
> 
> Philippe
> 
> 
> Unable to handle kernel paging request at virtual address 0040648e
>  c020318a
>  *pde = 00000000
>  Oops: 0002
>  CPU:    0
>  EIP:    0010:[<c020318a>]    Not tainted
>  Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00010206
>  eax: 00000011   ebx: ca38b02e   ecx: f5196000   edx: 00406480
>  esi: 0d00c1d5   edi: 00007458   ebp: 3500c1d5   esp: f5197cac
>  ds: 0018   es: 0018   ss: 0018
>  Process nfsd (pid: 394, stackpage=f5197000)
>  Stack: c2a39811 c02038c4 00000005 ca38b02e c2a39860 ca38b02e c2a39860 c2a39860 
>         f7e2b000 ca38b02e c0202900 c2a39860 f7e2b000 ca38b02e c2a39860 c2a39860 
>         c0202d1a c2a39860 00000000 c2a39860 00000800 00000008 00000001 c01f5aeb 
>  Call Trace:    [<c02038c4>] [<c0202900>] [<c0202d1a>] [<c01f5aeb>] [<c01f5b99>]
>    [<c01f5cce>] [<c011bc0f>] [<c01088bb>] [<c010adf8>] [<c0115610>] [<c012808c>]
>    [<c012894d>] [<c0128dd4>] [<c0128ccc>] [<c016c584>] [<c017170b>] [<c0168b23>]
>    [<c0236585>] [<c016890f>] [<c0105684>]
>  Code: 88 42 0e c6 42 0f 00 0f b7 43 04 66 89 42 0c 8b 43 0c 89 42 
> 
> 
>  >>EIP; c020318a <ip_frag_create+26/b0>   <=====
> 
>  >>ebx; ca38b02e <_end+a05832a/3860435c>
>  >>ecx; f5196000 <_end+34e632fc/3860435c>
>  >>esp; f5197cac <_end+34e64fa8/3860435c>
> 
>  Trace; c02038c4 <ip_defrag+bc/16b>
>  Trace; c0202900 <ip_local_deliver+1c/12c>
>  Trace; c0202d1a <ip_rcv+30a/38d>
>  Trace; c01f5aeb <netif_receive_skb+11f/14c>
>  Trace; c01f5b99 <process_backlog+81/124>
>  Trace; c01f5cce <net_rx_action+92/154>
>  Trace; c011bc0f <do_softirq+6f/cc>
>  Trace; c01088bb <do_IRQ+db/ec>
>  Trace; c010adf8 <call_do_IRQ+5/d>
>  Trace; c0115610 <.text.lock.sched+7a/1da>
>  Trace; c012808c <___wait_on_page+98/b8>
>  Trace; c012894d <do_generic_file_read+301/464>
>  Trace; c0128dd4 <generic_file_read+7c/110>
>  Trace; c0128ccc <file_read_actor+0/8c>
>  Trace; c016c584 <nfsd_read+1bc/260>
>  Trace; c017170b <nfsd3_proc_read+127/184>
>  Trace; c0168b23 <nfsd_dispatch+d3/19a>
>  Trace; c0236585 <svc_process+28d/4d4>
>  Trace; c016890f <nfsd+1f7/338>
>  Trace; c0105684 <kernel_thread+28/38>
> 
>  Code;  c020318a <ip_frag_create+26/b0>
>  00000000 <_EIP>:
>  Code;  c020318a <ip_frag_create+26/b0>   <=====
>     0:   88 42 0e                  mov    %al,0xe(%edx)   <=====
>  Code;  c020318d <ip_frag_create+29/b0>
>     3:   c6 42 0f 00               movb   $0x0,0xf(%edx)
>  Code;  c0203191 <ip_frag_create+2d/b0>
>     7:   0f b7 43 04               movzwl 0x4(%ebx),%eax
>  Code;  c0203195 <ip_frag_create+31/b0>
>     b:   66 89 42 0c               mov    %ax,0xc(%edx)
>  Code;  c0203199 <ip_frag_create+35/b0>
>     f:   8b 43 0c                  mov    0xc(%ebx),%eax
>  Code;  c020319c <ip_frag_create+38/b0>
>    12:   89 42 00                  mov    %eax,0x0(%edx)
