Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWJJTGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWJJTGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWJJTGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:06:45 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:37006 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP id S932169AbWJJTGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:06:44 -0400
Message-ID: <452BEF41.9060402@grupopie.com>
Date: Tue, 10 Oct 2006 20:06:41 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Adam Jerome <abj@novell.com>
CC: linux-kernel@vger.kernel.org, Akpm@osdl.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 002/001] /kernel: /proc/kallsyms reports lower-case	types
 for some non-exported symbols       (Resend #1)
References: <452B7079.3C0A.0073.0@novell.com>
In-Reply-To: <452B7079.3C0A.0073.0@novell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Jerome wrote:
> This patch addresses incorrect symbol type information reported through /proc/kallsyms.
> A lowercase character should designate the symbol as local (or non-exported).  An
> uppercase character should designate the symbol as global (or external). Without this
> patch, some non-exported symbols are incorrectly assigned an upper-case designation in
> /proc/kallsyms.  This patch corrects this condition by converting non-exported symbols
> types to lower case when appropriate and eliminates the superfluous upcase_if_global
> function

After looking at this patch I thought "this is all wrong: we should fix 
this at build time and not at run-time". The module infrastructure is a 
little hard to follow, though (Rusty CC'ed).

Anyway, it looks like doing the case correction in add_kallsyms should 
at least avoid the "is_exported" call at every module symbol at every 
"cat /proc/kallsyms". It would be done only once at module loading 
(doing it at build time would be even better, though).

"is_exported" does a linear search inside the symbols of one module, so 
the time it takes to "cat" all the symbols in a module grows O(N^2). 
Although there aren't that many symbols in each module, a quick grep 
shows that "usbcore", for instance, has 876 symbols in /proc/kallsyms.

The st_info field seems to be used only to display the type in 
"/proc/kallsyms" and in mod_find_symname to ignore undefined symbols 
(this would have to be adjusted if the case of the 'U' symbol is changed).

This has actually very little to do with the patch in question, because 
this behavior was already in place before the patch. Maybe some 
benchmarks of "cat /proc/kallsyms" with both the is_exported call and 
without it can show if this really matters in the end.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
