Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTEKXex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 19:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEKXex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 19:34:53 -0400
Received: from lisa.JS.Jura.Uni-Goettingen.de ([134.76.166.209]:32161 "EHLO
	lisa.goe.net") by vger.kernel.org with ESMTP id S261506AbTEKXev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 19:34:51 -0400
Date: Mon, 12 May 2003 01:50:01 +0200
From: Bernhard Kaindl <bernhard.kaindl@gmx.de>
X-X-Sender: bkaindl@hase.a11.local
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
In-Reply-To: <200305111140_MC3-1-385D-EEF@compuserve.com>
Message-ID: <Pine.LNX.4.53.0305120119540.1572@hase.a11.local>
References: <200305111140_MC3-1-385D-EEF@compuserve.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283901862-1552911378-1052695740=:1572"
Content-ID: <Pine.LNX.4.53.0305120129100.1572@hase.a11.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1283901862-1552911378-1052695740=:1572
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.53.0305120129101.1572@hase.a11.local>

On Sun, 11 May 2003, Chuck Ebbert wrote:
> Carl-Daniel Hailfinger wrote:
> > Chuck Ebbert wrote:
> > >   I just found out minicom is spawing /sbin/lockdev which is setgrp
> > > 'lock'.  Would that cause ptrace failure??
> >
> > AFAIK that could have caused the failure. Please test 2.4.21-rc2 whcih
> > has fixes for many ptrace problems.
>
>   I can now strace minicom and its children with 2.4.21-rc2-ac1 but it
> hangs on exit.  Both child processes exit successfully:

Very strange, does this work with 2.4.20? What's your version of strace?

> However strace and minicom are hung up somehow and the screen is
> black with a blinking cursor at row 1 column 1.  The other ttys all
> work OK and killing minicom cleans everything up.

Hm, this sounds like there could be some error/loop opening the device,
which could be the effect of another side effect of the original ptrace
fix, which my fixes which are included in 2.4.21-rc2 don't fix.

This side effect causes that if a system call needs a module loaded,
it is not loaded and only an error from request_module() is sent to
the kernel log. The attached patch on top of 2.4.21-rc2, fixes this
remaining problem.

I'm not writing much info about it now, except that I think that it does
not open any securiy hole, but I would like to give it a little more
testing on SMP machines. On single CPU it fixed the "modprobe rejected"
problem fine for me, without sacrifying ptrace securitey.

I'm uncertain if it would help in your case.

In your first message, you wrote:

>   (BTW does minicom work for you on 2.5?  It fails with the "No child
> processes" message on 2.5.6x here but works on 2.4 when it's not being
> traced.  Just the very act of running it under strace on 2.4 makes it
> fail the same way it does on 2.5 here.  And stracing it on 2.5.66 made
> it start working again!  Something very strange is going on...)

Very strange, maybe a "tail minicom.trc.*" at the time when it's hanging
helps to get some idea.

Another note: suid is ignored when you are tracing the task which runs
exec() for a setuid program.

So if minicom relies on having the setgid gid of /sbin/lockdev honored
has in your case, the only ways I can find to get it working inder strace are:

- Change the locking config (temporary, for the debug) so that /sbin/lockdev
  does not need to be setgid.

- Don't have ptrace follow fork mode activated when forking the child
  which exec()'s /sbin/lockdev.

Bernd
--1283901862-1552911378-1052695740=:1572
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ptrace-kmod-2.4.21-rc2.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0305120129000.1572@hase.a11.local>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ptrace-kmod-2.4.21-rc2.diff"

LS0tIGxpbnV4LTIuNC4yMS1yYzIva2VybmVsL2ZvcmsuYw0KKysrIGxpbnV4
LTIuNC4yMS1yYzItYmsxL2tlcm5lbC9mb3JrLmMNCkBAIC01NzIsMjEgKzU3
MiwxMyBAQA0KIAl1bnNpZ25lZCBvbGRfdGFza19kdW1wYWJsZTsNCiAJbG9u
ZyByZXQ7DQogDQotCS8qIGxvY2sgb3V0IGFueSBwb3RlbnRpYWwgcHRyYWNl
ciAqLw0KLQl0YXNrX2xvY2sodGFzayk7DQotCWlmICh0YXNrLT5wdHJhY2Up
IHsNCi0JCXRhc2tfdW5sb2NrKHRhc2spOw0KLQkJcmV0dXJuIC1FUEVSTTsN
Ci0JfQ0KLQ0KLQlvbGRfdGFza19kdW1wYWJsZSA9IHRhc2stPnRhc2tfZHVt
cGFibGU7DQorCS8qIGxvY2sgb3V0IGFueSBwb3RlbnRpYWwgcHRyYWNlciBm
b3IgdGhlIG5ldyB0YXNrX3N0cnVjdCBjb3B5ICovDQogCXRhc2stPnRhc2tf
ZHVtcGFibGUgPSAwOw0KLQl0YXNrX3VubG9jayh0YXNrKTsNCiANCiAJcmV0
ID0gYXJjaF9rZXJuZWxfdGhyZWFkKGZuLCBhcmcsIGZsYWdzKTsNCiANCiAJ
LyogbmV2ZXIgcmVhY2hlZCBpbiBjaGlsZCBwcm9jZXNzLCBvbmx5IGluIHBh
cmVudCAqLw0KLQljdXJyZW50LT50YXNrX2R1bXBhYmxlID0gb2xkX3Rhc2tf
ZHVtcGFibGU7DQorCXRhc2stPnRhc2tfZHVtcGFibGUgPSBvbGRfdGFza19k
dW1wYWJsZTsNCiANCiAJcmV0dXJuIHJldDsNCiB9DQo=

--1283901862-1552911378-1052695740=:1572--
