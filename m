Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269752AbUHZXIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269752AbUHZXIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbUHZXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:05:56 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:52417 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S269752AbUHZWzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:55:03 -0400
Message-ID: <412E69DC.5050907@ttnet.net.tr>
Date: Fri, 27 Aug 2004 01:53:16 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: 2.4.28-pre2 and ntfs-2.1.6b ?
References: <412E4F43.9030801@ttnet.net.tr> <20040826221229.GB564@alpha.home.local>
In-Reply-To: <20040826221229.GB564@alpha.home.local>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi,
> 
> On Thu, Aug 26, 2004 at 11:59:47PM +0300, O.Sezer wrote:
> 
>>Hi all:
>>
>>With 2.4.28-pre2, ntfs-2.1.6b from linux-ntfs site
>>started failing to compile at aops.c:
>>
>>aops.c: In function `ntfs_read_block':
>>aops.c:315: parse error before "else"
>>-- or in case of gcc3.4 --
>>aops.c:315: error: syntax error before "else"
>>
>>This happens with gcc-3.2.2 and gcc-3.4.0
>>and can be fixed by:
>>
>>--- aops.c.BAK	2004-08-26 19:35:11.000000000 +0300
>>+++ aops.c	2004-08-26 21:41:53.000000000 +0300
>>@@ -310,10 +310,11 @@
>> 		return 0;
>> 	}
>> 	/* No i/o was scheduled on any of the buffers. */
>>-	if (likely(!PageError(page)))
>>+	if (likely(!PageError(page))) {
>> 		SetPageUptodate(page);
>>-	else /* Signal synchronous i/o error. */
>>+	} else { /* Signal synchronous i/o error. */
>> 		nr = -EIO;
>>+	}
>> 	unlock_page(page);
>> 	return nr;
>> }
> 
> 
> No !
> Please don't fix it this way ! The problem lies within the declaration of
> SetPageUptodate() which it seems is a macro which lacks some braces somewhere.
> You were very lucky that there was an 'else' to point it out, but imagine
> what it would do in the following case :
> 
> 	if (likely(!PageError(page))) {
>  		SetPageUptodate(page);
> 	blah();
> 
> It would always execute the second half of SetPageUptodate(), whatever
> the condition, and nothing will alert you.
> 
> What does SetPageUptodate() look like ?
> 
> 
>>The very same code used to compile fine with
>>2.4.27 without any changes to it.
> 
> 
> I think that the gcc-3.4 fixes might have hit some sensible parts...
> 
> 
>>I can't see
>>where the problem is (it's 23:57 here ;)).
>>Can anyone tell, please?
> 
> 
> It's even later now, good night :-)
> 
> Regards,
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Hi Willy, and thanks, you're a lifesaver! All the evidence points
to the s390 changes in -pre2, specificly cset-1.1514 by schwidefsky
which touches include/linux/mm.h this way:

--- 1.44/include/linux/mm.h	2004-08-26 15:51:04 -07:00
+++ 1.45/include/linux/mm.h	2004-08-26 15:51:04 -07:00
@@ -308,11 +308,9 @@
/* Make it prettier to test the above... */
#define UnlockPage(page)	unlock_page(page)
#define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
-#define SetPageUptodate(page) \
-	do {								\
-		arch_set_page_uptodate(page);				\
-		set_bit(PG_uptodate, &(page)->flags);			\
-	} while (0)
+#ifndef SetPageUptodate
+#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags);
+#endif
#define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
#define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)
#define SetPageDirty(page)	set_bit(PG_dirty, &(page)->flags)

Marcelo, you maybe interested in this.

Cheers,
Ozkan Sezer
