Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSE3JFz>; Thu, 30 May 2002 05:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316523AbSE3JFy>; Thu, 30 May 2002 05:05:54 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:51453 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316512AbSE3JFx>; Thu, 30 May 2002 05:05:53 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15605.60268.673419.701625@wombat.chubb.wattle.id.au>
Date: Thu, 30 May 2002 19:05:48 +1000
To: Michael Dunsky <michael.dunsky@p4all.de>
Cc: linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: Strange code in ide_cdrom_register
In-Reply-To: <3CF5D424.2060500@p4all.de>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michael" == Michael Dunsky <michael.dunsky@p4all.de> writes:

Michael> Hi!  Peter Chubb wrote:
PeterC> Hi, This code snippet in ide_cdrom_register() seems really
PeterC> strange...

>> *(int *)&devinfo->speed = CDROM_STATE_FLAGS
>> (drive)->current_speed; *(int *)&devinfo->capacity = nslots;

PeterC> devinfo-> speed and devinfo->capacity are both ints.  So the casts are
PeterC> just a disaster waiting to happen, if the types of capacity or
PeterC> speed ever change?

Michael> Just take a quick look in drivers/ide/ide-cd.h: values
Michael> "nslots" and "current_speed" are of type "byte", so we need
Michael> to cast to store them (like that) into the
Michael> integer-vars. Nothing strange there....

Sure, the RHS is a byte.  But devinfo->speed is an int and an lvalue. so
&devinfo->speed is an (int*) (so the cast in this case is a no-op),
and *(int*)&devinfo->speed is the same as *&devinfo->speed which is
the same as devinfo->speed.

But, *(int*)&devinfo->speed is an int no matter what type
devinfo->speed has.  So if for some reason, you decide to change the
type of devinfo->speed to a byte, say, the cast will still force
int format data to be stored, overwriting adjacent bits of memory (or
causing an unaligned store trap).

The cast is *wrong*, and potentially dangerous.

I'll submit a patch....

--
Peter C					    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
