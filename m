Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWDSUjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWDSUjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWDSUjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:39:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751207AbWDSUjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:39:25 -0400
Date: Wed, 19 Apr 2006 13:41:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [RFC] copy_from_user races with readpage
Message-Id: <20060419134148.262c61cd.akpm@osdl.org>
In-Reply-To: <200604191318.45738.mason@suse.com>
References: <200604191318.45738.mason@suse.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> Hello everyone,
> 
> I've been working with IBM on a long standing bug where zeros unexpectedly pop 
> up during a disk certification test.  We tracked it down to copy_from_user.  
> A simplified form of the test works like this:
> 
> memset(buffer, 0x5a, 4096);
> fd = open("/dev/some_disk", O_RDWR);
> write(fd, buffer, 4096);
> pid = fork();
> if (pid) {
>     while(1) {
>         lseek(fd, 0, 0);
>         read(fd, buf2, 4096);
>     }
> } else {
>     while(1) {
>         lseek(fd, 0, 0);
>         write(fd, buffer, 4096);
>     }
> }
> 
> First we fill a given block in the file with a specific pattern.  Then we 
> fork.  One proc writes that exact same pattern over and over, and the other 
> proc reads from the block over and over.
> 
> The reads and writes race, but you would expect the read to always see the 
> 0x5a pattern.  If we introduce enough memory pressure, sometimes the read 
> sees zeros instead of the pattern because of kmap_atomic:
> 
> cpu1                                            cpu2
> file_write 
> (page now up to date)
> file_write                                     file_read
> __copy_from_user (atomic)
>                                                    file_read_actor
>                                                    copy_to_user
> __copy_from_user (non-atomic)
> 
> The first copy_from_user fails because of a page fault.  So, the destination
> page is zero filled, which is the data found by file_read_actor().  The second 
> copy_from_user succeeds and puts the proper data in the page.

Yeah.

> The solution seems to be a non-zeroing copy_from_user, but this is only 
> required on arches where kmap_atomic incs the preemption count.  Andrea has a 
> patch for i386 that does this (small and obvious), along with some memsets to 
> zero out the kernel page when copy_from_user fails.

We need to be careful not to convert a temporarily-is-zero into
temporarily-is-uninitialised, but that looks to be OK.

> This feature has been present for quite a while, and I think it should be 
> fixed.  But before we go through making a patch for ppc (any other arches 
> affected?) I wanted to poll here and make sure people agreed the zeros are 
> not correct.

The application is being a bit silly, because the read will return
indeterminate results depending on whether it gets there before or after
the write.  But that's assuming that the read is reading the part of the
page which the writer is writing.  If the reader is reading bytes 1000-1010
and the writer is writing bytes 990-1000 then the reader is being non-silly
and would be justifiably surprised to see zeroes.


I'd have thought that a sufficient fix would be to change
__copy_from_user_inatomic() to not do the zeroing, then review all users to
make sure that they cannot leak uninitialised memory.
