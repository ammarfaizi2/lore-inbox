Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWDBNJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWDBNJT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 09:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWDBNJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 09:09:19 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:2763 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S932331AbWDBNJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 09:09:18 -0400
X-ASG-Debug-ID: 1143983348-10189-25-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: [RFC][PATCH 1/2] Create initial kernel ABI
	header	infrastructure
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI
	header	infrastructure
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
In-Reply-To: <5AC6F01C-8010-4A28-A303-52F7F11B84BF@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	 <200603231811.26546.mmazur@kernel.pl>
	 <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	 <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
	 <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
	 <20060326065416.93d5ce68.mrmacman_g4@mac.com>
	 <1143376351.3064.9.camel@laptopd505.fenrus.org>
	 <A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
	 <20060329222640.GA2755@ucw.cz>
	 <20060401162213.dc68d120.rdunlap@xenotime.net>
	 <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com>
	 <1143946866.3056.4.camel@laptopd505.fenrus.org>
	 <5AC6F01C-8010-4A28-A303-52F7F11B84BF@mac.com>
Content-Type: text/plain
Date: Sun, 02 Apr 2006 15:09:04 +0200
Message-Id: <1143983345.2994.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10381
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-02 at 00:53 -0500, Kyle Moffett wrote:
> deal with compatibility: the kernel/userspace boundary.  I'd like to  
> strictly define all of that compatibility within a single set of  
> _upstream_ headers in linux/include/linux-kabi or similar.

yes that was what I was hoping you meant

> 
> But returning to your statements above, user code in that (C  
> standards) context means anything not standard-specified. 

I think you misread the C standard then. This only applies when you ONLY
include the headers defined in the standard, and no others.

>  Basically,  
> from userspace, a program that includes _any_ standard-specified  
> header must bring in *only* those symbols specified by the standard  
> as being present in that header, as well as any implementation- 
> defined double-underscore symbols.  

if you follow this argument then ANY library, be it glibc or gtk or
mysql or .. can only add __ things. That is not the case. Think of
"non-indirect" kernel header includes as including a header for a
library.

Maybe an example is needed: include/mtd/mtd-abi.h  
Well it's a slightly bad example since it uses stdint.h types not __u64
types. But assume it used __u64 types, then this header would be
perfectly fine, including from a standards point of view.



> So unless I "#include  
> <stdint.h>", my user program can typedef uint32_t to anything it  
> wants, even a struct, if it likes. 

yes this the example where __u64 needs underscores, and headers need to
use __u64 as they have to today.


>  I've actually done that before on  
> a very strange Cray platform with non-GCC compiler and OS that only  
> supported 64-bit integers (a char was a 64-bit integer with ops to  
> mask out the upper 56 bits), just to make bzip2 work as expected.   
> The same rules apply for _every_ other standard-specified header  
> (stdlib.h, stdio.h, sys/types.h, etc).

exactly. Nowhere is linux/* or asm/* in the standards as specified.


> to get access to them.  Unfortunately this made it impossible to use  
> those headers in userspace.

ok now I'm confused. How is providing FUNCTIONALITY such as setting
bitops the right thing for such headers? I would argue that the clean
headers should absolutely NOT do that but only provide the INTERFACE.

(this is also there for a license angle btw, if you actually start to
provide large bodies of code this way the lawyers will get unhappy wrt
the GPL; it's a LOT better to strictly do interface things only, eg
types, defines and prototypes)


In general:
I think you're focusing WAY too much on the __u64 kind of thing, which
is the vast minority of the ABI work, the ioctl structs are the big one.
For the __u64 kind of thing I would strongly suggest that you stick to
the currently already used symbols; anything existing knows to stay
clear of those already, so things are fine there so lets keep it simple
for those.



