Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313126AbSDDKU5>; Thu, 4 Apr 2002 05:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSDDKUs>; Thu, 4 Apr 2002 05:20:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44294 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313124AbSDDKUm>;
	Thu, 4 Apr 2002 05:20:42 -0500
Message-ID: <3CAC28C2.927F29E5@zip.com.au>
Date: Thu, 04 Apr 2002 02:19:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ishan O. Jayawardena" <ioshadij@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] kjournald locking fix
In-Reply-To: <Pine.LNX.4.21.0204041539260.572-200000@shalmirane.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ishan O. Jayawardena" wrote:
> 
> Greetings,
> 
>         kjournald seems to be missing an unlock_kernel() for a matching
> lock_kernel(). A posting by  Dennis Vadura to l-k mentions (among other
> things) a kernel message that says kjournald exited with preempt_count ==
> 1. The attached patch (text/plain) adds the necessary
> unlock_kernel(). [But I haven't been able to reproduce the hang that
> Dennis experiences...]
>         Tested only on UP. Patch is for 2.4.19-pre5 + prempt-kernel, _no_
> lock-break. I hope the positioning of unlock_kernel() is correct... please
> correct me if I'm wrong.

The unlock_kernel() is fine.  The kernel will drop the
lock for us as the task makes its final call to schedule()
on its way to the process graveyard, but it's neater this way.

>         Please CC me (ioshadij@hotmail.com). I can't subscribe to the list
> with my own ISP because they aren't ECN-friendly, and subscribing via
> 
> PS: Of course, the reparent_to_init() isn't part of the fix, but I've seen
> kjournald become a zombie in an ugly episode with a deadlock in devfs many
> moons ago.

I've always put the reparent_to_init() call after the daemonize()
call.  I don't immediately see anything wrong with doing it
beforehand, but that is a less tested code sequence.

But yes, you're right - kjournald needs to call reparent_to_init(),
else it'll turn into a zombie if the process which mounted the
filesystem is still running.

Could you please move the reparent_to_init() down a line and send
a diff to Marcelo?

Thanks.
