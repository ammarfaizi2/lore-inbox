Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSFQR1T>; Mon, 17 Jun 2002 13:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSFQR1S>; Mon, 17 Jun 2002 13:27:18 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:43525 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S316803AbSFQR1R>; Mon, 17 Jun 2002 13:27:17 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7881@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'rwhite@pobox.com'" <rwhite@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'Theodore Tso'" <tytso@mit.edu>
Subject: RE: n_tty.c driver patch (semantic and performance correction) (a
	ll recent versions)
Date: Mon, 17 Jun 2002 10:27:15 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, June 15, 2002 at 9:01 PM, Robert White wrote:
> Kernel Versions: 2.2, 2.4, 2.5 (all of them since 1996 really 8-)
> 
> The n_tty line discipline module contains a "semantic error" that 
> limits its speed and usefulness in many uses.  The attached patch 
> directly addresses serial performance in a completely backwards-
> compatible way.
> 
> In particular, the current handling of VMIN hugely limits, 
> complicates, and/or slows down optimal serial use.  The most 
> obvious example is that if you call read(2) with a buffer size less 
> than the current value of VMIN, the line discipline will insist 
> that the read call wait for characters that can not be returned to 
> that call.  The POSIX standard is silent on the subject of whether 
> this is right or wrong.  Common sense says it is wrong.

Hi,

IIRC, the way VMIN>0,VTIME=0 is supposed to work is to make characters 
available to the top level queue to be read when the low level input 
queue contains VMIN or more characters. Until that moment, there are 
no characters available to a read of any buffer size regardless of how 
many characters have been received at the low level. This is why a 
single character read blocks when at least one character has been 
received but not yet VMIN characters. Only data in the top level queue 
can be read. If the line discipline has not yet released data to the 
top level queue because of VMIN, then no data can be read, but this is 
not an error. 

Many have been tempted to change the behavior of this part of the 
system. IMHO, it is not worth tossing away application portability. 

Standards compliance can feel a bit like vertigo while instrument 
flying. Sometimes one has to just stare at the artificial horizon and 
say "I believe it" to one's self until the gut is convinced. 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
