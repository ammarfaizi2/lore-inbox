Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270999AbRIJQ7P>; Mon, 10 Sep 2001 12:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271085AbRIJQ7E>; Mon, 10 Sep 2001 12:59:04 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:16532 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S270999AbRIJQ6w>; Mon, 10 Sep 2001 12:58:52 -0400
Message-ID: <3B9CF178.333B11BE@kegel.com>
Date: Mon, 10 Sep 2001 09:59:36 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd.Suessmilch@SWAROVSKI.COM,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: 2.4.x, mlockall() and pthreads: exceptionally huge memory demands
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd.Suessmilch@SWAROVSKI.COM wrote:
> I have written an application that uses mlockall() in conjunction
> with posix-threads. I realized that under Kernel 2.4.x (tested
> on 2.4.5-pre1 and 2.4.10-pre6, pentium III, no swap) each thread
> consumes an exceptionally huge amount of memory (about 2MB).
> When I omit the mlockall()-call each thread consumes only about
> 24KB.
> Running the same application under kernel 2.2.x  each thread
> consumes about 12KB of memory (with memory locked).
> The attached program illustrates this behavior. 
> 
> May this be a bug in the mlockall() implementation of 2.4.x and is
> this behavior already known (I found no hint in the archive)?

First - this is a glibc issue, not a kernel issue, I bet.
Second - the new behavior seems allowed by the standard, if not desirable.
Portably speaking, the default stack size for a thread may be quite large.
If you want to consume less memory, either configure the threads to use a 
smaller stack with pthread_attr_setstacksize() (I haven't tried this), 
or use fewer threads (my favorite approach).

Third - the old behavior is hinted by 
http://pauillac.inria.fr/~xleroy/linuxthreads/faq.html
(see below) so perhaps there's a problem with newer glibc's?
- Dan

"E.5: Does LinuxThreads implement pthread_attr_setstacksize() and pthread_attr_setstackaddr()?

These optional functions are provided in recent versions 
of LinuxThreads (0.8 and up). Earlier releases did not provide 
these optional components of the POSIX standard.

Even if pthread_attr_setstacksize() and pthread_attr_setstackaddr() 
are now provided, we still recommend that you do not use them 
unless you really have strong reasons for doing so. The default 
stack allocation strategy for LinuxThreads is nearly optimal: 
stacks start small (4k) and automatically grow on demand to a 
fairly large limit (2M). 
Moreover, there is no portable way to estimate the stack requirements 
of a thread, so setting the stack size yourself makes your program 
less reliable and non-portable."
