Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267794AbUHFN6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267794AbUHFN6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267809AbUHFN6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:58:53 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:65273 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S267794AbUHFN6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:58:50 -0400
Date: Fri, 6 Aug 2004 15:57:56 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806135756.GA21411@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <20040806104630.GA17188@holomorphy.com> <20040806120123.GA23081@k3.hellgate.ch> <20040806121118.GE17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806121118.GE17188@holomorphy.com>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2004 05:11:18 -0700, William Lee Irwin III wrote:
> Some of the 2.4 semantics just don't make sense. I would not find it
> difficult to explain what I believe correct semantics to be in a written
> document.

IMO this is a must for such files (and be it only some comments above
the code implementing them). I'm afraid that statm is carrying too much
historical baggage, though -- you would add yet another interpretation
of those 7 fields.

Tools reading statm would have to be updated anyway, so I'd rather
think about what could be done with a new (or just different) file.

For sysfs we have guidelines (e.g. sysfs.txt: "Attributes should be ASCII
text files, preferably with only one value per file. It is noted that it
may not be efficient to contain only value per file, so it is socially
acceptable to express an array of values of the same type.").

I'm not aware of anything comparable for proc, so it's hard to say
what a good solution would look like. Files like /proc/pid/status
are human-readable and maintenance-friendly (the parser can recognize
unknown values and gets a free label along with it; obsolete fields can
be removed). The downside is the performance aspect you pointed out:
Reading that file for every process just to grep for one or two values
is slow, and some of the unused data items might be expensive for the
kernel to produce in the first place.

It seems that most new information of interest is being added to
/proc/pid/status and friends these days. Are there any plans to
accomodate tool authors who are interested in additional information
but are wary of the increasing costs of these files?

A light-weight interface for tools could work like this (ugly):

$ cat /proc/pid.provided
Name SleepAVG Pid Tgid PPid VmSize VmLck VmData [...]
$ cat /proc/10235/VmSize.VmData
3380 144

Or use netlink maybe? It sure would be nice to monitor all processes
with lower overhead, and to have tools that can deal with new data
items without an update.

Roger
