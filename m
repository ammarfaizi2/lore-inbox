Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTEMXAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTEMXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:00:38 -0400
Received: from holomorphy.com ([66.224.33.161]:65469 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263661AbTEMXAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:00:36 -0400
Date: Tue, 13 May 2003 16:11:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Mika Penttil? <mika.penttila@kolumbus.fi>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030513231139.GZ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave McCracken <dmccr@us.ibm.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	Linux Memory Management <linux-mm@kvack.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <154080000.1052858685@baldur.austin.ibm.com> <3EC15C6D.1040403@kolumbus.fi> <199610000.1052864784@baldur.austin.ibm.com> <20030513224929.GX8978@holomorphy.com> <220550000.1052866808@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220550000.1052866808@baldur.austin.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 13, 2003 15:49:29 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
>> That doesn't sound like it's going to help, there isn't a unique
>> mmap_sem to be taken and so we just get caught between acquisitions
>> with the same problem.

On Tue, May 13, 2003 at 06:00:08PM -0500, Dave McCracken wrote:
> Actually it does fix it.  I added code in vmtruncate_list() to do a
> down_write(&vma->vm_mm->mmap_sem) around the zap_page_range(), and the
> problem went away.  It serializes against any outstanding page faults on a
> particular page table.  New faults will see that the page is no longer in
> the file and fail with SIGBUS.  Andrew's test case stopped failing.
> I've attached the patch so you can see what I did.
> Can anyone think of any gotchas to this solution?

Okay, what's stopping filemap_nopage() from fetching the page from
pagecache after one of the mm->mmap_sem's is dropped but before
truncate_inode_pages() removes the page? The fault path is only locked
out for one mm during one part of the operation. I can see taking
->i_sem in do_no_page() fixing it, but not ->mmap_sem in vmtruncate()
(but of course that's _far_ too heavy-handed to merge at all).

-- wli
