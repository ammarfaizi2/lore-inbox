Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVAJPXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVAJPXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVAJPXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:23:40 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:18041 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262288AbVAJPXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:23:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MSYKS/4Rkq0B8t9AarPAEU96FSAoyKhgs5Atuuq6M8Wl7BCFnZmE+YJltzS9SMZsKiAqq5o2gVOMuEV7h1Eu3i23ZQnzoSGdYoeqd1NXCyXvdvpQIDfV9JvP+cDujdIMQuroioabLk0nhkxVEYJbXtVehUlgkXDr9gyLZr2nmn4=
Message-ID: <3f250c7105011007237d9e25c@mail.gmail.com>
Date: Mon, 10 Jan 2005 11:23:07 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, William Irwin <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005 20:20:39 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> On Thu, 6 Jan 2005, Andrew Morton wrote:
> > Mauricio Lin <mauriciolin@gmail.com> wrote:
> > >
> > > Here is a new entry developed for /proc that prints for each process
> > > memory area (VMA) the size of rss. The maps from original kernel is
> > > able to present the virtual size for each vma, but not the physical
> > > size (rss). This entry can provide an additional information for tools
> > > that analyze the memory consumption. You can know the physical memory
> > > size of each library used by a process and also the executable file.
> > >
> > > Take a look the output:
> > > # cat /proc/877/smaps
> > > 08048000-08132000 r-xp  /usr/bin/xmms
> > > Size:     936 kB
> > > Rss:     788 kB
> >
> > This is potentially quite useful.  I'd be interested in what others think of
> > the idea and implementation.
> 
> Regarding the implementation.
> 
> Unnecessarily inefficient: a pte_offset_map and unmap for each pte.
> Better go back to the 2.4.28 or 2.5.36 fs/proc/array.c design for
> statm_pgd_range + statm_pmd_range + statm_pte_range - but now you
> need a pud level too.
> 
> Seems to have no locking: needs to down_read mmap_sem to guard vmas.
There are down_read and up_read inside the functions. The
proc_pid_smaps_op has fields that points to these functions that treat
the down_read and up_read related to mmap_sem.
The smaps implementation is based on map entry, so you can check it.
Actually this implementation could be included in maps, but create a
new entry is better, because we do not want to mess up the original
maps entry for a while.

+ struct seq_operations proc_pid_smaps_op = {
+       .start  = m_start,
+       .next   = m_next,
+       .stop   = m_stop,
+       .show   = show_smap
+ };

> Does it need page_table_lock?  I think not (and proc_pid_statm didn't).
> 
> If there were a use for it, that use might want to distinguish between
> the "shared rss" of pagecache pages from a file, and the "anon rss" of
> private pages copied from file or originally zero - would need to get
> the struct page and check PageAnon.  And might want to count swap
> entries too.  Hard to say without real uses in mind.
Let's wait for new results.
> 
> Andrew mentioned "unsigned long page": similarly, we usually say
> "struct vm_area_struct *vma" rather than "*map" (well, some places
> say "*mpnt", but that's not a precedent to follow).
OK, this can be changed.
> 
> Regarding the display.
> 
> It's a mixture of two different styles, the /proc/<pid>/maps
> many-hex-fields one-vma-per-line style and the /proc/meminfo
> one-decimal-kB-per-line style.  I think it would be better following
> the /proc/<pid>/maps style, but replacing the major,minor,ino fields
> by size and rss (anon_rss? swap?) fields (decimal kB? I suppose so).
The ouput format can be changed, because I also prefer the maps
format. The temporary format is just for people to understand it
easily.
> Hugh
> 
>
