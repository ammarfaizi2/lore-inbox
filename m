Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTCEJEm>; Wed, 5 Mar 2003 04:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTCEJEm>; Wed, 5 Mar 2003 04:04:42 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:61333 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S264908AbTCEJEh>; Wed, 5 Mar 2003 04:04:37 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: reducing stack usage in v4l?
Date: 05 Mar 2003 10:15:52 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87u1eigomv.fsf@bytesex.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1046855752 16998 127.0.0.1 (5 Mar 2003 09:15:52 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> Hi,
> 
> I was looking at stack usage in drivers/media/video/v4l1-compat.c::
> v4l_compat_translate_ioctl().  It's 0x924 bytes on my peecee.

Whoops.  Hmm.  I assumed having the variable declarations within the
case blocks where they are actually used helps to keep the stack size
small, i.e. use this ...

        do_ioctl()
        {
                switch (cmd)
                case FOO:
                {
                        struct foo;
                        ...
                }
                case BAR:
                {
                        struct bar;
                        ...
                }
                ...
        }

... instead of this:

        do_ioctl()
        {
                struct foo;
                struct bar;

                switch (cmd) {
                        ...
                }
        }

But when looking at the disasm output it is obvious that it isn't true
(at least with gcc 3.2).  On the other hand it is common practice in
many drivers, there must be a reason for that, no?  Any chance this
used to work with older gcc versions?

> It's fairly straightforward to change the stack space to
> kmalloc() space, but some of these functions (ioctls) are
> speed-critical, so I was wondering if the changes should still
> be done, or done only in some cases and not others, or wait
> until an oops is reported here....

Although v4l_compat_translate_ioctl() is probably one of the worst
offenders, this issue likely exists for lots of other ioctl functions
too: Lot of stack space is allocated but never used because the
variables for all cases are allocated but only one of the switch cases
actually runs ...

Not sure what is the best idea to fix that.  Don't like the kmalloc
idea that much.  The individual structs are not huge, the real problem
is that many of them are allocated and only few are needed.  Any
chance to tell gcc that it should allocate block-local variables at
the start block not at the start of the function?

  Gerd

-- 
/join #zonenkinder
