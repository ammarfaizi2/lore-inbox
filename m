Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUILPKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUILPKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 11:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268746AbUILPKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 11:10:31 -0400
Received: from aun.it.uu.se ([130.238.12.36]:4538 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268726AbUILPK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 11:10:28 -0400
Date: Sun, 12 Sep 2004 17:10:05 +0200 (MEST)
Message-Id: <200409121510.i8CFA5Ji015615@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: khali@linux-fr.org
Subject: Re: [PATCH][2.4.28-pre3] I2C driver core gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 15:44:29 +0200, Jean Delvare <khali@linux-fr.org> wrote:
>> This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
>> kernel's I2C driver core. The i2c-core.c change is from the 2.6
>> kernel, the i2c-proc.c changes are new since the 2.6 code is
>> different.
>> (...)
>> --- linux-2.4.28-pre3/drivers/i2c/i2c-proc.c.~1~	2004-02-18 15:16:22.000000000 +0100
>> +++ linux-2.4.28-pre3/drivers/i2c/i2c-proc.c	2004-09-12 01:56:20.000000000 +0200
>> (...)
>> @@ -287,7 +287,7 @@
>>  			if(copy_to_user(buffer, BUF, buflen))
>>  				return -EFAULT;
>>  			curbufsize += buflen;
>> -			(char *) buffer += buflen;
>> +			buffer += buflen;
>>  		}
>>  	*lenp = curbufsize;
>>  	filp->f_pos += curbufsize;
>
>Looks like arithmetics on void* to me, so while removing a warning you
>add a different one. Same for all other "fixes" later in the patch.
>
>It doesn't look to me like you are fixing the code, only hiding the
>warnings. I am not really confident you aren't breaking things while
>doing this.

Yes, it results in code doing void* pointer arithmetic, but
the kernel uses that particular gcc extension in a lot of
places. It's ugly but known to work exactly like char*.

However, I'm no fan of void* arithmetic. Would code like
buffer = (void*)((char*)buffer + buflen); make you happier?

>After a quick look at the code I'd say that the buffer-like parameters
>involved should be declared as char* instead of void* in the first
>place, which would effectively make all further casts unnecessary, and
>still work exactly as before.

Maybe, but that's potentially a much larger change. I'm just
looking for the minimal changes to make the 2.4 kernel safe for
gcc-3.4 and later (cast-as-lvalue is an error in gcc-3.5/4.0).

/Mikael
