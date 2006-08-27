Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWH0RV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWH0RV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWH0RV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:21:58 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:40073 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932194AbWH0RV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:21:57 -0400
Date: Sun, 27 Aug 2006 19:21:55 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Message-ID: <20060827172155.GA21724@rhlx01.fht-esslingen.de>
References: <20060827084417.918992193@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827084417.918992193@goop.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 27, 2006 at 01:44:17AM -0700, Jeremy Fitzhardinge wrote:
> This patch implements per-processor data areas by using %gs as the
> base segment of the per-processor memory.  This has two principle
> advantages:
> 
> - It allows very simple direct access to per-processor data by
>   effectively using an effective address of the form %gs:offset, where
>   offset is the offset into struct i386_pda.  These sequences are faster
>   and smaller than the current mechanism using current_thread_info().

Yess!!
Something like that had to be done eventually about the inefficient
current_thread_info() mechanism, but I wasn't sure what exactly.

> I haven't measured performance yet, but when using the PDA for "current"
> and "smp_processor_id", I see a 5715 byte reduction in .text segment
> size for my kernel.

This is interesting, since even by doing a non-elegant
current->... --> struct task_struct *tsk = current;
replacement for excessive uses of current, I was able to gain almost 10kB
within a single file already!
I guess it's due to having tried that on an older installation with gcc 3.2,
which probably does less efficient opcode merging of current_thread_info()
requests compared to a current gcc version.
IOW, .text segment reduction could be quite a bit higher for older gcc:s.

> This uses the x86 segmentation stuff in a way similar to NPTL's way of
> implementing Thread-Local Storage.  It relies on the fact that each CPU
> has its own Global Descriptor Table (GDT), which is basically an array
> of base-length pairs (with some extra stuff).  When a segment register
> is loaded with a descriptor (approximately, an index in the GDT), and
> you use that segment register for memory access, the address has the
> base added to it, and the resulting address is used.

Not a problem for more daring user-space apps (i.e. Wine), I hope?

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
