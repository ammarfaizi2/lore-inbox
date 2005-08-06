Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVHFMqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVHFMqu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 08:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVHFMqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 08:46:50 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23010 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261731AbVHFMqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 08:46:49 -0400
Subject: Re: [PATCH 8/8] ALSA: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paulo Marques <pmarques@grupopie.com>
Cc: dtor_core@ameritech.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <42F38F65.402@grupopie.com>
References: <ikr7kg.6lzzr6.7ocpqo9oanclt926l5vz7gkyx.beaver@cs.helsinki.fi>
	 <ikr7kp.i3e3jm.bv3m5oebr5lt3u19xzl3ct9yu.beaver@cs.helsinki.fi>
	 <d120d5000508050822f18c9ac@mail.gmail.com>  <42F38F65.402@grupopie.com>
Date: Sat, 06 Aug 2005 15:37:24 +0300
Message-Id: <1123331844.11074.6.camel@haji.ri.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dmitry Torokhov wrote:
> > Have you seen the following in include/sound/core?
> > 
> > ...
> > #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
> > #define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
> > #define kfree(obj) snd_hidden_kfree(obj)

On Fri, 2005-08-05 at 17:10 +0100, Paulo Marques wrote:
> Arghh... I've been bitten by this before, too.

Me too.

On Fri, 2005-08-05 at 17:10 +0100, Paulo Marques wrote:
> I really hate this "#define kmalloc" hack. It makes the code really 
> unreadble, because you expect a kmalloc to be just a kmalloc...
> 
> Couldn't we turn this into a generic kernel debugging option, so that it 
> could be used for every kmalloc instead of just the ones from the sound 
> system?
> 
> If I get this right, what this code does is to track kfree's on pointers 
> that were not alloc'ed with kmalloc (using a magic number) and keep 
> track of all the allocations to detect leaks.

Yes, that's what it does.

On Fri, 2005-08-05 at 17:10 +0100, Paulo Marques wrote:
> We already have SLAB_DEBUG. We could add a list of allocations with a 
> proc interface (or something) to give an histogram of kmalloc callers / 
> number of allocations not yet freed.
> 
> This way, if after stopping everything related to sound there were still 
> callers like "snd_xxxx" (through kallsyms) you would know there is a 
> leak there.
> 
> What does CONFIG_SND_DEBUG_MEMORY provide that this more generic scheme 
> does not?

I would like to make it generic too. CONFIG_SND_DEBUG_MEMORY has the
advantage of snd_memory_done() which can detect memory leaks in their
modules automatically. Therefore, to replace the ALSA magic allocator,
we would need to track which module did the allocation and add hooks to
module_exit.

		Pekka

