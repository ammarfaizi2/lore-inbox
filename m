Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272278AbTHNJju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 05:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272279AbTHNJjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 05:39:49 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:24282 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S272278AbTHNJjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 05:39:46 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20AB@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Timothy Miller'" <miller@techsource.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Thu, 14 Aug 2003 11:34:50 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Trimmed the recipient list. ]

> -----Original Message-----
> From: Timothy Miller [mailto:miller@techsource.com] 
> Sent: Wednesday, August 13, 2003 21:04
> To: andersen@codepoet.org
> Cc: Albert Cahalan; linux-kernel mailing list; 
> bernd@firmix.at; Anthony.Truong@mascorp.com; 
> alan@lxorguk.ukuu.org.uk; schwab@suse.de; 
> ysato@users.sourceforge.jp; willy@w.ods.org; 
> Valdis.Kletnieks@vt.edu; william.gallafent@virgin.net
> Subject: Re: generic strncpy - off-by-one error
> 
> Erik Andersen wrote:
> 
> > char *strncpy(char * s1, const char * s2, size_t n)
> > {
> >     register char *s = s1;
> >     while (n) {
> > 	if ((*s = *s2) != 0) s2++;
> > 	++s;
> > 	--n;
> >     }
> >     return s1;
> > }
> 
> 
> 
> Nice!

I can but agree.

> How about this:
> 
> 
> char *strncpy(char * s1, const char * s2, size_t n)
> {
> 	register char *s = s1;
> 
> 	while (n && *s2) {
> 		n--;
> 		*s++ = *s2++;
> 	}
> 	while (n--) {
> 		*s++ = 0;
> 	}
> 	return s1;
> }

This may be improved further:

char *strncpy(char *dest, const char *src, size_t count)
{
	char *tmp = dest;

	while (count) {
		if (*src == '\0')
			break;

		*tmp++ = *src++;
		count--;
	}

	while (count) {
		*tmp++ = '\0';
		count--;
	}

	return dest;
}

Moving the check for *src == '\0' into the first loop seems
to let the compiler reuse the object code a little better
(may depend on the optimizer). Also note that your version
of the second loop needs an explicit  comparison with -1,
whereas mine uses an implicit comparison with 0.

Testing on the CRIS architecture, your version is 24 instructions,
whereas mine is 18. For comparison, Eric's one is 12 and the
currently used implementation is 26 (when corrected for the
off-by-one error by comparing with > 1 rather than != 0 in the
second loop).

Here is another version that I think is quite pleasing
aesthetically (YMMV) since the loops are so similar (it is 21
instructions on CRIS):

char *strncpy(char *dest, const char *src, size_t count)
{
	char *tmp = dest;

	for (; count && *src; count--)
		*tmp++ = *src++;

	for (; count; count--)
		*tmp++ = '\0';

	return dest;
}

This is probably the version I would choose if I were to decide
as the object code generated for the actual loops are optimal in
this version (at least for CRIS).

> This reminds me a lot of the ORIGINAL, although I didn't pay much 
> attention to it at the time, so I don't remember.  It may be that
> the original had "n--" in the while () condition of the first 
> loop, rather than inside the loop.
> 
> I THINK the original complaint was that n would be off by 1 
> upon exiting the first loop.  The fix is to only decrement n 
> when n is nonzero.
> 
> If s2 is short enough, then we'll exit the first loop on the nul byte 
> and fill in the rest in the second loop.  Since n is only decremented 
> with we actually write to s, we will only ever write n bytes.  No 
> off-by-one.
> 
> If s2 is too long, the first loop will exit on n being zero, 
> and since it doesn't get decremented in that case, it'll be 
> zero upon entering the second loop, thus bypassing it properly.
> 
> Erik's code is actually quite elegant, and its efficiency is probably 
> essentially the same as my first loop.  But my second loop would 
> probably be faster at doing the zero fill.
> 
> 
> Now, consider this for the second loop!
> 
> 	while (n&3) {

I think sizeof(int)-1 would be better than 3. ;)
And long would probably be better for the 64-bit architectures?

> 		*s++ = 0;
> 		n--;
> 	}
> 	l = n>>2;
> 	while (l--) {
> 		*((int *)s)++ = 0;
> 	}
> 	n &= 3;
> 	while (n--) {
> 		*s++ = 0;
> 	}
> 
> This is only a win for relatively long nul padding.  How often is the 
> padding long enough?

I guess another way would be to replace the second loop with
memset(s, '\0', n), but that would probably only be a win for
quite long paddings.

//Peter
