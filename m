Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUHQSSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUHQSSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268380AbUHQSSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:18:11 -0400
Received: from [195.23.16.24] ([195.23.16.24]:10142 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268378AbUHQSSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:18:01 -0400
Message-ID: <41224BD7.5070008@grupopie.com>
Date: Tue, 17 Aug 2004 19:17:59 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <6450.1092747900@ocs3.ocs.com.au> <41220FEA.9050106@grupopie.com> <20040817162323.GA7689@mars.ravnborg.org> <20040817175511.GA29763@elte.hu>
In-Reply-To: <20040817175511.GA29763@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.13; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> 
>>That said do not put too much effort moving kode from the kernel to
>>kallsyms.c. kallsyms support can be deselected, and users will not
>>care about the little extra overhead (down in noise compared with the
>>symbols).

I know I'm probably putting to much effort on a low priority task 
(understatement of the year), but I was having fun doing it, so I saw no 
reason to stop :)

The new algorithm that I was thinking about is quite simple from the 
kernel point of view. It takes advantage of the fact that not all 
characters are allowed on symbols.

It uses these extra chars to feed a table that maps "special unused 
char"->"small string". For instance, it can say char \x85 is in fact 
"write_". Interesting enough the best string on my test data is "acpi_", 
and saves about 3kb of data to map it to just one char :)

So the work in the kernel is quite easy, and I believe it will in fact 
be faster than now, using less code.

The real problem is that the algorithm has to give the best strings to 
use in the table fast enough as to not be noticed in the total kernel 
compile time. Selecting the best strings is a really interesting problem 
from a mathematical point of view, and I was trying to solve it just for 
the fun of doing it :)

> distributions tend to enable it though, so saving 64K of kernel RAM is 
> good indeed. Good compression of the symbols increases the applicability 
> of kallsyms.

I'm glad you also found this scheme to be useful.

The code might be useful on other situations where we need to compress 
english text (or something like that) in a way that uncompressing a 
small string is quite fast. (I remember a thread a long time ago about 
compressing all the printk texts in the kernel, so maybe this could be 
useful there too)

-- 
Paulo Marques - www.grupopie.com
