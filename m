Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbUKWLlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUKWLlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 06:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUKWLli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 06:41:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10128 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262390AbUKWLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 06:41:36 -0500
Date: Tue, 23 Nov 2004 12:41:35 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm3 - oops on boot
Message-ID: <20041123114135.GA9714@atrey.karlin.mff.cuni.cz>
References: <20041121223929.40e038b2.akpm@osdl.org> <41A26BD4.8000509@eyal.emu.id.au> <20041122151049.6b9dc575.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122151049.6b9dc575.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> >
> > EIP is at invalidate_bdev+0x10/0x29
> > eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7ca4320
> > esi: 00000002   edi: 00000006   ebp: f7cb3400   esp: c194bef8
> > ds: 007b   es: 007b   ss: 0068
> > Process swapper (pid: 1, threadinfo=c194b000 task=c194aa80)
> > Stack: 00000000 00000004 c0187aa3 00000000 00000000 00000005 00000006 00000006 
> >        00000000 00000000 00000000 f7cb3400 c1931f80 00000000 c0176377 f7cb3400 
> >        ffffffff c02cc149 00000000 ffffffff c194bf60 c02cc149 00000000 c0176498 
> > Call Trace:
> >  [<c0187aa3>] vfs_quota_off+0xc0/0x219
> >  [<c0176377>] do_umount+0x19e/0x235
> >  [<c0176498>] sys_umount+0x8a/0x8e
> >  [<c03c72b0>] umount_devfs+0x17/0x1b
> >  [<c03c71bd>] prepare_namespace+0x2e/0xd7
> >  [<c012e2fc>] flush_workqueue+0x77/0x95
> >  [<c0100454>] init+0x14e/0x18d
> >  [<c0100306>] init+0x0/0x18d
> >  [<c010128d>] kernel_thread_helper+0x5/0xb
> > Code: 5e 5f 5d c3 89 5c 24 1c f0 ff 43 0c eb d5 0f 0b b2 01 7f 6d 2d c0 e9 4b ff ff ff 83 ec 08 89 5c 24 04 8b 5c 24 0c e8 f5 0f 00 00 <8b> 43 04 8b 5c 24 04 8b 80 b4 00 00 00 89 44 24 0c 83 c4 08 e9 
> >  <0>Kernel panic - not syncing: Attempted to kill init!
> 
> Well devfs has a NULL sb->s_bdev, so the oops is no surprise.  However I'm
> a bit surprised that we even got that far into the quota code.
  Actually I'm not that surprised as DQUOT_OFF is called on any
umount. Thanks for the fix. I'll also make DQUOT_OFF check whether
there's any sence in calling the quota code so that superblocks of
various strange filesystems are not passed to vfs_quota_off() (although
it should be safe now).

> Maybe it's a bit odd that sync_blockdev() accepts a NULL argument, but
> invalidate_bdev() does not.  Whatever.  This should get you going:
> 
> --- 25/fs/dquot.c~vfs_quota_off-oops-fix	Mon Nov 22 15:08:31 2004
> +++ 25-akpm/fs/dquot.c	Mon Nov 22 15:08:49 2004
> @@ -1372,7 +1372,8 @@ int vfs_quota_off(struct super_block *sb
>  			mark_inode_dirty(toput[cnt]);
>  			iput(toput[cnt]);
>  		}
> -	invalidate_bdev(sb->s_bdev, 0);
> +	if (sb->s_bdev)
> +		invalidate_bdev(sb->s_bdev, 0);
>  	return 0;
>  }
>  
> _

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
