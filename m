Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbUB2A0F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 19:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUB2A0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 19:26:05 -0500
Received: from mail.shareable.org ([81.29.64.88]:4997 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261949AbUB2AZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 19:25:59 -0500
Date: Sun, 29 Feb 2004 00:25:52 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
Message-ID: <20040229002552.GB1048@mail.shareable.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, I just committed the "add hidden d_type to the 32-bit getdents" thing, 
> and I'd like to have people verify that it works (I just verified that it 
> didn't break anything, but hey, nothing is using the data, so..)

I'd like to draw your attention to a patch posted earlier last century:

>> From: Jamie Lokier <lkd@tantalophile.demon.co.uk>
>> Date: Wed, 17 Nov 1999 22:56:56 +0100
>> Subject: [PATCH] dirent->d_type support
>>
>> I rejected adding a new system call.  Instead, I extended getdents() to
>> return data in a backward compatible way.  The d_type information as
>> placed at the end of each dirent record, and can be recognised
>> unambiguously.

:)

It got flamed by Alex Viro for being a useless feature so was lost in
the dismay.

(Btw, that patch also added support for reporting a useful d_type from
a large number of filesystems, some of which I think still don't have it
in the main kernel tree.)

I added d_type to dirent slightly differently, like this:

 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
+	/*
+	 * This, plus adding sizeof(long) to reclen, allows d_type to be
+	 * included in a backward & forward compatible way.
+	 */
+	if (type != DT_UNKNOWN) {
+		put_user(0, (unsigned char *) dirent + reclen - (1 + sizeof (long)));
+		put_user(type, (unsigned char *) dirent + reclen - 2);
+		put_user(0, (unsigned char *) dirent + reclen - 1);
+	}
+
 	((char *) dirent) += reclen;
 	buf->current_dir = dirent;

The idea is that you can unambiguously determine if a d_type byte is
included in the record without calling strlen(d_name), and in a way
that allows more data to be appended to the record in future, like
this:

#define D_TYPE(dent)							      \
  (((dent)->d_reclen > ((dent)->d_name - (char *) (dent) + sizeof (long))     \
    && !*((unsigned char *) (dent) + (dent)->d_reclen - (1 + sizeof (long)))) \
   ? *((unsigned char *) (dent) + (dent)->d_reclen - 2) : DT_UNKNOWN)

However, as there are no plans to ever add any more information to the
records from getdents(), your method is fine and of course it's much
simpler to use.

> On Thu, 26 Feb 2004, Jakub Jelinek wrote:
> > Because no 32-bit getdents syscall provides this field to userland,
> > glibc needs to use getdents64 syscall even for 32-bit getdents
> > (and readdir etc.) and convert dirent entries from struct dirent64
> > to struct dirent.  The code is quite complicated and as the former
> > is bigger and the size of 64-bit dirents cannot be predicted accurately,
> > it can happen that glibc reads too many entries and has to seek back
> > on the dir etc.
> 
> However, the more I look at the above, the more confused I get. Your 
> explanation simplty doesn't make any sense.
> 
> The thing is, it's _trivial_ to convert from the bigger format into the 
> smaller format. It would be much harder to convert the other way. What's 
> the problem with just using he getdents64 format and converting the data 
> in-place?

You can convert dirent64 to dirent in-place, and it gets smaller so
that isn't a cause for "read too many entries".  What can happen is
that Glibc reads too _few_ entries.  That doesn't cause lseek()
problems.

In Glibc 2.3.1's code, there's a more complicate heuristic that
sometimes reads more than can be returned to userspace, and thus has
to lseek(), but that's only used if it's running on an old kernel that
_doesn't_ have getdents64().

The problem with seeking back on the directory that Jakub mentions can
happen when Glibc uses getdents64() -- but it has nothing to do with
the structure sizes or running out of space.

What happens is that if getdents64() returns a d_ino or d_off value
which overflows the 32-bit fields returned to userspace, then Glibc
2.3.1 calls lseek() to go back just before that entry, and returns as
many entries as it could.

This is so that userspace sees all the entries that could be read
whose inodes and offsets fitted into 32 bits, and then sees EOVERFLOW
when it tries to read the next, overflowing entry.

-- Jamie
