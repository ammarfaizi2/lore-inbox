Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbTGBPnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTGBPnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:43:12 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:53710 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265054AbTGBPnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:43:07 -0400
Date: Wed, 2 Jul 2003 16:57:27 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030701022516.GL3040@dualathlon.random>
Message-ID: <Pine.LNX.4.53.0307021641560.11264@skynet>
References: <Pine.LNX.4.53.0307010238210.22576@skynet>
 <20030701022516.GL3040@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, Andrea Arcangeli wrote:

> >    Non-Linear Populating of Virtual Areas
> >    ======================================
> >
> and it was used to break truncate, furthmore the API doesn't look good
> to me, the vma should have a special VM_NONLINEAR created with a
> MAP_NONLINEAR so the vm will skip it enterely and it should be possible
> to put multiple files in the same vma IMHO.

OK, I think I absorbed most of this and read through most of the old
threads on the subject that I could find. It is very difficult to express
all the viewpoints in any type of concise manner so I'm settling for
getting about 70% of it.

The discussions on what API to use instead are all over the place and I
got lost in a twisty maze of emails, all similar. Below is the summary of
what I found that could be made into something coherent.

--Begin Extract--
   Whether this feature should remain is still being argued but it is likely
   to remain until an acceptable alternative is implemented. The main
   benefits only apply to applications such as database servers or
   virtualising applications such as emulators. There is a small number of
   reasons why it was introduced.

   The first is space requirements for large numbers of mappings. For every
   mapped region a process needs, a VMA has to be allocated to it which
   becomes a considerable space commitment when a process needs a large
   number of mappings. At worst case, there will be one VMA for every
   file-backed page mapped by the process.

   The second reason is avoiding the poor linear search algorithm used by
   get_unmapped_area() when looking for a large free virtual area. With a
   large number of mappings, this search is very expensive. It has been
   proposed to alter the function to perform a tree based search. This could
   be a tree of free areas ordered by size for example but none has yet been
   implemented. In the meantime, non-linear mappings are being used to bypass
   the VM.

   The third reason is related to frequent page faults associated with linear
   mappings. A non-linear mapping is able to prefault in all pages that are
   required by the mapping as it is presumed they will be needed very soon.
   To some extent, this can be addressed by specifying the MAP_POPULATE when
   calling mmap() for a normal mapping.

   This feature has a very serious drawback. The system calls truncate() and
   mincore() are broken with respect to non-linear mappings. Both calls
   depend on vm_area_struct>vm_pgoff, which is the offset within
   the mapped file, but the field is meaningless within a non-linear mapping.
   This means that truncated files will still have mapped pages that no
   longer have a physical backing. A number of possible solutions, such as
   allowing the pages to exist but be anonymous and private to the process,
   have been suggested but none implemented.

--End Extract--

-- 
Mel Gorman
