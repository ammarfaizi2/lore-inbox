Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758601AbWK1JZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601AbWK1JZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 04:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbWK1JZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 04:25:27 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:36974 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1758601AbWK1JZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 04:25:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GxyGn/ONIWIYjpvt/DHpfgxd5/gqlaR/5FUelPXe+tlvWLF0hhLlkvBP6F+B/a5T7Fyuv12IeBaqsaF4yWfGVS4j6u+dDcrjh1AjbnXJCNpedEvCkSfJ71wsGgt/6dNnwcHkUnbrhT9/aPnDrkvzbi+/Sb6681sbVhA35MTJJho=
Date: Tue, 28 Nov 2006 18:18:11 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Don Mullis <dwm@meer.net>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 -mm] fault-injection: lightweight code-coverage maximizer
Message-ID: <20061128091811.GA2004@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Don Mullis <dwm@meer.net>, akpm <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1164699866.2894.88.camel@localhost.localdomain> <1164700290.2894.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164700290.2894.93.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 11:51:30PM -0800, Don Mullis wrote:
> Allow all non-unique call stacks, as judged by pushed sequence of EIPs,
> to be to be ignored as failure candidates.
> 
> Upon keying in
> 	echo 1 >probability
> 	echo 3 >verbose
> 	echo -1 >times
> a few dozen stacks are printk'ed, then system responsiveness
> recovers to normal.  Similarly, starting a non-trivial program
> will print a few stacks before responsiveness recovers.

What kind of test did you do?

> Intent is to make code-coverage-maximizing test lightweight, perhaps
> light enough to remain enabled during the course of the developer's
> interactive testing of new code.
> 
> Enabled by default. (/debug/fail*/stacktrace-depth > 0)

This doesn't maximize code coverage. It makes fault-injector reject
any failures which have same stacktrace before.

So it should not be default.

> +static bool fail_uniquestack(struct fault_attr *attr)
> +{
> +	u32 oldhash;
> +	u32 newhash;
> +	uint offset = 0;
> +
> +	newhash = unique_stack_p(attr);
> +
> +	for ( oldhash = newhash; oldhash != 0; offset++) {
> +		oldhash = atomic_xchg(
> +			&attr->uniquestack_hash_table[
> +				(newhash+offset)%ARRAY_SIZE(attr->uniquestack_hash_table)],
> +			oldhash);
> +		if (oldhash == newhash)
> +			return false;
> +		if (offset >= ARRAY_SIZE(attr->uniquestack_hash_table)) {
> +			printk(KERN_NOTICE
> +			       "FAULT_INJECTION: table overflow -- "
> +			       "fault injection disabled\n");
> +			return false;
> +		}
> +	}

Updating array in this way is not safe (SMP or interrupt).

