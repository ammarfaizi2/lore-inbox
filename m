Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSHJF6z>; Sat, 10 Aug 2002 01:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHJF6z>; Sat, 10 Aug 2002 01:58:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51718 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316599AbSHJF6z>;
	Sat, 10 Aug 2002 01:58:55 -0400
Message-ID: <3D54AED6.708F247F@zip.com.au>
Date: Fri, 09 Aug 2002 23:12:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <3D548E3D.4F8DC107@zip.com.au> <Pine.LNX.4.44.0208092046430.1354-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> > We'll need need to manually fault in the user page on the
> > generic_file_read() path before taking the kmap, because reading
> > into an unmapped page is a common case: malloc/read.
> 
> I actually suspect that most reads are fairly small, and the page already
> exists. But who knows.. pre-loading is certainly easy (a single
> instruction).

These things can be measured ;)

Across a `make -j6 bzImage' the kernel reads 166,000 pages via
file_read_actor().  And 31,000 of those generated a fault in
the copy_*_user.  (It wrote 14,400 pages and, of course, none
of those faulted).

And if gcc is getting a fault 20% of the time, some other apps will
get many more.  Which implies that we must prefault the page in
file_read_actor to get full benefit.

And if we do that, I'll bet you Victor's dollar that the fixup path
is never executed.   I'd have to disable the prefault even to be able
to test it.

What would be nice is a way of formalising the prefault, to pin
the mm's pages across the copy_*_user() in some manner, perhaps?
