Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132366AbQLHXIA>; Fri, 8 Dec 2000 18:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132467AbQLHXHv>; Fri, 8 Dec 2000 18:07:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45573 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132366AbQLHXHl>; Fri, 8 Dec 2000 18:07:41 -0500
Date: Fri, 8 Dec 2000 14:36:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: linux-kernel@vger.kernel.org, ch.rohland@gmx.net
Subject: Re: [PATCH,preliminary] cleanup shm handling
In-Reply-To: <m3snnyo92i.fsf@linux.local>
Message-ID: <Pine.LNX.4.10.10012081430580.31310-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Dec 2000, Christoph Rohland wrote:
> 
> Linus Torvalds <torvalds@transmeta.com> writes:
> > On 8 Dec 2000, Christoph Rohland wrote:
> > > 
> > > here is my first shot for cleaning up the shm handling. It did
> > > survive some basic testing but is not ready for inclusion.
> > 
> > The only comment I have right now is that you probably should not
> > mark the page dirty in "nopage" - theoretically somebody might have
> > a sparse mapping and depend on zero pages for the ones that aren't
> > touched. It's better to delay the dirty marking until swapout() (and
> > write(), when that is implemented), so that we don't needlessly
> > create swap entries for zero pages.
> 
> OK. I simply copied that from shm.c without thinking. Actually I do
> not yet understand the implications of it. (I never thought that I
> would get so deeply involved into these issues and still struggle
> often with the details)

Basically, a clean page will just get dropped by the VM, because it knows
it can always re-create the contents. 

So let's assume that you do a large mmap(MAP_SHARED) (or IPC shmem
mapping), and you populate your VM space with pages by just reading from
it. This is not common, but it does happen - things like sparse files
where just the fact that nothing has been written to a certain location is
information in itself.

Now, assume you run out of memory. With your current patch, we'd start
moving these zero-filled pages to the inode cache and write them out:
first we'd drop the entries from the page tables, then we'd call
"writepage()" to write the page to disk.

If, instead, you don't mark the page dirty immediately, but you wait until
somebody does a write, or until the VM layer informs you through the
"swapout()" function that somebody had a dirty page table entry, what
would happen is that (because nobody actually wrote to the page yet) it
would just get dropped from the VM space, and writepage() would never be
called.

> > Other than that the approach at least looks reasonable. And cleaner
> > than what we currently have.
> 
> Only reasonable? :-(

I did not have time to give it a good check, and "reasonable" is the
highest praise I'll give without having checked that there aren't any real
gotchas.

I certainly think that this is the right way to do things. I haven't had
time to check whether it's perfect.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
