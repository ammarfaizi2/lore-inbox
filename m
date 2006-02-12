Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWBLOlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWBLOlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 09:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWBLOlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 09:41:45 -0500
Received: from mx.meyering.net ([82.230.74.64]:19109 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1750733AbWBLOlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 09:41:44 -0500
From: Jim Meyering <jim@meyering.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "'austin-group-l@opengroup.org'" <austin-group-l@opengroup.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: The naming of at()s is a difficult matter
In-Reply-To: <43EEACA7.5020109@zytor.com> (H. Peter Anvin's message of "Sat,
	11 Feb 2006 19:33:59 -0800")
References: <43EEACA7.5020109@zytor.com>
Date: Sun, 12 Feb 2006 15:41:36 +0100
Message-ID: <87oe1cmyfz.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:
> I have noticed that the new ...at() system calls are named in what
> appears to be a completely haphazard fashion.  In Unix system calls,
> an f- prefix means it operates on a file descriptor; the -at suffix (a
> prefix would have been more consistent, but oh well) similarly
> indicates it operates on a (directory fd, pathname) pair.
>
> However, some system calls, in particular fchownat, futimesat,
> fchmodat and faccessat add the f- prefix for what appears to be
> absolutely no good reason.  Logically, these system calls should be
> named chownat, utimesat, chmodat, and accessat.
>
> I understand some of this braindamage comes from Solaris, but some of
> these calls do not.  We should avoid it if at all possible, and I
> would recommend at least introducing aliases with the sane names.

This has bothered me, too.
But what would the semantics be?  Using an alias named `chownat'
to get lchown-like functionality (with the AT_SYMLINK_NOFOLLOW flag)
seems undesirable.

If we're considering aliases,
then how about a pair of `f'-less names for each of the f*at
names.  E.g., chownat and lchownat corresponding to the use (or not)
of AT_SYMLINK_NOFOLLOW in the last parameter of an fchownat function call.

Here's some code from coreutils/lib/openat.h:

  /* Using these function names makes application code
     slightly more readable than it would be with
     fchownat (..., 0) or fchownat (..., AT_SYMLINK_NOFOLLOW).  */
  static inline int
  chownat (int fd, char const *file, uid_t owner, gid_t group)
  {
    return fchownat (fd, file, owner, group, 0);
  }

  static inline int
  lchownat (int fd, char const *file, uid_t owner, gid_t group)
  {
    return fchownat (fd, file, owner, group, AT_SYMLINK_NOFOLLOW);
  }

  static inline int
  chmodat (int fd, char const *file, mode_t mode)
  {
    return fchmodat (fd, file, mode, 0);
  }

  static inline int
  lchmodat (int fd, char const *file, mode_t mode)
  {
    return fchmodat (fd, file, mode, AT_SYMLINK_NOFOLLOW);
  }

[Note that afaik, faccessat is available only in glibc so far. ]
Unfortunately, this doesn't generalize as well to faccessat,
which has four (not just two) possible values of its last parameter.
Those correspond to settings of the AT_SYMLINK_NOFOLLOW and AT_EACCESS
bits.  AT_EACCESS means faccessat checks for access by the effective IDs
rather than by the real IDs.

With faccessat, we'd need 4 different names, e.g.,

  elaccessat or leaccessat
  ulaccessat or luaccessat
  eaccessat
  uaccessat

Personally, I do find it easier to read names like lstatat and statat
with only one extra argument (the file descriptor) than fstatat (...
with 0 or AT_SYMLINK_NOFOLLOW.  With fstatat uses, it seems like I always
have to convert mentally that the presence of AT_SYMLINK_NOFOLLOW means
that a particular use acts like lstat.
