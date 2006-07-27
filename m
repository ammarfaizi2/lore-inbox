Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWG0Obu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWG0Obu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWG0Obu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:31:50 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:43675 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751440AbWG0Obt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:31:49 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [BUG?] possible recursive locking detected
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org, aia21@cantab.net,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060727094617.GA5955@elte.hu>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	 <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au>
	 <1153984527.21849.2.camel@imp.csi.cam.ac.uk>
	 <20060727003806.def43f26.akpm@osdl.org>
	 <1153988398.21849.16.camel@imp.csi.cam.ac.uk>
	 <20060727015356.f01b5644.akpm@osdl.org>
	 <1153992484.21849.36.camel@imp.csi.cam.ac.uk>
	 <20060727094617.GA5955@elte.hu>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 27 Jul 2006 15:31:17 +0100
Message-Id: <1154010677.21849.66.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 11:46 +0200, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > An example is the potential deadlock in generic buffered file write 
> > where we fault in a page via fault_in_pages_readable() but there is 
> > nothing to guarantee that page will not go away between us doing this 
> > and us using the page.
> 
> isnt this solved by:
> 
>  commit 6527c2bdf1f833cc18e8f42bd97973d583e4aa83
>  Author: Vladimir V. Saveliev <vs@namesys.com>
>  Date:   Tue Jun 27 02:53:57 2006 -0700
> 
>      [PATCH] generic_file_buffered_write(): deadlock on vectored write
> 
> ?
> 
> if not, do you have any description of the problem or a link to previous 
> discussion[s] outlining the problem? To me it appears this is a kernel 
> bug where we simply dropped the ball to fix it. I personally dont find 
> it acceptable to have deadlocks in the kernel, where all that is needed 
> to trigger it is "high i/o loads", no matter how hard it is to fix the 
> deadlock.

For reiserfs?  Certainly not given it doesn't use
generic_file_buffered_write() and instead does the most useless and
stupid thing known to mankind by causing the deadlock even more
effectively (it grabs and locks all the pages and _then_ calls
fault_in_pages_readable() afterwards!)...  In fact the way we stabilize
reiserfs is to make it use generic_file_write() which doesn't do such
stupidities...

Note that even the above patch is not a 100% solution.  What guarantees
are there that the page faulted in will still be around when it is read
a few lines down the line in the code?  Given sufficient parallel memory
pressure/io pressure it can still cause the page to be evicted again
immediately after it is faulted in...

All the above patch does is to _dramatically_ reduce the race window for
this happening but it does not eliminate it in theory (AFAICS).

So if your stance is that deadlocks are completely unacceptable it still
is not fixed.  If your stance is that _really_ unlikely deadlocks are
acceptable then it is fixed.

The heavily loaded servers here certainly do not suffer from the
deadlock any more (well they haven't done for a while anyway no
guarantees it won't happen tomorrow).

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

