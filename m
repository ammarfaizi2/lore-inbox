Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTKGWCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTKGWB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:01:28 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:47365 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264453AbTKGQVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 11:21:06 -0500
Subject: lib.a causing modules not to load
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Nov 2003 10:21:04 -0600
Message-Id: <1068222065.1894.21.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this has been mentioned before, but I just ran across it again
recently.  The problem is that if the only reference to a routine in
lib.a is in a module, then it never gets compiled into the kernel, and
the module won't load.

In 2.6.0-test9 this is shown by compiling both ext2 and ext3 as
modules.  Since they're the only things to refer to percpu_counter_mod
which is in lib.a in an SMP system.

The quickest hack I could think of (attached below) was to make ext2
(and ext3 although I didn't code that) incorporate vestigial code into
the discarded init section of the kernel which forces a reference to
percpu_counter_mod and thus makes the kernel pull the required routine
out of lib.a

However, I think the best approach would be, after the kernel has built,
to build the non-included routines of lib.a as individual modules which
would then be pulled in by the module dependency rules.

Unless anyone has a better idea (or has already done something about
this problem), I'll look at doing the latter.

James


