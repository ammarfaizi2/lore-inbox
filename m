Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSGQRoY>; Wed, 17 Jul 2002 13:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGQRoY>; Wed, 17 Jul 2002 13:44:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4101 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315942AbSGQRoX>; Wed, 17 Jul 2002 13:44:23 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Date: Wed, 17 Jul 2002 17:43:57 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ah4act$1n5$1@penguin.transmeta.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020717043853.GA31493@eskimo.com> <je65zel8pr.fsf@sykes.suse.de> <20020717164933.GA2136@eskimo.com>
X-Trace: palladium.transmeta.com 1026928021 21505 127.0.0.1 (17 Jul 2002 17:47:01 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Jul 2002 17:47:01 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020717164933.GA2136@eskimo.com>,
Elladan  <elladan@eskimo.com> wrote:
>
>Consider what this says, if a particular OS doesn't pick a standard
>which the application can port to.  It means that the *only way* to
>correctly close a file descriptor is like this:
>
>int ret;
>do {
>	ret = close(fd);
>} while(ret == -1 && errno != EBADF);

NO.

The above is
 (a) not portable
 (b) not current practice

The "not portable" part comes from the fact that (as somebody pointed
out), a threaded environment in which the kernel _does_ close the FD on
errors, the FD may have been validly re-used (by the kernel) for some
other thread, and closing the FD a second time is a BUG.

The "not practice" comes from the fact that applications do not do what
you suggest.

The fact is, what Linux does and has always done is the only reasonable
thing to do: the close _will_ tear down the FD, and the error value is
nothing but a warning to the application that there may still be IO
pending (or there may have been failed IO) on the file that the (now
closed) descriptor pointed to.

The application may want to take evasive action (ie try to write the
file again, make a backup, or just warn the user), but the file
descriptor is _gone_. 

>That means, if we get an error, we have to loop until the kernel throws
>a BADF error!  We can't detect that the file is closed from any other
>error value, because only BADF has a defined behavior.

But your loop is _provably_ incorrect for a threaded application.  Your
explicit system call locking approach doesn't work either, because I'm
pretty certain that POSIX already states that open/close are thread
safe, so you can't just invalidate that _other_ standard. 

		Linus
