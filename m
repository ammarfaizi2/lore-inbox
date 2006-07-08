Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWGHJ7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWGHJ7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWGHJ7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:59:37 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:30727 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932316AbWGHJ7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:59:36 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] spinlocks: remove 'volatile'
Date: Sat, 8 Jul 2006 02:59:28 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEJONAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060708094556.GA13254@tsunami.ccur.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 08 Jul 2006 02:54:46 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 08 Jul 2006 02:54:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Jul 07, 2006 at 11:54:10PM -0400, Albert Cahalan wrote:
> > That's all theoretical though. Today, gcc's volatile does
> > not follow the C standard on modern hardware. Bummer.
> > It'd be low-performance anyway though.

> But gcc would follow the standard if it emitted a 'lock'
> insn on every volatile reference.  It should at least
> have an option to do that.

	The premise is wrong, therefore so is the conclusion. GCC does follow the C
standard on modern hardware. The 'volatile' keyword imposes the minimum
amount of pain necessary to get the two guarantees that 'volatile' is
supposed to provide. It has no special semantics on multiple CPUs, and was
never intended to have any.

	The problem is that the C standard's definition of volatile is meaningless
on modern hardware (because there is no one clear true right place for
accesses to be visible, accesses occur in more than one place). All you can
do is make the cases where 'volatile has guaranteed semantics work.

	There would be absolutely no point in having GCC have an option to emit a
locked instruction on every volatile reference because there would still be
no way to know what the right thing to lock is. For example:

volatile int i;
i=i+1;

	Should this be a locked read, an increment in a register, followed by a
locked write? Or must this be a locked increment?

	If you cannot explain in platform-independent terms the *semantics* the
option is supposed to give, then it's probably wrong. What happens when the
next CPU requires something different to get the same effect?

	If you need atomic 32-bit loads, you know how to get them. If you need
atomic increments, you know how to get them. If you need memory optimization
barriers, you have them. Why ask for something new with vague,
poorly-defined semantics based on what 'lock' happens to do on current
processors? That just makes it easier to write non-portable code.

	Now if you had asked for portable atomic loads, increments, stores, and the
like, that would be a sensible thing. It makes sense because you define what
behavior that function is supposed to give.

	DS


