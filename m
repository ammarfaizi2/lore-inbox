Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270551AbRHISyN>; Thu, 9 Aug 2001 14:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270552AbRHISyD>; Thu, 9 Aug 2001 14:54:03 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:60937 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S270551AbRHISxs>; Thu, 9 Aug 2001 14:53:48 -0400
Message-ID: <3B72DD66.A6F65247@zip.com.au>
Date: Thu, 09 Aug 2001 11:58:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Borntraeger <CBORNTRA@de.ibm.com>
CC: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
        Carsten Otte <COTTE@de.ibm.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
In-Reply-To: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger wrote:
> 
> Hello ext3-users,
> 
> I tested ext3 on a Linux for S/390 with several stress and benchmark test
> tests and faced a kernel bug message.
> The console showed the following output:
> 
> Message from syslogd@boeaet34 at Fri Aug  3 11:34:16 2001 ...
> boeaet34 kernel: Assertion failure in journal_forget() at
> transaction.c:1184: "!
> jh->b_committed_data"
> 

Simple bug, subtle symptoms.  Could you please retest 0.9.5
with this patch?  Thanks.

--- ext3-0_9_5/fs/ext3/inode.c	Mon Jul 30 05:46:12 2001
+++ ext3/fs/ext3/inode.c	Thu Aug  9 00:03:34 2001
@@ -1522,7 +1523,7 @@
 	 * AKPM: turn on bforget in journal_forget()!!!
 	 */
 	for (p = first; p < last; p++) {
-		u32 nr = *p;
+		u32 nr = le32_to_cpu(*p);
 		if (nr) {
 			struct buffer_head *bh;
 

Now, if all on-disk structures were defined in terms of something
like

	struct disk32 {
		u32 x;
	}

then these things wold never happen - the compiler would catch
it.

-
