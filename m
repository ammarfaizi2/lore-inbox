Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270115AbRHIRJY>; Thu, 9 Aug 2001 13:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270233AbRHIRJO>; Thu, 9 Aug 2001 13:09:14 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:35577 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S270115AbRHIRJC>; Thu, 9 Aug 2001 13:09:02 -0400
Date: Thu, 9 Aug 2001 17:22:46 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org, arjanv@redhat.com,
        sct@redhat.com, trini@kernel.crashing.org,
        Carsten Otte <COTTE@de.ibm.com>
Subject: Re: Debugging help: BUG: Assertion failure with ext3-0.95 for 2.4.7
Message-ID: <20010809172246.B20408@redhat.com>
In-Reply-To: <OFA546F20C.78C10EBF-ONC1256AA3.0052D4C2@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFA546F20C.78C10EBF-ONC1256AA3.0052D4C2@de.ibm.com>; from CBORNTRA@de.ibm.com on Thu, Aug 09, 2001 at 05:24:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 09, 2001 at 05:24:05PM +0200, Christian Borntraeger wrote:
> 
> Hello ext3-developers,
> 
> Just to summarize, I reported a kernel bug message with ext3 on S/390 in
> transaction.c. I was able to reproduce it with a ext3 on LVM  and on MD.
> Tom Rini reported a similar problem on PPC. (both big endian). I have sent
> a backtrace and with jbd-debug set to 5 I was not able to reproduce the
> problem until now.

Thanks.  I think it's due to a missing endian-conversion in
ext3_clear_blocks().  Could you try the patch below?

Cheers,
 Stephen


Index: fs/ext3/inode.c
===================================================================
RCS file: /cvsroot/gkernel/ext3/fs/ext3/inode.c,v
retrieving revision 1.63
diff -u -r1.63 inode.c
--- fs/ext3/inode.c	2001/07/30 12:46:12	1.63
+++ fs/ext3/inode.c	2001/08/09 16:19:29
@@ -1522,7 +1522,7 @@
 	 * AKPM: turn on bforget in journal_forget()!!!
 	 */
 	for (p = first; p < last; p++) {
-		u32 nr = *p;
+		u32 nr = le32_to_cpu(*p);
 		if (nr) {
 			struct buffer_head *bh;
 
