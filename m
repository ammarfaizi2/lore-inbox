Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbUKEAHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUKEAHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbUKEAGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:06:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55192 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262506AbUKDXzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:55:19 -0500
Message-ID: <418AC130.7030004@engr.sgi.com>
Date: Thu, 04 Nov 2004 15:54:24 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net
Subject: Re: [Lse-tech] [PATCH 2.6.9 2/2] enhanced accounting data collection
References: <41785FE3.806@engr.sgi.com>	<417863D3.9060907@engr.sgi.com> <20041021192551.2c2dfe18.akpm@osdl.org>
In-Reply-To: <20041021192551.2c2dfe18.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> Please don't send multiple patches under the same Subject:.  It confuses me
> and breaks my patch processing tools (I strip out the "1/2" numbering
> because it becomes irrelevant).
> 
> Please choose a meaningful and distinct title for each patch.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Will do better next time :)

> 
> Jay Lan <jlan@engr.sgi.com> wrote:
> 
>>2/2: acct_mm
>>
>>Enhanced MM accounting data collection.
>>
> 
> 
>>Index: linux/include/linux/sched.h
>>===================================================================
>>--- linux.orig/include/linux/sched.h	2004-10-01 17:16:35.105905373 -0700
>>+++ linux/include/linux/sched.h	2004-10-14 12:15:33.450280955 -0700
>>@@ -249,6 +249,8 @@
>> 	struct kioctx		*ioctx_list;
>> 
>> 	struct kioctx		default_kioctx;
>>+
>>+	unsigned long hiwater_rss, hiwater_vm;
>> };
> 
> 
> 	unsigned long hiwater_rss;	/* comment goes here */
> 	unsigned long hiwater_vm;	/* and here */

Will do.

> 
> 
>> 
>> extern int mmlist_nr;
>>@@ -593,6 +595,10 @@
>> 
>> /* i/o counters(bytes read/written, #syscalls */
>> 	unsigned long rchar, wchar, syscr, syscw;
>>+#if defined(CONFIG_BSD_PROCESS_ACCT)
>>+	u64 acct_rss_mem1, acct_vm_mem1;
>>+	clock_t acct_stimexpd;
>>+#endif
> 
> 
> Please place the above three fields on separate lines and document them.
> 
> It's not clear to me what, semantically, these fields represent.  That's
> something which is appropriate for the supporting changelog entry.

Certainly!

> 
> 
>>+/* Update highwater values */
>>+static inline void update_mem_hiwater(void)
>>+{
>>+	if (current->mm) {
>>+		if (current->mm->hiwater_rss < current->mm->rss) {
>>+			current->mm->hiwater_rss = current->mm->rss;
>>+		}
>>+		if (current->mm->hiwater_vm < current->mm->total_vm) {
>>+			current->mm->hiwater_vm = current->mm->total_vm;
>>+		}
>>+	}
>>+}
> 
> 
> If this has more than one callsite then it it too big to inline.
> 
> If it has a single callsite then it's OK to inline it, but it can and
> should be moved into the .c file.
> 
> 
>>+
>>+static inline void acct_update_integrals(void)
>>+{
>>+	long delta;
>>+
>>+	if (current->mm) {
>>+		delta = current->stime - current->acct_stimexpd;
>>+		current->acct_stimexpd = current->stime;
>>+		current->acct_rss_mem1 += delta * current->mm->rss;
>>+		current->acct_vm_mem1 += delta * current->mm->total_vm;
>>+	}
>>+}
> 
> 
> Consider caching `current' in a local variable - sometimes gcc likes to
> reevaluate it each time and it takes 14 bytes of code per pop.
> 
> This function is too big to inline.

If not inline, where these functions do you suggest to place? How
about kernel/acct.c?

> 
> 
>>+static inline void acct_clear_integrals(struct task_struct *tsk)
>>+{
>>+	if (tsk) {
>>+		tsk->acct_stimexpd = 0;
>>+		tsk->acct_rss_mem1 = 0;
>>+		tsk->acct_vm_mem1 = 0;
>>+	}
>>+}
> 
> 
> Do any of the callers pass in a null `tsk'?

No. Just to be safe, i guess :(

***

The revised version of acct_io and acct_mm should be posted soon.

Thank you very much for reviewing and comments.

- jay

> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

