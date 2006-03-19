Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWCSXF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWCSXF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 18:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWCSXF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 18:05:27 -0500
Received: from mx1.suse.de ([195.135.220.2]:21475 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751169AbWCSXF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 18:05:26 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 20 Mar 2006 10:03:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17437.58206.416304.674207@cse.unsw.edu.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2 - BUG when flushing a ramdisk
In-Reply-To: message from Andrew Morton on Saturday March 18
References: <20060318044056.350a2931.akpm@osdl.org>
	<200603182121.58071.rjw@sisk.pl>
	<20060318125438.420f0608.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday March 18, akpm@osdl.org wrote:
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

Well... someone is doing strange things....

This BUG would only hit if a page used by ramdisk had buffers
attached, but as far as I can see, rd.c never attaches buffers to its
pages, or sets the PagePrivate flag.  So this cannot happen :-)

If there are no users of the page (as one expects given that rd_ioctl
only called truncate_inode_pages is bd_openers is nice and low), then
try_to_release_page should succeed.
On the other hand, if the page could still be in use, then rd_ioctl
should really be calling invalidate_inode_pages() (probably via
invalidate_bdev) rather than truncate_inode_pages. 

Either way, I'm not convinced that removing the BUG is the "right"
solution, though I concede that it might be the "practical" solution.
It seems very likely that the failure of try_to_release_page at this
point means that some buffer_heads will be leaking, but as I cannot
reproduce the problem by just playing with a ramdisk (the reported
problem happens during early boot from an initrd) I cannot point to a
clear leak for you....

Maybe the "right" thing to do is for rd.c to define an invalidate_page
function that removes dirty buffers (which try_to_release_page won't),
but that would only make sense if rd.c put buffers on the page in the
first place....

Confused!

> 
> That's two.  I guess I need to see if Neil left any other little timebombs
> in there for us ;)

No, I think you've got them all now.  One in block_invalidatepage, one
in journal_invalidatepage, and one in jfs that has been confirmed as
'OK'.

NeilBrown

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
