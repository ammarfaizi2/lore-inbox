Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbSI3EXr>; Mon, 30 Sep 2002 00:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261916AbSI3EXr>; Mon, 30 Sep 2002 00:23:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52678 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261910AbSI3EXq>;
	Mon, 30 Sep 2002 00:23:46 -0400
Date: Mon, 30 Sep 2002 10:03:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020930100317.A21939@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain> <20020930004559.A19071@in.ibm.com> <20020929.172022.23984844.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929.172022.23984844.davem@redhat.com>; from davem@redhat.com on Sun, Sep 29, 2002 at 05:20:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:20:22PM -0700, David S. Miller wrote:
>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    Date: Mon, 30 Sep 2002 00:45:59 +0530
> 
>    > net_bh_lock: i have removed it, since it would synchronize to nothing. The
>    > old protocol handlers should still run on UP, and on SMP the kernel prints
>    > a warning upon use. Alexey, is this approach fine with you?
>    
>    The cache line bouncing of global_bh_lock and net_bh_lock in
>    run_timer_tasklet() show up in our profiles, so getting rid of
>    them is a good thing (TM).
>    
> What ancient protocols are you running that make use of this?

I wasn't running any old protocols. It was a problem I faced
with my port of smptimers - I serialized
wrt BHs and old protocols using global_bh_lock and net_bh_lock (exported
it globally) respectively in the per-cpu tasklet that runs timers.
So, the spin_trylock() in run_timer_tasklet() would modify the
lock cache line and hence the bouncing. Getting rid of BHs and
old protocol serialization avoids this as in Ingo's latest patch.

> 
> IPv4 and IPv6 both do not use it at all.  Even IPX, Appletalk, and
> DecNET layers do not use it

This is the list, I think,  by looking at packet_types -

        802/psnap.c
        appletalk/ddp.c
        ax25/af_ax25.c
        core/ext8022.c
        econet/af_econet.c
        irda/irsyms.c
        x25/af_x25.c

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
