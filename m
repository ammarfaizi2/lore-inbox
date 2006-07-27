Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWG0SFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWG0SFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbWG0SFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:05:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751905AbWG0SFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:05:03 -0400
Date: Thu, 27 Jul 2006 11:04:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: aia21@cam.ac.uk, nickpiggin@yahoo.com.au, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net, arjan@infradead.org
Subject: Re: [BUG?] possible recursive locking detected
Message-Id: <20060727110425.5cd40bd9.akpm@osdl.org>
In-Reply-To: <20060727144542.GA27451@elte.hu>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	<20060726225311.f51cee6d.akpm@osdl.org>
	<44C86271.9030603@yahoo.com.au>
	<1153984527.21849.2.camel@imp.csi.cam.ac.uk>
	<20060727003806.def43f26.akpm@osdl.org>
	<1153988398.21849.16.camel@imp.csi.cam.ac.uk>
	<20060727015356.f01b5644.akpm@osdl.org>
	<1153992484.21849.36.camel@imp.csi.cam.ac.uk>
	<20060727094617.GA5955@elte.hu>
	<1154010677.21849.66.camel@imp.csi.cam.ac.uk>
	<20060727144542.GA27451@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 16:45:43 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > Note that even the above patch is not a 100% solution.  What 
> > guarantees are there that the page faulted in will still be around 
> > when it is read a few lines down the line in the code?  Given 
> > sufficient parallel memory pressure/io pressure it can still cause the 
> > page to be evicted again immediately after it is faulted in...
> >
> > All the above patch does is to _dramatically_ reduce the race window 
> > for this happening but it does not eliminate it in theory (AFAICS).
> > 
> > So if your stance is that deadlocks are completely unacceptable it 
> > still is not fixed.  If your stance is that _really_ unlikely 
> > deadlocks are acceptable then it is fixed.
> 
> my 'stance' is pretty common-sense: exploitable deadlocks (it's possible 
> to force eviction of a page), or even hard-to-trigger but possible 
> deadlocks (which are not associated with hopeless resource exhaustation) 
> must be fixed.

Yeah.  It's super-hard to hit though - I spent some time trying to do so
back in 2.5.<late> and was unable to do so.

And nobody is likely to hit it in production because nobody will go and
write() into a pagecache page from a mmapped copy of the same page
(surely?).  So it's the deliberately-triggered deadlocks we need to be
concerned of here.

That's for ext2/3.  I didn't know about the reiserfs problem.

> couldnt we exclude the case of 'write writing to the same page it is 
> reading from' abuse, to avoid the deadlock problem?

That would involve doing a follow_page() to get at the other pageframe.  If
we were to do that, we could just pin the page.  But we've always been
reluctant to add the cost of that.

I guess we could fix it by making the copy_to/from_user be atomic and if it
faults, drop the page lock, loop around and try again.

There's a more serious deadlock in there: an ab/ba deadlock between
journal_start() and lock_page().  It's hard to fix.
