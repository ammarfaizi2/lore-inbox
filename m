Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVDKW2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVDKW2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVDKW1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:27:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63723 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261980AbVDKWZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:25:12 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hifumi.hisashi@lab.ntt.co.jp,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, vherva@viasys.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050411134651.719e3434.akpm@osdl.org>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
	 <1112818233.3377.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112889078.2859.264.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113224149.2164.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050411134651.719e3434.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113258283.2164.311.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 11 Apr 2005 23:24:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-04-11 at 21:46, Andrew Morton wrote:
> "Stephen C. Tweedie" <sct@redhat.com> wrote:
> >
> > Andrew, what was the exact illegal state of the pages you were seeing
> >  when fixing that recent leak?  It looks like it's nothing more complex
> >  than dirty buffers on an anon page.
> 
> Correct.

Good --- I think I've got the debugging solid against 2.4 for that case,
patching against 2.6 now.

> >  I think that simply calling
> >  try_to_release_page() for all the remaining buffers at umount time will
> 
> Presumably these pages have no ->mapping, so try_to_release_page() will
> call try_to_free_buffers().

Exactly.

> >  The only thing that would be required on
> >  top of that would be a check that the page is also on the VM LRU lists.
> 
> Why do we have dirty buffers left over at umount time?

In the leak case we're worried about, the buffers are dirty but the page
is anon so there's nothing to clean them up.  The buffers _will_ be
destroyed by unmount, sure; invalidate_bdev() should see to that.  But
I'm doing the bh leak check before we get to the final
invalidate_bdev(), so they should still be available for testing at that
point.

--Stephen

