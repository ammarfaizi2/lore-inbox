Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTIMIXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 04:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbTIMIXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 04:23:41 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:23545 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262074AbTIMIXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 04:23:39 -0400
Message-ID: <1aba01c379d0$4d061ab0$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Date: Sat, 13 Sep 2003 17:22:16 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although I can't keep up with the mailing list, I saw this from Adrian Bunk:
> On Thu, Sep 11, 2003 at 04:04:48PM -0700, Tom Rini wrote:
> >
> > Okay.  The following Kconfig illustrates what I claim to be a bug.
> > config A
> > bool "This is A"
> > select B
> > config B
> > bool "This is B"
> > # Or, depends C=y
> > depends C
> > config C
> > bool "This is C"
> >
> > Running oldconfig will give:
> > This is A (A) [N/y] (NEW) y
> > This is C (C) [N/y] (NEW) n
> > And in .config:
> > CONFIG_A=y
> > CONFIG_B=y
> > # CONFIG_C is not set

This is a problem.  Proposed solution follows later.

> > I claim that this should in fact be:
> > CONFIG_A=y
> > CONFIG_B=y
> > CONFIG_C=y

Even for this simple case, there are other possibilities.  When we add human
logic to the specified sequence of events then we can say that your
interpretation is most likely what the user wanted, but in ordinary logic
there are other possibilities such as n, n, n.  Proposed solution follows.

> The problem is that select ignores dependencies.
> Unfortunately, your proposal wouldn't work easily, consider e.g.
> config A
> bool "This is A"
> select B
> config B
> bool
> depends C || D
> config C
> bool "This is C"
> depends D=n
> config D
> bool "This is D"
> Do you want C or D to be selected?

If neither is selected, then the problem is essentially the same as the one
which Mr. Rini pointed out.  And again there are other possible
possibilities such as n, n, n, n.

Solution:  Surely plain "make" could start by checking dependencies.  Or
maybe "make dep" could be reincarnated.  If there is any inconsistency, then
the Makefile could issue an error and refuse to start compiling.

This has the added benefit that if the human has some reason to edit the
.config file by hand instead of using a make [...]config command, plain
"make" will have a chance of catching editing errors.

This doesn't automate a solution as thoroughly as either of you were hoping
for; it honestly admits that it can't read the human's mind  :-)

