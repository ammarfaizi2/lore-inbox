Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263845AbUEMHFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUEMHFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUEMHFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:05:13 -0400
Received: from holomorphy.com ([207.189.100.168]:32700 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263850AbUEMHFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:05:03 -0400
Date: Thu, 13 May 2004 00:04:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Muli Ben-Yehuda <mulix@mulix.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513070434.GS1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org> <20040513065912.GR1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513065912.GR1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 11:59:12PM -0700, William Lee Irwin III wrote:
> +#ifdef CONFIG_HUGETLB_PAGE
> +static inline int create_hugetlb_file(struct file **file, unsigned long flags)

That would be:


Index: wli-2.6.6-mm1/mm/mmap.c
===================================================================
--- wli-2.6.6-mm1.orig/mm/mmap.c	2004-05-12 23:29:53.000000000 -0700
+++ wli-2.6.6-mm1/mm/mmap.c	2004-05-13 00:02:36.000000000 -0700
@@ -771,6 +771,26 @@
 	return error;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static inline int create_hugetlb_file(struct file **file, unsigned long flags,
+							unsigned long len)
+{
+	/* Create an implicit hugetlb file if necessary */
+	if (*file || !(flags & MAP_HUGETLB))
+		return 0;
+	else if (!IS_ERR(*file = hugetlb_zero_setup(len)))
+		return 0;
+	else
+		return PTR_ERR(*file);
+}
+#else
+static inline int create_hugetlb_file(struct file **file, unsigned long flags,
+							unsigned long len)
+{
+	return 0;
+}
+#endif
+
 /*
  * The caller must hold down_write(current->mm->mmap_sem).
  */
@@ -809,14 +829,10 @@
 	if (current->mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
-	/* Create an implicit hugetlb file if necessary */
-	if (!file && (flags & MAP_HUGETLB)) {
-		file = hugetlb_file = hugetlb_zero_setup(len);
-		if (IS_ERR(file))
-			return PTR_ERR(file);
-	}
-
-	result = __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	if (!(result = create_hugetlb_file(&hugetlb_file, flags, len)))
+		result = __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	else
+		return result;
 
 	/* Drop reference to implicit hugetlb file, it's already been
 	 * "gotten" in __do_mmap_pgoff in case of success
