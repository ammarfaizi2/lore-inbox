Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVCIVQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVCIVQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCIVQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:16:10 -0500
Received: from [195.23.16.24] ([195.23.16.24]:32132 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262166AbVCIVNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:13:41 -0500
Message-ID: <422F59A3.9010209@grupopie.com>
Date: Wed, 09 Mar 2005 20:16:35 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: inconsistent kallsyms data [2.6.11-mm2]
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050308192900.GA16882@isilmar.linta.de> <20050308123554.669dd725.akpm@osdl.org> <20050308204521.GA17969@isilmar.linta.de> <422EF2B0.7070304@grupopie.com>
In-Reply-To: <422EF2B0.7070304@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> [...]
> Can you send me privately a tar.bz2 containing your .config, 
> .tmp_kallsyms1.S and .tmp_kallsyms2.S so I can try to figure out what's 
> going on?

Ok, after some investigation into the files I was able to find out the 
problem.

scripts/kallsyms.c uses a subset of the symbol table to optimize the 
tokens to use to compress the symbols. It does this because using the 
complete set of symbols would be much slower without a significant gain 
in compression.

For some reason, in the files sent by Dominik, two aliased symbols 
change places from the first to the second step of the kallsyms build 
process (__sched_text_start, __down).

Because of this, the subset used for optimization is different and so 
are the tokens selected, producing a 2 byte difference in the total size 
of the compressed symbol names :P

So I must change the sampling algorithm in a way that is robust to 
symbol position changes.

A simple and robust way is to do the sampling on a list of symbols 
sorted by symbol name. This way, even if the symbol positions that are 
given to scripts/kallsyms change, the symbols sampled will be the same.

I'll do the patch to do this and send it ASAP.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
