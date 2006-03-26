Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWCZQRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWCZQRS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWCZQRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:17:17 -0500
Received: from smtpout.mac.com ([17.250.248.83]:63980 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751403AbWCZQRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:17:17 -0500
In-Reply-To: <mj+md-20060326.153649.8590.albireo@ucw.cz>
References: <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <mj+md-20060326.125803.7105.albireo@ucw.cz> <50ACA1D0-C376-491A-A927-872B04964663@mac.com> <mj+md-20060326.153649.8590.albireo@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F198DCEB-D09F-47B1-A827-A6341167D7A8@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header	infrastructure
Date: Sun, 26 Mar 2006 11:16:48 -0500
To: Martin Mares <mj@ucw.cz>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 10:38:59, Martin Mares wrote:
>> It _is_ fragile, but for a number of POSIX-defined structs that's  
>> actually the only way to do it without duplicating the data  
>> structure in entirety, unless the GCC people can implement a  
>> "typedef struct foo struct bar;"
>
> Actually, something like that can be achieved using anonymous  
> structure members:
>
> struct xxx {
> 	struct yyy;
> };

Oh, if only that worked.  Actually, what happens is the "struct yyy;"  
declaration inside of struct xxx looks just like "struct yyy;" out in  
the middle of some random header file.  It predeclares the existence  
of a struct yyy and does nothing else.

For instance, the following sample program:
   struct foo {
   	int a;
   	int b;
   };

   struct bar {
   	struct foo;
   };

   int main()
   {
   	struct foo myfoo = { .a = 1, .b = 2 };
   	struct bar mybar = { .a = 1, .b = 2 };
   	return 0;
   }

Compiled like this:
   gcc mytest.c -o mytest

Generates these errors:
   mytest.c:7: warning: declaration does not declare anything
   mytest.c: In function `main':
   mytest.c:12: error: unknown field `a' specified in initializer
   mytest.c:12: warning: excess elements in struct initializer
   mytest.c:12: warning: (near initialization for `mybar')
   mytest.c:12: error: unknown field `b' specified in initializer
   mytest.c:12: warning: excess elements in struct initializer
   mytest.c:12: warning: (near initialization for `mybar')

Cheers,
Kyle Moffett

