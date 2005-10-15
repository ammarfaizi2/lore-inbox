Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVJOKgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVJOKgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVJOKgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:36:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9151 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750913AbVJOKgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:36:39 -0400
Subject: Re: interruptible_sleep_on, interrupts and device drivers
From: Arjan van de Ven <arjan@infradead.org>
To: Gabriele Brugnoni <news@dveprojects.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510151229.37124.news@dveprojects.com>
References: <200510151229.37124.news@dveprojects.com>
Content-Type: text/plain
Date: Sat, 15 Oct 2005 12:36:29 +0200
Message-Id: <1129372589.2908.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-15 at 12:29 +0200, Gabriele Brugnoni wrote:
> Arjan van de Ven wrote:
> 
> > 
> > don't.
> > 
> > interruptible_sleep_on() is a broken interface (see the comments in the
> > header) and should not be used in any new code (where "new" is "since
> > the year 2000" :)
> > 
> > Just use the wait_event() interfaces .... or just a simple semaphore
> > even if what you want to do is simple and performance isn't too
> > critical.
> > 
> 
> OK, i'll not use, but the kernel has a lot of device drivers using it, that 
> may present the problem explained in my message.
> 
> In my code i've try the following:
> 
> 		save_flags(flags); cli();

this is broken code; cli() cannot and should not be used. (and isn't
even available on SMP kernels anymore)

> 		if( !rs.txdone ) {
> 			if( arg < 0 ) arg = rs.ttimeout;
> 			if( arg > 0 )
> 				interruptible_sleep_on_timeout ( &rs.txwait, arg );
> 			else
> 				interruptible_sleep_on ( &rs.txwait );
> 		}
> 		restore_flags(flags);

and this is missing a sti()

> 		return rs.txdone;


your code is just wrong. Yes I know many really old drivers do this, but
those are getting extinct fast..

