Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUDWJY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUDWJY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUDWJY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:24:56 -0400
Received: from village.ehouse.ru ([193.111.92.18]:65291 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264770AbUDWJYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:24:54 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: admin@list.net.ru
Subject: Re: Similar behaviour without BUG() message(was: Re: 2.6.5-aa3: kernel BUG at mm/objrmap.c:137!)
Date: Fri, 23 Apr 2004 13:24:42 +0400
User-Agent: KMail/1.6.1
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <200404141257.16731.gluk@php4.ru> <200404191632.53565.gluk@php4.ru> <20040423022732.GU29954@dualathlon.random>
In-Reply-To: <20040423022732.GU29954@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404231324.42819.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 06:27, Andrea Arcangeli wrote:
> following your trace I got to some futex issue (likely invoked by NPTL),
> and following the futex code I noticed a race with threads in
> expand_stack and likely the futex is effectively calling expand_stack
> too. Then I found a race in expand_stack with threads.
>
> here the details:
>
> in 2.6-aa expand_stack is moving down vm_start and vm_end with only the
> read semaphore held. this means this thing can even run in parallel in
> both cpus, the latter will corrupt vm_pgoff which generate malfunction
> with anon-vma:
>
>         vma->vm_start = address;
>         vma->vm_pgoff -= grow;
>
> this isn't an issue for the file mappings because only anon vmas can be
> growsdown (the filemappings could never work right in filemap_nopage if
> expand_stack would mess with pgoff and vm_start without holding the
> mmap_sem in write mode).
>
> serializing this with anon-vma is easy and scalable with the
> anon_vma_lock (not an mm-wide lock like the page_table_lock).
> This will also serialize perfectly with the objrmap. objrmap should be
> the only thing that cares about vm_pgoff and vm_start being coherent at
> the same time for anon-mappings in anon-vma, and the anon_vma_lock
> provides perfect locking for that.
>
> One of the scalability and simplicity locking beauty of anon-vma is the
> total avoidance of page_table_lock for vma merging and all other vma
> operations in general, and true usage of page_table_lock only for the
> pagetables (and future usage of vma->page_table_lock only for pagetables
> too). I wouldn't really like to giveup on this and to reintroduce the
> whole mess of page_table_lock in the vma merging and in expand stack
> that all other implementations like 2.6 mainline and anonmm are
> suffering from, and I hope my fix will be enough. Could you test if this
> patch helps?

       Of course, but it will take some time,i've got two followed oops 
  on previous kernel after almost two weeks of stable work. I think week 
  or two would be enough  "timeslice" to say something. Unfortunately i 
  can't try artificial tests on a production system but i guess ordinary 
  load would be enough.

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
