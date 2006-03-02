Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWCBSYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWCBSYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWCBSYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:24:51 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:17026 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S964782AbWCBSYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:24:50 -0500
Message-ID: <4407386D.4070008@namesys.com>
Date: Thu, 02 Mar 2006 10:24:45 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>,
       Oleg Drokin <green@linuxhacker.ru>
Subject: [Fwd: Re: [PATCH] reiserfs: use balance_dirty_pages_ratelimited_nr
 in reiserfs_file_write]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000301000207050207010304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000301000207050207010304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I suspect that when someone did the search and replace when creating
balance_dirty_pages_ratelimited_nr they failed to read the code and
realize this code path was already effectively ratelimited.  The result
is they made it excessively infrequent (every 1MB if ratelimit is 8) in
its calling balance_dirty_pages.

If anyone has ever seen this as an actual problem on a real system, I
would be curious to hear of it.

Hans

--------------000301000207050207010304
Content-Type: message/rfc822;
 name="Re: [PATCH] reiserfs: use balance_dirty_pages_ratelimited_nr in reiserfs_file_write"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [PATCH] reiserfs: use balance_dirty_pages_ratelimited_nr in reiserfs_file_write"

Return-Path: <zam@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 20789 invoked by uid 85); 2 Mar 2006 06:21:20 -0000
Received: from zam@namesys.com by thebsh.namesys.com by uid 82 with qmail-scanner-1.15 
 (spamassassin: 2.43-cvs.  Clear:SA:0(0.0/2.0 tests=none autolearn=no version=2.60):. 
 Processed in 0.384252 secs); 02 Mar 2006 06:21:20 -0000
Received: from pc050.trc-odintsovo.ru (HELO rogue.namesys.com) (212.15.96.50)
  by thebsh.namesys.com with SMTP; 2 Mar 2006 06:21:20 -0000
Received: by rogue.namesys.com (Postfix, from userid 1000)
	id 3424E10EE88; Thu,  2 Mar 2006 09:21:19 +0300 (MSK)
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: use balance_dirty_pages_ratelimited_nr in reiserfs_file_write
Date: Thu, 2 Mar 2006 09:21:18 +0300
User-Agent: KMail/1.8.2
Cc: Hans Reiser <reiser@namesys.com>
References: <200602282040.16294.zam@namesys.com> <4404A0E1.3040706@namesys.com> <4404A18A.1000805@namesys.com>
In-Reply-To: <4404A18A.1000805@namesys.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_e7oBE3SAVQFeFqO"
Message-Id: <200603020921.18680.zam@namesys.com>
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	thebsh.namesys.com
X-Spam-DCC: : 
X-Spam-Status: No, hits=0.0 required=2.0 tests=none autolearn=no version=2.60

--Boundary-00=_e7oBE3SAVQFeFqO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hans, 

The patch works, however its effect is not visible.
Would you please forward it?

On Tuesday 28 February 2006 22:16, E.Gryaznova wrote:
> Zam said me about this patch, it is in my todo list for tomorrow.
>
> Thanks,
> Lena
>

--Boundary-00=_e7oBE3SAVQFeFqO
Content-Type: application/x-trash;
  name="reiserfs-reiserfs_file_write-use-balance_dirty_pages_ratelimited_nr.diff~"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="reiserfs-reiserfs_file_write-use-balance_dirty_pages_ratelimited_nr.diff~"

Use balance_dirty_pages_ratelimited_nr in reiserfs "largeio" 
file write.
Index: linux-2.6.16-rc4-mm2/fs/reiserfs/file.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/fs/reiserfs/file.c
+++ linux-2.6.16-rc4-mm2/fs/reiserfs/file.c
@@ -1532,7 +1532,7 @@ static ssize_t reiserfs_file_write(struc
 		buf += write_bytes;
 		*ppos = pos += write_bytes;
 		count -= write_bytes;
-		balance_dirty_pages_ratelimited(inode->i_mapping);
+		balance_dirty_pages_ratelimited_nr(inode->i_mapping, num_pages);
 	}
 
 	/* this is only true on error */

--Boundary-00=_e7oBE3SAVQFeFqO--



--------------000301000207050207010304--
