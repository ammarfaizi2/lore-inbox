Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274963AbTHLB3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274968AbTHLB3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:29:17 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:49293 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S274963AbTHLB3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:29:15 -0400
Date: Tue, 12 Aug 2003 03:25:50 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Handling workqueue threads (was: Re: [PATCH] [2.6.0-test3] request_firmware related problems.)
Message-ID: <20030812012550.GB24218@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030810210646.GA6746@ranty.pantax.net> <20030810142928.4b734e8d.akpm@osdl.org> <3F36CD93.4010704@pobox.com> <3F36CE8D.8090201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F36CE8D.8090201@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 07:00:29PM -0400, Jeff Garzik wrote:
> Jeff Garzik wrote:
> >So, in terms of concrete suggestions:
> >
> >1) if schedule_work is called and no kevent thread is available, create 
> >a new one
> >2) ponder perhaps an implementation that would use generic keventd until 
> >a certain load is reached; then, create per-cpu kernel threads just like 
> >private workqueue creation occurs now.  i.e. switch from shared 
> >(keventd) to private at runtime.
> 
> 
> 3) offer private workqueue interface like we have now -- but one thread 
> only, not NN threads
> 

 How about, launching the private workqueue threads on demand?

 a) Create thread/s then the first work gets scheduled.
 b) When the last pending work is done arm a timer or schedule a delayed
    special work that kills the thread/s after a while of idleness.
 c) When a new work gets added to an otherwise idle workqueue either:
 	- If we have thread/s we cancel the kill and go on.
	- Else we are back at a) we create it/them.

 And if instead of creating all threads at once, we create them one by
 one as work comes in and also kill them one by one as they stay idle,
 it could be quite smooth.

 How does this sound? Am I over-designing the issue?
 
 IMHO this would remove the threads of unused private workqueues without
 affecting busy workqueues. 

 About using a single thread instead of NN, wouldn't that impact
 workqueue users expecting speedy handling of their queues?

 Have a nice day

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
