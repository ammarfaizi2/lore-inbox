Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSKKJVN>; Mon, 11 Nov 2002 04:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKKJVM>; Mon, 11 Nov 2002 04:21:12 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:3596 "EHLO mail.intermeta.de")
	by vger.kernel.org with ESMTP id <S265713AbSKKJVL>;
	Mon, 11 Nov 2002 04:21:11 -0500
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
From: Henning Schmiedehausen <hps@intermeta.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0211101854350.22017-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0211101854350.22017-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Nov 2002 10:27:53 +0100
Message-Id: <1037006873.2011.12.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2002-11-11 at 04:05, Randy.Dunlap wrote:
> On Sun, 10 Nov 2002, Henning P. Schmiedehausen wrote:
> 
> | "Randy.Dunlap" <rddunlap@osdl.org> writes:
> |
> | >+		digit = *str;
> | >+		if (is_sign && digit == '-')
> | >+			digit = *(str + 1);
> |
> | If signed is not allowed and you get a "-", you're in an error case
> | again...
> 
> Yes, and a 0 value is returned.
> IOW, asking for an unsigned number (in the format string)
> and getting "-123" does return 0.
> 
> What should it do?

I would model this after user space. (Which does strange things:

--- cut ---
#include <stdio.h>

main()
{
  char *scan = "-100";
  unsigned int foo;
  int bar;

  int res = sscanf(scan, "%ud", &foo);

  printf("%s = %ud = %d\n", scan, foo, res);

  res = sscanf(scan, "%ud", &bar);

  printf("%s = %d = %d\n", scan, bar, res);

}
--- cut ---

% gcc -o xxx xxx.c
./xxx 
-100 = 4294967196d = 1
-100 = -100 = 1

Hm, so I guess, yes, a warning message would be nice IMHO. Returning an
error code would IMHO moot, because noone is checking these codes
anyway.

	Regards
		Henning



> This function can't return -EINPUTERROR or -EILSEQ.
> (since it's after feature-freeze :)
> And the original problem was that a leading '-' sign on a
> signed number (!) caused a return of 0.  At least that is fixed.
> 
> So now the problem (?) is that a '-' sign on an unsigned number
> returns 0.  We can always add a big printk() there that
> something is foul.  Other ideas?


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

