Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUCaSwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCaSwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:52:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63364 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262339AbUCaSwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:52:25 -0500
Date: Wed, 31 Mar 2004 13:53:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alex Williamson <alex.williamson@hp.com>
cc: davidm@hpl.hp.com, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       ulrich.windl@rz.uni-regensburg.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip
 400000000062ada1, isr 0000020000000008
In-Reply-To: <1080757433.2326.32.camel@patsy.fc.hp.com>
Message-ID: <Pine.LNX.4.53.0403311339550.12319@chaos>
References: <406AE0D5.10359.1930261@localhost> 
 <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua> 
 <16491.2184.253165.545651@napali.hpl.hp.com> <1080757433.2326.32.camel@patsy.fc.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Alex Williamson wrote:

> On Wed, 2004-03-31 at 11:06, David Mosberger wrote:
>
> > If the messages appear with a frequency of less than 5 messages/5
> > seconds, then there is certainly no performance issue and you may want
> > to just turn off the messages.
>
>    But if you do get them at the maximum rate for a computational
> application, performance could be _severely_ impacted (ie. orders of
> magnitude).
>
> 	Alex
>
The power-on or hardware-reset default for the ix86 FPU
is to attempt to handle div 0 errors transparently.
In others words:

R = 1 / (1/r1 + 1/r2 + 1/r3 +...) will resolve correctly
if any r...n = 0. Parallel resistance when one or more
resistors is 0 ohms.

This it probably not the default for the Itanium so your
application either needs to be fixed or at least needs to
set the FPU to handle these problems. The configuration of
the FPU remains, per-process, so some executable could
be run upon login to "fix" the processor.

The following program should cause the bad program to
core-dump any time it is run. You could also configure
this so it lets anybody write garbage and it will "work".

----------------------------------------------------------------
/*
 *  Note FPU control only exists per process. Therefore, you have
 *  to set up the FPU before you use it in any program.
 */
#include <fpu_control.h>

#define FPU_MASK (_FPU_MASK_IM |\
                  _FPU_MASK_DM |\
                  _FPU_MASK_ZM |\
                  _FPU_MASK_OM |\
                  _FPU_MASK_UM |\
                  _FPU_MASK_PM)

void fpu()
{
    __setfpucw(_FPU_DEFAULT & ~FPU_MASK);
}

main() {
   double zero=0.0;
   double one=1.0;
   fpu();

   one /=zero;  // Testing, remove this after
}
-----------------------------


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


