Return-Path: <linux-kernel-owner+w=401wt.eu-S932097AbXACUmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXACUmx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXACUmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:42:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48370 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098AbXACUmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:42:52 -0500
Date: Wed, 3 Jan 2007 12:38:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <200701032047.02941.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.64.0701031225090.4473@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org> <200701032047.02941.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2007, Denis Vlasenko wrote:
> 
> Why CPU people do not internally convert cmov into jmp,mov pair?

Probably because

 - it's not worth it. cmov's certainly _can_ be faster for unpredictable 
   input. So expecially if you teach your compiler (by using profiling) to 
   use cmov's mainly for unpredictable cases, turning it into a 
   conditional jump internally would likely be a bad idea.

 - the biggest reason to do it would likely be microarchitectural: if you 
   have an ALU or a bypass network that just isn't suitable for bypassing 
   the flags that way (because you designed your pipeline for a 
   conditional branch), you might decide that it just simplifies things to 
   turn the cmov internally into a branch+mov uop pair. 

 - cmov's simply aren't common enough to be worth worrying about, 
   especially as it's not likely that the difference is all that big in 
   the end. The limitations on cmov's means that the compiler can only use 
   them under certain fairly limited circumstances anyway, so it's not 
   like you'll make a huge difference by doing anything clever.  So see 
   above - it's simply a wash, and likely ends up just depending on other 
   issues.

And don't get me wrong. cmov's can make a difference. You can use them to 
avoid polluting your branch prediction tables, you can use them to make 
code smaller, and you can use them when they simply just fit the problem 
really well. It's just _not_ the case that they are "obviously better". 
They simply aren't. Conditional branches aren't "evil". There are many 
MUCH worse things you can do, and other things you should avoid.

It really all boils down to: there's simply no real reason to use cmov. 
It's not horrible either, so go ahead and use it if you want to, but don't 
expect your code to really magically run any faster.

			Linus
