Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVBVU0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVBVU0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVBVU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:26:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:51621 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261228AbVBVUZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:25:51 -0500
Message-ID: <421B955A.9060000@sgi.com>
Date: Tue, 22 Feb 2005 12:26:02 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
CC: Andrew Morton <akpm@osdl.org>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
In-Reply-To: <421993A2.4020308@ak.jp.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kaigai Kohei wrote:
> Hello, everyone.
> 
> Andrew Morton wrote:
>  > Jay Lan <jlan@sgi.com> wrote:
>  >
>  >>Since the need of Linux system accounting has gone beyond what BSD
>  >>accounting provides, i think it is a good idea to create a thin layer
>  >>of common code for various accounting packages, such as BSD accounting,
>  >>CSA, ELSA, etc. The hook to do_exit() at exit.c was changed to invoke
>  >>a routine in the common code which would then invoke those accounting
>  >>packages that register to the acct_common to handle do_exit situation.
>  >
>  >
>  > This all seems to be heading in the wrong direction.  Do we really 
> want to
>  > have lots of different system accounting packages all hooking into a
>  > generic we-cant-decide-what-to-do-so-we-added-some-pointless-overhead
>  > framework?
>  >
>  > Can't we get _one_ accounting system in there, get it right, avoid the
>  > framework?
> 
> I think there are two issues about system accounting framework.
> 
> Issue: 1) How to define the appropriate unit for accounting ?
> Current BSD-accountiong make a collection per process accounting 
> information.
> CSA make additionally a collection per process-aggregation accounting.

The 'enhanced acct data collection' patches that were added to
2-6-11-rc* tree still do collection of per process data.

CSA added those per-process data to per-aggregation ("job") data
structure at do_exit() time when a process termintes.

> 
> It is appropriate to make the fork-exit event handling framework for 
> definition
> of the process-aggregation, such as PAGG.
> 
> This system-accounting per process-aggregation is quite useful,
> thought I tried the SGI's implementation named 'job' in past days.
> 
> 
> Issue: 2) What items should be collected for accounting information ?
> BSD-accounting collects PID/UID/GID, User/Sys/Elapsed-Time, and # of
> minor/major page faults. SGI's CSA collects VM/RSS size on exit time,
> Integral-VM/RSS, and amount of block-I/O additionally.

These data are now collected in 2.6.11-rc* code. Note that these data
are still per-process.

> 
> I think it's hard to implement the accounting-engine as a kernel loadable
> module using any kinds of framework. Because, we must put callback 
> functions
> into all around the kernel for this purpose.
> 
> Thus, I make a proposion as follows:
> We should separate the process-aggregation functionality and collecting
> accounting informations.

I totally agree with this! Actually that was what we have done. The data
collection part of code has been unified.

> Something of framework to implement process-aggregation is necessary.
> And, making a collection of accounting information should be merged
> into BSD-accounting and implemented as a part of monolithic kernel
> as Guillaume said.

This sounds good. I am interested in learning how ELSA saves off
the per-process accounting data before the data got disposed. If
that scheme works for CSA, we would be very happy to adopt the
scheme. The current BSD scheme is very insufficient. The code is
very BSD centric and it provides no way to handle process-aggregation.

Thanks,
  - jay

> 
> Thanks.

