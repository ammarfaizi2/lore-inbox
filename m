Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVC0O2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVC0O2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVC0O2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:28:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10193 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261670AbVC0O2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:28:48 -0500
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
	-fs/ext2/
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-os@analogic.com, Jesper Juhl <juhl-lkml@dif.dk>,
       ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200503271551.18342.vda@ilport.com.ua>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	 <1111913130.6297.24.camel@laptopd505.fenrus.org>
	 <200503271551.18342.vda@ilport.com.ua>
Content-Type: text/plain
Date: Sun, 27 Mar 2005 16:28:42 +0200
Message-Id: <1111933722.6297.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 15:51 +0300, Denis Vlasenko wrote:
> > > It's impossible to be otherwise. A call requires
> > > that the return address be written to memory (the stack),
> > > using register indirection (the stack-pointer).
> > 
> > and it's a so common pattern that it's optimized to death. Internally a
> > call gets transformed to 2 uops or so, one is push eip, the other is the
> > jmp (which gets then just absorbed by the "what is the next eip" logic,
> > just as a "jmp"s are 0 cycles)
> 
> Arjan, you overlook the fact that kfree() contains 'if(!p) return;' too.
> call + test-and-branch can never be faster than test+and+branch

ok so for the non-null case you have

test-nbranch-call-test-nbranch
vs
call-test-nbranch

vs the null case where you get
test-branch
vs
call-test-branch

(I'm using nbranch here as a non-taken branch; it's also a conditional
branch and it has the same misprediction possibility)

in the non-null case with if you have *two* chances for the branch
predictor to go wrong. (and "wrong" can also mean "cold, eg unknown"
here) and always an extra "test-nbranch" sequence, which is probably a
cycle at least

the offset for that is the null-case-without-if where you have an extra
"call", which is also half to a whole cycle.

even in the null case it's dubious if there is gain, it depends on how
the branch predictor happens to feel that day ;)


