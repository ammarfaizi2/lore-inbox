Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVBWHGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVBWHGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 02:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVBWHGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 02:06:35 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:20472 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261346AbVBWHGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 02:06:22 -0500
Message-ID: <421C2B99.2040600@ak.jp.nec.com>
Date: Wed, 23 Feb 2005 16:07:05 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com>
In-Reply-To: <421B955A.9060000@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thanks for your comments.

 >> I think there are two issues about system accounting framework.
 >>
 >> Issue: 1) How to define the appropriate unit for accounting ?
 >> Current BSD-accountiong make a collection per process accounting
 >> information.
 >> CSA make additionally a collection per process-aggregation accounting.
 >
 >
 > The 'enhanced acct data collection' patches that were added to
 > 2-6-11-rc* tree still do collection of per process data.

Hmm, I have not noticed this extension. But I made sure about it.
The following your two patches implements enhanced data collection, didn't it?

- ChangeLog for 2.6.11-rc1
[PATCH] enhanced I/O accounting data patch
[PATCH] enhanced Memory accounting data collection

Since making a collection per process accounting is unified to the stock kernel,
I want to have a discussion about remaining half, "How to define the appropriate
unit for accounting ?"
We can agree that only per process-accounting is so rigid, I think.
Then, process-aggregation should be provided in one way or another.

[1] Is it necessary 'fork/exec/exit' event handling framework ?

The common agreement for the method of dealing with process aggregation
has not been constructed yet, I understood. And, we will not able to
integrate each process aggregation model because of its diverseness.

For example, a process which belong to JOB-A must not belong any other
'JOB-X' in CSA-model. But, In ELSA-model, a process in BANK-B can concurrently
belong to BANK-B1 which is a child of BANK-B.

And, there are other defferences:
Whether a process not to belong to any process-aggregation is permitted or not ?
Whether a process-aggregation should be inherited to child process or not ?
(There is possibility not to be inherited in a rule-based process aggregation like CKRM)

Some process-aggregation model have own philosophy and implemantation,
so it's hard to integrate. Thus, I think that common 'fork/exec/exit' event handling
framework to implement any kinds of process-aggregation.


[2] What implementation should be adopted ?

I think registerable hooks on fork/execve/exit is necessary, not only exit() hook.
Because a rule or policy based process-aggregation model requirees to catch
the transition of a process status.
It might be enough to hook the exit() event only in process-accounting,
but it's not kind for another customer.

Thus, I recommend SGI's PAGG.

In my understanding, the reason for not to include such a framework is that
increase of unidentifiable (proprietary) modules is worried.
But, SI can divert LSM to implemente process-aggregation if they ignore
the LSM's original purpose, for example.
# I'm strongly opposed to such a movement as a SELinux's user :-)

So, I think such a fork/execve/exit hooks is harmless now.
Is this the time to unify it?

Thanks.

 > CSA added those per-process data to per-aggregation ("job") data
 > structure at do_exit() time when a process termintes.
 >
 >>
 >> It is appropriate to make the fork-exit event handling framework for
 >> definition
 >> of the process-aggregation, such as PAGG.
 >>
 >> This system-accounting per process-aggregation is quite useful,
 >> thought I tried the SGI's implementation named 'job' in past days.
 >>
 >>
 >> Issue: 2) What items should be collected for accounting information ?
 >> BSD-accounting collects PID/UID/GID, User/Sys/Elapsed-Time, and # of
 >> minor/major page faults. SGI's CSA collects VM/RSS size on exit time,
 >> Integral-VM/RSS, and amount of block-I/O additionally.
 >
 >
 > These data are now collected in 2.6.11-rc* code. Note that these data
 > are still per-process.
 >
 >>
 >> I think it's hard to implement the accounting-engine as a kernel loadable
 >> module using any kinds of framework. Because, we must put callback
 >> functions
 >> into all around the kernel for this purpose.
 >>
 >> Thus, I make a proposion as follows:
 >> We should separate the process-aggregation functionality and collecting
 >> accounting informations.
 >
 >
 > I totally agree with this! Actually that was what we have done. The data
 > collection part of code has been unified.
 >
 >> Something of framework to implement process-aggregation is necessary.
 >> And, making a collection of accounting information should be merged
 >> into BSD-accounting and implemented as a part of monolithic kernel
 >> as Guillaume said.
 >
 >
 > This sounds good. I am interested in learning how ELSA saves off
 > the per-process accounting data before the data got disposed. If
 > that scheme works for CSA, we would be very happy to adopt the
 > scheme. The current BSD scheme is very insufficient. The code is
 > very BSD centric and it provides no way to handle process-aggregation.
 >
 > Thanks,
 >  - jay
 >
 >>
 >> Thanks.

-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
