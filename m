Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVCZIp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVCZIp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVCZIp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:45:57 -0500
Received: from grunt3.ihug.co.nz ([203.109.254.43]:40609 "EHLO
	grunt3.ihug.co.nz") by vger.kernel.org with ESMTP id S261924AbVCZIpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:45:47 -0500
Date: Sat, 26 Mar 2005 20:32:55 +1200 (NZST)
From: Bart Oldeman <bartoldeman@ihug.co.nz>
To: Arjan van de Ven <arjan@infradead.org>
cc: Arnd Bergmann <arnd@arndb.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-rc1 breaks dosemu
In-Reply-To: <1111825501.6293.25.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0503262023250.3166@enm-bo-lt.localnet>
References: <20050320021141.GA4449@stusta.de>  <200503251952.33558.arnd@arndb.de>
  <1111778074.6312.87.camel@laptopd505.fenrus.org>  <200503252354.53154.arnd@arndb.de>
 <1111825501.6293.25.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Arjan van de Ven wrote:

> looking at the dosemu code; the following bit looks a tad suspect:
>
> unsigned long int stk_ptr, stk_beg, stk_end;
> ...
>  if ((fp = fopen("/proc/self/maps", "r"))) {
>     while(fgets(line, 100, fp)) {
>       sscanf(line, "%lx-%lx", &stk_beg, &stk_end);
>       if (stk_ptr >= stk_beg && stk_ptr < stk_end) {
>         stack_init_top = stk_end;
>         stack_init_bot = stk_beg;
>         c_printf("CPU: Stack bottom %#lx, top %#lx, esp=%#lx\n",
> 	  stack_init_bot, stack_init_top, stk_ptr);
> 	break;
>       }
>     }
>     fclose(fp);
>   }
>
> do you see that printf somewhere in the logs?
> (afaics stk_ptr never gets initialized; what the code meant probably was
>  if (&stk_ptr >= stk_beg && &stk_ptr < stk_end) {
> but the dosemu code is missing the two &'s )

I think stk_ptr is OK, and the log reports it correctly. Inline assembly
gives it the value of esp. Also, this code is meant for DPMI programs so
if it is the culprit it should not crash dosemu straight away, only if
you'd start DOOM or something like that.

The log prints:
CPU: Stack bottom 0xbfd61000, top 0xbfd76000, esp=0xbfd75480

To Arnd:
There is one more improbable thing I can think of: comcom. This is
dosemu's built-in command.com and uses some very tricky code
(coopthreads), which certainly does not work any more with address space
randomization. It's deprecated but was still present in 1.2.2, and Debian
packages still used it with dosemu 1.2.1. The fix for that one is easy:
replace your command.com with a real DOS command.com (e.g. FreeDOS
freecom).

Bart

