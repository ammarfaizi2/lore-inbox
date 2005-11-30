Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVK3PHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVK3PHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVK3PHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:07:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:21710 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750860AbVK3PHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:07:31 -0500
Date: Wed, 30 Nov 2005 16:07:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
In-Reply-To: <438D77E5.DCAC8804@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0511301436180.1609@scrub.home>
References: <438C5057.A54AFA83@tv-sign.ru> <Pine.LNX.4.61.0511300330130.1609@scrub.home>
 <438D77E5.DCAC8804@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Nov 2005, Oleg Nesterov wrote:

> Still not correct, I beleive.

Here is a new idea, what do you think about using spin_trylock(), e.g. 
something like:

	if (spin_trylock(&new_base->t_base.lock)) {
		timer->base = &new_base->t_base;
		spin_unlock(&base->lock);
	} else
		new_base = container_of(base, tvec_base_t, t_base);

It's not like we must start the timer on the current cpu and this might 
even be faster. If the new base is busy on another cpu, it's possible we 
have to pull dirty cache lines from the other cpu, where we might already 
have the data from the current base already in the cache from the detach.

bye, Roman
