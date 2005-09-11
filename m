Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVIKXLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVIKXLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVIKXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:11:04 -0400
Received: from smtpout.mac.com ([17.250.248.72]:50889 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751031AbVIKXLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:11:03 -0400
In-Reply-To: <20050911155637.3839db5c.rdunlap@xenotime.net>
References: <20050911103757.7cc1f50f.rdunlap@xenotime.net> <20050911104437.6445ff20.donate@madrone.org> <8244F3CF-9EF7-44BB-B3DA-B46A1FF39E1C@mac.com> <20050911155637.3839db5c.rdunlap@xenotime.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B341E46B-1987-4284-8521-B9A177EC4A46@mac.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] [PATCH] make add_taint() inline
Date: Sun, 11 Sep 2005 19:10:44 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 11, 2005, at 18:56:37, Randy.Dunlap wrote:
> On Sun, 11 Sep 2005 14:22:08 -0400 Kyle Moffett wrote:
>
>> On Sep 11, 2005, at 13:44:37, donate wrote:
>>
>>> From: Randy Dunlap <rdunlap@xenotime.net>
>>>
>>> add_taint() is a trivial function.
>>> No need to call it out-of-line, just make it inline and
>>> remove its export.
>>
>> Actually, in this case it might be better to leave add_taint
>> exported, add and export a new function get_taint(), and then
>> remove all export of the variable "tainted".  I've actually
>> seen one case where some module removed taint bits.  I don't
>
> some in-tree module?

No, it was a BSD out-of-tree module, I don't even remember what
it was anymore, it's probably not significant, but if "tainted"
is exported, it seems like some binary module writers might get
the brilliant idea to twiddle it by hand.  How about something
like this to enforce the idea that taintedness is add-only:

void add_taint(unsigned int flags);
unsigned int get_taint(void);

static unsigned int tainted;

Then use atomic bit operations on platforms which have them and
a spinlock on those that don't.  My guess where the lack of
locking might cause issues is if we hit an MCE and bad_page at
the same time on SMP or something.  It seems like it would be
really rare in practice, but I guess that appropriately timed
badness in multiple drivers (perhaps one triggered by the other?)
could cause it to occur.

> Maybe Dave Jones's modprobe/insmod killer test on a big
> multiprocessor system could do that one day.

Or that :-D.  The only way I can see this dying or accidentally
untainting is if two processors try to add different types of
taint simultaneously.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because
life wouldn't have any meaning for them if they didn't. That's why I  
draw
cartoons. It's my life."
   -- Charles Shultz


