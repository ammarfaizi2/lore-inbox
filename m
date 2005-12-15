Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVLOSBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVLOSBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVLOSBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:01:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750880AbVLOSBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:01:15 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com> 
References: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com> 
To: "Luck, Tony" <tony.luck@intel.com>
Cc: dhowells@redhat.com, "Andrew Morton" <akpm@osdl.org>,
       "Mark Lord" <lkml@rtr.ca>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk,
       pj@sgi.com, mingo@elte.hu, hch@infradead.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 15 Dec 2005 18:00:32 +0000
Message-ID: <15324.1134669632@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony <tony.luck@intel.com> wrote:

> There was a USENIX paper a couple of decades ago that described how
> to do a fast s/w disable of interrupts on machines where really disabling
> interrupts was expensive.  The rough gist was that the spl[1-7]()
> functions would just set a flag in memory to hold the desired interrupt
> mask.

Cute. The slow bit on FRV is any time you access the PSR register (read or
write). It seems to be something on the order of 60 clock cycles a pop - in
which time the CPU could have executed 120 instructions under ideal
circumstances.

I do something like this to implement "atomic" operations, playing on the
FRV's ability to pack two instructions atomically together and to have
conditionally executed instructions:

	Documentation/fujitsu/frv/atomic-ops.txt.

Trading off against the memory speed might just do it - though you have to do
a write and a read (the latter of which should hopefully be cached). I could
always steal another register (I have 31-ish to play with, plus a bunch of
single-bit condition values).

It'd make the exception prologue even more "interesting" though...:-)

Hmmm...

David
