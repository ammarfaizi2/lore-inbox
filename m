Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWDLNXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWDLNXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWDLNXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:23:34 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:34062 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751132AbWDLNXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:23:33 -0400
Message-ID: <443CFF30.1090801@shadowen.org>
Date: Wed, 12 Apr 2006 14:22:56 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Kravetz <mjkravetz@verizon.net>
CC: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       Joel H Schopp <jschopp@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparsemem interaction with memory add bug fixes
References: <20060412023347.GA9343@w-mikek2.ibm.com>
In-Reply-To: <20060412023347.GA9343@w-mikek2.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030001010904010303060307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030001010904010303060307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mike Kravetz wrote:
> This patch fixes two bugs with the way sparsemem interacts with memory
> add.  They are:
> - memory leak if memmap for section already exists
> - calling alloc_bootmem_node() after boot
> These bugs were discovered and a first cut at the fixes were provided by
> Arnd Bergmann <arnd@arndb.de> and Joel Schopp <jschopp@us.ibm.com>.
> 
> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> 
> diff -Naupr linux-2.6.17-rc1-mm2/mm/sparse.c linux-2.6.17-rc1-mm2.work/mm/sparse.c
> --- linux-2.6.17-rc1-mm2/mm/sparse.c	2006-04-03 03:22:10.000000000 +0000
> +++ linux-2.6.17-rc1-mm2.work/mm/sparse.c	2006-04-11 23:32:10.000000000 +0000
> @@ -32,7 +32,10 @@ static struct mem_section *sparse_index_
>  	unsigned long array_size = SECTIONS_PER_ROOT *
>  				   sizeof(struct mem_section);
>  
> -	section = alloc_bootmem_node(NODE_DATA(nid), array_size);
> +	if (system_state == SYSTEM_RUNNING)
> +		section = kmalloc_node(array_size, GFP_KERNEL, nid);
> +	else
> +		section = alloc_bootmem_node(NODE_DATA(nid), array_size);
>  
>  	if (section)
>  		memset(section, 0, array_size);
> @@ -281,9 +284,9 @@ int sparse_add_one_section(struct zone *
>  
>  	ret = sparse_init_one_section(ms, section_nr, memmap);
>  
> +out:
>  	if (ret <= 0)
>  		__kfree_section_memmap(memmap, nr_pages);
> -out:
>  	pgdat_resize_unlock(pgdat, &flags);
>  	return ret;
>  }

First change looks sane.  For the second it makes it obvious that we are
freeing the alloc'd section within the pgdat resize lock.  Doesn't seem
to make any sense to do that to me?  Perhaps it should be more like the
attached.

-apw


--------------030001010904010303060307
Content-Type: text/plain;
 name="fix-leak-in-sparse_add_one_section"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-leak-in-sparse_add_one_section"

 sparse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
diff -upN reference/mm/sparse.c current/mm/sparse.c
--- reference/mm/sparse.c
+++ current/mm/sparse.c
@@ -281,9 +281,9 @@ int sparse_add_one_section(struct zone *
 
 	ret = sparse_init_one_section(ms, section_nr, memmap);
 
-	if (ret <= 0)
-		__kfree_section_memmap(memmap, nr_pages);
 out:
 	pgdat_resize_unlock(pgdat, &flags);
+	if (ret <= 0)
+		__kfree_section_memmap(memmap, nr_pages);
 	return ret;
 }

--------------030001010904010303060307--
