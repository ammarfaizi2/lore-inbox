Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWGGOAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWGGOAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWGGOAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:00:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3163 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932159AbWGGOAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:00:08 -0400
Date: Fri, 7 Jul 2006 16:02:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, mtk-manpages@gmx.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice/tee bugs?
Message-ID: <20060707140224.GB4188@suse.de>
References: <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de> <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de> <20060707131247.GX4188@suse.de> <20060707131403.GY4188@suse.de> <1152278514.3111.77.camel@laptopd505.fenrus.org> <20060707132651.GZ4188@suse.de> <44AE6799.7080705@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AE6799.7080705@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Paulo Marques wrote:
> Jens Axboe wrote:
> >On Fri, Jul 07 2006, Arjan van de Ven wrote:
> >>>I cannot see where this could be happening, Ingo is this valid?
> >>maybe the test found a way to exit the kernel previously while holding
> >>the lock ?
> >
> >I don't see how that could happen. The function in question is
> >fs/splice.c:link_pipe(). There are no returns in that function, it
> >always just breaks out and unlocks the two mutexes again.
> 
> AFAICS, in the case that you don't release any lock before entering 
> pipe_wait (because of the lock ordering), pipe_wait just releases one of 
> the locks and then schedules with the other lock still held.

That should not violate the lock ordering, though. I'm testing an easier
fix now, basically always grabbing the ipipe mutex first and never
blocking on the input pipe. Makes sense too, we will attempt to dupe the
contents of that pipe from when sys_tee() was invoked. We cannot
reliably have the pipe changing too much in progress anyway.

-- 
Jens Axboe

