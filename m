Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVD0W06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVD0W06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVD0WZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:25:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28860 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262064AbVD0WXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:23:02 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1113402868.3019.27.camel@sisko.sctweedie.blueyonder.co.uk>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
	 <1113402868.3019.27.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114640549.4885.25.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 27 Apr 2005 23:22:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-13 at 15:34, Stephen C. Tweedie wrote:

> >   			if (unlikely(!buffer_uptodate(bh)))
> >   				err = -EIO;
> >   			/* the journal_head may have been removed now */
> > +			put_bh(bh);
> >   			lock_journal(journal);
> >   			goto write_out_data;

> In further testing, this chunk is causing some problems.  It is entirely
> legal for a buffer to be !uptodate here, although the path is somewhat
> convoluted.  The trouble is, once the IO has completed,
> journal_dirty_data() can steal the buffer from the committing
> transaction.  And once that happens, journal_unmap_buffer() can then
> release the buffer and clear the uptodate bit.  

It turns out that simply testing for 

	(!buffer_uptodate(bh) && buffer_mapped(bh))

is enough to fix this: the situation where the uptodate bit is cleared
manually here also clears the buffer_mapped bit, and that is done under
bh lock so we don't even have to worry about the order in which the
bitops occur.  There's another path later on in commit.c where the same
test encounters the same problem; that gets cured by the same fix.  With
the EIO errors turned into BUG()s for debugging, I've been able to run
under severe load, with 50msec commit intervals, for a day or so on SMP
without running into any false positives.

In checking out the patch one last time, though, I found one anomaly. 
The patch that was submitted to 2.6 for this problem also changed
write_inode_now() to return an error value.  The patch that got
submitted to 2.4 had no such change.  Was there a reason for this
difference between the two versions?

Cheers,
 Stephen

