Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVAaTou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVAaTou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVAaTnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:43:53 -0500
Received: from opersys.com ([64.40.108.71]:46091 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261335AbVAaTlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:41:32 -0500
Message-ID: <41FE8924.2000809@opersys.com>
Date: Mon, 31 Jan 2005 14:38:12 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux, part 2
References: <16890.38062.477373.644205@tut.ibm.com> <m1d5volksx.fsf@muc.de> <16892.26990.319480.917561@tut.ibm.com> <20050131125758.GA23172@muc.de>
In-Reply-To: <20050131125758.GA23172@muc.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:
> It's doing a complicated function call which does who knows what in
> the logging fast path (I stopped reading after some point)  
> It definitely is not putc !

I was anticipating some people would have this requirement, and this
is why I introduced the ad-hoc mode. Roman asked me to get rid of it
because nobody had yet asked for it, so this is why it was dropped.
As it is, the implementation you are suggesting is insufficient for
LTT, which is relayfs' first formal client. I think that it would be
better to provide two underlying mechanisms for relayfs at this point,
we had already stripped it as thin as it would go for things like LTT.

>>separate grabbing a slot in the buffer from the memcpy because some
>>applications such as ltt want to be able to directly write into the
>>slot without having to copy it into another buffer first.  How about
> 
> 
> If the inline function to log was fast enough it wouldn't need 
> any such hacks.

Actually that's not true. There are two problems with this statement:
a- It requires prepackaged data units.
b- It's only useful for fixed-size data units.

Any efficient client that has complex data units will want to write
directly into the buffer instead of creating an intermediate package
which is then memcopied. With the modified code, we are now forced
to create an intermediate package, which is wrong. Also, if the client
wants to log variable-size events, he would have to re-implement lots
of the writing code.

Note that I really think relay_write() should be dropped altogether.
Clients should call on relay_reserve() and do whatever is necessary
after that.

> Note that gcc is quite good at optimizing memcpy, so essentially
> when you e.g. do log(singleint) it should be roughly equivalent
> to a int store into the buffer + the check if there is enough
> buffer space.

I understand the point you are trying to make, but I really think that
this is best implemented as two separate buffering schemes instead of
breaking the existing one (which had already been trimmed down quite
thin following Roman's input.)

> You could avoid the local_irq_save() if you use separate interrupt
> buffers that are only accessed in non nesting interrupt context 
> (like softirqs) That would require a sorting step at output though. Not
> sure if it's worth it. The problem is that hardirqs can nest anyways,
> so it wouldn't work for them. However a lot of important code runs
> in softirq (like the network stack) where this is true.

For the kind of data sizes we are looking at for LTT (100GBs) splitting
buffers is not viable anyway.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
