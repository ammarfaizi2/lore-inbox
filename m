Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWJKOWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWJKOWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWJKOWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:22:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37789 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030399AbWJKOWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:22:20 -0400
Date: Wed, 11 Oct 2006 16:22:05 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Eric Sandeen <esandeen@redhat.com>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061011142205.GB24508@atrey.karlin.mff.cuni.cz>
References: <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com> <20061009225036.GC26728@redhat.com> <20061010141145.GM23622@atrey.karlin.mff.cuni.cz> <452C18A6.3070607@redhat.com> <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com> <452C4C47.2000107@sandeen.net> <20061011103325.GC6865@atrey.karlin.mff.cuni.cz> <452CF523.5090708@sandeen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452CF523.5090708@sandeen.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara wrote:
> 
> >  Umm, but these two traces confuse me:
> >1) They are different traces that those you wrote about initially,
> >aren't they? Because here we would not call sync_dirty_buffer() from
> >journal_dirty_data().
> >  BTW: Does this buffer trace lead to that Oops in submit_bh()? I guess not
> >as the buffer is not dirty...
> 
> They do wind up at the same oops, from the same "testcase" (i.e. beat the 
> tar out of the filesystem with multiple fsx's and fsstress...)
> 
> The buffer is not dirty at that tracepoint because it has just done
>                 if (locked && test_clear_buffer_dirty(bh)) {
> prior to the tracepoint...
  Oh, I see. OK.

> 
> See the whole traces at
> 
> http://people.redhat.com/esandeen/traces/eric_ext3_oops1.txt
> http://people.redhat.com/esandeen/traces/eric_ext3_oops2.txt
  Hmm, those traces look really useful. I just have to digest them ;).

> As an aside, when we do journal_unmap_buffer... should it stay on 
> t_sync_datalist?
  Yes, it should and it seems it really was removed from it at some
point. Only later journal_dirty_data() came and filed it back to the
BJ_SyncData list. And the buffer remained unmapped till the commit time
and then *bang*... It may even be a race in ext3 itself that it called
journal_dirty_data() on an unmapped buffer but I have to read some more
code.

							Bye
								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
