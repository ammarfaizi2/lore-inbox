Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUIALRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUIALRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUIALRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:17:34 -0400
Received: from [195.23.16.24] ([195.23.16.24]:3468 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266133AbUIALR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:17:29 -0400
Message-ID: <4135AFBE.1000707@grupopie.com>
Date: Wed, 01 Sep 2004 12:17:18 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
References: <4134DEF4.8090001@grupopie.com> <1094016277.17828.53.camel@bach>
In-Reply-To: <1094016277.17828.53.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.40; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Wed, 2004-09-01 at 06:26, Paulo Marques wrote:
> 
>>This patch implements the "is_exported" bit in the kallsyms_names
>>compressed stream, so that a "cat /proc/kallsyms" doesn't call
>>is_exported on every iteration.
> 
> 
> Prefer the patch split into "comments", "inconsistent kallsyms data fix"
> and "speedup".  I also prefer using a whole letter over a single bit:
> this allows archs which have wierd nm letters to express them, and
> instead of case indicating what symbols are exported, we get the real
> correct results.

I'm still new to this :(

I'll send more fine-grained patches next time, grouped by issue addressed.

The single bit approach was meant to keep the current behavior, because
that is what I thought you wanted:

> The current code is simple.  We could reserve the first letter in
> kallsyms_names for the type letter from System.map.  The current upcase
> semantics are deliberately distorted to be more kernel-relevant (ie.
> exported are upper case) but simplistic.
> 
> That's how I'd recommend "fixing" it.

I read this as: "we could have used the first letter in each symbol for
the type letter from System.map, but we deliberately distorted the
current semantics to be more kernel-relevant."

Since we are on different time zones, we only get to send an email a
day, so asking for confirmation and waiting for the reply would take a
long time... :(

Anyway, I'm assuming now that what we really want is the same type chars
that appear on the System.map file. If compiled with KALLSYMS_ALL, the
/proc/kallsyms file would be an almost exact copy of System.map.

So, moving forward...

A defconfig build produces 13743 symbols with a compressed name stream
of ~130kB. (it is 240kB uncompressed, for the curious)

Adding a letter to each symbol would increase this by about 10%.

We can try 2 different approaches to minimize the impact of this:

  - have the letter inserted before the compression step. This way, the
    table of the best tokens may have "tacpi_" instead of "acpi_" and
    the compression would not suffer as much, except that the symbols
    started with "Tacpi_" would suffer. Only real tests can show how
    this would turn out.

  - build a "sections" table that groups together symbols with the same
    letter. The table would say symbols that have addresses between
    X and Y would have letter Z. This can go horribly wrong if there
    are situations where completely different type letters appear
    intermixed.

I think I'll try the first approach first and see how it goes. I'll
post as soon as I got some numbers.

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
