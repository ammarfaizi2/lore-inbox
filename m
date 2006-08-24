Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWHXNxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWHXNxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWHXNxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:53:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5861 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751542AbWHXNxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:53:52 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Serge E. Hallyn" <sergeh@us.ibm.com>
Cc: kjhall@us.ibm.com, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
In-Reply-To: <20060824133248.GC15680@sergelap.austin.ibm.com>
References: <1156359937.6720.66.camel@localhost.localdomain>
	 <20060823192733.GG28594@kvack.org>
	 <1156365357.6720.87.camel@localhost.localdomain>
	 <1156418815.3007.89.camel@localhost.localdomain>
	 <20060824133248.GC15680@sergelap.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 15:15:17 +0100
Message-Id: <1156428917.3007.150.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 08:32 -0500, ysgrifennodd Serge E. Hallyn:
> > You also have to deal with existing mmap() mappings and outstanding I/O.
> 
> That she does.

I don't believe so from the patches.

> > 	SysV shared memory
> 
> standard mmap controls should handle this, right?

No its rather independant of mmap

> > 	mmap
> 
> She handles these.

I must have missed where it handles that.

> thread #2 is reading data from a pipe which is at a secret level, so how
> will it exploit that?  It can't write it to a lower integrity file...

Ok my example isn't quite right - I can create the pipes and do the
blocking in other patterns to get the result I mean. The problem is that
I can be blocked in a driver write() method before you raise the
security level and no change at the VFS level will be early enough to
stop it.

Another example would be

Type ^S
	thread #1
		write(console, padding, internalbuffersize);
		write(console, secret_buffer, data) [blocks]

	thread #2
		sleep to be sure #1 is blocked
		open secret file
		read(secret, secret_buffer, data);

Type ^Q

By the time you raise the security level due to the action of thread #2
I'm already blocked in tty_do_write() and have passed any vfs checks.

> The revoke(2) isn't quite right semantically, because it would revoke
> all users' access, right?  Rather, we want one process' rights to all
> files revoked, but other read/writers should still have access.

The core is the same, the question of specifically what you revoke is
different.


