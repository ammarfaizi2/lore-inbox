Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTHSS43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTHSSx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:53:58 -0400
Received: from mail.webmaster.com ([216.152.64.131]:44542 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261291AbTHSSv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:51:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <vda@port.imtp.ilyichevsk.odessa.ua>, "Mike Fedyk" <mfedyk@matchmail.com>,
       "Hank Leininger" <hlein@progressive-comp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Tue, 19 Aug 2003 11:51:50 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEKJFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200308190654.h7J6sIL07040@Port.imtp.ilyichevsk.odessa.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19 August 2003 01:39, David Schwartz wrote:

> > > And why not just catch the ones sent from the kernel?  That's
> > > the one that
> > > is killing the program because it crashed, and that's the one the
> > > origional
> > > poster wants logged...

> > 	Because sometimes a program wants to terminate. And it is
> > perfectly legal
> > for a programmer who needs to terminate his program as quickly
> > as possible
> > to do this:
> >
> > char *j=NULL;
> > signal(SIGSEGV, SIG_DFL);
> > *j++;

> > 	This is a perfectly sensible thing for a program to do with
> > well-defined
> > semantics. If a program wants to create a child every minute
> > like this and
> > kill it, that's perfectly fine. We should be able to do that in
> > the default
> > configuration without a sysadmin complaining that we're DoSing
> > his syslogs.

> I disagree. _exit(2) is the most sensible way to terminate.

	Read the documentation for _exit. You will see that it is useless in the
case of a portable program that needs to terminate as quickly as possible
and, in fact, isn't guaranteed to cause program termination at all:

       The function _exit is like exit(), but does not  call  any
       functions  registered with the ANSI C atexit function, nor
       any registered signal handlers. Whether it  flushes  stan-
       dard  I/O buffers and removes temporary files created with
       tmpfile(3)  is  implementation-dependent.   On  the  other
       hand, _exit does close open file descriptors, and this may
       cause an unknown delay, waiting for pending output to fin-
       ish.  If  the delay is undesired, it may be useful to call
       functions like tcflush() before calling _exit().   Whether
       any pending I/O is cancelled, and which pending I/O may be
       cancelled upon _exit(), is implementation-dependent.

	One major problem with _exit() is that it touches various structures. If
the program's execution environment is no longer trusted, calling _exit()
can cause an endless loop. In multithreaded programs, _exit() may need to
acquire mutexes. This can take an indeterminate amount of time. Portable
programs cannot rely on _exit() in a case where they need to terminate as
soon as possible.

	Now, if you have a better way for a portable program that needs to
terminate immediately to do so, that's fine, tell me what it is. Otherwise,
you are *forcing* people to DoS your syslog.

	DS


