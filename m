Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313069AbSC0SiI>; Wed, 27 Mar 2002 13:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313068AbSC0Sh5>; Wed, 27 Mar 2002 13:37:57 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29348 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313070AbSC0Shk>;
	Wed, 27 Mar 2002 13:37:40 -0500
Message-ID: <3CA20EDF.7080402@vnet.ibm.com>
Date: Wed, 27 Mar 2002 12:26:39 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: proc_file_read() hack?
In-Reply-To: <20020323114004.92117.qmail@web10307.mail.yahoo.com> 	<3C9F69F4.3010908@vnet.ibm.com> <1017085557.5263.335.camel@thanatos>
Content-Type: multipart/mixed;
 boundary="------------090108040904010006050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090108040904010006050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thomas Hood wrote:

> Unfortunately, your method #3 conflicts with methods #0 through #2,
> which exhaust the range of possible values that may be returned
> in *start.  Any value greater than buffer is regarded as being
> "within the buffer".


I guess I don't understand the conflict.

There is case #0 where start is NULL.  In this case start is computed in 
proc_file_read as page + *ppos so (unsigned long)start < PROC_BLOCK_SIZE 
is NOT true and so start is used as before.

In case #1 (unsigned long)start < PROC_BLOCK_SIZE so it will grab the 
data from page and use start as the length to copy as it did before.

And finally cases #2 and #3 are the same:  use start as an explicit data 
address.  It doesn't matter whether this points into page or if it is 
space provided by read_proc (which is why I suggested not even 
mentioning a "case #3").


Did you get a chance to read the patch?  I'll attach it again just in 
case.  Or is there a chance that start >= PROC_BLOCK_SIZE (but start < 
page) in case #1?  If that is true I am wondering how it could possibly 
be correct since start will be used as a length which is greater than 
the size of the page.

-todd


> 
> Introducing method #1 was a bad idea because this hack made it
> impossible cleanly to implement what you suggest.
> 
> --
> Thomas Hood
> 
> On Mon, 2002-03-25 at 13:18, Todd Inglett wrote:
> 
>>How about applying my trivial patch and then adding this to your nice 
>>comment?
>>
>>3) Set *start = an address outside the buffer.
>>    Put the data of the requested offset at *start.
>>    Return the number of bytes of data placed there.
>>    If this number is greater than zero and you
>>    didn't signal eof and the reader is prepared to
>>    take more data you will be called again with the
>>    requested offset advanced by the number ob tyes
>>    absorbed.
>>
>>The code should still work with the other cases now that the hack is 
>>fixed.  Of course, rather than add 3), it would be better to re-word 2) 
>>(e.g. "Set *start = address of the buffer which may or may not be in the 
>>given buffer.).
>>
>>There are cases where the data is available and need not be copied.  My 
>>code got simpler when I got rid of the need to copy my data around.
>>



--------------090108040904010006050000
Content-Type: text/plain;
 name="fs-proc-generic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs-proc-generic.patch"

Index: fs/proc/generic.c
===================================================================
RCS file: /cvs/linuxppc64/linuxppc64_2_4/fs/proc/generic.c,v
retrieving revision 1.6
diff -u -r1.6 generic.c
--- fs/proc/generic.c	8 Oct 2001 19:19:59 -0000	1.6
+++ fs/proc/generic.c	22 Mar 2002 14:34:47 -0000
@@ -104,14 +104,14 @@
  		 * return the bytes, and set `start' to the desired offset
  		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
 		 */
- 		n -= copy_to_user(buf, start < page ? page : start, n);
+ 		n -= copy_to_user(buf, (unsigned long)start < PROC_BLOCK_SIZE ? page : start, n);
 		if (n == 0) {
 			if (retval == 0)
 				retval = -EFAULT;
 			break;
 		}
 
-		*ppos += start < page ? (long)start : n; /* Move down the file */
+		*ppos += (unsigned long)start < PROC_BLOCK_SIZE ? (long)start : n; /* Move down the file */
 		nbytes -= n;
 		buf += n;
 		retval += n;

--------------090108040904010006050000--

