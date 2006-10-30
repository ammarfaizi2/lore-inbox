Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWJ3Oir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWJ3Oir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWJ3Oir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:38:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14315 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751931AbWJ3Oiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:38:46 -0500
Subject: Re: [patch] drivers: wait for threaded probes between initcall
	levels
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
In-Reply-To: <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com>
	 <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org>
	 <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 15:38:00 +0100
Message-Id: <1162219080.2948.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I admit the complexity is a bit high, but since the maximum nesting  
> is bounded by the complexity of the hardware and the number of  
> busses, and the maximum memory-allocation is strictly limited in the  
> single-threaded case this could allow 64-way systems to probe all  
> their hardware an order of magnitude faster than today without  
> noticeably impacting an embedded system even in the absolute worst case.


how much of this complexity goes away if you consider the
scanning/probing as a series of "work elements", and you end up with a
queue of work elements that threads can pull work off one at a time (so
that if one element blocks the others just continue to flow). If you
then find, say, a new PCI bus you just put another work element to
process it at the end of the queue, or you process it synchronously. Etc
etc.

All you need to scale then is the number of worker threads on the
system, which should be relatively easy to size....
(check every X miliseconds if there are more than X outstanding work
elements, if there are, spawn one new worker thread if the total number
of worker threads is less than the system wide max. Worker threads die
if they have nothing to do for more than Y miliseconds)

Oh and... we have a concept for this already, or at least mostly, via
the work queue mechanism :)


