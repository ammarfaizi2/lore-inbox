Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVHEQOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVHEQOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbVHEQL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 12:11:27 -0400
Received: from [195.23.16.24] ([195.23.16.24]:6303 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263021AbVHEQKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 12:10:16 -0400
Message-ID: <42F38F65.402@grupopie.com>
Date: Fri, 05 Aug 2005 17:10:13 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 8/8] ALSA: convert kcalloc to kzalloc
References: <ikr7kg.6lzzr6.7ocpqo9oanclt926l5vz7gkyx.beaver@cs.helsinki.fi>	 <ikr7kp.i3e3jm.bv3m5oebr5lt3u19xzl3ct9yu.beaver@cs.helsinki.fi> <d120d5000508050822f18c9ac@mail.gmail.com>
In-Reply-To: <d120d5000508050822f18c9ac@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 8/5/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> 
>>This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.
>>
> 
> 
> Hi,
> 
> Have you seen the following in include/sound/core?
> 
> ...
> #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
> #define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
> #define kfree(obj) snd_hidden_kfree(obj)

Arghh... I've been bitten by this before, too.

Pekka, the sound subsystem uses its own allocation functions that are 
just defined to the standard kernel counterparts when 
CONFIG_SND_DEBUG_MEMORY is not defined, but that map to their own 
functions that add aditional debug information when that config is set.

To play well with the current structure you have to define you own 
snd_hidden_kzalloc(size, flags) and use the same scheme.

For my previous encounter with this problem search a thread named 
"replace snd_kmalloc_strdup by kstrdup". The patch there might useful to 
you.

I really hate this "#define kmalloc" hack. It makes the code really 
unreadble, because you expect a kmalloc to be just a kmalloc...

Couldn't we turn this into a generic kernel debugging option, so that it 
could be used for every kmalloc instead of just the ones from the sound 
system?

If I get this right, what this code does is to track kfree's on pointers 
that were not alloc'ed with kmalloc (using a magic number) and keep 
track of all the allocations to detect leaks.

We already have SLAB_DEBUG. We could add a list of allocations with a 
proc interface (or something) to give an histogram of kmalloc callers / 
number of allocations not yet freed.

This way, if after stopping everything related to sound there were still 
callers like "snd_xxxx" (through kallsyms) you would know there is a 
leak there.

What does CONFIG_SND_DEBUG_MEMORY provide that this more generic scheme 
does not?

-- 
Paulo Marques
Software Development Department - Grupo PIE, S.A.
Phone: +351 252 290600, Fax: +351 252 290601
Web: www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
