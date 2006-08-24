Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWHXNdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWHXNdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWHXNdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:33:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:14750 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751406AbWHXNc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:32:59 -0400
Date: Thu, 24 Aug 2006 08:32:48 -0500
From: "Serge E. Hallyn" <sergeh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kjhall@us.ibm.com, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge E Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060824133248.GC15680@sergelap.austin.ibm.com>
References: <1156359937.6720.66.camel@localhost.localdomain> <20060823192733.GG28594@kvack.org> <1156365357.6720.87.camel@localhost.localdomain> <1156418815.3007.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156418815.3007.89.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> Ar Mer, 2006-08-23 am 13:35 -0700, ysgrifennodd Kylene Jo Hall:
> > Example: The current process is running at the USER level and writing to
> > a USER file in /home/user/.  The process then attempts to read an
> > UNTRUSTED file.  The current process will become UNTRUSTED and the read
> > allowed to proceed but first write access to all USER files is revoked
> > including the ones it has open.
> 
> Which really doesn't mean anything in many cases because there are many
> ways to get data out of a file handle once you had it opened for write
> including sharing via non file handle paths.
> 
> You also have to deal with existing mmap() mappings and outstanding I/O.

That she does.

> So here are some ways to break it
> 
> 	SysV shared memory

standard mmap controls should handle this, right?

> 	mmap

She handles these.

> or just race it:
> 
> 	Open the USER file
> 	create a new thread
> 	thread #1 create a pipe to a new process ("receiver")
> 	thread #1 fill pipe
> 	thread #1 issue write of buffer that will hold secret data
> 			[blocks after check for rights]
> 	thread #2
> 		wait for thread #1 to block
> 		read secret data into buffer
> 		send signal to "receiver"
> 
> 
> 	receiver now empties the pipe, the write completes and I get the
> goodies.

thread #2 is reading data from a pipe which is at a secret level, so how
will it exploit that?  It can't write it to a lower integrity file...

> This is why you need a proper implementation of revoke(2) in Linux. You
> can't really do it any more easily.

The revoke(2) isn't quite right semantically, because it would revoke
all users' access, right?  Rather, we want one process' rights to all
files revoked, but other read/writers should still have access.

Certainly if it were implemented, I'd hope slim could share some of it's
code.

I did try another version of the revocation code which uses
change_protection() to remove the write access, then introduced a hook
on in front of page_mkwrite() to prevent making the page writeable
again.  But I was thinking only of integrity, so actually the secrecy
concerns would not be addressed.

-serge
