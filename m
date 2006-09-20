Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWITU7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWITU7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWITU7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:59:46 -0400
Received: from [63.64.152.142] ([63.64.152.142]:61197 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751055AbWITU7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:59:23 -0400
From: Ashwini Kulkarni <ashwini.kulkarni@intel.com>
Subject: [RFC 5/6] Add skb_splice_bits to skbuff.c
Date: Wed, 20 Sep 2006 14:08:20 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: christopher.leech@intel.com
Message-Id: <20060920210820.17480.39840.stgit@gitlost.site>
In-Reply-To: <20060920210711.17480.92354.stgit@gitlost.site>
References: <20060920210711.17480.92354.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---

 include/linux/skbuff.h |    2 +
 net/core/skbuff.c      |  137 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 0 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 755e9cd..8f4b90e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1338,6 +1338,8 @@ extern unsigned int    skb_checksum(cons
 				    int len, unsigned int csum);
 extern int	       skb_copy_bits(const struct sk_buff *skb, int offset,
 				     void *to, int len);
+extern int	       skb_splice_bits(const struct sk_buff *skb, int offset,
+				     struct pipe_inode_info *pipe, int len, unsigned int flags);
 extern int	       skb_store_bits(const struct sk_buff *skb, int offset,
 				      void *from, int len);
 extern unsigned int    skb_copy_and_csum_bits(const struct sk_buff *skb,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c54f366..a92d165 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -53,6 +53,7 @@
 #endif
 #include <linux/string.h>
 #include <linux/skbuff.h>
+#include <linux/pipe_fs_i.h>
 #include <linux/cache.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
@@ -70,6 +71,17 @@
 static kmem_cache_t *skbuff_head_cache __read_mostly;
 static kmem_cache_t *skbuff_fclone_cache __read_mostly;
 
+/* Pipe buffer operations for a socket. */
+static struct pipe_buf_operations sock_buf_ops = {
+	.can_merge = 0,
+	.map = generic_pipe_buf_map,
+	.unmap = generic_pipe_buf_unmap,
+	.pin = generic_pipe_buf_pin,
+	.release = generic_sock_buf_release,
+	.steal = generic_pipe_buf_steal,
+	.get = generic_pipe_buf_get,
+};
+
 /*
  *	Keep out-of-line to prevent kernel bloat.
  *	__builtin_return_address is not used because it is not always
@@ -1148,6 +1160,131 @@ fault:
 	return -EFAULT;
 }
 
+/* Move specified number of bytes from the source skb to the
+ * destination pipe buffer. This function even handles all the
+ * bits of traversing fragment lists.
+ */
+int skb_splice_bits(const struct sk_buff *skb, int offset, struct pipe_inode_info *pipe, int len, unsigned int flags)
+{
+	struct page *page;
+	struct partial_page partial[PIPE_BUFFERS];
+	struct page *pages[PIPE_BUFFERS];
+	int buflen, available_len;
+	int pg_nr = 0;
+	int i, nfrags;
+	void *address;
+	size_t ret = 0;
+	struct splice_pipe_desc spd = {
+		.pages = pages,
+		.partial = partial,
+		.flags = flags,
+		.ops = &sock_buf_ops,
+	};
+
+	buflen = skb_headlen(skb);
+
+	if ((available_len = buflen - offset) >0) {
+		if (available_len > len)
+			available_len = len;
+
+			page = alloc_page(GFP_KERNEL);
+				if (!page)
+					return -ENOMEM;
+
+				address = kmap(page);
+				memcpy(address, skb->data + offset, available_len);
+				/* Push page into splice pipe desc. */
+				spd.pages[pg_nr] = page;
+				pg_nr++;
+				kunmap(page);
+
+				/* If entire length has been consumed or number of pages pushed into
+				 * splice pipe desc(pipe buffer) equals 16, then call splice_to_pipe.
+				 */
+				if (((len -= available_len) == 0) || pg_nr == PIPE_BUFFERS) {
+					spd.nr_pages = pg_nr;
+					offset += available_len;
+                                        ret = splice_to_pipe(pipe, &spd);
+                                        if (ret == -EPIPE)
+                                                return -EPIPE;
+                                        else if (ret == -EAGAIN)
+                                                return -EAGAIN;
+                                        else if (ret == -ERESTARTSYS)
+                                                return -ERESTARTSYS;
+                                        else goto frags;
+				}
+			}
+		frags:
+			if (skb_shinfo(skb)->nr_frags != 0) {
+				nfrags = skb_shinfo(skb)->nr_frags;
+
+				for (i = 0; i < nfrags; i++) {
+					int total;
+					skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+					get_page(skb_shinfo(skb)->frags[i].page);
+
+					total = buflen + skb_shinfo(skb)->frags[i].size;
+
+					if ((available_len = total - offset) > 0) {
+
+						if (available_len > len)
+							available_len = len;
+
+						spd.pages[pg_nr] = frag->page;
+						spd.partial[pg_nr].offset = frag->page_offset;
+						spd.partial[pg_nr].len = frag->size;
+						pg_nr++;
+
+						if (((len -= available_len) == 0) || pg_nr == PIPE_BUFFERS) {
+							spd.nr_pages = pg_nr;
+							ret = splice_to_pipe(pipe, &spd);
+							goto out;
+						}
+
+							offset += available_len;
+					}
+							buflen = total;
+				}
+							spd.nr_pages = pg_nr;
+							ret = splice_to_pipe(pipe, &spd);
+			}
+		out:
+			if (ret == -EPIPE)
+                                return -EPIPE;
+                        if (ret == -EAGAIN)
+                                return -EAGAIN;
+                        if (ret == -ERESTARTSYS)
+                                return -ERESTARTSYS;
+
+			if (skb_shinfo(skb)->frag_list) {
+				struct sk_buff *list = skb_shinfo(skb)->frag_list;
+
+				for(; list; list = list->next) {
+					int total, more;
+
+				total = buflen + list->len;
+					if ((available_len = total - offset) > 0) {
+
+						if (available_len > len)
+							available_len = len;
+
+						more = skb_splice_bits(list, offset - buflen, pipe, available_len, flags);
+						if (more >= 0)
+                	                                ret += more;
+                        	                else
+                                	                return -EFAULT;
+
+						if ((len -= available_len) == 0)
+							return ret;
+
+							offset += available_len;
+					}
+							buflen = total;
+				}
+			}
+	return ret;
+}
+
 /**
  *	skb_store_bits - store bits from kernel buffer to skb
  *	@skb: destination buffer

