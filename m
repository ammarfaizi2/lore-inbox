Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbSJPV3g>; Wed, 16 Oct 2002 17:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbSJPV3g>; Wed, 16 Oct 2002 17:29:36 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:17937 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S261431AbSJPV3f>; Wed, 16 Oct 2002 17:29:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: can chroot be made safe for non-root?
Date: 16 Oct 2002 21:18:00 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aokl28$955$2@abraham.cs.berkeley.edu>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> <87n0pevq5r.fsf@ceramic.fifi.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1034803080 9381 128.32.153.211 (16 Oct 2002 21:18:00 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 16 Oct 2002 21:18:00 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin  wrote:
>Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net> writes:
>> Would it be reasonable to allow non-root processes to chroot(), if the
>> chroot syscall also changed the cwd for non-root processes?
>
>No.
>
>  fd = open("/", O_RDONLY);
>  chroot("/tmp");
>  fchdir(fd);
>
>and you're out of the chroot.

Irrelevant.  If a process *wants* to voluntarily sandbox itself, it can
close all open file descriptors before sandboxing.

Please note that
  chroot("/tmp");
  fd = open("/", O_RDONLY);
  fchdir(fd);
does *not* let you escape from the sandbox.  This means that a process
can sandbox itself, and once sandboxed, it can no longer escape.
This functionality would be very useful for security purposes (see, e.g.,
"privilege separation").

It is true that there are some tricky issues here.  For instance, root
has many ways to escape from a chroot() jail, so you should never use
chroot() to confine processes running as root.  Also, if non-root users
can call chroot(), then there may be bad interactions if the chroot-ed
process later calls chroot() again, or execs a setuid program.

However, I believe all of these tricky issues can be dealt with.  See, e.g.,
  http://www.cs.berkeley.edu/~smcpeak/cs261/index.html
