Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUK1ARd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUK1ARd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 19:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUK1ARd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 19:17:33 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:23710 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261376AbUK1ARb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 19:17:31 -0500
Message-ID: <41A9190D.5020108@yahoo.com.au>
Date: Sun, 28 Nov 2004 11:17:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Tomas Carnecky <tom@dbservice.com>
CC: Marcel Sebek <sebek64@post.cz>, Pekka Enberg <penberg@cs.helsinki.fi>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document kfree and vfree NULL usage
References: <1101565560.9988.20.camel@localhost> <20041127171357.GA5381@penguin.localdomain> <41A9148E.6070501@dbservice.com>
In-Reply-To: <41A9148E.6070501@dbservice.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:
> Marcel Sebek wrote:
> 
>> On Sat, Nov 27, 2004 at 04:26:00PM +0200, Pekka Enberg wrote:
>>
>>> Hi,
>>>
>>> This patch adds comments for kfree() and vfree() stating that both 
>>> accept
>>> NULL pointers.  I audited vfree() callers and there seems to be lots of
>>> confusion over this in the kernel.
>>>
>> I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
>> constructions. I'm going to to this for most of the kernel if I found
>> some time.
> 
> 
> Isn't 'if (x) { free(x); }' faster than the call to free() with a NULL
> pointer?
> What about a macro ?
> #define fast_free(x) if (x) { free(x); }
> Or even
> #define kfree(x) if (x) { _kfree(x); }
> Or maybe a inline function so it doesn't break existing code.
> inline void kfree(x) { if (x) { _kfree(x); } }
> 

Well if a NULL parameter is the exceptional case, then you don't want to
litter the L1 cache with the extra code that will only save a function
call in rare cases.

And I think it should be the exceptional case, because it shouldn't really
be used for much other than streamline error handling or cleanup functions
to cope with failed allocations without adding checks everywhere. If you're
doing lots of kfree(NULL) as part of normal operation, then that may
suggest you aren't tracking your memory very well.
