Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269468AbRHCQoK>; Fri, 3 Aug 2001 12:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269472AbRHCQoA>; Fri, 3 Aug 2001 12:44:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269468AbRHCQnz>; Fri, 3 Aug 2001 12:43:55 -0400
Date: Fri, 3 Aug 2001 12:44:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrey Ilinykh <ailinykh@usa.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: fake loop
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>
Message-ID: <Pine.LNX.3.95.1010803123040.675A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Aug 2001, Andrey Ilinykh wrote:

> Hi!
> Very often I see in kernel such code as
> do {
>   dosomthing();
> } while(0);
> 
> or even
> 
> #define prepare_to_switch()     do { } while(0)
> 
> Who can explain me a reason for these fake loops?
> Thank you,
>   Andrey
> 

Yes! This is neat! The { } defines a new program unit. Therefore,
you can allocate temporary variables within it, like:

    do {
        int i;
        for(i=0; i< MAX; i++)
          do_something(i);
       } while (0);

The new "i" doesn't interfere with any previous one because it is
an independent program-unit and it executes just once.

Then, the second reason is also real neat.

#define foo do {printk(...);do_something;do_something_else;} while (0)

In the code, you can now do:

    if(event)
        foo;
    else
        bar;

Since the program unit contains its own {}, you don't have to worry
about what the "else" refers to, it always refers to if(event) even
if the "do while {} (0)" contains conditional statements.

FYI, it is an ISO C compatible construct, not a "gnuism". Therefore,
it is a safe and effective way to even make statements disappear
under certain conditions:

#ifdef __SMP__
#define foo something_that_exists_only_under_these_conditions()
#else
#define foo do { } while(0)
#


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


