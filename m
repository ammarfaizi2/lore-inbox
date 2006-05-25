Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWEYQiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWEYQiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWEYQhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:37:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030256AbWEYQha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:37:30 -0400
Date: Thu, 25 May 2006 09:37:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
       Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc5
In-Reply-To: <20060525132336.7f6ca8af@doriath.conectiva>
Message-ID: <Pine.LNX.4.64.0605250934220.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
 <20060525132336.7f6ca8af@doriath.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 May 2006, Luiz Fernando N. Capitulino wrote:
> 
>  I'm getting this after running 'halt':
> 
> Halting system...
> md: stopping all md devices.
> md: md0 switched to read-only mode.
> Shutdown: hda
> System halted.
> BUG: halt/3367, lock held at task exit time!
>  [dfe70494] {mddev_find}
> .. held by:              halt: 3367 [decf4a90, 118]
> ... acquired at:               md_notify_reboot+0x31/0x7f

Sounds like this is due to df5b89b323b922f56650b4b4d7c41899b937cf19, aka 
"md: Convert reconfig_sem to reconfig_mutex" by NeilBrown.

Neil? It may well be (and likely is) an old thing, just exposed by the 
lock debugging of the new mutexes.

Was it _meant_ to take the lock and hold it? Looks like it might be the

	ITERATE_MDDEV(mddev,tmp)
		if (mddev_trylock(mddev))
			do_md_stop (mddev, 1);

(maybe it should release the lock after the md_stop?)

		Linus
