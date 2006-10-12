Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWJLCgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWJLCgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 22:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWJLCgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 22:36:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52353 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965260AbWJLCgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 22:36:50 -0400
Message-ID: <452DAA26.6080200@redhat.com>
Date: Wed, 11 Oct 2006 21:36:22 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@sandeen.net>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061002231945.f2711f99.akpm@osdl.org>	 <452AA716.7060701@sandeen.net>	 <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com>	 <20061009225036.GC26728@redhat.com>	 <20061010141145.GM23622@atrey.karlin.mff.cuni.cz>	 <452C18A6.3070607@redhat.com>	 <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>	 <452C4C47.2000107@sandeen.net>	 <20061011103325.GC6865@atrey.karlin.mff.cuni.cz>	 <452CF523.5090708@sandeen.net>	 <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

> Here is what I think is happening..
> 
> journal_unmap_buffer() - cleaned the buffer, since its outside EOF, but
> its a part of the same page. So it remained on the page->buffers
> list. (at this time its not part of any transaction).
> 
> Then, ordererd_commit_write() called journal_dirty_data() and we added
> all these buffers to BJ_SyncData list. (at this time buffer is clean -
> not dirty).
> 
> Now msync() called __set_page_dirty_buffers() and dirtied *all* the
> buffers attached to this page.
> 
> journal_submit_data_buffers() got around to this buffer and tried to
> submit the buffer...

This seems about right, but one thing bothers me in the traces; it seems like 
there is some locking that is missing.  In
http://people.redhat.com/esandeen/traces/eric_ext3_oops1.txt
for example, it looks like journal_dirty_data gets started, but then the 
buffer_head is acted on by journal_unmap_buffer, which decides this buffer is 
part of the running transaction, past EOF, and clears mapped, dirty, etc.  Then 
journal_dirty_data picks up again, decides that the buffer is not on the right 
list (now BJ_None) and puts it back on BJ_SyncData.  Then it gets picked up by 
journal_submit_data_buffers and submitted, and oops.

Talking with Stephen, it seemed like the page lock should synchronize these 
threads, but I've found that we can get to journal_dirty_data acting on the 
buffer heads w/o having the page locked...

I'm still digging, and, er, grasping at straws here... Am I off base?

-Eric


> Andrew is right - only option for us to check the filesize in the
> write out path and skip the buffers beyond EOF.
> 
> Thanks,
> Badari
> 

