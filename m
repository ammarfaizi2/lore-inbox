Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWJEVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWJEVWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWJEVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:22:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751399AbWJEVWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:22:33 -0400
To: Mike Mason <mmlnx@us.ibm.com>
Cc: jrs@us.ibm.com, Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>
Subject: Re: Fwd: Any way to find the network usage by a process?
References: <3420082f0610030114o5b44b8ak7797483e02002614@mail.gmail.com>
	<3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com>
	<452285FD.7010909@us.ibm.com> <45241F7A.5050501@us.ibm.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 05 Oct 2006 17:22:23 -0400
In-Reply-To: <45241F7A.5050501@us.ibm.com>
Message-ID: <y0m3ba2jw4w.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Mason <mmlnx@us.ibm.com> writes:

> Here's a variation of Jose's script that uses the networking tapset
> and prints top-like output for transmits and receives.  [...]

Thanks for posting it to the systemtap wiki.

Some minor style suggestions follow:

> [...]
>          ifxmit_p[pid(), dev_name] ++
>          ifxmit_b[pid(), dev_name] += length

These could be collapsed into a single statistics-aggregate array: 
#          ifxmit[pid(), dev_name] <<< length
Then the printing routine would use @count(ifxmit[...]) and @sum(ifxmit[...])
to extract the two values.  Same of course for ifrecv.

>          execname[pid()] = execname()
>          user[pid()] = uid()
>          ifdevs[pid(), dev_name] = dev_name

Calling pid() so many times is worse than calling it once and caching
the result in a local variable ("p = pid()").  

The way that the script tracks pid-to-uid and pid-to-execname mappings
is not bad, though if that part were moved to new probes on fork or
exec, it would allow the network-related probes to run concurrently on
an SMP without fighting over locks.


- FChE
