Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSFGJ4x>; Fri, 7 Jun 2002 05:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSFGJ4w>; Fri, 7 Jun 2002 05:56:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44955 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317257AbSFGJ4v>;
	Fri, 7 Jun 2002 05:56:51 -0400
Date: Fri, 07 Jun 2002 02:53:19 -0700 (PDT)
Message-Id: <20020607.025319.111425384.davem@redhat.com>
To: gianni@ecsc.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: mmap packet socket information leak (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1022673535.31102.17.camel@lemsip>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gianni Tedesco <gianni@ecsc.co.uk>
   Date: 29 May 2002 12:58:55 +0100

   Here is a quick patch which blanks the mmap() packet socket buffer areas
   before using them. Previously you would get uninitialised data inbetween
   the data structures where they are TPACKET_ALIGNED().
   
 ...
   
   diff -urN linux.orig/net/packet/af_packet.c linux/net/packet/af_packet.c
   --- linux.orig/net/packet/af_packet.c	Wed May 29 12:30:10 2002
   +++ linux/net/packet/af_packet.c	Wed May 29 12:29:10 2002

The following seems simpler and is what I checked into my
tree.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.539   -> 1.540  
#	net/packet/af_packet.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/07	davem@nuts.ninka.net	1.540
# AF_PACKET: Clear out packet-mmap pages.
# --------------------------------------------
#
diff -Nru a/net/packet/af_packet.c b/net/packet/af_packet.c
--- a/net/packet/af_packet.c	Fri Jun  7 02:53:22 2002
+++ b/net/packet/af_packet.c	Fri Jun  7 02:53:22 2002
@@ -1662,7 +1662,7 @@
 			pg_vec[i] = __get_free_pages(GFP_KERNEL, order);
 			if (!pg_vec[i])
 				goto out_free_pgvec;
-
+			memset((void *)(pg_vec[i]), 0, PAGE_SIZE << order);
 			pend = virt_to_page(pg_vec[i] + (PAGE_SIZE << order) - 1);
 			for (page = virt_to_page(pg_vec[i]); page <= pend; page++)
 				SetPageReserved(page);
