Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbUKWAW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUKWAW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUKWAUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:20:00 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:39406
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262478AbUKWASF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:18:05 -0500
Message-ID: <41A281B5.2010908@eyal.emu.id.au>
Date: Tue, 23 Nov 2004 11:17:57 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: 2.6.10-rc2-mm3 - oops on boot
References: <20041121223929.40e038b2.akpm@osdl.org>	<41A26BD4.8000509@eyal.emu.id.au> <20041122151049.6b9dc575.akpm@osdl.org>
In-Reply-To: <20041122151049.6b9dc575.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> 
>>EIP is at invalidate_bdev+0x10/0x29
>>eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7ca4320
>>esi: 00000002   edi: 00000006   ebp: f7cb3400   esp: c194bef8
>>ds: 007b   es: 007b   ss: 0068
>>Process swapper (pid: 1, threadinfo=c194b000 task=c194aa80)
>>Stack: 00000000 00000004 c0187aa3 00000000 00000000 00000005 00000006 00000006 
>>       00000000 00000000 00000000 f7cb3400 c1931f80 00000000 c0176377 f7cb3400 
>>       ffffffff c02cc149 00000000 ffffffff c194bf60 c02cc149 00000000 c0176498 
>>Call Trace:
>> [<c0187aa3>] vfs_quota_off+0xc0/0x219
>> [<c0176377>] do_umount+0x19e/0x235
>> [<c0176498>] sys_umount+0x8a/0x8e
>> [<c03c72b0>] umount_devfs+0x17/0x1b
>> [<c03c71bd>] prepare_namespace+0x2e/0xd7
>> [<c012e2fc>] flush_workqueue+0x77/0x95
>> [<c0100454>] init+0x14e/0x18d
>> [<c0100306>] init+0x0/0x18d
>> [<c010128d>] kernel_thread_helper+0x5/0xb
>>Code: 5e 5f 5d c3 89 5c 24 1c f0 ff 43 0c eb d5 0f 0b b2 01 7f 6d 2d c0 e9 4b ff ff ff 83 ec 08 89 5c 24 04 8b 5c 24 0c e8 f5 0f 00 00 <8b> 43 04 8b 5c 24 04 8b 80 b4 00 00 00 89 44 24 0c 83 c4 08 e9 
>> <0>Kernel panic - not syncing: Attempted to kill init!
> 
> 
> Well devfs has a NULL sb->s_bdev, so the oops is no surprise.  However I'm
> a bit surprised that we even got that far into the quota code.
> 
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

Very good. -mm3 now boots and TV works as well (both the dvb cards and
the analog one). No oops or other unusual messages yet.

Thanks

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
