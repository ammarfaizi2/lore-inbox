Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136110AbRBFAYM>; Mon, 5 Feb 2001 19:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136105AbRBFAYB>; Mon, 5 Feb 2001 19:24:01 -0500
Received: from gateway.sequent.com ([192.148.1.10]:15996 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S136063AbRBFAXv>; Mon, 5 Feb 2001 19:23:51 -0500
Message-Id: <200102060022.QAA13622@eng4.sequent.com>
To: linux-kernel@vger.kernel.org
Subject: locking question
Date: Mon, 05 Feb 2001 16:22:34 -0800
From: Rick Lindsley <nevdull@sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of better understanding some of the issues in SMP,
I've been working at documenting all the global kernel locks in use,
including what's left of the BKL, and have run into a use of the BKL
that seems pretty consistent and also pretty obscure.

The code base I'm inspecting is 2.4.0-test8. (Yes I know that's out of
date, but I had to take a snapshot *somewhere*!)

For those drivers which define a struct file_operations->release
function, I'm seeing that that function often calls lock_kernel()
at the beginning and unlock_kernel() at the end. (A simple example
can be found in arch/m68k/mvme16x/rtc.c.)  Various functions perform
various feats, but I can't for the life of me figure out what it is
guarding. In the example above, if it is guarding rtc_status, why
in the rtc_open function (directly above it) are there no locks held?
It often seems the case that things modified in the release() function
are left unguarded elsewhere. And in most cases, it seems that the BKL
is probably unnecessary (a local lock would accomplish the same.)

I'm slowly coming to the conclusion that either
    
    a) there is a global assumption (or need) in place that I can't get
       my hands around, or

    b) people have copied drivers as templates for so long that the only
       reason they grab the lock there is because the person before them
       did, or
    
    c) some other driver-specific reason.

Can somebody tell me what we're guarding against here? Why is it safe
to use the "guarded" data elsewhere (apparently) without the lock?

Rick
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
