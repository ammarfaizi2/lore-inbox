Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTEIJIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTEIJIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:08:47 -0400
Received: from [193.170.194.10] ([193.170.194.10]:48138 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262409AbTEIJIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:08:46 -0400
Date: Fri, 9 May 2003 11:20:27 +0200
From: Andi Kleen <ak@muc.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: hammer: MAP_32BIT
Message-ID: <20030509092026.GA11012@averell>
References: <3EBB5A44.7070704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBB5A44.7070704@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 09:35:32AM +0200, Ulrich Drepper wrote:
> It would be much better if there would also be a MAP_32PREFER flag with
> the appropriate semantics.  The failing mmap() calls seems to be quite
> expensive so programs with many threads are really punished a lot.

That's just an inadequate data structure. It does an linear search of the
VMAs and you probably have a lot of them. Before you add kludges like this 
better fix the data structure for fast free space lookup.

MAP_32BIT currently limits to the first 2GB only. That's needed because
most programs use it to allocate modules for the small code model and that
only supports 2GB (poster child for that is the X server) But for your 
application 4GB would be better. But adding another MAP_32BIT_4GB or so
would be quite ugly. I considered making the address where mmap starts searching
(TASK_UNMAPPED_BASE) settable using a prctl.

In some vendor kernels it's already in /proc/pid/mapped_base, but that is 
quite costly to change. That would probably give you the best of both, Just 
set it to a low value for the thread stacks and then reset it to the default.

I guess that would be the better solution for your stacks. 

-Andi
