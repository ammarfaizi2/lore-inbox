Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRCLOqe>; Mon, 12 Mar 2001 09:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130403AbRCLOqY>; Mon, 12 Mar 2001 09:46:24 -0500
Received: from mons.uio.no ([129.240.130.14]:61368 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S130383AbRCLOqP>;
	Mon, 12 Mar 2001 09:46:15 -0500
To: Leon Bottou <leonb@research.att.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Subtle NFS/VFS/GLIBC interaction bug
In-Reply-To: <3AA7EC55.E0020B8E@research.att.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 12 Mar 2001 15:45:27 +0100
In-Reply-To: Leon Bottou's message of "Thu, 08 Mar 2001 15:32:21 -0500"
Message-ID: <shsr903jbaw.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Leon Bottou <leonb@research.att.com> writes:

     > Note the strange numbers in the d_off fields.  These are in
     > fact cookies used internally by nfs.  Under nfs2, these are 32
     > bit unsigned number, sign extended to 64 bits.

     > The last cookie has not been properly sign extended.  The
     > glibc-2.2.2 source code for readdir uses __NR_getdents64 and
     > converts the result into 32 bit dirents.  But it sees that the
     > last d_ino cannot fit in an off_t and it simply bails out.

     > There is already a problem in the making since nfs3 cookies are
     > 64 bits long.  But things should work with nfs2.

This is why I wish glibc would drop the whole idea of relying on
seekdir/telldir existing. The LFS does in fact not specify any
equivalent seekdir64/telldir64, and most implementations of *NIX don't
support them.
Currently, the VFS only allows us to support the minimum
implementation which is required to support the 32-bit interface.

     > I can fix the problem using the following hack:

I've got a more complete one. See the 'IRIX' patch on

  http://www.fys.uio.no/~trondmy/src/2.4.2/linux-2.4.2-dir.dif

That patch also sign-extends 32-bit cookies at the NFS level, so that
we can
  a) convert cookies back so that the server accepts them
  b) match sign-extended 32-bit cookies in the page cache

     > That is acceptable as long as filldir_t does not handle 64bits
     > offsets anyway.

     > But it won't last.

Yes and no. All NFSv3 implementations are supposed to support 32-bit
client implementations. All you lose here is the ability to handle
multi-Gigabyte directories.

Cheers,
  Trond
