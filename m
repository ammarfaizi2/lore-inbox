Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSGBQPe>; Tue, 2 Jul 2002 12:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSGBQPd>; Tue, 2 Jul 2002 12:15:33 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:36566 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316833AbSGBQPc>;
	Tue, 2 Jul 2002 12:15:32 -0400
Date: Tue, 2 Jul 2002 13:22:23 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
Message-ID: <20020702132223.H2295@almesberger.net>
References: <31042.1025576745@kao2.melbourne.sgi.com> <3D2169CB.73126A47@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2169CB.73126A47@aitel.hist.no>; from helgehaf@aitel.hist.no on Tue, Jul 02, 2002 at 10:52:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> decrement_usecount will return to the module _if_ the count
> didn't reach 0.  If it does, it goes straight to whatever 
> usually happens after the module returns.

This looks appealing, but you still need an unconditional
"decrement_module_count_and_return", like I proposed earlier,
because multiple decrement_usecount could race with removal,
so you'd still hit removed code.

Example:

	...
	decrement_usecount();
	return; /* unsafe */
}

Now we have two CPUs executing this, and the third one will
remove the module.

Use count	CPU 1		CPU 2		CPU 3
    2		decrement	...		...
    1		return 1x	decrement	...
    0		-		return 2x	remove
    0		*CRASH*		...		...

The only case where decrement_usecount would work is if all
possible callers of decrement_usecount are serialized. I
can't think of any case where this is true, and just moving
the decrementing before the return(s) would improve anything
but perhaps the code structure, so I'm not sure if this would
be worth the potential and easily overlooked problems.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
