Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVAJJWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVAJJWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVAJJWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:22:12 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:48735 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262167AbVAJJVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:21:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V1QAGtc/fgbR7qCk1NmhccQx/L2IylBRdb8OA51PK50mbkKbGwB0qx/6p1Euyba3mo/KB3r3NjWbnDGOOzd1J3HXEFtCSwkZTTEeEqEgrHnKNajGhIhv3rKU7BuWUB+7I00Nbmzpii1vLEnjLD7iZG7riAdijXRjSErStNkhJTE=
Message-ID: <4d6522b9050110012161b95f87@mail.gmail.com>
Date: Mon, 10 Jan 2005 11:21:32 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauriciolin@gmail.com>,
       William Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Regarding he Code:

I am not an expert like you guys, but I worked with the first version of this
proposal about a year ago and posted it to this list. At that time we had no
idea about how useful it migh be. Lin continued the work and improved it, 
and I can see for the feedbacks he will be able to meet the standards.

Regarding the idea:

IMHO, I belive we've just found a potentially important use of it. We tested
the old version of this patch for applications running on the Sarge Debian
Distro for ARM platform (can be found ftp.debian.org/dists/sarge). 
We tested only on OMAP 1510 and 5912. The advantage we found is that
these little numbers can be used to help control the memory consumption
for embedded devices like the one we tested. A fine grain memory control
can help us envisage how memory is consumed with such systems that
usually lack swap space. If they ever have (allocating space from flash 
memory) the tiny control give us a better picuture where we should
work on optimising memory consumption. 

We intend to test this new patch and see how it works with more applications.
Other tests would help comparing the results we will send soon.

br

Edjard


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
> Regarding the idea.
> 
> Well, it goes back to just what wli freed 2.6 from, and what we scorned
> clameter for: a costly examination of every pte-slot of every vma of the
> process.  That doesn't matter _too_ much so long as there's no standard
> tool liable to do it every second or so, nor doing it to every single
> process, and it doesn't need spinlock or preemption disabled too long.
> 
> But personally I'd be happier for it to remain an out-of-tree patch,
> just to discourage people from writing and running such tools,
> and to discourage them from adding other such costly analyses.
> 
> Potentially quite useful, perhaps.  But I don't have a use for it
> myself, and if I do have, I'll be content to search out (or recreate)
> the patch.  Let's hear from those who actually have a use for it now -
> the more useful it is, of course, the stronger the argument for inclusion.
> 
> I am a bit sceptical how useful such a lot of little numbers would
> really be - usually it's an overall picture we're interested in.
> 
> Regarding the implementation.
> 
> Unnecessarily inefficient: a pte_offset_map and unmap for each pte.
> Better go back to the 2.4.28 or 2.5.36 fs/proc/array.c design for
> statm_pgd_range + statm_pmd_range + statm_pte_range - but now you
> need a pud level too.
> 
> Seems to have no locking: needs to down_read mmap_sem to guard vmas.
> Does it need page_table_lock?  I think not (and proc_pid_statm didn't).
> 
> If there were a use for it, that use might want to distinguish between
> the "shared rss" of pagecache pages from a file, and the "anon rss" of
> private pages copied from file or originally zero - would need to get
> the struct page and check PageAnon.  And might want to count swap
> entries too.  Hard to say without real uses in mind.
> 
> Andrew mentioned "unsigned long page": similarly, we usually say
> "struct vm_area_struct *vma" rather than "*map" (well, some places
> say "*mpnt", but that's not a precedent to follow).
> 
> Regarding the display.
> 
> It's a mixture of two different styles, the /proc/<pid>/maps
> many-hex-fields one-vma-per-line style and the /proc/meminfo
> one-decimal-kB-per-line style.  I think it would be better following
> the /proc/<pid>/maps style, but replacing the major,minor,ino fields
> by size and rss (anon_rss? swap?) fields (decimal kB? I suppose so).
> 
> Hugh
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
"In a world without fences ... who needs Gates?"
