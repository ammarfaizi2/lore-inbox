Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSKFLGZ>; Wed, 6 Nov 2002 06:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKFLGY>; Wed, 6 Nov 2002 06:06:24 -0500
Received: from [195.223.140.107] ([195.223.140.107]:51844 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264983AbSKFLGY>;
	Wed, 6 Nov 2002 06:06:24 -0500
Date: Wed, 6 Nov 2002 12:11:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@conectiva.com.br>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Kswapd madness in 2.4 kernels
Message-ID: <20021106111149.GC3823@x30.school.suse.de>
References: <200210242026.13071.jamesclv@us.ibm.com> <3DB8C941.DEF1C069@digeo.com> <200211051413.00661.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211051413.00661.jamesclv@us.ibm.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 02:13:00PM -0800, James Cleverdon wrote:
> Status report:
> 
> Due to dependencies, I didn't try the two recommended patches alone.  I ran 
> Andrea's 2.4.20-pre10aa1 kernel on the test load for one week.  Low memory 
> was conserved and kswapd never went out of control.  Presumably, 
> 05_vm_16_active_free_zone_bhs-1 did the job for buffers, and the inode patch 
> continued to work.

yes, for stability the related-bh patch is known to be more than enough
and this is a nice confirmation. I would also like to integrated some
bit of andrew's nuke-buffer patch for performance reasons (to maximize
the free memory utilization), not for stability. For stability teaching
the VM about the problem is the right fix IMHO, good to have regardless
in case for some reason the bh cannot be nucked if we can't take a lock
or similar. But the bit that drops the bhs after reads may improve
memory utilization when there is no memory pressure at all. The part I
wouldn't merge in 2.4 from the Andrew's patch is the drop after writes,
that has the potential of slowing down rewrite. I'm not saying it will
slow down the rewrite performance, but there is definitely the
potential. My fix instead has no way to affect read/writes w/o memory
pressure compared to mainline (i.e. in a <1G machine).

> Are there any plans on getting these into 2.4.21?

the related-bhs fix should be definitely integrated. Then Andrew's patch
that drops bh after reads may be an obvious further optimization but not
really related to this bug anymore. I didn't experimented with it yet
because it was low prio and it can only improve performance by saving
some ram. And even only merging the drop bhs after read from the
nuke-buffers, still might decrease performance in a read+write case in
the same pagecache block, but that case probably isn't very common,
rewrite instead is more likely to happen.

> > Yes, these patches are a good idea.  I'm curious why they
> > haven't been submitted to Marcelo yet ;)
> >

they have been sumitted, I think I covered this bit with Marcelo during
the kernel summit, but you know there are many other important patches
to merge, the google fix etc.. but we must not forget that lots of them
are been just integrated in 2.4.20pre, it is normal that we discuss
only the pending fix that aren't been integrated yet and we forget about
the ones that are just included ;).

Andrea
