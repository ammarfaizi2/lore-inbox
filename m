Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUHRQAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUHRQAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUHRQAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 12:00:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28546 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267194AbUHRP75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:59:57 -0400
Date: Wed, 18 Aug 2004 11:59:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Daniel Gryniewicz <dang@fprintf.net>
cc: Brian McGrew <Brian@doubledimension.com>, linux-kernel@vger.kernel.org
Subject: Re: Help with mapping memory into kernel space?
In-Reply-To: <1092843015.14961.2.camel@localhost>
Message-ID: <Pine.LNX.4.53.0408181144160.16298@chaos>
References: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com>
 <1092843015.14961.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, Daniel Gryniewicz wrote:

> On Tue, 2004-08-17 at 22:39 -0700, Brian McGrew wrote:
> > Good day All:
> >
>
> <snip>
>
> > The overall problem is that the more system memory we install,
> > the fewer IBB's we can use.  For instance, 256MB lets us use
> > four IBB's; 512MB lets us use three IBB's and so on.  Basicly,
> > the kernel blows up trying to map memory.  Each IBB has two
> > banks of 64MB of RAM on them which we try and memmap to system
> > memory for speed of addressing.  So essentaily, we're sending
> > out four camera systems with only 256MB of memory which is only
> > about one quarter of what we need.
>
> On x86, the kernel has 1 GiB of address space.  Try the 2G/2G split
> patches, or the 4G/4G patches, either one of which should increase your
> kernel address space enough to map both memory and your buffers.
>
> Daniel

>  out four camera systems with only 256MB of memory which is only
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can use as much memory as you can afford if the designer of
this system would only understand that you can't fit 4 GB of
application RAM into 4 GB of address-space and leave anything
available for the system.

It needs to be done like this:

------------|-------------|-----------
 Other      |   N Mbyte   |  Other address space
 address    |   window    |  ..................
------------|-------------|-----------
            |
            |
        -----------------
        | Page register |
        |----------------
                        |
                        -----------------------
                        |    Page 0            |
                        |--|--------------------
                           |  Page 1            |
                           |---------------------
                                Page N, etc.

You make a small window in the available address-space, and you
map your RAM into that address-space with a page register. You
can access much, much more RAM than available address-space,
and with things like video and pictures, the occasional switching
of a page-register adds practically no overhead.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


