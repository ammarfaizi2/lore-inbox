Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVDWAEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVDWAEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVDWAEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:04:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22033 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261367AbVDWACO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:02:14 -0400
Date: Sat, 23 Apr 2005 02:02:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: vandrove@vc.cvut.cz
Cc: linware@sh.cvut.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ncpfs/: remove unused #ifdef USE_OLD_SLOW_DIRECTORY_LISTING code
Message-ID: <20050423000212.GL4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some unused #ifdef USE_OLD_SLOW_DIRECTORY_LISTING 
code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ncpfs/dir.c           |   13 ------------
 fs/ncpfs/ncplib_kernel.c |   40 ---------------------------------------
 fs/ncpfs/ncplib_kernel.h |    3 --
 3 files changed, 56 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/ncpfs/dir.c.old	2005-04-20 23:53:44.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/ncpfs/dir.c	2005-04-20 23:53:56.000000000 +0200
@@ -705,18 +705,6 @@
 		DPRINTK("ncp_do_readdir: init failed, err=%d\n", err);
 		return;
 	}
-#ifdef USE_OLD_SLOW_DIRECTORY_LISTING
-	for (;;) {
-		err = ncp_search_for_file_or_subdir(server, &seq, &entry.i);
-		if (err) {
-			DPRINTK("ncp_do_readdir: search failed, err=%d\n", err);
-			break;
-		}
-		entry.volume = entry.i.volNumber;
-		if (!ncp_fill_cache(filp, dirent, filldir, ctl, &entry))
-			break;
-	}
-#else
 	/* We MUST NOT use server->buffer_size handshaked with server if we are
 	   using UDP, as for UDP server uses max. buffer size determined by
 	   MTU, and for TCP server uses hardwired value 65KB (== 66560 bytes). 
@@ -754,7 +742,6 @@
 		}
 	} while (more);
 	vfree(buf);
-#endif
 	return;
 }
 
--- linux-2.6.12-rc2-mm3-full/fs/ncpfs/ncplib_kernel.h.old	2005-04-20 23:54:04.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/ncpfs/ncplib_kernel.h	2005-04-20 23:54:11.000000000 +0200
@@ -87,9 +87,6 @@
 
 int ncp_initialize_search(struct ncp_server *, struct inode *,
 		      struct nw_search_sequence *target);
-int ncp_search_for_file_or_subdir(struct ncp_server *server,
-			      struct nw_search_sequence *seq,
-			      struct nw_info_struct *target);
 int ncp_search_for_fileset(struct ncp_server *server,
 			   struct nw_search_sequence *seq,
 			   int* more, int* cnt,
--- linux-2.6.12-rc2-mm3-full/fs/ncpfs/ncplib_kernel.c.old	2005-04-20 23:54:19.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/ncpfs/ncplib_kernel.c	2005-04-20 23:54:26.000000000 +0200
@@ -845,46 +845,6 @@
 	return result;
 }
 
-/* Search for everything */
-int ncp_search_for_file_or_subdir(struct ncp_server *server,
-				  struct nw_search_sequence *seq,
-				  struct nw_info_struct *target)
-{
-	int result;
-
-	ncp_init_request(server);
-	ncp_add_byte(server, 3);	/* subfunction */
-	ncp_add_byte(server, server->name_space[seq->volNumber]);
-	ncp_add_byte(server, 0);	/* data stream (???) */
-	ncp_add_word(server, cpu_to_le16(0x8006));	/* Search attribs */
-	ncp_add_dword(server, RIM_ALL);		/* return info mask */
-	ncp_add_mem(server, seq, 9);
-#ifdef CONFIG_NCPFS_NFS_NS
-	if (server->name_space[seq->volNumber] == NW_NS_NFS) {
-		ncp_add_byte(server, 0);	/* 0 byte pattern */
-	} else 
-#endif
-	{
-		ncp_add_byte(server, 2);	/* 2 byte pattern */
-		ncp_add_byte(server, 0xff);	/* following is a wildcard */
-		ncp_add_byte(server, '*');
-	}
-	
-	if ((result = ncp_request(server, 87)) != 0)
-		goto out;
-	memcpy(seq, ncp_reply_data(server, 0), sizeof(*seq));
-	ncp_extract_file_info(ncp_reply_data(server, 10), target);
-
-	ncp_unlock_server(server);
-	
-	result = ncp_obtain_nfs_info(server, target);
-	return result;
-
-out:
-	ncp_unlock_server(server);
-	return result;
-}
-
 int ncp_search_for_fileset(struct ncp_server *server,
 			   struct nw_search_sequence *seq,
 			   int* more,

