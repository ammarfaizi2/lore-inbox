Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWHCVPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWHCVPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWHCVPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:15:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22406 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932233AbWHCVPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:15:34 -0400
Message-ID: <44D26769.4070505@sgi.com>
Date: Thu, 03 Aug 2006 14:15:21 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, jes@sgi.com, csturtiv@sgi.com,
       tee@sgi.com, guillaume.thouvenin@bull.net
Subject: Re: [patch 3/3] convert CONFIG tag for extended accounting routines
References: <44D17A47.4010302@engr.sgi.com> <20060803000331.22fcb4c0.akpm@osdl.org>
In-Reply-To: <20060803000331.22fcb4c0.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 02 Aug 2006 21:23:35 -0700
> Jay Lan <jlan@engr.sgi.com> wrote:
> 
> 
>>+/**
>>+ * acct_update_integrals - update mm integral fields in task_struct
>>+ * @tsk: task_struct for accounting
>>+ */
>>+void acct_update_integrals(struct task_struct *tsk)
>>+{
>>+	if (likely(tsk->mm)) {
>>+		long delta =
>>+			cputime_to_jiffies(tsk->stime) - tsk->acct_stimexpd;
> 
> 
> If a 32 architecture chooses to implement a 64-bit cputime_t, this
> expression might go wrong for very long-running tasks and high HZ.
> 
> Perhaps we should do all this in terms of cputime_t and export everything
> to userspace as u64?

Andrew,

We export to userspace the acct_rss_mem1 and acct_vm_mem1, both as u64.
The above logic is to calculate stime delta since last update. Note that
acc_update_integrals() is invoked at do_execve, do_exit, _AND_ at
account_system_time, which is called every jiffy by timer interrupt
handler.

The tsk->acct_stimexpd is used to save the tsk->stime of last update.
It should be changed to cputime_t as well. I will include the fix in
my next fix patch.

> 
> 
>>+		if (delta == 0)
>>+			return;
>>+		tsk->acct_stimexpd = tsk->stime;
>>+		tsk->acct_rss_mem1 += delta * get_mm_rss(tsk->mm);
>>+		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
> 
> 
> It's a bit weird to be multiplying RSS by time.  What unit is a "byte
> second"?
> 
> If this is not a bug then I guess this is an intermediate term for
> additional downstream processing.  There is information loss here and I'd
> have thought that it would be better to simply send `delta' and the rss
> straight to userspace, let userspace work out what math it wants to perform
> on it.  If that makes sense?
> 
> I see that the code has been like this for a long time, so treat this as a
> "please educate me about BSD accounting" email ;)

This is not a BSD accounting thing. It came from UNICOS and IRIX.
I am pinging the person who knows how the real world users use these
two fields...

Regards,
  - jay

> 


