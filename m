Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268911AbRHBMyo>; Thu, 2 Aug 2001 08:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268919AbRHBMyZ>; Thu, 2 Aug 2001 08:54:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32321 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268911AbRHBMyS>; Thu, 2 Aug 2001 08:54:18 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Christoph Hellwig <hch@ns.caldera.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>, <sct@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <Pine.LNX.4.33L.0108020655530.5582-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Aug 2001 06:47:40 -0600
In-Reply-To: <Pine.LNX.4.33L.0108020655530.5582-100000@duckman.distro.conectiva>
Message-ID: <m1y9p2y6fn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Thu, 2 Aug 2001, Christoph Hellwig wrote:
> 
> > > Well, if there's not a single dirent, you cannot retrieve the data,
> >
> > Of course you can, you can pass and fd for an unliked file
> > everywhere using AF_LOCAL descriptor passing.
> 
> But this assumes the system doesn't crash, while
> fsync() seems meant more as a protection against
> the system going down unexpectedly ...

There is something to that.  However taking this argument to
it's logical extreme I have you have to not only sync every directory
in the current path of the file.  You have to sync your online file
index, because search engines is how we find things right?  

Since the filename in unix is not part of the files metadata it is a
perfectly sane semantic for fsck to drop the file into /lost+found, if
no one cared enough about the index/directory to update it.

In the general case if you have the guarantee that a filesystem does
safe directory updates.  So unless someone does an unlink you won't
loose your old link.  For most cases it doesn't matter as your
directory entry for the file is much older than the file itself, and
has been already synched.  MTA's are the exception to this where there
good filename is written only after the file is written.

The only other argument that seems to come from the MTA case is that
syscalls are slow, and a pain and programmers don't want to make two
or three syscalls just to do this.  Heck if you are doing a sync you
are waiting for a disk which is slow.  So speed doesn't really count.

There is probably an argument in there somewhere about batching up
I/O, so you have to wait a minimum amount of time for your sync.  But
until someone benchmarks, and tries a few different approatches I
won't believe that you need a kernel change even for that.

My question is what does fsync do on directories in other unix's.  It
would be really strange if it didn't behave similiarly to linux.
If forget wether it was AIX or HP-UX where doing a grep foo * would
also grep through "." .  So at least open works on other peoples directores.

Eric
