Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132504AbRAQT2K>; Wed, 17 Jan 2001 14:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRAQT2B>; Wed, 17 Jan 2001 14:28:01 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:52486 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S132504AbRAQT1r>; Wed, 17 Jan 2001 14:27:47 -0500
Date: Wed, 17 Jan 2001 11:27:40 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David L. Parsley" <parsley@linuxjedi.org>
cc: Felix von Leitner <leitner@convergence.de>, <linux-kernel@vger.kernel.org>,
        <mingo@elte.hu>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <3A646322.B76A1661@linuxjedi.org>
Message-ID: <Pine.LNX.4.30.0101171118410.16292-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, David L. Parsley wrote:

> Felix von Leitner wrote:
> > >   close (0);
> > >   close (1);
> > >   close (2);
> > >   open ("/dev/console", O_RDWR);
> > >   dup ();
> > >   dup ();
> >
> > So it's not actually part of POSIX, it's just to get around fixing
> > legacy code? ;-)

it's part of POSIX.

> This makes me wonder...
>
> If the kernel only kept a queue of the three smallest unused fd's, and
> when the queue emptied handed out whatever it liked, how many things
> would break?  I suspect this would cover a lot of bases...

apache-1.3 relies on the open-lowest-numbered-free-fd behaviour... but
only as a band-aid to work around other broken behaviours surrounding
FD_SETSIZE.

when opening the log files, and listening sockets apache uses
fcntl(F_DUPFD) to push them all higher than fd 15.  (see ap_slack)  some
sites are configured in a way that there's thousands of log files or
listening fds (both are bogus configs in my opinion, but hey, let the
admin shoot themself).

this generally leaves a handful of low numbered fds available.  this
pretty much protects apache from broken libraries compiled with small
FD_SETSIZE, or which otherwise can't handle big fds.  libc used to be just
such a library because it used select() in the DNS resolver code.  (a libc
guru can tell you when this was fixed.)

it also ensures that the client fd will be low numbered, and lets us be
lazy and just use select() rather than do all the config tests to figure
out which OSs support poll().

it's all pretty gross... but then select() is pretty gross and it's
essentially the bug that necessitated this.

(solaris also has a stupid FILE * limitation that it can't use fds > 255
in a FILE * ... which breaks even more libraries than fds >= FD_SETSIZE.)

-dean



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
