Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753329AbWKQWLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbWKQWLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbWKQWLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:11:40 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:42137 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1753329AbWKQWLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:11:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=HsDVZPFbXybuPKhoP4qPvuPDosM59yELx433eNOuMzi6edFjeCrCaJkTeD/IB7IzaSYzbPI5xbphZ93oal4Ecp070K6M4Wwban9CXEJF1AnBZ3xcniCngoSJlA0bUPlJyDKozAELG08IQn/eDL084wEnDhS/rdcBY9nK1P4LqXU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Alan Cox <alan@redhat.com>
Subject: TTY layer locking design
Date: Sat, 18 Nov 2006 00:11:38 +0200
User-Agent: KMail/1.9.1
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>, Jeff Dike <jdike@addtoit.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200611172311.38744.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started cleaning up locking in UML TTY drivers, and I've found some 
difficulties in making it work cleanly.

I was starting looking well into the TTY layer locking and its design, and at 
a first (and carent) look I found it difficult to follow; recent changes to 
tty refcounting seem to point out that much work needs to be done, as one can 
guess after looking at the code (I wasn't sure whether the problem was on the 
code or on the reader ;-), however).

So I have some questions before starting really to delve here:

*) who is maintaining this aspect of code ? The only name found in MAINTAINERS 
and CREDITS is the one of James Simmons.
*) would the locking need to be redesigned?
*) is the current design reputed solid? I'm not only talking about the big 
kernel lock, but also about whether drivers need to reinvent (incorrectly) 
the wheel for their locking. UML drivers are very bad on this, but I've found 
difficulty both at reading the code and at finding documentation.
*) Documentation/tty.txt is quite carent.

*) there is no generic way to handle tty's which are also consoles, except 
drivers/char/vt.c - that code is written as if it were the only case where 
that applies. Instead, UML drivers are an exception to this - UML cannot use 
virtual terminals.
Having a generic console driver using tty methods appears to be a cleaner 
design (think, in filesystem writing, of page cache methods based 
on ->readpage and ->writepage).

I'm trying to establish whether it is possible, for instance, for ->close to 
be called in parallel to ->write and such; in other driver layer this is 
impossible because refcounts are used (normal files, char & block devices) 
or, in the network layer, where refcount usage is impossible, because of 
state machines (in the network layer).

It seems not to happen for the console layer - is this true?
Also, since write must use a spinlock because it must protect from interrupt 
races, and open cannot, must we use both a mutex and a spinlock in ->write 
and similar methods? This can be avoided in other drivers.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
