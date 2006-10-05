Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWJEX4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWJEX4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWJEX4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:56:03 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:15807 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932436AbWJEX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:56:00 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Thu, 5 Oct 2006 23:55:48 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eg4624$be$1@taverner.cs.berkeley.edu>
References: <200610052059.11714.mb@bu3sch.de>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1160092548 366 128.32.168.222 (5 Oct 2006 23:55:48 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Thu, 5 Oct 2006 23:55:48 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch  wrote:
>Is is really a good idea to allow processes to remap something
>to address 0?
>I say no, because this can potentially be used to turn rather harmless
>kernel bugs into a security vulnerability.

Let me see if I understand.  If the kernel does this somewhere:

    struct s *foo;
    foo->x->y = 0;

and if there is some way that userland code can cause this to be
executed with 'foo' set to a NULL pointer, then user-land code can
do this:

    mmap(0, 4096, PROT_READ|PROT_EXEC|PROT_WRITE,
        MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
    struct s *bar = 0;
    bar->x = ... whatever ...;

An attacker could execute this user-land code and then invoke the
kernel in a way that causes the above kernel statement to be executed
with foo==NULL.  The result will effectively be as though the kernel
executed the statement '*whatever = 0;', where 'whatever' can be
completely controlled by the attacker.

In other words, the consequences of the buggy kernel code listed above
is that an attacker can choose any location in memory (of his choice,
including code that is within kernel space) and set it to zero.

If this is correct so far, this sounds pretty dangerous.  For instance,
the above hypothetical scenario would be enough to allow an attacker
to set his euid to zero by overwriting the euid field in the process
structure maintained by the kernel.  That would mean that a NULL pointer
bug in the kernel might allow an attacker to gain root.  That would
mean that every NULL pointer dereference bug is potentially security
critical.  If so, we'd better be pretty darn careful to make sure we've
eliminated all NULL pointer bugs in the kernel.

Is this right?  Have I correctly understood the issue?
