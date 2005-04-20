Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVDTMEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVDTMEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVDTMEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:04:39 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:16023 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261524AbVDTMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:04:08 -0400
Message-ID: <42664654.5080409@jp.fujitsu.com>
Date: Wed, 20 Apr 2005 21:08:52 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Subject: [RFC][PATCH] nameing reserved pages [1/3]
Content-Type: multipart/mixed;
 boundary="------------030507030909050902020207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507030909050902020207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

inline functions for naming pages.
-- Kame

--------------030507030909050902020207
Content-Type: text/plain;
 name="name_reserved.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="name_reserved.patch"


Adding page_type definitions and funcs for naming reserved pages.

Reserved page's information is stored into page->private.

This is a weak naming method and anyone can overwrite it. 

This information is used in /dev/memstate in following patch.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---

 linux-2.6.12-rc2-kamezawa/include/linux/mm.h |   31 +++++++++++++++++++++++++++
 1 files changed, 31 insertions(+)

diff -puN include/linux/mm.h~name_reserved include/linux/mm.h
--- linux-2.6.12-rc2/include/linux/mm.h~name_reserved	2005-04-20 09:37:48.000000000 +0900
+++ linux-2.6.12-rc2-kamezawa/include/linux/mm.h	2005-04-20 10:38:01.000000000 +0900
@@ -348,6 +348,37 @@ static inline void put_page(struct page 
 #endif		/* CONFIG_HUGETLB_PAGE */
 
 /*
+ * Type of Pages. This is used in /dev/memstate.
+ * value range is 0-255.
+ */
+enum page_type {
+	Page_Common = 0,
+	Min_Reserved_Types = 1,
+	Rserved_Unknwon = 1,
+	Reserved_At_Boot,
+	Max_Reserved_Types,
+	Page_Invalid = 0xff
+};
+/*
+ * Basically, page->private has no meaning without PG_private.
+ * Here, we use page->private for PG_reserved pages to record type of a page.
+ * Because a page is reserved, anyone will not modify page->private.
+ * When it is freed, page->private will be overwritten by some code.
+ */
+static inline void set_page_reserved(struct page *page, unsigned char type)
+{
+	SetPageReserved(page);
+	page->private = type;
+}
+
+static inline unsigned char reserved_page_type(struct page *page)
+{
+	if (!PageReserved(page))
+		return 0;
+	return (unsigned char)page->private;
+}
+
+/*
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
  * zeroes, and text pages of executables and shared libraries have

_

--------------030507030909050902020207--

