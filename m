Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVAaQmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVAaQmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVAaQmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:42:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:33043 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261252AbVAaQlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:41:47 -0500
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack
	pointer)
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Busser <busser@m-privacy.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501311357.59630.busser@m-privacy.de>
References: <200501311015.20964.arjan@infradead.org>
	 <200501311357.59630.busser@m-privacy.de>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 17:41:39 +0100
Message-Id: <1107189699.4221.124.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 13:57 +0100, Peter Busser wrote:
> Hi!
> 
> > I'm not entirely happy yet (it shows a bug in mmap randomisation) but
> > it's way better than what you get in your tests (this is the
> > desabotaged
> > 0.9.6 version fwiw)
> 
> As you may or may not know, I am the author of PaXtest. Please tell me what a 
> ``desabotaged'' version of PaXtest exactly is. I've never seen a 
> ``sabotaged'' PaXtest and I'm interested in finding out who sabotaged it and 
> for what purpose.
> 
> Come to thin

> I'm sorry to have to bother the people on this list, as you have much more 
> important things to do. But for me personally, the integrity of PaXtest (and 
> related to that, my personal integrity) matters a great deal. So I'd like to 
> get to the bottom of this, even if that means bothering lkml. I hope Arjan 
> can provide facts soon, so I can take action against this sabotage. 

ok the paxtest 0.9.5 I downloaded from a security site (not yours) had
this gem in:

--- paxtest/body.c
+++ paxtest-0.9.5/body.c        2005-01-18 17:30:11.000000000 +0100
@@ -29,7 +29,6 @@
        fflush( stdout );

        if( fork() == 0 ) {
+               do_mprotect((unsigned long)argv & ~4095U, 4096,
PROT_READ|PROT_WRITE|PROT_EXEC);
                doit();
        } else {
                wait( &status );

which is clearly there to sabotage any segmentation based approach (eg
execshield and openwall etc); it cannot have any other possible use or
meaning.

the paxtest 0.9.6 that John Moser mailed to this list had this gem in
it:
@@ -39,8 +42,6 @@
         */
        int paxtest_mode = 1;

+       /* Dummy nested function */
+       void dummy(void) {}

        mode = getenv( "PAXTEST_MODE" );
        if( mode == NULL ) {


which is clearly there with the only possible function of sabotaging the
automatic PT_GNU_STACK setting by the toolchain (which btw is not fedora
specific but happens by all new enough (3.3 or later) gcc compilers on
all distros) since that requires an executable stack.

Now I know you're a honest and well meaning guy and didn't put those
sabotages in, and I did indeed not get paxtests from your site directly,
so they obviously must have been tampered with, hence me calling it de-
sabotaging when I fixed this issue (by moving the function to not be
nested).

Greetings,
   Arjan van de Ven

