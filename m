Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270661AbRHXHjq>; Fri, 24 Aug 2001 03:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270630AbRHXHjh>; Fri, 24 Aug 2001 03:39:37 -0400
Received: from mailc.telia.com ([194.22.190.4]:7930 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S270661AbRHXHja>;
	Fri, 24 Aug 2001 03:39:30 -0400
Message-Id: <200108240739.f7O7dWj01330@mailc.telia.com>
Content-Type: text/plain;
  charset="utf-8"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: <pcg@goof.com ( Marc A. Lehmann )>, linux-kernel@vger.kernel.org
Subject: [resent PATCH] Re: very slow parallel read performance
Date: Fri, 24 Aug 2001 09:35:08 +0200
X-Mailer: KMail [version 1.3]
Cc: oesi@plan9.de
In-Reply-To: <20010823233557.A12873@cerebro.laendle>
In-Reply-To: <20010823233557.A12873@cerebro.laendle>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday den 23 August 2001 23:35, pcg@goof.com ( Marc) (A.) (Lehmann ) 
wrote:
> I tested the following under linux-2.4.8-ac8, linux-2.4.8pre4 and
> 2.4.5pre4, all had similar behaviour.
>
> I have written a webserver that serves many large files, and thus, the
> disks are the bottleneck. To get around the problem of blocking reads
> (this killed thttpd's performance totally, for example) I can start one or
> more reader threads. And strace of them under load looks like this:
>

I earlier questioned this too...
And I found out that read ahead was too short for modern disks.
This is a patch I did it does also enable the profiling, the only needed
line is the  
-#define MAX_READAHEAD  31
+#define MAX_READAHEAD  511
I have not tried to push it further up since this resulted in virtually
equal total throughput for read two files than for read one.


Is possible that the limit can be altered per disk, can it?
I have read about 127 being the current max limit...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden


*******************************************
Patch prepared by: roger.larsson@norran.net

--- linux/mm/filemap.c.orig	Fri Jul 27 21:31:41 2001
+++ linux/mm/filemap.c	Sat Jul 28 03:01:05 2001
@@ -744,10 +744,8 @@
 	return NULL;
 }
 
-#if 0
 #define PROFILE_READAHEAD
 #define DEBUG_READAHEAD
-#endif
 
 /*
  * Read-ahead profiling information
@@ -791,13 +789,13 @@
 		}
 
 		printk("Readahead average:  max=%ld, len=%ld, win=%ld, async=%ld%%\n",
-			total_ramax/total_reada,
-			total_ralen/total_reada,
-			total_rawin/total_reada,
-			(total_async*100)/total_reada);
+		       total_ramax/total_reada,
+		       total_ralen/total_reada,
+		       total_rawin/total_reada,
+		       (total_async*100)/total_reada);
 #ifdef DEBUG_READAHEAD
-		printk("Readahead snapshot: max=%ld, len=%ld, win=%ld, raend=%Ld\n",
-			filp->f_ramax, filp->f_ralen, filp->f_rawin, filp->f_raend);
+		printk("Readahead snapshot: max=%ld, len=%ld, win=%ld, raend=%ld\n",
+		       filp->f_ramax, filp->f_ralen, filp->f_rawin, filp->f_raend);
 #endif
 
 		total_reada	= 0;
--- linux/include/linux/blkdev.h.orig	Fri Jul 27 21:36:37 2001
+++ linux/include/linux/blkdev.h	Sat Jul 28 02:51:10 2001
@@ -184,7 +184,7 @@
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)
 
 /* read-ahead in pages.. */
-#define MAX_READAHEAD	31
+#define MAX_READAHEAD	511
 #define MIN_READAHEAD	3
 
 #define blkdev_entry_to_request(entry) list_entry((entry), struct request, 
queue)
