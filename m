Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVAaQOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVAaQOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVAaQOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:14:02 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:14089 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261249AbVAaQN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:13:58 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: SPARC64 mapped figure goes unsignedly negative...
References: <87sm4izw3u.fsf@amaterasu.srvr.nix>
	<Pine.LNX.4.61.0501311256580.5368@goblin.wat.veritas.com>
	<87sm4hwr81.fsf@amaterasu.srvr.nix>
	<Pine.LNX.4.61.0501311545200.5933@goblin.wat.veritas.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: where editing text is like playing Paganini on a glass harmonica.
Date: Mon, 31 Jan 2005 16:13:47 +0000
In-Reply-To: <Pine.LNX.4.61.0501311545200.5933@goblin.wat.veritas.com> (Hugh
 Dickins's message of "Mon, 31 Jan 2005 16:01:06 +0000 (GMT)")
Message-ID: <87d5vlwp8k.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005, Hugh Dickins said:
> On Mon, 31 Jan 2005, Nix wrote:
>> (2.6.10 seems to *run* perfectly well on that box, for what it's worth;
>> unless this is a symptom of some underlying dark and terrible failure,
>> it looks like a not-very-important cosmetic bug.)
> 
> A lot of the time you're right and it is just cosmetic.  But if memory
> gets tight and it should be using swap, it mistakenly fails to do so,
> so you may end up getting OOM-killed.  Patch below is a temporary hack
> workaround against that.

Odd: this machine seems to be using swap, albeit not very much (and I've
got the swap priorities upside down, as well; whoops, that's probably
been harming performance for, well, years):

Filename				Type		Size	Used	Priority
/dev/sda2                               partition	523016	0	1
/dev/sda4                               partition	511232	57648	2
/dev/sdb2                               partition	523016	0	1

Is the problem that the higher-priority kicking out to swap which should
happen when memory is tight, won't?

>                           The Mapped count also affects when dirty file
> writeback kicks in, but the effect there appears to be less serious.

... since it kicks in eventually anyway.

> More worrying is, what else might sparc64 gcc-3.4 be getting wrong?

That's a question that's very hard to answer until we know the cause of
this failure and can fix it: then we can go through the RTL or assembler
dumps of a kernel compilation and comb more potential problems out
(or not: it's probably a long and thankless task).

I'll build rmap.c with GCC-3.3 later tonight (if I can find a copy on my
old backups), compare the generated code, and see if anything leaps out
at me.

> --- 2.6.10/mm/vmscan.c	2004-12-24 21:36:18.000000000 +0000
> +++ linux/mm/vmscan.c	2005-01-31 12:44:56.006629152 +0000
> @@ -690,6 +690,8 @@ refill_inactive_zone(struct zone *zone, 
>  	 * is mapped.
>  	 */
>  	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
> +	if (mapped_ratio < 0)
> +		mapped_ratio = 78;
>  
>  	/*
>  	 * Now decide how much we really want to unmap some pages.  The mapped

`78'? A hack indeed! :)

-- 
`Blish is clearly in love with language. Unfortunately,
 language dislikes him intensely.' --- Russ Allbery
