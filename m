Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbUL0NBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUL0NBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUL0NBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:01:08 -0500
Received: from [195.23.16.24] ([195.23.16.24]:40647 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261882AbUL0NA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:00:59 -0500
Message-ID: <41D00772.1050600@grupopie.com>
Date: Mon, 27 Dec 2004 13:00:34 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@sgi.com>
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.10
References: <18921.1103977059@ocs3.ocs.com.au>
In-Reply-To: <18921.1103977059@ocs3.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.34; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> KDB (Linux Kernel Debugger) has been updated.

Hi,

I browsed the patch quickly to check for kallsyms uses, and validate 
them, and it generally seems correct.

There is however one comment that makes me wonder:
*2.6 kallsyms has a "feature" where it unpacks the name into a string.
*If that string is reused before the caller expects it then the caller
*sees its string change without warning.

kallsyms_lookup always uses the buffer passed to it in the case the 
symbol is a kernel symbol, as opposed to a module symbol, and so it is 
not responsible for the buffer.

So this probably only happens when a module symbol is returned directly 
from its symbol table, and then the module is unloaded (or something 
like that).

Later there is another comment:
* Another 2.6 kallsyms "feature".  Sometimes the sym_name is
* set but the buffer passed into kallsyms_lookup is not used,
* so it contains garbage.

It seems to be the same problem. If we modify kallsyms_lookup to always 
use the buffer passed, even if the symbol comes from a module, maybe we 
could solve both problems with just one change.

On the downside, a caller that just wants to print the name, would pay 
an unnecessary string copy.

On the upside, this would make the interface more coherent with standard 
C functions like strcpy, where the buffer passed is always the buffer 
returned.

So, is it worth the change?

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

