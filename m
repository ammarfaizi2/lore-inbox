Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVAOJ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVAOJ7S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 04:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVAOJ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 04:59:17 -0500
Received: from canuck.infradead.org ([205.233.218.70]:22291 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262251AbVAOJ65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 04:58:57 -0500
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
From: Arjan van de Ven <arjan@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, matthias@corelatus.se,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050115093657.GI3474@holomorphy.com>
References: <16872.55357.771948.196757@antilipe.corelatus.se>
	 <20050115013013.1b3af366.akpm@osdl.org>
	 <20050115093657.GI3474@holomorphy.com>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 10:58:45 +0100
Message-Id: <1105783125.6300.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 01:36 -0800, William Lee Irwin III wrote:
> Matthias Lang <matthias@corelatus.se> wrote:
> >> The linux implementation of setitimer() doesn't behave quite as
> >>  expected. I found several problems:
> >>    1. POSIX says that negative times should cause setitimer() to 
> >>       return -1 and set errno to EINVAL. In linux, the call succeeds.
> >>    2. POSIX says that time values with usec >= 1000000 should
> >>       cause the same behaviour. In linux, the call succeeds.
> >>    3. If large time values are given, linux quietly truncates them
> >>       to the maximum time representable in jiffies. On 2.4.4 on PPC,
> >>       that's about 248 days. On 2.6.10 on x86, that's about 24 days.
> >>       POSIX doesn't really say what to do in this case, but looking at
> >>       established practice, i.e. "what BSD does", since the call comes 
> >>       from BSD, *BSD returns -1 if the time is out of range.
> 
> On Sat, Jan 15, 2005 at 01:30:13AM -0800, Andrew Morton wrote:
> > These are things we probably cannot change now.  All three are arguably
> > sensible behaviour and do satisfy the principle of least surprise.  So
> > there may be apps out there which will break if we "fix" these things.
> > If the kernel version was 2.7.0 then well maybe...
> 
> We can easily do a "rolling upgrade" by adding new versions of the
> system calls, giving glibc and apps grace periods to adjust to them,
> and nuking the old versions in a few years.

but for 1: do we care? it is being more tolerant than allowed by a
standard. Those who care can easily add the test in the userspace
wrapper

for 2: we again are more tolerant and dtrt; again. And again userspace
wrapper can impose an additional restriction if it wants

3 is more nasty and needs thinking; we could consider a fix inside the
kernel that actually does wait long enough


I don't see a valid reason to restrict/reject input that is accepted now
and dealt with reasonably because some standard says so (if you design a
new api, following the standard is nice of course). I don't see "doesn't
reject a condition that can reasonable be dealt with" as a good reason
to go double ABI at all.


