Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVA2G7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVA2G7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 01:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVA2G7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 01:59:37 -0500
Received: from one.firstfloor.org ([213.235.205.2]:12770 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262863AbVA2G7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 01:59:35 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: =?iso-8859-1?q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       linux-kernel@vger.kernel.org, chrisw@osdl.org, netdev@oss.sgi.com,
       arjan@infradead.org, hlein@progressive-comp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
References: <1106932637.3778.92.camel@localhost.localdomain>
	<20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	<1106937110.3864.5.camel@localhost.localdomain>
	<20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	<1106944492.3864.30.camel@localhost.localdomain>
	<20050128124517.36aa5e05.davem@davemloft.net>
	<20050128133408.49021343@dxpl.pdx.osdl.net>
From: Andi Kleen <ak@muc.de>
Date: Sat, 29 Jan 2005 07:59:33 +0100
In-Reply-To: <20050128133408.49021343@dxpl.pdx.osdl.net> (Stephen
 Hemminger's message of "Fri, 28 Jan 2005 13:34:08 -0800")
Message-ID: <m1hdl0lnze.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> On Fri, 28 Jan 2005 12:45:17 -0800
> "David S. Miller" <davem@davemloft.net> wrote:
>
>> On Fri, 28 Jan 2005 21:34:52 +0100
>> Lorenzo Hernández García-Hierro <lorenzo@gnu.org> wrote:
>> 
>> > Attached the new patch following Arjan's recommendations.
>> 
>> No SMP protection on the SBOX, better look into that.
>> The locking you'll likely need to add will make this
>> routine serialize many networking operations which is
>> one thing we've been trying to avoid.
>> 
>
> per-cpu would be the way to go here.

I don't think so no - just doing per cpu counters you
risk nearby duplicates, which can cause even easier data corruption 
(e.g. during ip fragment reassembly - it is already very weak
and making it weaker is probably not a good idea) 

If you want SMP performance for ipids you can resurrect
the old "cookie jar" approach I used in 2.4 time frame to get
rid of inetpeers. The idea was that you have global state,
and each CPU would regenerate some numbers from the state,
then store them in a private "jar" and use them use, then
look at the global state with locking again etc.

This can be tuned on how big the jar is - the bigger the
smaller the sequence space (risky for 16bit ipids), but
the better the scalability.

But before doing anything like this I would recommend
that someone skilled in cryptography evaluates the security
of these functions carefully and see if it actually has any 
advantages. I remember that Andrey S. broke
some of the "cool" "secure" openbsd IDs easily some years ago.

At least for ipids I'm utterly sceptical. 16bits are just
hopeless.

-Andi
