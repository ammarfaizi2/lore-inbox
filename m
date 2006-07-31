Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWGaPLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWGaPLn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWGaPLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:11:43 -0400
Received: from web36702.mail.mud.yahoo.com ([209.191.85.36]:45486 "HELO
	web36702.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932100AbWGaPLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:11:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mINDqaeoc2SgFRT3ZAR/6F4ZXdMmYrcintpofRlJgGPPSw+CXe1tG2UjpSJbcLSrHeEHr1ZzGfxr5Ws2FVYeiCUMplPi5rj5RVoceTgId0hWEmKeyYz+K9CySAWHfgoBNcKaHy6yfPW634rVnykgxpyq0NZfm53AU3yLCYjPXIg=  ;
Message-ID: <20060731151141.45469.qmail@web36702.mail.mud.yahoo.com>
Date: Mon, 31 Jul 2006 08:11:41 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44CC85FD.1050000@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Then try to make qualified guesses. Even if the
> constants are
> TIFM_INTFLAG_2, that still makes the code more
> readable as you see which
> values are the same constant.
It is not necessarily good idea for constants that are
used only once on initialization. May be a side
comment will be better. I'll check this out.

> Is it possible for a "socket" to have
> multiple "card":s
> associated with it? Otherwise I see little need for
> the dynamic behaviour.

It appears that any socket can hold any card type. So
the logic goes as following:
1. Get insertion interrupt on socket
2. Detect card type
3. Stick proper handler to the socket
...do work
4. Get removal interrupt on socket
5. Ditch type-specific handler, mark socket as empty
A quick example: on 8033 sd cards are most often wired
to socket 3, while on 803b they are wired to socket 1.

> Sorry, I was a bit unclear. Of course hardware cares
> about what kind of
> response it will get. What I meant was that hardware
> shouldn't care if
> it's R1, R2 or R666. 

I'm afraid you'll have to clarify this issue further.
Consider the following: TI uses look up table to set
command type register. The decoding of this table is
my tifm_sd_op_flags. Its output directly sent to
hardware. Can you notice any bit patterns here:
Response type (4b):
R1 - 1     R1b - 9 (so highest 1 is MMC_RSP_BUSY)
R2 - 2     R3 - 3      R6 - 6
(if bit 1 is MMC_RSP_136 why it is set for R3 and R6;
and if it's MMC_RSP_CRC why it is not set for R1?)

Command type (2b):
BC - 0 (implied)   BCR  - 1
AC - 2             ADTC - 3 
(even if higher bit stands for "addressed vs
broadcast" it still doesn't make sense for lower bit).

By the way, if I recall correctly, SD spec does not
splits command types and responses into components. It
always speaks of R1s and R6s and so on.

> Baby steps. If you test carefully enough (and do
> some qualified
> guessing), you usually can figure out what most bits
> of a register are for.

It's not hard to figure out bits that are used
systematically. The problem is that there are 4 or 5
registers that are set to some constant at
initialization. I made all kinds of trials with them
and got no conclusive idea on their meaning.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
