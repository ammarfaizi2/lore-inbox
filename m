Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUATHIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 02:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUATHIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 02:08:51 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50337 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265231AbUATHIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 02:08:46 -0500
Message-ID: <400CD2CF.6030506@us.ibm.com>
Date: Mon, 19 Jan 2004 23:03:43 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joe.korty@ccur.com
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap parsing/printing routines, version 4
References: <20040114150331.02220d4d.pj@sgi.com> <20040115002703.GA20971@tsunami.ccur.com> <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115161732.458159f5.pj@sgi.com> <400873EC.2000406@us.ibm.com> <20040117063618.GA14829@tsunami.ccur.com> <20040117183929.GA24185@tsunami.ccur.com> <400C4966.2030803@us.ibm.com> <20040120035756.GA15703@tsunami.ccur.com>
Content-Type: multipart/mixed;
 boundary="------------040004040707080102040305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040004040707080102040305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joe Korty wrote:
> On Mon, Jan 19, 2004 at 01:17:26PM -0800, Matthew Dobson wrote:
> 
>>Joe,
>>	I've attatched a small patch with some *small* changes, and the 
>>addition of a whole lotta comments.  I'd like to see what you think.
>>
>>Changes:
>>1) Added a missing '"' in the comment for the bitmap_parse function
>>2) Renamed 'oc' to 'old_c' for readability
>>3) Remove "totaldigits == 0" check at the end of bitmap_parse.  I 
>>believe this check is redundant.  The only way that totaldigits could be 
>>0 at the end of the function is if ndigits is also 0 (because they're 
>>both incremented at the same time), and this condition is already 
>>checked for at the end of each chunk parsed.  Is this correct?
>>
>>Additions:
>>4) A whole bunch of comments.  Are these all correct?
>>
>>None of the things in my patch (with the possible exception of #3) 
>>change the functionality of the code, which looks great.
>>
>>Andrew, I agree with Paul's "thumbs-up" of Joe's patch.  My patch is 
>>solely meant to increase the readability of the bitmap_parse function.
>>
>>Cheers!
>>
>>-Matt
> 
> 
> Indeed you are correct, the final (totaldigits == 1) test can be removed.
> Good catch.

Thanks!

> However, IMHO you added too many comments.  Unlike Andrew, I do believe
> one can have too many comments.  Comments become 'too many' when they
> dilute to the point that the code can no longer be clearly read.
> 
> If you reduce the comments to just those that say something not easily
> deduced from the code, then they would be acceptable to me, and would
> make a useful addition IMO.  That would be all but three, or perhaps four,
> of them.
> 
> Andrew, if you do like the fully commented version, then please remove
> my name from the comment in the patch.  The dilute style of coding is
> not one I wish to have my name associated with.
> 
> Thanks,
> Joe

I'm sorry you feel that way, Joe.  I had no intention of "diluting" your 
code, and I certainly don't want you to remove your name from good code 
you spent significant time & effort on.  I'm just about to go to sleep, 
so I made this patch pretty quickly.  I think the 4 comments I kept are 
the most useful and non-obvious.  Let me know if this looks acceptable 
to you.  As I said, I have no desire to have you pull your name from the 
code, especially since I feel it is good code!

Andrew, once Joe and I work out an acceptable patch, we'll make sure you 
get a copy.

Cheers!

-Matt

--------------040004040707080102040305
Content-Type: text/plain;
 name="joe_korty-bitmap-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="joe_korty-bitmap-fix.patch"

--- linux-2.6.1-joe_korty-bitmap/lib/bitmap.c.orig	Mon Jan 19 11:45:32 2004
+++ linux-2.6.1-joe_korty-bitmap/lib/bitmap.c	Mon Jan 19 22:57:19 2004
@@ -209,13 +209,13 @@ EXPORT_SYMBOL(bitmap_snprintf);
  * bits of the resultant bitmask.  No chunk may specify a value larger
  * than 32 bits (-EOVERFLOW), and if a chunk specifies a smaller value
  * then leading 0-bits are prepended.  -EINVAL is returned for illegal
- * characters and for grouping errors such as "1,,5", ,44", "," and "".
+ * characters and for grouping errors such as "1,,5", ",44", "," and "".
  * Leading and trailing whitespace accepted, but not embedded whitespace.
  */
 int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
         unsigned long *maskp, int nmaskbits)
 {
-	int i, c, oc, ndigits, totaldigits, nchunks, nbits;
+	int i, c, old_c, totaldigits, ndigits, nchunks, nbits;
 	u32 chunk;
 
 	bitmap_clear(maskp, nmaskbits);
@@ -223,21 +223,39 @@ int bitmap_parse(const char __user *ubuf
 	nchunks = nbits = totaldigits = c = 0;
 	do {
 		chunk = ndigits = 0;
+
+		/* Get the next chunk of the bitmap */
 		while (ubuflen) {
-			oc = c;
+			old_c = c;
 			if (get_user(c, ubuf++)) 
 				return -EFAULT;
 			ubuflen--;
 			if (isspace(c))
 				continue;
-			if (totaldigits && c && isspace(oc))
+
+			/*
+			 * If the last character was a space and the current 
+			 * character isn't '\0', we've got embedded whitespace.
+			 * This is a no-no, so throw an error.
+			 */
+			if (totaldigits && c && isspace(old_c))
 				return -EINVAL;
-			if (!c || c == ',')
+
+			/* A '\0' or a ',' signal the end of the chunk */
+			if (c == '\0' || c == ',')
 				break;
+
 			if (!isxdigit(c))
 				return -EINVAL;
+
+			/*
+			 * Make sure there are at least 4 free bits in 'chunk'.
+			 * If not, this hexdigit will overflow 'chunk', so 
+			 * throw an error.
+			 */
 			if (chunk & ~((1UL << (CHUNKSZ - 4)) - 1))
 				return -EOVERFLOW;
+
 			chunk = (chunk << 4) | unhex(c);
 			ndigits++; totaldigits++;
 		}
@@ -245,6 +263,7 @@ int bitmap_parse(const char __user *ubuf
 			return -EINVAL;
 		if (nchunks == 0 && chunk == 0)
 			continue;
+
 		bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
 		for (i = 0; i < CHUNKSZ; i++)
 			if (chunk & (1 << i))
@@ -255,8 +274,6 @@ int bitmap_parse(const char __user *ubuf
 			return -EOVERFLOW;
 	} while (ubuflen && c == ',');
 
-	if (totaldigits == 0)
-		return -EINVAL;
 	return 0;
 }
 EXPORT_SYMBOL(bitmap_parse);

--------------040004040707080102040305--

