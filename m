Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275387AbTHMTwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275420AbTHMTwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:52:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36874 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275387AbTHMTvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:51:49 -0400
Message-ID: <3F3A9A43.4080801@techsource.com>
Date: Wed, 13 Aug 2003 16:06:27 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: generic strncpy - off-by-one error]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This may appear twice.  Due to the length of the recipient list, my 
reply to the list got blocked by the server.

Erik Andersen wrote:

> char *strncpy(char * s1, const char * s2, size_t n)
> {
>     register char *s = s1;
>     while (n) {
> 	if ((*s = *s2) != 0) s2++;
> 	++s;
> 	--n;
>     }
>     return s1;
> }



Nice!



How about this:


char *strncpy(char * s1, const char * s2, size_t n)
{
	register char *s = s1;

	while (n && *s2) {
		n--;
		*s++ = *s2++;
	}
	while (n--) {
		*s++ = 0;
	}
	return s1;
}



This reminds me a lot of the ORIGINAL, although I didn't pay much 
attention to it at the time, so I don't remember.  It may be that the 
original had "n--" in the while () condition of the first loop, rather 
than inside the loop.

I THINK the original complaint was that n would be off by 1 upon exiting 
the first loop.  The fix is to only decrement n when n is nonzero.

If s2 is short enough, then we'll exit the first loop on the nul byte 
and fill in the rest in the second loop.  Since n is only decremented 
with we actually write to s, we will only ever write n bytes.  No 
off-by-one.

If s2 is too long, the first loop will exit on n being zero, and since 
it doesn't get decremented in that case, it'll be zero upon entering the 
second loop, thus bypassing it properly.

Erik's code is actually quite elegant, and its efficiency is probably 
essentially the same as my first loop.  But my second loop would 
probably be faster at doing the zero fill.


Now, consider this for the second loop!

	while (n&3) {
		*s++ = 0;
		n--;
	}
	l = n>>2;
	while (l--) {
		*((int *)s)++ = 0;
	}
	n &= 3;
	while (n--) {
		*s++ = 0;
	}


This is only a win for relatively long nul padding.  How often is the 
padding long enough?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




