Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVCNNeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVCNNeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVCNNeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:34:21 -0500
Received: from [195.23.16.24] ([195.23.16.24]:37021 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261491AbVCNNdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:33:54 -0500
Message-ID: <423592BB.80207@grupopie.com>
Date: Mon, 14 Mar 2005 13:33:47 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: inconsistent kallsyms data [2.6.11-mm2]
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050308192900.GA16882@isilmar.linta.de> <20050308123554.669dd725.akpm@osdl.org> <20050308204521.GA17969@isilmar.linta.de> <422EF2B0.7070304@grupopie.com> <422F59A3.9010209@grupopie.com> <423039A6.5010301@grupopie.com> <20050313085441.GA24006@mars.ravnborg.org>
In-Reply-To: <20050313085441.GA24006@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Mar 10, 2005 at 12:12:22PM +0000, Paulo Marques wrote:
> 
>>Paulo Marques wrote:
>>
>>>[...]
>>>A simple and robust way is to do the sampling on a list of symbols 
>>>sorted by symbol name. This way, even if the symbol positions that are 
>>>given to scripts/kallsyms change, the symbols sampled will be the same.
>>>
>>>I'll do the patch to do this and send it ASAP.
>>
>>Ok, here it is.
>>
>>Dominik can you try the attached patch and see if it solves the problem?
> 
> Hi Paulo.

Hi Sam :)

> Alexander Stohr had similar problems with down and __sched_text_start.
> 
> I figured out that what was causing the troubles was the fact that the
> linker generated symbol __sched_text_start changed value from pass 1 to
> pass 2. The reason for this was the alingment used within that section.

Damn, you're right. Looking more carefully at Dominik's files I can see 
that on the first pass we have:

T __sched_text_start 	PTR	0xc0420482
t __down 	PTR	0xc0420484

and on the second pass:

t __down 	PTR	0xc0420484
T __sched_text_start 	PTR	0xc0420484

I only looked at the addresses on the second pass and noticed they were 
aliased symbols and that the symbol order changed from the first pass :P

> I never came around submitting this since I do not know what the correct
> number for function alignment is on different paltforms.

If this will just align the beginning of a section, I don't think it 
will be a problem to always align at 8 bytes even on platforms that need 
only a 4 byte alignment.

So I think that your patch should definitely go in, as it solves a real 
problem.

As for my patch it could potentially solve problems that we don't 
currently have(*), so it is probably better to wait for them to appear 
before trying to solve an non-existent problem :)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

(*) order of aliased symbols changing, or 'nm' returning non sorted 
addresses.
