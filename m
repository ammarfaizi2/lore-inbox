Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSBZXQA>; Tue, 26 Feb 2002 18:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSBZXPl>; Tue, 26 Feb 2002 18:15:41 -0500
Received: from fe040.worldonline.dk ([212.54.64.205]:5380 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S288086AbSBZXPW>; Tue, 26 Feb 2002 18:15:22 -0500
Message-ID: <3C7C1797.7050604@dif.dk>
Date: Wed, 27 Feb 2002 00:17:43 +0100
From: Jesper Juhl <jju@dif.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: barubary@cox.net, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: ISO9660 bug and loopback driver bug - a bigger problem then it would appear?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > First, the ISO9660 bug.  The ISO file system driver in Linux doesn't 
handle
 > leap years correctly.  It assumes all years divisible by 4 are leap 
years,
 > which is incorrect.  For those that don't know the right algorithm, all
 > years that (are divisible by 4) and ((not divisible by 100), or 
(divisible
 > by 400)) are leap years.  ISO file dates on or after March 1, 2100 
will be 1
 > day off when viewed under Linux as a result.  The bug is in 
fs/isofs/util.c,


Ok, unless I'm missing something (quite possible), this bug cannot be 
fixed without lots of changes outside fs/isofs/util.c .

First of all, the function returns "int", so ints being 4 bytes, this 
function can not handle dates beyond ~2038. And since there are no leap 
years between 1970 and 2038 that are not correctly accounted for by just 
doing a divide by four (the year 2000 would have been the only exception 
due to the if year%100 == 0 then it's not a leap year rule, but it is 
after all due to the year%400 exception to that rule).
There is also the problem of the function only being passed a single 
char as the value for the year - that's not enough to be able to pass 
the year 2100, and it's only beyond this year that we have a problem 
with the current code. In order to be able to pass more than a single 
char to iso_date() we'd have to modify the "struct iso_directory_record" 
structure to extend the "date" field to be able to hold the entire four 
digit year that iso9660 actually stores on disk (if I'm not mistaken) - 
changing that struct would then require that all users of the struct be 
checked for correctness. That's quite a large piece of work, and it's 
pointless as long as iso_date just returns "int".

Is the above analysis correct or did I miss something obvious?

If the above is indeed correct, wouldn't it then be better to just do 
those changes in 2.5.x instead of 2.4.x (and then maybe backport them 
later)...

Comments ?


Best regards,
Jesper Juhl
jju@dif.dk


