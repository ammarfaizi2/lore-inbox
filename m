Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUDGGX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUDGGX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:23:27 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:11341 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264103AbUDGGXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:23:22 -0400
Date: Wed, 7 Apr 2004 16:23:14 +1000
From: Nathan Scott <nathans@sgi.com>
To: Oliver Kiddle <okiddle@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfs and page allocation failures
Message-ID: <20040407162314.A10240@wobbly.melbourne.sgi.com>
References: <22084.1081244015@trentino.logica.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22084.1081244015@trentino.logica.co.uk>; from okiddle@yahoo.co.uk on Tue, Apr 06, 2004 at 11:33:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Tue, Apr 06, 2004 at 11:33:35AM +0200, Oliver Kiddle wrote:
> I posted back in January about problems I was having with 2.6.1. Thanks
> for the help back then. I'm still having problems with the same
> machine, though.
> 
> 2.6.3 is usable (just three page allocation failures printed when I run
> xfsdump). xfsdump crashed 2.6.4 and I never got around to trying to
> capture the console output. I tried 2.6.5 yesterday and have had two
> issues. The first, relatively harmless problem was two page allocation
> failures printed when running xfsdump (output is below).
> 
> Then, this morning, mountd was no longer working. NFS was still happily
> working where clients had mounted the filesystems. rpcinfo -u was
> getting a timeout for mountd. I tried first restarting rpc.mountd which
> had no effect and then tried `/etc/init.d/nfs-kernel-server restart',
> also to no effect.
> 
> I've attached the relevant part of the dmesg output below.
> 
> Thanks
> 
> Oliver
> 
> st0: Block limits 1 - 16777215 bytes.
> xfsdump: page allocation failure. order:9, mode:0xd0
> Call Trace:
>  [<c012d79f>] __alloc_pages+0x2e0/0x325
>  [<c02ad92d>] enlarge_buffer+0xcf/0x182

This is xfsdump making requests of the SCSI tape driver with buffers
which are too large for it to pin down, the warning is harmless and
ST chugs on.  I believe the warnings will be fixed in future kernels,
and xfsdump/xfsrestore will need some tweaks to use more appropriately
sized buffers.

> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> EIP is at free_block+0x48/0xc8
> Process kswapd0 (pid: 7, threadinfo=c1b74000 task=c1b791e0)
> Call Trace:
>  [<c0130296>] cache_flusharray+0x3f/0xbc
>  [<c013045f>] kmem_cache_free+0x48/0x4c
>  [<c02119fa>] linvfs_destroy_inode+0x1b/0x1f

This looks like a use-after-free - freeing an inode for a second
time, I think - I haven't come across this one before.  I expect
the second oops and pagebuf warnings will be a follow-on effect
from this initial failure.  The initial failure will need some 
more investigation - if you can reliably hit it pls let me know
what/how you're doing that.

thanks.

-- 
Nathan
