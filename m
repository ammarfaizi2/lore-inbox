Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTJUL0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTJUL0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:26:49 -0400
Received: from dark.beer.net ([204.145.225.20]:18441 "EHLO dark.beer.net")
	by vger.kernel.org with ESMTP id S262927AbTJUL0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:26:48 -0400
Date: Tue, 21 Oct 2003 06:26:45 -0500 (CDT)
Message-Id: <200310211126.h9LBQjx4097592@dark.beer.net>
From: "Michael Glasgow" <glasgowNOSPAM@beer.net>
To: <linux-kernel@vger.kernel.org>
Subject: posix capabilities inheritance  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a simple setuid-root wrapper which sets some capabilities, 
gives up all other privs, and and then execs a shell.  I was hoping
to use this wrapper as a login shell so that I could have a user  
log in interactively with a small subset of elevated privileges.

Unfortunately after looking over the capabilities code in the 2.4
kernel, it would appear that this is not currently possible, and
my wrapper cannot work without filesystem support for capabilities.
And even then, I'd have to set each file's inheritable flag for the
capabilities I want on every executable that I am likely to run,
including the shell.  Am I mising something, or is this an accurate
description?

I think I understand the rationale behind this behavior; the draft
posix 1003.1e specification states:

     The purpose of assigning capability states to files is
     to provide the exec() function with information regarding
     the capabilities that any process image created with the
     program in the file is capable of dealing with and have
     been granted by some authority to use.

So, the lack of an inheritable flag on a file can serve to prevent
that file from executing with the corresponding capability enabled.

Fine, but what about my semi-superuser shell situation?  How can
I force the retention of a capability set across exec() for all
executables?  It would seem that neither the spec nor the current
implementation in the 2.4 kernel allow for this, but it strikes
me as a pretty reasonable and useful thing to do in some cases.

As an interim workaround, how about assuming all capabilities are
inheritable in fs/exec.c:prepare_binprm, i.e. instead of
cap_clear(bprm->cap_inheritable), call cap_set_full() ???  I don't
think this would break anything, and it would make capabilities a
lot more useful until we get fs support merged in.

-- 
Michael Glasgow < glasgow at beer dot net >
