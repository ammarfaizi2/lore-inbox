Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265868AbTF3UNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbTF3UNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:13:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39627 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265869AbTF3UNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:13:42 -0400
Date: Mon, 30 Jun 2003 22:27:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 compile warnings
Message-ID: <20030630202752.GJ282@fs.tum.de>
References: <5.1.0.14.2.20030630170916.00afd930@pop.t-online.de> <20030630160319.GA15506@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630160319.GA15506@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 06:03:19PM +0200, Andries Brouwer wrote:
> On Mon, Jun 30, 2003 at 05:13:05PM +0200, Margit Schubert-While wrote:
> > 2.5.73 + latest cset
> > GCC 3.3
> > 
> > drivers/char/vt_ioctl.c: In function `do_kdsk_ioctl':
> > drivers/char/vt_ioctl.c:85: warning: comparison is always false due to 
> > limited range of data type
> > drivers/char/vt_ioctl.c:85: warning: comparison is always false due to 
> > limited range of data type
> > drivers/char/vt_ioctl.c: In function `do_kdgkb_ioctl':
> > drivers/char/vt_ioctl.c:211: warning: comparison is always false due to 
> > limited range of data type
> > 
> > drivers/char/keyboard.c: In function `k_fn':
> > drivers/char/keyboard.c:665: warning: comparison is always true due to 
> > limited range of data type
> 
> These are checks of the "cannot happen" type, where "cannot happen"
> can be seen by the compiler, so that it can optimize the tests away.
> 
> As it is now, correctness of the code can be seen locally.
> If the tests are removed, a human reader must look up the values
> of these constants to conclude that the code is correct.

There are cases where a comparison is only on 32 bit architectures 
always true/false (if longs are involved).

There are cases where a #define is set that might be set differently
under certain circumstances:

<--  snip  -->

#define MAX_VALUE 10000

u8 tmp;

if (tmp > MAX_VALUE)
    return -ESOMEERROR;

<--  snip  -->


These are cases where the warning is just noise. But this new warning 
already found several bugs, there are several places where I sent 
patches for things like:

<--  snip  -->

u8 i;

for (i = 0; i <= 0xFF; i++)
    do_something;

<--  snip  -->


In these cases the warning found an actual bug.


Is there any way to tell gcc to disable such warnings locally?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

