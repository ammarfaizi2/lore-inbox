Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261965AbSIYMOT>; Wed, 25 Sep 2002 08:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbSIYMOT>; Wed, 25 Sep 2002 08:14:19 -0400
Received: from pr-66-150-46-254.wgate.com ([66.150.46.254]:40050 "EHLO
	mail.tvol.net") by vger.kernel.org with ESMTP id <S261965AbSIYMOL>;
	Wed, 25 Sep 2002 08:14:11 -0400
Message-ID: <3D91A9C4.2030409@wgate.com>
Date: Wed, 25 Sep 2002 08:19:16 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1b) Gecko/20020813
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
CC: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] streq()
References: <20020924045313.0FBE52C075@lists.samba.org> <1032953252.18004.18.camel@sonja.de.interearth.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> Am Die, 2002-09-24 um 06.49 schrieb Rusty Russell:
> 
> 
>>Embarrassing, huh?  But I just found a bug in my code cause by
>>"if (strcmp(a,b))" instead of "if (!strcmp(a,b))".
> 
> 
>>diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.38/include/linux/string.h working-2.5.38-streq/include/linux/string.h
>>--- linux-2.5.38/include/linux/string.h	2002-06-06 21:38:40.000000000 +1000
>>+++ working-2.5.38-streq/include/linux/string.h	2002-09-24 14:43:30.000000000 +1000
>>@@ -15,7 +15,7 @@ extern "C" {
>> extern char * strpbrk(const char *,const char *);
>> extern char * strsep(char **,const char *);
>> extern __kernel_size_t strspn(const char *,const char *);
>>-
>>+#define streq(a,b) (strcmp((a),(b)) == 0)
> 
> 
> Considering most compares will only care for equality/non-equality and
> not about the type of unequality a strcmp usually returns, wouldn't it
> be more wise and faster to use an approach like memcpy for comparison
> instead of that stupid compare each character approach?
> 
> Something along the lines of:
> Start comparying by granules with the biggest type the architecture has
> to offer which will fit into the length of the string and going down
> to the size of 1 char bailing out as soon as the granules don't match.

I see two problems with this - first is that strings are not and can not
be assumed to be on nice word boundaries.  While x86 and some (many)
CPUs can actually read words (longs/etc) at non-natural boundaries,
they suffer in performance.  Other architectures can not even do the
reads and will cause a trap/exception that *may* be handled in software.
(Or may not)

Second, unless you know for sure how long the string buffer is you can
not easily bound down the string in larger chunks.  (It may hurt
reading that byte just beyond the end of the string since it is on
another page, etc)

There is also the added overhead of noticing the '\0' byte at the
end of the string since it may be in the middle of your 32-bit
64-bit) data value.

Given all of this, it is rather unlikely that for strings it is worth
doing anything different than the (usually) highly tuned assembly of
the strcmp() code.

(memcpy() has, by its nature and API at least the size which can
significantly help, along with architecture knowledge that it can
then use to pick the right)

A side note:  While memcmp() could use the same logic of memcpy(),
the greater/less than result code specifically is documented at
byte level.  This was a real PITA for Alpha CPUs to make fast,
especially the earlier ones that did not even have natural byte
operators.  (Alpha was designed with UNICODE characters in mind
and performance as its top concern.)

-- 
Michael Sinz -- Director, Systems Engineering -- Worldgate Communications
A master's secrets are only as good as
	the master's ability to explain them to others.


