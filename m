Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269820AbRHDRff>; Sat, 4 Aug 2001 13:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269825AbRHDRfY>; Sat, 4 Aug 2001 13:35:24 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:29109 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S269820AbRHDRfL>; Sat, 4 Aug 2001 13:35:11 -0400
Date: Sat, 4 Aug 2001 13:35:00 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804133500.F22090@cs.cmu.edu>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Mason <mason@suse.com>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010804100143.A17774@weta.f00f.org>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 10:01:43AM +1200, Chris Wedgwood wrote:
> On Fri, Aug 03, 2001 at 06:34:14PM +0000, Linus Torvalds wrote:
> 
>     	fsync(int fd)
>     	{
>     		dentry = fdget(fd);
>     		do_fsync(dentry);
>     		for (;;) {
>     			tmp = dentry;
>     			dentry = dentry->d_parent;
>     			if (dentry == tmp)
>     				break;
>     			do_fdatasync(dentry);
>     		}
>     	}
> 
> I really like this idea. Can people please try out the attached patch?

Deadly for Coda, every fsync triggers an upcall to userspace, which
costs at least 2 context switches and a whole bunch of network traffic
as updates are sent back to the server, i.e. the fact that some parent
has a new child or timestamp is not related to or interesting for this
delivery.

The existing fsync(dir) is far better and the reasons are simple and
explained multiple times throughout this far too long thread. So let me
reiterate.

- fsync(dir) is an _explicit_ indication by an application that actually
  cares what precisely needs to be written to disk.
- fsync(dir) doesn't negatively affect applications that don't care.
- The proposed patch doesn't solve the 'oops I relinked the file, or I
  renamed a parent' problems where the path leading to a file is lost
  anyways. And the relinking is exactly what is done by both qmail and
  cyrus imap, i.e. this patch wouldn't even solve the problem that is
  being discussed.
- fsync(dir) doesn't write out anymore that has to be written, i.e. a
  open/unlink in a temporary directory doesn't need to hit the disk if
  there is an fsync in the middle (see qmail/cyrus syscall paths in a
  previous email)
- We don't need to modify the code to make fsync(dir) work! If it turns
  out to be too slow, let's fix fsync(dir) to be more efficient.

Jan

