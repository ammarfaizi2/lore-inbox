Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312606AbSCVOo0>; Fri, 22 Mar 2002 09:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSCVOoQ>; Fri, 22 Mar 2002 09:44:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27550 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312606AbSCVOoE>;
	Fri, 22 Mar 2002 09:44:04 -0500
Message-ID: <3C9B40E6.8010500@vnet.ibm.com>
Date: Fri, 22 Mar 2002 08:34:14 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: proc_file_read() hack?
Content-Type: multipart/mixed;
 boundary="------------040902020406070502000101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902020406070502000101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to understand this little hack in 2.4.18's (and earlier) 
fs/proc/generic.c:

/* This is a hack to allow mangling of file pos independent
  * of actual bytes read.  Simply place the data at page,
  * return the bytes, and set `start' to the desired offset
  * as an unsigned int. - Paul.Russell@rustcorp.com.au
  */

I take it to mean that if I return a small integer for "start" instead 
of a ptr the hack will kick in.  However it compares pointers instead. 
I'll attach a patch that does it the way I am thinking -- but I may be 
misunderstanding the comment.

Or perhaps it is always assumed that I am copying my data to the given 
page?  If that is true, then the way it is coded will work but the patch 
trivially allows me to point "start" anywhere without copying.

-todd

--------------040902020406070502000101
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

--------------040902020406070502000101--

