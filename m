Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVB1TGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVB1TGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVB1TEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:04:43 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30120 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261717AbVB1S4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:56:53 -0500
Message-ID: <42236979.5030702@sgi.com>
Date: Mon, 28 Feb 2005 10:56:57 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>, kaigai@ak.jp.nec.com,
       jbarnes@sgi.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
References: <421EA8FF.1050906@sgi.com>	 <20050224204646.704680e9.akpm@osdl.org> <1109314660.1738.206.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1109314660.1738.206.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

You asked:
 >
 > In other words: given that ELSA can do its thing via existing accounting
 > interfaces and a fork notifier, why does CSA need to add lots more kernel
 > code?

And i explained:
 > Here are some codes from do_exit() starting line 813 (based on
 > 2.6.11-rc4-mm1):
 >
 > 813        acct_update_integrals(tsk);
 > 814        update_mem_hiwater(tsk);
 > 815        group_dead = atomic_dec_and_test(&tsk->signal->live);
 > 816        if (group_dead) {
 > 817                del_timer_sync(&tsk->signal->real_timer);
 > 818                acct_process(code);
 > 819        }
 > 820        exit_mm(tsk);
 >
 > The acct_process() is called to save off BSD accounting data at
 > line 818. The next statement at 820, tsk->mm is disposed and all
 > data saved at tsk->mm is gone, including memory hiwater marks
 > information saved at line 814. The complete tsk is disposed
 > before exit of do_exit() routine.

I was hoping Guilluame could jump in himself...
But, in a separate discussion thread, he wrote:
 >> (Jay asked)
 >> I spent some time trying to understand how ELSA save the per-process
 >> accounting data before the task_struct data structure gets disposed,
 >> but failed to find anything. My assumption would be that ELSA does
 >> not collection those data in the kernel itself? Instead, it would
 >> read the pacct file created by either BSD or CSA?
 >
 > Yes you're right, ELSA reads accounting file created by BSD or CSA. We
 > don't make accounting. I think that the communication problem is here

Guilluame's reply should answer your question. ELSA does not collect
accounting data in the kernel as BSD/CSA does. It uses accounting
data collected by BSD/CSA.

The exit hook is essential for CSA to save off data before the data
is gone, A netlink type of thing does not help. BSD is in the same
situation. You can not replace the acct_process() call with a netlink.
If ELSA is to use the enhanced accounting data, it needs the CSA
eop handling at exit as well.

Thanks,
  - jay


Guillaume Thouvenin wrote:
> On Thu, 2005-02-24 at 20:46 -0800, Andrew Morton wrote:
> 
>>Jay Lan <jlan@sgi.com> wrote:
>>
>>>Since my idea of providing an accounting framework was considered
>>> 'overkill', here i submit a tiny patch just to allow CSA to
>>> handle end-of-process (eop) situation by saving off accounting
>>> data before a task_struct is disposed.
>>>
>>> This patch is to modify the acct_process() in acct.c, which is
>>> invoked from do_exit() to handle eop for BSD accounting. Now
>>> the acct_process() wrapper will also take care of CSA, if it has
>>> been loaded. If the CSA module has been loaded, a CSA routine
>>> will be invoked to construct a CSA job record and to write the
>>> record to the CSA accounting file.
>>
>>I really don't want to have to (and shouldn't need to) become an accounting
>>person, but as there seems to be a communication problem somewhere..
>>
>>Please, you guys are the subject matter experts.  Put your heads together
>>and come up with something.
> 
> 
> I completely agree with that and we will continue this conversation in
> private with Jay and all people involved to come up with an appropriate
> solution.
> 
> Guillaume

