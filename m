Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSG3SWP>; Tue, 30 Jul 2002 14:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSG3SWP>; Tue, 30 Jul 2002 14:22:15 -0400
Received: from agate.roonetworks.com ([12.44.168.40]:29314 "EHLO
	h216.ofc.roonetworks.com") by vger.kernel.org with ESMTP
	id <S316768AbSG3SWO>; Tue, 30 Jul 2002 14:22:14 -0400
From: Remco Treffkorn <remco@rvt.com>
Reply-To: remco@rvt.com
To: "David S. Miller" <davem@redhat.com>
Subject: Re: 3 Serial issues up for discussion
Date: Tue, 30 Jul 2002 11:23:47 -0700
User-Agent: KMail/1.4.5
Cc: dan@embeddededge.com, benh@kernel.crashing.org, trini@kernel.crashing.org,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
References: <20020729181352.27999@192.168.4.1> <200207291246.43134.remco@rvt.com> <20020729.195414.31386335.davem@redhat.com>
In-Reply-To: <20020729.195414.31386335.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207301123.48322.remco@rvt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 19:54, David S. Miller wrote:
>    From: Remco Treffkorn <remco@rvt.com>
>    Date: Mon, 29 Jul 2002 12:46:42 -0700
>
>    Drivers need not fight about minor numbers. That can be simply handled:
>
>    int get_new_serial_minor()
>    {
>        static int minor;
>
>        return minor++;
>    }
>
>    Any serial driver can call this when it initializes a new uart.
>    Hot pluggable drivers have to hang on to their minors, and
>    re-use.
>
> I don't think it's wise to make hot-plug drivers keep track
> of the minors they ever use in such a sloppy way.  Why not
> make the get_new_serial_minor() thing have a release method
> too and then we can keep track of minor allocation in one
> place.
>
> Also if I remmove the module for a serial port driver, those minors
> should get reused by the next registered uart too.

Point taken.
Here are a few more points.

The given solution presents almost zero overhead, but has the mentioned 
problem. There is a way to allocate and free minor numbers, but that requires 
storage. It could be handled like the fd_set's select uses. Just a bit field. 
Bit cleared == minor available, bit set == in use.

If you want to do that, you would want to know the maximum number of minors 
used. Also, finding the first cleared bit in your field costs more on some 
platforms, than on others.

Although I suspect this additional overhead to not matter much, since 
initialising a new uart is a rare event, I have bin surprised in the past.

So:
How many minors?
Is the overhead in getting a minor acceptable?
Is it worth doing?

Cheers,
Remco

-- 
Remco Treffkorn (RT445)
HAM DC2XT
remco@rvt.com   (831) 685-1201
