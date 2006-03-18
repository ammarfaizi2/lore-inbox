Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWCRVZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWCRVZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWCRVZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:25:46 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:40668 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750989AbWCRVZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:25:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc6-mm2
Date: Sat, 18 Mar 2006 22:24:37 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
References: <20060318044056.350a2931.akpm@osdl.org> <200603182121.58071.rjw@sisk.pl> <20060318125438.420f0608.akpm@osdl.org>
In-Reply-To: <20060318125438.420f0608.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182224.37856.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 21:54, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Saturday 18 March 2006 13:40, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/
> > 
> >  I get the following oops from it 100% of the time (on boot):
> > 
> >  Trying to free ramdisk memory ... ----------- [cut here ] --------- [please bite here ] ---------
> >  Kernel BUG at fs/buffer.c:1629
> >  invalid opcode: 0000 [1] PREEMPT
> >  last sysfs file: /block/hdc/range
> >  CPU 0
> >  Modules linked in:
> >  Pid: 1, comm: swapper Not tainted 2.6.16-rc6-mm2 #16
> >  RIP: 0010:[<ffffffff80280d9a>] <ffffffff80280d9a>{block_invalidatepage+202}
> >  RSP: 0000:ffff81005ff07ac8  EFLAGS: 00010246
> >  RAX: 0000000000000000 RBX: ffff810037c09138 RCX: ffff810037c09228
> >  RDX: 0000000000000000 RSI: ffff81005ff07a88 RDI: 0000000000000000
> >  RBP: ffff81005ff07af8 R08: 0000000000000002 R09: ffff81005ff07a99
> >  R10: ffff810037c09138 R11: 0000000000000010 R12: ffff810037c09138
> >  R13: 0000000000001000 R14: ffff810037c09138 R15: ffff810001c34e28
> >  FS:  0000000000000000(0000) GS:ffffffff80690000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> >  CR2: 00002afbe89a3000 CR3: 000000005fe36000 CR4: 00000000000006e0
> >  Process swapper (pid: 1, threadinfo ffff81005ff06000, task ffff81005ff05530)
> >  Stack: 0000000000000000 ffff810001c34e28 0000000000000002 0000000000000001
> >         ffff810037df47e0 ffffffffffffffff ffff81005ff07b08 ffffffff8027f7b3
> >         ffff81005ff07b28 ffffffff802610d5
> >  Call Trace: <ffffffff8027f7b3>{do_invalidatepage+35}
> >         <ffffffff802610d5>{truncate_complete_page+37} <ffffffff8026154f>{truncate_inode_pages_range+207}
> >         <ffffffff802617c0>{truncate_inode_pages+16} <ffffffff803bac96>{rd_ioctl+86}
> 
> Yeah, ramdisk does strange things.
> 
> That's two.  I guess I need to see if Neil left any other little timebombs
> in there for us ;)
> 
> --- devel/fs/buffer.c~make-address_space_operations-invalidatepage-return-void-fix	2006-03-18 12:52:37.000000000 -0800
> +++ devel-akpm/fs/buffer.c	2006-03-18 12:53:04.000000000 -0800
> @@ -1624,10 +1624,8 @@ void block_invalidatepage(struct page *p
>  	 * The get_block cached value has been unconditionally invalidated,
>  	 * so real IO is not possible anymore.
>  	 */
> -	if (offset == 0) {
> -		int ret = try_to_release_page(page, 0);
> -		BUG_ON(!ret);
> -	}
> +	if (offset == 0)
> +		try_to_release_page(page, 0);
>  out:
>  	return;
>  }
> _

That helps, thanks.
