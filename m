Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVBANID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVBANID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVBANHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:07:44 -0500
Received: from [195.23.16.24] ([195.23.16.24]:52650 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262012AbVBANHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:07:31 -0500
Message-ID: <41FF7F0D.5080800@grupopie.com>
Date: Tue, 01 Feb 2005 13:07:25 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [PATCH 2.6] 7/7 replace snd_kmalloc_strdup by kstrdup
References: <1107228526.41fef76e4c9be@webmail.grupopie.com>	<s5h651ch6lc.wl@alsa2.suse.de>	<41FF75C0.6040602@grupopie.com> <s5hy8e8fol6.wl@alsa2.suse.de>
In-Reply-To: <s5hy8e8fol6.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> [...]
> The compile should be fine but it may result in memory corruption
> since kmalloc/kfree become wrappers when CONFIG_SND_DEBUG_MEMORY is
> set.  See include/sound/core.h.

Ok, I see what you mean. I'm sorry I've missed this, but you must admit 
that code like this:

> #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
> #define kfree(obj) snd_hidden_kfree(obj)

in sound/core.h make the code really hard to read :P

I thought of going all the way and changing the callers of kstrdup in 
sound to use kfree, so that it would work without debugging memory 
allocated for strdup'ed strings.

However the code there already uses kfree, just not the standard kfree 
because it might have been defined to something else in core.h if 
CONFIG_SND_DEBUG_MEMORY is set.

We could still go all the way and carry on with this approach: use the 
standard kstrdup / kfree when not CONFIG_SND_DEBUG_MEMORY, and define 
kstrdup to be an internal sound function in sound/core/memory.c when 
CONFIG_SND_DEBUG_MEMORY is set.

Do you prefer that I do another patch to do this, or that I just drop 
the patch and leave snd_kmalloc_strdup alone?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
