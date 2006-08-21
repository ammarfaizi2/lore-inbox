Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWHUTzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWHUTzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWHUTzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:55:11 -0400
Received: from pat.uio.no ([129.240.10.4]:52463 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750909AbWHUTzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:55:10 -0400
Subject: Re: [NFS] 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock
	manager!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Neil Brown <neilb@suse.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, nfs@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <17641.10665.116168.867041@cse.unsw.edu.au>
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
	 <17636.4462.975774.528003@cse.unsw.edu.au>
	 <9a8748490608170258s32df0272r60c8c540e5871485@mail.gmail.com>
	 <17641.10665.116168.867041@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 15:54:58 -0400
Message-Id: <1156190098.6158.109.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.941, required 12,
	autolearn=disabled, AWL 0.55, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 13:34 +1000, Neil Brown wrote:
> Looking in fs/nfs/file.c (at 2.6.18-rc4-mm1 if it matters, but 2.6.17
> is much the same)
> 
>  - do_vfs_lock is only called when the filesystem was mounted with
>     -o nolock  EXCEPT
>  - If a lock request to the server in interrupted (when mounted with
>      -o intr) then do_vfs_lock is called to try to get the lock
>     locally.  Normally equivalent code will be called inside
>     fs/lockd/clntproc.c when the server replies that the lock has been
>     gained.  In the case of an interrupt though this doesn't happen
>     but the lock may still have happened on the server.  So we record
>     locally that the lock was gained, to ensure that it gets unlocked
>     when the process exits.
> 
> As you don't have '-o nolocks' you must be hitting the second case.
> The lock call to the server returns -EINTR or -ERESTARTSYS and
> do_vfs_lock is called just-in-case.  
> As this is a just-in-case call, it is quite possible that the lock is
> held by some other process, so getting an error is entirely possible.
> So printing the message in this case seems wrong.
> 
> On the other hand, printing the message in any other case seems wrong
> too, as server locking is not being used, so there is nothing to get
> out of sync with.
> 
> As a further complication, I don't think that in the just-in-case
> situation that it should risk waiting for the lock.
> Now maybe we can be sure there is a pending signal which will break
> out of any wait (though I'm worried about -ERESTARTSYS - that doesn't
> imply a signal does it?), but I would feel more comfortable if
> FL_SLEEP were turned off in that path.
> 
> So: Trond:  Any obvious errors in the above?
> Is the following patch ok?

Could we instead replace it with a dprintk() that returns the value of
"res"? That will keep it useful for debugging purposes.

Cheers,
  Trond

