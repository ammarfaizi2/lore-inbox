Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265325AbUFHVvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUFHVvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUFHVvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:51:14 -0400
Received: from mail.inter-page.com ([12.5.23.93]:40968 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S265325AbUFHVvM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:51:12 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Tue, 8 Jun 2004 14:50:43 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040607141903.GA20863@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would think that having an easy call to disable the NX modification would be both
safe and effective.  That is, adding a syscall (or whatever) that would let you mark
your heap and/or stack executable while leaving the new default as NX, is "just as
safe" as flagging the executable in the first place.

-- You would have to turn it on manually (so Wine etc could do this freely.)
-- Nobody who didn't _need_ it on, would leave it off because people are lazy like
that.
-- The execute-arbitrary-code hacks could only execute that arbitrary code to turn
off NX if the hack was already able to execute its arbitrary code... (recurse as
necessary 8-)

Architecturally the easy-application-accessible switch should be something more than
a syscall to prevent a return-address-twiddle invoking the call directly.  I'd make
it a /proc/self something, or put it in a separate include-only-if-used shared
library or something.  If the minimal distance is opening and writing a
normally-untouched file then you get a nice support matrix.  (e.g. no file means no
feature, file plus action means executable stack, no action means system default (old
can, new cannot), hacks would require a variable (fd) and executing arbitrary code to
open and write that file, programs/programmers that want/need the old behavior can
achieve it without having to know how to manipulate their ELF headers or tool-chains,
etc.)

I know that flagging the binary gives new programs control, but to a great extent we
want the old programs to be controlled as-is instead of only-if-recompiled.

But that's just a thought... 8-)

Rob.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Ingo Molnar
Sent: Monday, June 07, 2004 7:19 AM
 
Wine is in a really difficult position (due to the complex task it
achieves) and is more sensitive to VM layout changes than other
applications. So lets try to find the solution that preserves the
kernel's ability to further optimize the VM layout, while meeting Wine's
desire to get a simple VM layout that is not mapped in the first 1 GB or
so.



