Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVJJW02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVJJW02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVJJW01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:26:27 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:7845 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1751289AbVJJW00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:26:26 -0400
Date: Mon, 10 Oct 2005 19:36:36 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: glommer@br.ibm.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051010223636.GB11427@br.ibm.com>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>If you had read the source code rather than just the comments you would
> >>have seen that this is not true.  It can return NULL (see
> >>fs/buffer.c::__getblk_slow()).  Certainly I would prefer to keep the
> >>checks in NTFS, please.  They may only be good for catching bugs but I
> >>like catching bugs rather than segfaulting due to a NULL dereference.
> 
> The check should be rather a BUG() than dump_stack() and return NULL --- I 
> think it's not right to write code to recover from programming errors. 
> Filesystem drivers are supposed to pass correct blocksize to getblk(). --- 
> even for users it's better to crash, because user whose machine has locked 
> up on BUG() will report bug more likely than user whose machine has 
> written stack dump into log and corrupted filesystem --- by the time he 
> discovers the corruption and mesage he might not even remember what 
> triggered it.

That was what I meant by having the opposite problem here. I think
dumping the stack and returning NULL is okay, as long as all programmers
test its return value, and decide to fail in an alternative way, just
like Anton does, for example. But unfortunately, that's not what happen. 

In a lot of cases, we see uses like these: (This one from affs.h)

	bh = sb_getblk(sb, block);
	lock_buffer(bh);
	memset(bh->b_data, 0 , sb->s_blocksize);
	set_buffer_uptodate(bh);
	unlock_buffer(bh);

Which does not seem to be the right usage for it.

As I said, I took away the checks because I missed that return
statement. I usually don't think that hanging is the preferred solution
in the cases in which you can stop gracefully - But in case you do stop
gracefully, not dereference a NULL pointer.

																																								
> 
> As comment in buffer.c says, getblk will deadlock if the machine is out of 
> memory. It is questionable whether to deadlock or return NULL and corrupt 
> filesystem in this case --- deadlock is probably better.
> 
> Mikulas

Maybe the best solution is neither one nor another. Testing and failing
gracefully seems better.

What do you think?

Glauber

