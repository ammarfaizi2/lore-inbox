Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUJLOYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUJLOYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJLOXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:23:45 -0400
Received: from dyn3.mc.tuwien.ac.at ([128.130.175.85]:44421 "EHLO
	mail.13thfloor.at") by vger.kernel.org with ESMTP id S264098AbUJLOXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:23:30 -0400
Date: Tue, 12 Oct 2004 16:29:16 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lock issues
Message-ID: <20041012142916.GA8513@DUMA.13thfloor.at>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20041011225700.GD32228@DUMA.13thfloor.at> <1097539708.5432.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1097539708.5432.64.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:08:28AM +0200, Trond Myklebust wrote:
> På ty , 12/10/2004 klokka 00:57, skreiv Herbert Poetzl:
> > Hi Trond!
> > 
> > experiencing the following panic on a linux-vserver
> > kernel (2.6.9-rc4, no modifications to locking)
> 
> Which filesystem? Is this NFS or CIFS (which both have an f_op->lock()
> routine)?

NFS v3  options should be rw,intr,tcp,nfsvers=3
(not 100% sure)

> > it's the locks_free_lock(file_lock); at the end of 
> > fcntl_setlk64() and I'm asking myself if something
> > like in sys_flock()
> > 
> >         if (list_empty(&lock->fl_link)) {
> >                 locks_free_lock(lock);
> >         }
> > 
> > would help here or just paper over the real issue?
> 
> Actually, the sys_flock() thing looks a lot more iffy to me: why should
> list_empty(lock->fl_link) mean that you are responsible for freeing that
> lock? Couldn't a sibling or child thread have released it from
> underneath you?

btw, once the following messages where observed
right before the panic()

nlmclnt_lock: VFS is out of sync with lock manager!
nlmclnt_lock: VFS is out of sync with lock manager!
nlmclnt_lock: VFS is out of sync with lock manager!

but that was jsut in one case of many ...

> Anyhow, that would indeed be papering over an issue in the posix lock
> case. 

thought so .. but why the check for sys_flock() ?
(disclaimer: don't know the locking code)

> By the time we get to the end of fcntl_setlk64(), the file_lock
> should not be on any lists. If it got added to somebody else's block
> list, it should either have been unblocked when the region was freed, or
> in case of a signal, we remove it from the block list manually. Unlike
> the flock case, file_lock itself never gets added to the active list.

best,
Herbert

> Cheers,
>   Trond
