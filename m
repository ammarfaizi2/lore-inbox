Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUI0Sya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUI0Sya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUI0Sy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:54:29 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:62140 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267195AbUI0SyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:54:12 -0400
Message-ID: <415861C4.4030604@colorfullife.com>
Date: Mon, 27 Sep 2004 20:53:56 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Jean-Luc Cooke <jlcooke@certainkey.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:55:55AM -0400, Theodore Ts'o wrote:
> 
> While you're at it, please re-read RFC 793 and RFC 1185.  You still
> don't have TCP sequence generation done right.

Actually trying to replace the partial MD4 might be worth an attempt: 
I'm certain that the partial MD4 is not the best/fastest way to generate 
sequence numbers.
 >
 >The only real way to settle this would be to ask Jamal and some of the
 >other networking hackers to repeat their benchmarks and see if the AES
 >encryption for every TCP SYN is a problem or not.
 >
It would be unfair: The proposed implementation is not optimized - e.g. 
the sequence number generation runs under a global spinlock. On large 
SMP systems this will kill the performance, regardless of the internal 
implementation.

For the Linux-variant of RFC 1948, the sequence number generation can be 
described as:
A hash function that generates 24 bit output from 96 bit input. Some of 
the input bits can be chosen by the attacker, all of these bits are 
known to the attacker. The attacker can query the output of the hash for 
some inputs - realistically less than 2^16 to 2^20 inputs. A successful 
attack means guessing the output of the hash function for one of the 
inputs that the attacker can't query.

Current implementation:
Set the MD4 initialization vector to the 96 bit input plus 32 secret, 
random bits.
Perform an MD4 hash over 256 secret, random bits.
Take the lowest 24 bits from one of the MD4 state words.
Every 5 minutes the secret bits are reset.

For IPV6, the requirements are similiar, except that the input is 288 
bits long.

--
    Manfred
