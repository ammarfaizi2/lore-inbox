Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281225AbRKLDmc>; Sun, 11 Nov 2001 22:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281233AbRKLDmX>; Sun, 11 Nov 2001 22:42:23 -0500
Received: from pat.uio.no ([129.240.130.16]:49827 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281225AbRKLDmH>;
	Sun, 11 Nov 2001 22:42:07 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Writing over NFS causes lots of paging
In-Reply-To: <200111111829.fABIT9v14680@penguin.transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Nov 2001 04:36:53 +0100
In-Reply-To: <200111111829.fABIT9v14680@penguin.transmeta.com>
Message-ID: <shs1yj4wtgq.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > The VM layer has one explicit special case: it knows about the
     > magic in "page->buffers", and can handle writeback for
     > block-oriented devices sanely. But any non-buffer-oriented
     > filesystem is "invisible" to the VM layer, and has to use other
     > tricks to make the VM ignore its pages.

<snip>

     > Quite frankly, I don't rightly know what the real fix
     > is. Making "page->buffers" be a generic thing (a "void *")
     > along with making the buffer flushing logic be behind a address
     > space operation is probably the right thing in the long run.

That only takes care of writebacks. Don't forget that reading &
readahead can also eat memory if somebody forgets to call lock_page()
(a common problem on 'hard,intr' mounts).

You'll notice that in the NFS updates I sent you the other day, there
is a new function 'nfs_try_to_free_pages()' that provides a rather
generic way of freeing up NFS memory resources. Its sole purpose today
is to ensure that we keep an upper limit of 256 requests per mount.

My (still somewhat vague) plan is to expand that interface some time
during 2.5.x to allow the VM to control and limit the memory usage of
the NFS client - flushing out read and write requests if necessary.
IMHO, the filesystem can often be more efficient at clearing out pages
if we leave the choice of strategy up to it, rather than having the VM
micro-manage exactly which page is to be thrown out first.
For instance, under NFSv3 there is usually a huge advantage to sending
off a COMMIT over any other call, since it can potentially free up a
whole truckload of pages.

Cheers,
   Trond
