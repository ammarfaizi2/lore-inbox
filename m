Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUBAQl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 11:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbUBAQl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 11:41:59 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:58517 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265373AbUBAQl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 11:41:56 -0500
Message-ID: <401BDA9F.1080001@xfs.org>
Date: Sat, 31 Jan 2004 10:41:03 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Miquel van Smoorenburg <miquels@cistron.nl>, nathans@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
References: <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org> <20040130225353.A26383@infradead.org> <20040130151316.40d70ed3.akpm@osdl.org> <20040131012507.GQ25833@drinkel.cistron.nl> <20040130173851.2cc5938f.akpm@osdl.org> <20040131114638.GA29609@drinkel.cistron.nl> <401BD0CA.5070204@xfs.org> <20040201161513.A15966@infradead.org>
In-Reply-To: <20040201161513.A15966@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Jan 31, 2004 at 09:59:06AM -0600, Steve Lord wrote:
> 
>>The vn_revalidate call is called out of linvfs_setattr,
>>which is called with the i_sem held, it is also potentially called out
>>of linvfs_getattr, although since the i_size is always maintained
>>as it is changed, this call should not actually be updating the size.
>>Possibly changing the code in vn_revalidate to do this:
>>
>>	if (i_size_read(inode) < va.va_size))
>>		i_size_write(inode, va.va_size);
>>
>>Would be a good starting point, I suspect those calls from the nfs
>>revalidate call are not really going to change the inode size. My
>>guess is this will make your problem go away.
>>
>>Probably some larger code restructure is needed so that revalidate
>>knows if the i_sem is held or not at this point.
> 
> 
> I think the right fix is to update the Linux i_size always shortly after
> di_size is updated.  There's a lot of updates in the directory code while
> should be handled by an i_size_write in the matching linvfs routines, and
> there's a few more but we should be able to handle those without
> vn_revalidate aswell.
> 

Changing the validate_fields call to use

	if (i_size_read(inode) != va.va_size)
		i_size_write(inode, va.va_size);

should take care of directories, certainly better than the
direct assignment to i_size which is in there now....
This is called from the directory ops which modify the
contents of a directory and should already be under the
i_sem. The vn_revalidate code should use a != test
as well of course...


> 
>>The O_DIRECT write case is the hard one. In XFS's internal view of
>>the world, the inode size is maintained via the XFS_ILOCK, but we
>>only hold that across metadata manipulation within the fs code,
>>not across I/O such as a call to generic_file_aio_write_nolock.
>>Right now the only way I see of dealing with that is to make
>>writes which we know will extent the file hold the i_sem for
>>the duration in the O_DIRECT case.
> 
> 
> That's the more difficult case.  Any reson why you'd hold i_sem
> for the whole O_DIRECT I/O instead of just for updating i_sem?
> 

We worked hard not to hold it, but that i_size_write in
the middle of the async_io code is tough to work around.

> Note that the EOF zeroing code also calls i_size_write.
> 

But that is called out of an extending setattr or a buffered write which
hold the semaphore. Hmm, actually O_DIRECT write can be in there as
well, but that is the same problem as the generic I/O path call.

Steve

