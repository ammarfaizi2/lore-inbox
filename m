Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269197AbRHRWxB>; Sat, 18 Aug 2001 18:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRHRWwv>; Sat, 18 Aug 2001 18:52:51 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:48103 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S269099AbRHRWwm>;
	Sat, 18 Aug 2001 18:52:42 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: PROBLEM: select() says closed socket readable
Date: Sat, 18 Aug 2001 22:52:42 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <200108181627.UAA19351@ms2.inr.ac.ru>
NNTP-Posting-Host: quasar.home.lunix
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 998175162 17787 10.0.0.20 (18 Aug 2001 22:52:42
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sat, 18 Aug 2001 22:52:42 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:107163
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9lmrjq$hbr$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200108181627.UAA19351@ms2.inr.ac.ru>,
	kuznet@ms2.inr.ac.ru writes:
> Hello!
>
>> For linux 2.4.2, select() indicates socket ready for read on a
>> socket that's never been connected.
>
> Right. It does not block on read, hence it is readable.
>

mm, that's not really the rule, since e.g. you want to be able to select
on read and write on the write side of a pipe, and would expect to only
get readable on error/close:

But there's weird stuff going on here (examples need perl >= 5.6.0):

perl -wle 'use POSIX; pipe(my $rd, my $wr)||die $!; my $fd = fileno($wr); my $mask=""; vec($mask, $fd, 1)=1; select(my $r=$mask, my $w=$mask, "", undef); print "readable" if vec($r, $fd, 1); print "writable" if vec($w, $fd, 1); my $rc = POSIX::read($fd, my $buf, 4096) || die "read returns $!"; print STDERR $rc'

prints:

writable
read returns Bad file descriptor at -e line 1.

Which is in fact weird, since I still have the $rd descriptor around, so
the read should block (it does on solaris). This seems a bug.

perl -wle 'use POSIX; pipe(my $rd, my $wr)||die $!; close $rd; my $fd = fileno($wr); my $mask=""; vec($mask, $fd, 1)=1; select(my $r=$mask, my $w=$mask, "", undef); print "readable" if vec($r, $fd, 1); print "writable" if vec($w, $fd, 1); my $rc = POSIX::read($fd, my $buf, 4096) || die "read returns $!"; print STDERR $rc'

prints:

readable
writable
read returns Bad file descriptor at -e line 1.

Which is the behaviour you want (the read does not block in either case),
closing the other side causes readability. This allows you to watch a
connection for errors without being bothered by EOF (so it's good, but
contrary to your statement).
However, the reaction on read is still weird. on solaris I get in fact EOF,
not Bad file descriptor

In fact, somewhat related, i last week ran into this:

perl -wle 'use Socket; use POSIX; socketpair(my $rd, my $wr, AF_UNIX, SOCK_STREAM, PF_UNSPEC)||die $!; shutdown($rd, 1); shutdown($wr, 0); my $fd = fileno($wr); my $mask=""; vec($mask, $fd, 1)=1; select(my $r=$mask, my $w=$mask, "", undef); print "readable" if vec($r, $fd, 1); print "writable" if vec($w, $fd, 1); my $rc = POSIX::read($fd, my $buf, 4096) || die "read returns $!"; print STDERR $rc'

which prints:

readable
writable
0 but true

(so the read returns EOF). Which is very unfortunate, because it means a
pipe is not equivalent to a socketpair where you make one side only
readable and one only writable (the way it's supposedly implemented on
some OSes) Solaris and freebsd behaves the same as linux by the way.
On the other hand, you *do* want to know if the other side does a
shutdown, so in that sense the behaviour is good.

Damn, i wish this socket stuff would finally get completely standardized.
