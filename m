Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRIANIM>; Sat, 1 Sep 2001 09:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270721AbRIANIC>; Sat, 1 Sep 2001 09:08:02 -0400
Received: from [213.98.126.44] ([213.98.126.44]:32405 "HELO trasno.mitica")
	by vger.kernel.org with SMTP id <S270705AbRIANH6>;
	Sat, 1 Sep 2001 09:07:58 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <Pine.GSO.4.21.0108311558430.15931-100000@weyl.math.psu.edu>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.4.21.0108311558430.15931-100000@weyl.math.psu.edu>
Date: 01 Sep 2001 15:08:18 +0200
Message-ID: <m2y9nzjby5.fsf@mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "alexander" == Alexander Viro <viro@math.psu.edu> writes:


Hi

viro> What we need is a "I want rw access to fs"/"I give up rw access"/"make
viro> it ro" set of primitives.  Unfortunately, it's even more compilcated -
viro> e.g. fs may stomp its foot and set MS_RDONLY in ->s_flags (e.g. upon
viro> finding an error if it has such policy).  That DOESN'T look for files
viro> opened for write (reasonable) and DOESN'T revoke write access to them.

I really will like that thing for supermount, supermount tries to do
that thing by hand, and it really fails because it is difficult,
supermount tries to have the underlying fs unmounted if nobody has
open files on it, and mounted rw only when somebody has a file opened
on it and if someone has a file opened for write of there is happening
any operation that needs write access.  As we don't have an easy way
to check if we are able to write in one filesystem (we can only use
the IS_RDONLY() macro), it happens that I have to mount the filesystem
rw for being able to call permission in that filesystem.  Notice that
permission don't need write access per se, but the IS_RDONLY() macro
needs to have the filesystem mounted rw to fail.  Yes, I can hack the
macro to do the things that I need, but that means that everybody that
needs that functionality will have to also hack it :(

viro> Again, the main issue here is what do we want, not how to implement it.
viro> Flame away.

I will want a method is the inode/super_block (don't care which of
them) for:
      - is_read_only_fs()?
          Notice that this method told as if we are able to have the
          fs rw, not necessarily that the fs is rw at the moment.
      - get_write_access()
      - put_write_access()

Notice that there exist the functions get_write_access() and
put_write_access() functions in the tree, and I will be really happy if
there where a way to hook fs specific information there, as it will
make a lot of the code in supermount really easy, and the same for
other fs that need similar semantics.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
