Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUDSHgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 03:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUDSHgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 03:36:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:55454 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263653AbUDSHgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 03:36:00 -0400
Subject: siginfo & 32 bits compat, what is the story ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082360155.1677.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 17:35:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks !

So I've been playing around the siginfo copy code for 32 bits
processes on ppc64 and found some interesting stuffs that I don't
know how to fix at this point.

So I rewrote the routine copying a siginfo to a 32 bits one in
a way that is similar to s390 (that's part of the ppc64 message
queue patch I sent earlier). However, I just noticed we also do
the opposite conversion for the sys32_rt_sigqueueinfo syscall,
and we do it "the old way" (based on signal number, which is
apparently incorrect).

Now my question: What to copy ? I suppose I need at least to
be consistent between the 2 functions between what is done for
a userland siginfo. Right now, I am not. I followed Stephen
suggestions and I'm copying the whole padding after the first
3 fields in the 64 -> 32 bits copy, but the opposite conversion
function that I just noticed will explicitely copy/convert some
fields (si_pid, si_uid and si_int).

I looked at x86-64, and they always copy/convert those 3 fields,
never copy the rest of the siginfo. I looked at s390 and they do
the opposite: just copy the rest of the structure...

So I suppose I need to choose between those 2 methods and be
consistent between the 32->64 and 64->32 routines, but which one ?

Ben.


