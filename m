Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTGTHb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTGTHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 03:31:25 -0400
Received: from mailf.telia.com ([194.22.194.25]:47078 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S263187AbTGTHbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 03:31:21 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz> <m2el0nvnhm.fsf@telia.com>
	<20030718094542.07b2685a.akpm@osdl.org> <m2oezrppxo.fsf@telia.com>
	<20030718131527.7cf4ca5e.akpm@osdl.org> <m2wuee9hdo.fsf@telia.com>
	<20030719180105.53b1226c.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 20 Jul 2003 09:45:52 +0200
In-Reply-To: <20030719180105.53b1226c.akpm@osdl.org>
Message-ID: <m2wuedvdxr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > I have tried the change, but the writeout is still very slow. (Maybe
> > somewhat faster than the original code, but far from being limited by
> > disk bandwidth.)
> 
> Did you fix swsusp to leave kswapd unrefrigerated during the shrink?  If
> not, the change wouldn't make any difference.

Yes, handled by this part of the patch:

@@ -976,10 +983,11 @@
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
+	tsk->flags |= PF_MEMALLOC|PF_KSWAPD|PF_IOTHREAD;

Without that change, nothing got swapped to disk. It looks like
__alloc_pages(GFP_ATOMIC,...) only wakes up the kswapd threads. Is the
pdflush threads needed during memory freeing? My patch leaves them
unrefrigerated too, but Pavel said that wasn't safe for some reason.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
