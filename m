Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWGYIdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWGYIdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWGYIdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:33:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:36518 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932207AbWGYIdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:33:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M9wqxQrq9n/TuMsBwPL4maUA+XkABs5+ozJ+p2tk6uMm0UNSz/ecZtyKsu/xy3DEI/typeCpz+z4W8E9rGCK9Afqzq1+Ss3mmRGty9fd975EvUv8IBC2CuWghPnvwjiCzxRvfsS6PLjhTixEykbAPKzbTKR9dTycclUCIp0oAMw=
Message-ID: <4df04b840607250133h750d7ef6ifa864bc5c5670dcf@mail.gmail.com>
Date: Tue, 25 Jul 2006 16:33:42 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "David Lang" <dlang@digitalinsight.com>
Subject: Re: Improvement on memory subsystem
Cc: linux-kernel@vger.kernel.org, valdis.kletnieks@vt.edu,
       penberg@cs.helsinki.fi
In-Reply-To: <Pine.LNX.4.63.0607240752050.8221@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
	 <4df04b840607240201l19f95f8cu12dca42de71dba69@mail.gmail.com>
	 <Pine.LNX.4.63.0607240752050.8221@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No COW in Private VMA
In current Linux 2.6.16, Linux applies copy-on-write technical when application
issues CLONE_MM parameter to do_fork, as the result, it makes private VMA of a
process share its private pages with other process. It increases memory
subsystem complexity.

In fact, OS should be application-oriented, not standard-oriented. In most
cases, supporting POSIX thread model, vfork and evecve is enough to application.
In other words, we should focus on optimizing our system for the frequent cases,
that is, do copy-on-call when someone really calls fork with CLONE_MM.

No COW in private VMA makes a simple one-to-one relationship among its pte, its
private page and its swap_entry of a private VMA, we will benefit from the model

A new PTE type is introduced here before we go
	struct UnmappedPTE {
		present : 1; // = 0.
		...;
		pageNum : 20;
	};

1) To swap daemon, we can give a fairer opportunity to every private page. As
I've suggested swap daemon should swap out pages based on VMA instead of memory
page array. So we do the steps listed below to every pte of a private VMA
	a) Convert the pte to UnmappedPTE type, that doesn't free the private page
	at all, UnmappedPTE::pageNum holds a trace of its private page.
	b) Allocate a swap entry for the private page of the pte and page-out it,
	remember do the job on current pte and its following ptes together, I've
	explained the virtue.
	c) OK, it's still untouched, reclaim the private page, convert the pte to
	SwappedPTE type.
The flow is better than the implementation of current Linux, I think.
2) We can economize a litter memory. Current swap space includes two parts, one
is swap_info_struct, its responsibility is tracing physical swap area by short
swap_info_struct::swap_map array. Now, it should be a bit array; Another is an
address_space structure, which is used by process to test whether its swap pages
have been read in memory. Now, it should be discarded, every swap page once is
read in, it's linked with its pte by UnmappedPTE.

Note, No COW in PrivateVMA is a bigger improvement.
