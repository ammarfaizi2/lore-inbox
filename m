Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUH2Vmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUH2Vmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUH2Vmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:42:45 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:25823 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S268336AbUH2Vml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:42:41 -0400
Date: Sun, 29 Aug 2004 23:41:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829214150.GA5060@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093810645.434.6859.camel@cube>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 16:17:26 -0400, Albert Cahalan wrote:
> When the reader falls behind, keep supplying differential
> updates as long as practical. When this starts to eat up
> lots of memory, switch to supplying the full list until
> the reader catches up again.

I think it should be up to the reader to request stuff, so I'd probably
just have the kernel notify the client that there won't be any more
differential updates. Then the client can decide what to do now.

But I'd have to play around with this to see what works.

> > While I'm not sure I understand how that partial rescan (or its limits)
> > would be defined, I agree with the general idea. There is indeed plenty
> > of room for improvement in a smart user space. For instance, most apps
> > show only the top n processes. So if an app shows the top 20 memory
> > users, it could use nproc to get a complete list of pid+vmrss, and then
> > request all the expensive fields only for the top 20 in that list.
> 
> This is crummy. It's done for wchan, since that is so horribly
> expensive, but I'm not liking the larger race condition window.

The races left with nproc are much smaller. There is of course the question
of whether the pid still exists by the time you query the kernel about it.
But you get all the information in one go (although the process may still
disappear while the kernel prepares the requested info).

> > $ ps --version
> > procps version 3.2.3
> > $ ps -o pid
> >   PID
> >  2089
> >  2139
> > $ strace ps -o pid 2>&1|grep 'open("/proc/'|wc -l
> > 325
> >
> > <whine>
> 
> While "pid" makes a nice extreme example, note that ps must
> handle arbitrary cases like "pmem,comm,wchan,ppid,session".
> 
> Now, I direct your attention to "Introduction to Algorithms",
> by Cormen, Leiserson, and Rivest. Find the section entitled
[...]
> Just remember that if I say "this is hard", I mean it.

Entertaining, but you missed the point: I am not terribly impressed with
the fact that ps opens two files (stat, statm) for _every_ _single_
_process_ if all I want to know is, say, the name of PID 42 (example
taken from ps(1): ps -p 42 -o comm=).

And FWIW, you don't need the "minimum set of /proc files needed to
supply some required set of process attributes". Any set that supplies
the required fields will do, and you can get an excellent approximation
in O(n).

I suspect Cormen, Leiserson, and Rivest would take exception with your
assertion that ps tools can't be improved. Or even that doing so is hard.

Roger

