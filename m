Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUBAQAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 11:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUBAQAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 11:00:05 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.131.37]:42652 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265352AbUBAQAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 11:00:00 -0500
Message-ID: <401BD0CA.5070204@xfs.org>
Date: Sat, 31 Jan 2004 09:59:06 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: nathans@sgi.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org> <20040130225353.A26383@infradead.org> <20040130151316.40d70ed3.akpm@osdl.org> <20040131012507.GQ25833@drinkel.cistron.nl> <20040130173851.2cc5938f.akpm@osdl.org> <20040131114638.GA29609@drinkel.cistron.nl>
In-Reply-To: <20040131114638.GA29609@drinkel.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> On Sat, 31 Jan 2004 02:38:51, Andrew Morton wrote:
> 
>>Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>>
>>>But the XFS problem appears to be vn_revalidate which calls i_size_write()
>>>without holding i_sem:
>>
>>There's your bug.
> 
> 
> Okay. It seems that XFS uses its own locking with xfs_ilock() etc,
> so I am not sure if this should be fixed by using down(&inode->i_sem)
> or by using xfs_ilock().
> 
> Perhaps xfs_ilock() should also get the inode->i_sem semaphore
> in the XFS_ILOCK_EXCL case ?
> 
> Also, there are one or two more places that call i_size_write()
> that should be looked at I guess.
> 

Actually it gets more messy than this. i_size_write is called by
different spots by xfs without the i_sem held. The call in
generic_file_aio_write_nolock() is made without the lock for O_DIRECT 
writes, XFS allows multiple parallel writes for O_DIRECT
writes.

The vn_revalidate call is called out of linvfs_setattr,
which is called with the i_sem held, it is also potentially called out
of linvfs_getattr, although since the i_size is always maintained
as it is changed, this call should not actually be updating the size.
Possibly changing the code in vn_revalidate to do this:

	if (i_size_read(inode) < va.va_size))
		i_size_write(inode, va.va_size);

Would be a good starting point, I suspect those calls from the nfs
revalidate call are not really going to change the inode size. My
guess is this will make your problem go away.

Probably some larger code restructure is needed so that revalidate
knows if the i_sem is held or not at this point.

The O_DIRECT write case is the hard one. In XFS's internal view of
the world, the inode size is maintained via the XFS_ILOCK, but we
only hold that across metadata manipulation within the fs code,
not across I/O such as a call to generic_file_aio_write_nolock.
Right now the only way I see of dealing with that is to make
writes which we know will extent the file hold the i_sem for
the duration in the O_DIRECT case.

Steve
