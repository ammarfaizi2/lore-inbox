Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSGBIuW>; Tue, 2 Jul 2002 04:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSGBIuV>; Tue, 2 Jul 2002 04:50:21 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43013 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316682AbSGBIuU>; Tue, 2 Jul 2002 04:50:20 -0400
Message-ID: <3D2169CB.73126A47@aitel.hist.no>
Date: Tue, 02 Jul 2002 10:52:27 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
References: <31042.1025576745@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 1 Jul 2002 22:40:34 -0300,
> Werner Almesberger <wa@almesberger.net> wrote:
> >If I remember right, the main arguments why module removal can
> >race with references were:
> >....
> > - removal happening immediately after module usage count is
> >   decremented to zero may unload module before module has
> >   executed "return" instruction
> >For the removal-before-return problem, I thought a bit about it
> >on my return flight. It would seem to me that an "atomic"
> >"decrement_module_count_and_return" function would do the trick.
> 
> This is just one symptom of the overall problem, which is module code
> that adjusts its use count by executing code that belongs to the
> module.  The same problem exists on entry to a module function, the
> module can be removed before MOD_INC_USE_COUNT is reached.
> 
> Apart from abandoning module removal, there are only two viable fixes:
> 
> 1) Do the reference counting outside the module, before it is entered.
> 
>    This is why Al Viro added the owner: __THIS_MODULE; line to various
>    structures.  The problem is that it spreads like a cancer.  

How about letting the module handle the reference counting but
with one key difference from today's arrangement:

The _code_ for inc/decrementing is kept outside the modules, in
the permanent part of the kernel.  So the module simply
does something like     decrement_usecount(&my_use_count)

decrement_usecount will return to the module _if_ the count
didn't reach 0.  If it does, it goes straight to whatever 
usually happens after the module returns.  (I.e. pop the
return address that goes to the module, and return to where
the module were supposed to return.)

The module gets an additional restriction: decrement_usecount
may not return so all cleanup etc. must be done first, so
only a return remains when it is called.

The "unsafe return" after decrementing to 0 is eliminated.

Helge Hafting
