Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUJLNxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUJLNxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 09:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUJLNxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 09:53:50 -0400
Received: from pat.uio.no ([129.240.130.16]:26078 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263962AbUJLNxi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 09:53:38 -0400
Subject: Re: lock issues
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041011225700.GD32228@DUMA.13thfloor.at>
References: <20041011225700.GD32228@DUMA.13thfloor.at>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1097539708.5432.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 02:08:28 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 12/10/2004 klokka 00:57, skreiv Herbert Poetzl:
> Hi Trond!
> 
> experiencing the following panic on a linux-vserver
> kernel (2.6.9-rc4, no modifications to locking)

Which filesystem? Is this NFS or CIFS (which both have an f_op->lock()
routine)?

> it's the locks_free_lock(file_lock); at the end of 
> fcntl_setlk64() and I'm asking myself if something
> like in sys_flock()
> 
>         if (list_empty(&lock->fl_link)) {
>                 locks_free_lock(lock);
>         }
> 
> would help here or just paper over the real issue?

Actually, the sys_flock() thing looks a lot more iffy to me: why should
list_empty(lock->fl_link) mean that you are responsible for freeing that
lock? Couldn't a sibling or child thread have released it from
underneath you?

Anyhow, that would indeed be papering over an issue in the posix lock
case. By the time we get to the end of fcntl_setlk64(), the file_lock
should not be on any lists. If it got added to somebody else's block
list, it should either have been unblocked when the region was freed, or
in case of a signal, we remove it from the block list manually. Unlike
the flock case, file_lock itself never gets added to the active list.

Cheers,
  Trond

