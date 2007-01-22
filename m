Return-Path: <linux-kernel-owner+w=401wt.eu-S1751940AbXAVQRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbXAVQRp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbXAVQRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:17:44 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:39416 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751940AbXAVQRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:17:44 -0500
Message-ID: <45B4E3A3.40706@cfl.rr.com>
Date: Mon, 22 Jan 2007 11:17:39 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, Linus Torvalds <torvalds@osdl.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <200701210005.36274.vda.linux@googlemail.com> <45B3580F.7040407@tls.msk.ru> <200701212102.43028.vda.linux@googlemail.com>
In-Reply-To: <200701212102.43028.vda.linux@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2007 16:18:15.0756 (UTC) FILETIME=[EBC258C0:01C73E40]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14950.003
X-TM-AS-Result: No--9.694800-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> The difference is that you block exactly when you try to access
> data which is not there yet, not sooner (potentially much sooner).
> 
> If application (e.g. database) needs to know whether data is _really_ there,
> it should use aio_read (or something better, something which doesn't use signals.
> Do we have this 'something'? I honestly don't know).

The application _IS_ using aio, which is why it can go and perform other 
work while it waits to be told that the read has completed.  This is not 
possible with mmap because the task is blocked while faulting in pages, 
and unless it tries to access the pages, they won't be faulted in.

> In some cases, evne this is not needed because you don't have any other
> things to do, so you just do read() (which returns early), and chew on
> data. If your CPU is fast enough and processing of data is light enough
> so that it outruns disk - big deal, you block in page fault handler
> whenever a page is not read for you in time.
> If CPU isn't fast enough, your CPU and disk subsystem are nicely working
> in parallel.

Being blocked in the page fault handler means the cpu is now idle 
because you can't go chew on data that _IS_ in core.  The aio + O_DIRECT 
allows you to control when IO is started rather than rely on the kernel 
to decide when is a good time for readahead, and to KNOW when that IO is 
done so you can chew on the data.

> With O_DIRECT, you alternate:
> "CPU is idle, disk is working" / "CPU is working, disk is idle".

You have this completely backwards.  With mmap this is what you get 
because you chew data, page fault... chew data... page fault...

> What do you want to do on I/O error? I guess you cannot do much -
> any sensible db will shutdown itself. When your data storage
> starts to fail, it's pointless to continue running.

Ever hear of error recovery?  A good db will be able to cope with one or 
two bad blocks, or at the very least continue operating the other tables 
or databases it is hosting, or flush transactions and switch to read 
only mode, or any number of things other than abort().

> You do not need to know which read() exactly failed due to bad disk.
> Filename and offset from the start is enough. Right?
> 
> So, SIGIO/SIGBUS can provide that, and if your handler is of
> 	void (*sa_sigaction)(int, siginfo_t *, void *);
> style, you can get fd, memory address of the fault, etc.
> Probably kernel can even pass file offset somewhere in siginfo_t...

Sure... now what does your signal handler have to do in order to handle 
this error in such a way as to allow the one request to be failed and 
the task to continue handling other requests?  I don't think this is 
even possible, yet alone clean.

> You can still be multithreaded. The point is, with O_DIRECT
> you _are forced_ to_ be_ multithreaded, or else perfomance will suck.

Or use aio.  Simple read/write with the kernel trying to outsmart the 
application is nice for very simple applications, but it does not 
provide very good performance.  This is why we have aio and O_DIRECT; 
because the application can manage the IO better than the kernel because 
it actually knows what it needs and when.

Yes, the application ends up being more complex, but that is the price 
you pay.  You simply can't get it perfect in a general purpose kernel 
that has to guess what the application is really trying to do.

> You think "Oracle". But this application may very well be
> not Oracle, but diff, or dd, or KMail. I don't want to care.
> I want all big writes to be efficient, not just those done by Oracle.
> *Including* single threaded ones.

Then redesign those applications to use aio and O_DIRECT.  Incidentally 
I have hacked up dd to do just that and have some very nice performance 
numbers as a result.

> Well, I too currently work with Oracle.
> Apparently people who wrote damn thing have very, eh, Oracle-centric
> world-view. "We want direct writes to the disk. Period." Why? Does it
> makes sense? Are there better ways? - nothing. They think they know better.

Nobody has shown otherwise to date.


