Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUHNKeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUHNKeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUHNKeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:34:18 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7176 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266353AbUHNKeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:34:06 -0400
Date: Sat, 14 Aug 2004 12:19:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no, jgarzik@pobox.com
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040814101916.GA27328@alpha.home.local>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814101039.GA27163@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again,

sorry for the noise, I've just found a similar report that Jeff sent
yesterday with a patch. I've applied it and it now runs reliably. It's
a bit of a shame that it didn't get into mainline just in time.

Cheers,
Willy

On Sat, Aug 14, 2004 at 12:10:39PM +0200, Willy Tarreau wrote:
> Hi Linus & All,
> 
> I've just compiled and booted 2.6.8 on my dual athlon. Everything went
> OK before I logged in as a non-root user whose home is mounted from
> another linux box over NFSv3/UDP.
> 
> I got this oops :
> 
> <-----------
> Unable to handle kernel NULL pointer dereference at virtual address 00000014
>  printing eip:
> c01f1e76
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT SMP
> Modules linked in: usbmouse ohci_hcd usbcore e1000 snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_util_mem snd_hwdep snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_pcm snd_page_alloc snd_timer snd_mixer_oss snd soundcore
> w83781d i2c_sensor i2c_amd756 i2c_core bsd_comp ppp_generic slhc
> CPU:    1
> EIP:    0060:[<c01f1e76>]    Not tainted
> EFLAGS: 00010296   (2.6.8)
> EIP is at nfs3_request_init+0x16/0x20
> eax: 00000000   ebx: d5496620   ecx: 00000000   edx: df614880
> esi: dc262000   edi: dbb4bd68   ebp: 00000000   esp: dc263c44
> ds: 007b   es: 007b   ss: 0068
> Process bash (pid: 460, threadinfo=dc262000 task=dfc3d730)
> Stack: dff96e00 c01ea7e8 d5496620 df614880 00000174 dbb4bd68 c12bd3c0 dc263cb0
>        d5496620 c01ed162 df614880 dbb4bd68 c12bd3c0 00000000 00000174 c12bd3d8
>        c12bd3c0 dc263dd0 dc263cb0 c014170c dc263d20 c12bd3c0 dc263d28 dc263d28
> Call Trace:
>  [<c01ea7e8>] nfs_create_request+0xd8/0xf0
>  [<c01ed162>] readpage_async_filler+0x52/0x100
>  [<c014170c>] read_cache_pages+0xac/0x160
>  [<c011e6b0>] autoremove_wake_function+0x0/0x40
>  [<c012985e>] recalc_sigpending+0xe/0x10
>  [<c03e3923>] rpc_call_sync+0x93/0xb0
>  [<c01ed29c>] nfs_readpages+0x8c/0xc0
>  [<c01ed110>] readpage_async_filler+0x0/0x100
>  [<c01417f5>] read_pages+0x35/0x130
>  [<c013eac4>] __alloc_pages+0xc4/0x320
>  [<c013ed0f>] __alloc_pages+0x30f/0x320
>  [<c0141cf2>] do_page_cache_readahead+0x1b2/0x1e0
>  [<c0141e5b>] page_cache_readahead+0x13b/0x1c0
>  [<c013ae88>] do_generic_mapping_read+0xb8/0x410
>  [<c013b488>] __generic_file_aio_read+0x1d8/0x200
>  [<c013b1e0>] file_read_actor+0x0/0xd0
>  [<c013b4f5>] generic_file_aio_read+0x45/0x50
>  [<c01e6128>] nfs_file_read+0xb8/0xd0
>  [<c0157e6a>] do_sync_read+0x7a/0xb0
>  [<c0157f55>] vfs_read+0xb5/0xf0
>  [<c0158170>] sys_read+0x40/0x70
>  [<c01059e3>] syscall_call+0x7/0xb
> Code: f0 ff 40 14 89 43 18 5b c3 90 8b 4c 24 04 8b 51 0c 3b 54 24
> 
> >>EIP; c01f1e76 <nfs3_request_init+16/20>   <=====
> Code;  c01f1e76 <nfs3_request_init+16/20>
> 00000000 <_EIP>:
> Code;  c01f1e76 <nfs3_request_init+16/20>   <=====
>    0:   f0 ff 40 14               lock incl 0x14(%eax)   <=====
> Code;  c01f1e7a <nfs3_request_init+1a/20>
>    4:   89 43 18                  mov    %eax,0x18(%ebx)
> Code;  c01f1e7d <nfs3_request_init+1d/20>
>    7:   5b                        pop    %ebx
> Code;  c01f1e7e <nfs3_request_init+1e/20>
>    8:   c3                        ret
> Code;  c01f1e7f <nfs3_request_init+1f/20>
>    9:   90                        nop
> Code;  c01f1e80 <nfs3_request_compatible+0/60>
>    a:   8b 4c 24 04               mov    0x4(%esp,1),%ecx
> Code;  c01f1e84 <nfs3_request_compatible+4/60>
>    e:   8b 51 0c                  mov    0xc(%ecx),%edx
> Code;  c01f1e87 <nfs3_request_compatible+7/60>
>   11:   3b 54 24 00               cmp    0x0(%esp,1),%edx
> ----------->
> 
> Extracts from the functions where the oops occured :
> 
> void
> nfs3_request_init(struct nfs_page *req, struct file *filp)
> {
>         req->wb_cred = get_rpccred(nfs_cred(req->wb_inode, filp));
> }
> 
> static inline
> struct rpc_cred *       get_rpccred(struct rpc_cred *cred)
> {
>         atomic_inc(&cred->cr_count);
>         return cred;
> }
> 
> static struct rpc_cred *
> nfs_cred(struct inode *inode, struct file *filp)
> {
>         struct rpc_cred *cred = NULL;
> 
>         if (filp)
>                 cred = (struct rpc_cred *)filp->private_data;
>         if (!cred)
>                 cred = NFS_I(inode)->mm_cred;
>         return cred;
> }
> 
> static inline struct nfs_inode *NFS_I(struct inode *inode)
> {
>         return container_of(inode, struct nfs_inode, vfs_inode);
> }
> 
> So it seems to me that both (filp or filp->private_data) and
> NFS_I(req->wb_inode)->mm_cred were NULL. I don't know if this
> is a permitted situation, but directly calling get_rpccred()
> from this leads to this oops.
> 
> Last 2.6 kernel I tried on this machine was 2.6.7, and I did
> not notice this oops. Unfortunately, I don't have enough time
> to dig through the large patch (19MB uncompressed), nor to try
> different configurations. But this seems reproducible anytime
> I try to access a file over NFSv3. Directory listings seem OK
> at the moment. I've not tested other combinations of NFS/config
> either (I'm typing this mail from the machine, so I don't want
> to risk retyping everything). Since it's reproducible on a
> single request, I don't think that PREEMPT/SMP has anything to
> do with this.
> 
> I can send other informations if needed. If anyone wants to
> suggest a patch, I can give it a try, but I won't have much
> time to help debugging this, unfortunately.
> 
> Cheers,
> Willy
