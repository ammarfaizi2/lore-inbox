Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273721AbRIXBBh>; Sun, 23 Sep 2001 21:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273726AbRIXBB1>; Sun, 23 Sep 2001 21:01:27 -0400
Received: from zok.SGI.COM ([204.94.215.101]:45214 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S273721AbRIXBBM>;
	Sun, 23 Sep 2001 21:01:12 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5 
In-Reply-To: Your message of "Mon, 24 Sep 2001 08:42:25 +1000."
             <E15lHxB-0005dt-00@wagner> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Sep 2001 11:01:29 +1000
Message-ID: <4103.1001293289@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001 08:42:25 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>In message <20010923124336.D30515@nightmaster.csn.tu-chemnitz.de> you write:
>> Can the startcall or the initcall still be called after stopcall? 
>
>No: at this stage the module will have to be reloaded, exactly because
>of assumptions like zero-initialization.

When we discussed this at linux.conf.au in Sydney, we agreed that we
could call startfn after stopfn to handle the quiesce unload algorithm.
That handles the rmmod race without exporting mod use count to
everything, i.e.

  rmmod
  if use count == 0, call stopfn()
    synchronize_kernel()
    if use count == 0, exitfn()
    if use count != 0, startfn()

That catches the race where a second cpu has entered the module but not
done MOD_INC_USECOUNT yet.  The module is now in use but stopfn has
been called, the best thing to do is accept that rmmod lost the race
and reinstate the module.

