Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274102AbRJDPKa>; Thu, 4 Oct 2001 11:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274133AbRJDPKU>; Thu, 4 Oct 2001 11:10:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9522 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274102AbRJDPKN>; Thu, 4 Oct 2001 11:10:13 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110032247190.7649-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Oct 2001 09:01:03 -0600
In-Reply-To: <Pine.LNX.4.33.0110032247190.7649-100000@penguin.transmeta.com>
Message-ID: <m1n137zbyo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Thu, 4 Oct 2001, Alexander Viro wrote:
> > <nit>
> > I _really_ doubt that something does write() on /etc/passwd.  Create a
> > file and rename it over the thing - sure, but that's it.
> > </nit>
> 
> Well, yeah, bad choice. Can you believe /var/run/utmp or similar?
> 
> And yes, we could add checks for the thing being executable before we
> accept MAP_DENYWRITE instead of just ignoring the flag from user space.
> Nobody has cared enough to make the effort.
> 
> Until now?

Hmm.  Before I volunteer I need to think this thing out.  I orginally
missed the clearing of MAP_DENYWRITE in the arch specific code.  

First what user space really wants is the MAP_COPY.  Which is
MAP_PRIVATE with the guarantee that they don't see anyone else's changes.  

Just skimming /lib most libraries are only rw by root so the case we
are protecting ourselves against is fumble fingered administrators.
The two fumbles in particular are fumbling the permissions, and
accidentaly writing to a shared library.

given that MAP_DENYWRITE does remove unlink permission for most uses it
can be worked around.  

We already allow user space applications to make arbitrary files
MAP_DENYWRITE simply by executing them, and the only restriction is
that MAP_DENYWRITE only persists while user space has the file open.
So I guess allowing it in mmap is not actually a problem, as we can
already do that. 

At the same time there are cases where it is unacceptable to stop
people from writing to a file just because you have read access to it,
and you open the file.  Even having write access to a file isn't
enough.  So you really need to have execute and read permissions on a
file for this to be reasonable.

The one downside of requiring libraries to be executable is that
tricks like preventing. /lib/ld-linux.so.2 /mnt/noexec/bin/true is
a little harder.  

A remaining question was for newer kernels should MAP_DENYWRITE fail
if you don't have execute permissions, or should it just be a strong
hint.

Having MAP_DENYWRITE fail on filesystems that are mounted noexec and
having a dynamic loader that tests looks like it would be easier to
enforce a noexec policy for untrusted mounts.

So the code will need to look something like.
if (flags & MAP_DENYWRITE) {
	struct inode *inode = file->f_dentry->inode;
	if (IS_NOEXEC(inode) || !ISREG(inode->i_mode) || 
		(permission(inode, MAY_EXEC) != 0)) {
		return -EACCESS;
        }
}


Eric
