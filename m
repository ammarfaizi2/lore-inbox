Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTBUJvH>; Fri, 21 Feb 2003 04:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTBUJvH>; Fri, 21 Feb 2003 04:51:07 -0500
Received: from holomorphy.com ([66.224.33.161]:40355 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267275AbTBUJvG>;
	Fri, 21 Feb 2003 04:51:06 -0500
Date: Fri, 21 Feb 2003 02:00:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       dmccr@us.ibm.com
Subject: Re: Performance of partial object-based rmap
Message-ID: <20030221100010.GB10401@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@imladris.surriel.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	dmccr@us.ibm.com
References: <7490000.1045715152@[10.10.2.4]> <278890000.1045791857@flay> <20030220190819.531e119d.akpm@digeo.com> <Pine.LNX.4.50L.0302210020560.2329-100000@imladris.surriel.com> <20030220194759.15d5d932.akpm@digeo.com> <Pine.LNX.4.50L.0302210117490.2329-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302210117490.2329-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 01:25:25AM -0300, Rik van Riel wrote:
> For object-based reverse mapping, the worst case is with large
> objects which are sparsely mapped many times (nonlinear vmas)
> and deeply inherited COW anonymous memory (apache w/ 300 children).

Actually few users of this care about time, only lowmem space. It
was (re)invented, after all, to save lowmem used for vma's.

The technical issues with 32-bit aren't anywhere near as difficult
to deal with as the massive amount of backlash anything targeted
at addressing 32-bit issues gets. These extremely irritating attempts
to marginalize every line of code written to address 32-bit issues are
probably best dealt with by showing common benefits with the so-called
"desktop" machines and/or workloads.

So witness a 768MB, 600MHz Athlon, running xmms, xterms, and mozilla:

Mem:   767376k av,  761932k used,    5444k free,       0k shrd,   70044k buff
       619264k active,             104160k inactive
Swap:  506008k av,  155860k used,  350148k free                  197644k cached

pte_chain                    5182K          5188K      99.88%   
radix_tree_node              1338K          3088K      43.32%   
dentry_cache                 1591K          2970K      53.59%   
reiser_inode_cache            480K          1226K      39.17%   
buffer_head                  1040K          1043K      99.79%   
size-4096                     828K           828K     100.00%   
size-32                       796K           800K      99.54%   
biovec-BIO_MAX_PAGES          768K           780K      98.46%   
pgd                           704K           704K     100.00%   

nr_page_table_pages                  689

which amounts to 2756KB RAM used for PTE's, demonstrating large
amounts of internal fragmentation within the pte_chain slab.

Reducing kernel memory consumption would reduce swapping requirements,
which generally speeds things up on the precious "desktop". The vfs
should probably get its act together too, since normal usage regularly
triggers explosive dentry_cache and reiser_inode_cache space usage.

-- wli
