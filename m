Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937099AbWLFSid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937099AbWLFSid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937097AbWLFSid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:38:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55807 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937089AbWLFSib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:38:31 -0500
Date: Wed, 6 Dec 2006 10:37:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy 
In-Reply-To: <Pine.LNX.4.64.0612061017220.3542@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612061033330.3542@woody.osdl.org>
References: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> 
 <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org>  <21690.1165426993@redhat.com>
 <Pine.LNX.4.64.0612060951150.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612060955380.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612061017220.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Linus Torvalds wrote:
>
> and remove the "volatile" from all the bitop accessor functions.

It might also be interesting to see if this would change code-size at all. 

There's a number of things that check different bits in the same word 
right now, and they just reload the word unnecessarily and do multiple 
tests. Some of the page flags functions obviously already work around this 
by doing horrible things by hand instead, eg:

                (page->flags & (
                        1 << PG_lru     |
                        1 << PG_private |
                        1 << PG_locked  |
                        1 << PG_active  |
                        1 << PG_reclaim |
                        1 << PG_slab    |
                        1 << PG_swapcache |
                        1 << PG_writeback |
                        1 << PG_reserved |
                        1 << PG_buddy ))

in the free_pages_check() thing. It may make sense there, but we really 
_should_ allow gcc to just do things like this for us, and just use the 
proper functions to test bits.

			Linus
