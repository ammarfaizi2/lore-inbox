Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUDNTDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUDNTDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:03:11 -0400
Received: from palrel10.hp.com ([156.153.255.245]:36016 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261225AbUDNTDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:03:07 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16509.35554.807689.904871@napali.hpl.hp.com>
Date: Wed, 14 Apr 2004 12:02:58 -0700
To: Jamie Lokier <jamie@shareable.org>
Cc: davidm@hpl.hp.com, linux-ia64@linuxia64.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
In-Reply-To: <20040414184603.GA12105@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
	<20040414082355.GA8303@mail.shareable.org>
	<20040414113753.GA9413@mail.shareable.org>
	<16509.25006.96933.584153@napali.hpl.hp.com>
	<20040414184603.GA12105@mail.shareable.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 14 Apr 2004 19:46:03 +0100, Jamie Lokier <jamie@shareable.org> said:

  Jamie> David Mosberger wrote:
  >> Huh?  You haven't actually checked, have you?

  Jamie> Yes I have.  Quite thoroughly.

Then you should have noticed that drivers/char/mem.c is using PAGE_COPY.
Various architecture-dependent code is also using PAGE_foo macros.

  Jamie> In theory the Alpha can do exec-only pages, but it's __[PS]*
  Jamie> map always gives read permission when there's execute
  Jamie> permission.  I'm not sure if there's a reason for that, or if
  Jamie> it just historically copied the i386 behaviour (Alpha was the
  Jamie> first port).

I know why: back in those days, GCC emitted code for nested C
functions that assumed an executable stack.  Also, Linus wasn't
terribly eager to turn off execute-permission on data/stacks.  Even on
ia64 we started out that way, until I saw the error in my ways.

  Jamie> I agree it is best to avoid namespace pollution.  However
  Jamie> this is one area where ia64 sticks out because it's approach
  Jamie> is different from other ports.  All of them except Alpha used
  Jamie> PAGE_* names to clarify the __[PS]* map, defining additional
  Jamie> names as needed.

The reality is that whenever you introduce a globally visible name
that is not used on x86, there is a very definite risk that someone
will use that same name and cause a conflict.  We have had that happen
several times and that's the reason I'm normally religious about
prefixing all ia64-specific names with a "ia64_" or "IA64_" (yes, this
makes code a bit uglier, but you can't have it both ways).  Your
argument that the Alpha and other ports are doing something different
doesn't buy me anything.  If the ia64 break builds, the Alpha
maintainer won't fix it up for me, after all.

	--david
