Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUIEPpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUIEPpz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIEPpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:45:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19389 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266820AbUIEPpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:45:50 -0400
Date: Sun, 5 Sep 2004 17:45:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@infradead.org>
cc: Matthias Urlichs <smurf@smurf.noris.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Getting kernel.org kernel to build for m68k?
In-Reply-To: <20040905144904.A30552@infradead.org>
Message-ID: <Pine.LNX.4.61.0409051716150.877@scrub.home>
References: <41355F88.2080801@kegel.com> <Pine.GSO.4.58.0409011029390.15681@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0409051224020.30282@anakin> <20040905120325.A29363@infradead.org>
 <20040905131948.GE2605@kiste> <20040905144904.A30552@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 5 Sep 2004, Christoph Hellwig wrote:

> Because we don't want gazillions of special cases in common code.  We
> already added support for allocating the thread_info and task_struct
> as a single object because ia64 needed it, there's no reason to stack
> another hack ontop for m68k.

What ia64 is doing is already a hack and doesn't really apply to m68k, as 
we want to keep the stack separate.
The basic problem is something completely different, as soon as an arch 
wants to reorganize some data structures a bit different you are in 
include hell. The problem are the mixture of structure definitions and 
inline functions, as soon as inline functions use functions/structures not 
defined in the same file, the include dependencies become very fragile.
So we either have the choice we only use macros or we separate some core 
data types into their own headers (well, the only other option is that 
m68k has to stack more hacks on the ia64 hack).
So as soon as one wants to allocate thread_info and task_struct together 
without using hacks, one very populuar problem are the various lock 
functions and their use of preempt_enable(), which needs access to 
thread_info, but sched.h (and so task_struct) needs the definition of 
various data structures. The spinlock functions are all still macros, but 
a lot of other lock functions, which were added after the stack/ 
task_struct split, are real inline functions and make a reorganization 
very painful.

bye, Roman
