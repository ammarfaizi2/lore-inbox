Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVEKLBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVEKLBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 07:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVEKLBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 07:01:18 -0400
Received: from [195.23.16.24] ([195.23.16.24]:12762 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261965AbVEKLAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 07:00:06 -0400
Message-ID: <4281E5AE.4090601@grupopie.com>
Date: Wed, 11 May 2005 11:59:58 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: arm: Inconsistent kallsyms data
References: <1115802310.9757.20.camel@mammoth.research.nokia.com>
In-Reply-To: <1115802310.9757.20.camel@mammoth.research.nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imre Deak wrote:
> Hi,
> 
> building 2.6.12-rc4 results in "Inconsistent kallsyms data". Setting
> CONFIG_KALLSYMS_EXTRA_PASS=y doesn't help.
> 
> I made a diff of .tmp_kallsyms[12].S after converting them to human
> readable form with kallsyms_uncompress.pl .

 From the diff, I can see the problem is that "__bss_start" changes 
position with "_edata" from the first to the second pass.

If your read my post from yesterday "Re: Linux v2.6.12-rc4" (not a very 
descriptive subject), I explain there why this is a problem.

Sam, from looking at your patch, it seems that the patch shouldn't 
affect these particular symbols. Am I correct?

Maybe we really need the more robust fix to kallsyms, so that this sort 
of thing doesn't bite us in the future, no matter what symbols change 
position.

> I noticed that the error is triggered by an __initdata definition. It is
> accessed only from an __init function, so that's ok I think. Removing
> the __initdata attribute gets rid of the error message.

This is just a "tape over" solution that makes the symbols change 
positions, so that maybe these 2 symbols don't get selected for sampling.

> Let me know if you need more data to track the problem.

There is a simple workaround that is to increase the WORKING_SET define 
in scripts/kallsyms.c to something like 65536. This will include every 
symbol in the token table calculation, so that even if symbol position 
changes, the token table should be the same.

I tested this with a configuration I have here that had a similar 
problem and it indeed worked as expected.

The problem with this approach is that it takes longer to calculate the 
token table. (~3secs on my P4 2.8GHz, 11300 symbols)

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
