Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUASVWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUASVWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:22:47 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:5300 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263618AbUASVWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:22:25 -0500
Message-ID: <400C4966.2030803@us.ibm.com>
Date: Mon, 19 Jan 2004 13:17:26 -0800
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
References: <20040108225929.GA24089@tsunami.ccur.com> <16381.61618.275775.487768@cargo.ozlabs.ibm.com> <20040114150331.02220d4d.pj@sgi.com> <20040115002703.GA20971@tsunami.ccur.com> <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115161732.458159f5.pj@sgi.com> <400873EC.2000406@us.ibm.com> <20040117063618.GA14829@tsunami.ccur.com> <20040117183929.GA24185@tsunami.ccur.com>
Content-Type: multipart/mixed;
 boundary="------------070601060100050808050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601060100050808050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joe Korty wrote:
> This release of the bitmap parser/printer continues the cycle of making
> ever-smaller changes to the base code.
> 
> The most significant change this time around is to be sure every
> character in the string is scanned for correctness.  In the previous
> version, the scan would stop on the first whitespace character following
> a non-whitespace character.  There was no determination made if that was
> the start of either embedded or trailing whitspace -- it was assumed to
> be trailing.
> 
> I gradually came to feel that examining the whole string was important, as
> the parser does not return a pointer to where it stopped as the string(3)
> family does, so it is not possible for the caller to easily determine
> if the condition stopping the scan was reasonable or not.
> 
> ChangeLog:
>  o remove trailing whitespace early termination.
>  o add leading / embedded / trailing whitespace tests.
>  o 'extern' not needed on prototypes (Bill Irwin)
>  o made terse variable names readable.
>  o continued the reduction of the algorithm to simpler forms.
> 
> This release concludes my contributions to this patch, other than changes
> driven by user requests and experience.
> 
> Against 2.6.1-mm4.
> 
> Joe

Joe,
	I've attatched a small patch with some *small* changes, and the 
addition of a whole lotta comments.  I'd like to see what you think.

Changes:
1) Added a missing '"' in the comment for the bitmap_parse function
2) Renamed 'oc' to 'old_c' for readability
3) Remove "totaldigits == 0" check at the end of bitmap_parse.  I 
believe this check is redundant.  The only way that totaldigits could be 
0 at the end of the function is if ndigits is also 0 (because they're 
both incremented at the same time), and this condition is already 
checked for at the end of each chunk parsed.  Is this correct?

Additions:
4) A whole bunch of comments.  Are these all correct?

None of the things in my patch (with the possible exception of #3) 
change the functionality of the code, which looks great.

Andrew, I agree with Paul's "thumbs-up" of Joe's patch.  My patch is 
solely meant to increase the readability of the bitmap_parse function.

Cheers!

-Matt

--------------070601060100050808050803
Content-Type: text/plain;
 name="joe_korty-bitmap-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="joe_korty-bitmap-fix.patch"

--- linux-2.6.1-joe_korty-bitmap/lib/bitmap.c.orig	Mon Jan 19 11:45:32 2004
+++ linux-2.6.1-joe_korty-bitmap/lib/bitmap.c	Mon Jan 19 13:11:24 2004
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
@@ -223,40 +223,73 @@ int bitmap_parse(const char __user *ubuf
 	nchunks = nbits = totaldigits = c = 0;
 	do {
 		chunk = ndigits = 0;
+
+		/* Get the next chunk of the bitmap */
 		while (ubuflen) {
-			oc = c;
+			/* Remember the last char & get the next char */
+			old_c = c;
 			if (get_user(c, ubuf++)) 
 				return -EFAULT;
 			ubuflen--;
+
+			/* Ignore spaces */
 			if (isspace(c))
 				continue;
-			if (totaldigits && c && isspace(oc))
+
+			/*
+			 * If the last character was a space and the current 
+			 * character isn't '\0' we've got embedded whitespace. 
+			 * This is a no-no, so throw an error.
+			 */
+			if (totaldigits && c && isspace(old_c))
 				return -EINVAL;
+
+			/* A '\0' or a ',' signal the end of the chunk */
 			if (!c || c == ',')
 				break;
+
+			/* A non-hexdigit is also a no-no, so throw an error */
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
+			/*
+			 * Add this expanded hexdigit to 'chunk' and increment 
+			 * both the current chunk & total digit counts.
+			 */
 			chunk = (chunk << 4) | unhex(c);
 			ndigits++; totaldigits++;
 		}
+		/* Empty chunks are another no-no.  Throw an error. */
 		if (ndigits == 0)
 			return -EINVAL;
+
+		/* If the first chunk is all 0's, just move to the next one */
 		if (nchunks == 0 && chunk == 0)
 			continue;
+
+		/* Shift the bitmap right to make room for this chunk */
 		bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
+
+		/* Copy the chunk into the bitmap, and increment chunk count */
 		for (i = 0; i < CHUNKSZ; i++)
 			if (chunk & (1 << i))
 				set_bit(i, maskp);
 		nchunks++;
+
+		/* Increment the bit count & make sure we didn't overflow */
 		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;
 		if (nbits > nmaskbits)
 			return -EOVERFLOW;
 	} while (ubuflen && c == ',');
 
-	if (totaldigits == 0)
-		return -EINVAL;
 	return 0;
 }
 EXPORT_SYMBOL(bitmap_parse);

--------------070601060100050808050803--

