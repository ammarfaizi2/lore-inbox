Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUFXVJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUFXVJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUFXVIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:08:15 -0400
Received: from [141.211.133.132] ([141.211.133.132]:45700 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265825AbUFXVGt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:06:49 -0400
Subject: Re: [PATCH] Make POSIX locks compatible with the NPTL thread model
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>, Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200406241356.19925.agruen@suse.de>
References: <1088010468.5806.52.camel@lade.trondhjem.org>
	 <200406241356.19925.agruen@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088111176.5194.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 17:06:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 24/06/2004 klokka 07:56, skreiv Andreas Gruenbacher:

> There are local and remote locks, and both of them need a pid discriminator. 
> We have used the files_struct pointer so far which was either a struct 
> files_struct pointer or a struct nlm_host pointer. By using pointers we had a 
> host+pid "uniquifier". Now we could change the fields from:
> 
> 	struct file_lock {
> 		[...]
> 		fl_owner_t fl_owner;
> 		unsigned int fl_pid;
> 		[...]
> 	};
> 
> to:
> 
> 	struct file_lock {
> 		[...]
> 		struct nlm_host *fl_host;	/* NULL for local locks */
> 		unsigned int fl_pid;
> 		[...]
> 	};
> 
> There would be no casting of other types into a fl_host here.

This was what the second patch I sent in did. However there is a flaw:
see Chris's Oops which shows that CLONE_FILES can still screw us...

Seeing that Oops, I'm starting to believe that the only way we can
achieve both goals of making the locking rules robust *and*
self-consistent is to scrap the fl_pid field...

If we do that, we end up with a situation in which an fcntl(F_GETLK)
call can return bogus values in the "pid" field, if someone calls
clone(CLONE_FILES) (without CLONE_THREAD). Also if someone calls
clone(CLONE_THREAD) (omitting CLONE_FILES) then fcntl(F_UNLCK) will fail
to clear all locks with the same pid. Finally we will still be saddled
with steal_locks()...

HOWEVER

At least NFS, CIFS,... will be able to set up ->lock() methods that are
consistent with what the VFS is doing above them, so that close() will
indeed free the same locks on the remote system as on the local system.
Currently that is not the case...
Note that doing this will require some work. In particular the NFS Lock
Manager protocol (used by NFSv2/v3 but not NFSv4) assumes that a 32-bit
"pid" field labels the lockowner. We would somehow have to convert the
lock->fl_owner into such a field - trivial on 32-bit systems, but less
so on systems with 64-bit pointers.
On the NLM/lockd server side, we need to stuff those same 32-bit "pid'
fields into the fl_lock fields in such a way that the "pid" values from
different clients do not conflict.


Cheers,
  Trond
