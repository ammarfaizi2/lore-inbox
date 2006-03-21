Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWCUXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWCUXKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWCUXKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:10:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751817AbWCUXKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:10:54 -0500
Date: Tue, 21 Mar 2006 15:13:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: kenneth.w.chen@intel.com, suparna@in.ibm.com, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] direct-io: bug fix in dio handling write error
Message-Id: <20060321151304.4c3be798.akpm@osdl.org>
In-Reply-To: <1142974672.6086.15.camel@dyn9047017100.beaverton.ibm.com>
References: <200603211903.k2LJ30g29071@unix-os.sc.intel.com>
	<1142974672.6086.15.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> If some one asks to do IO for 128K and if we get -EIO after say, 64K 
> - we fail the whole IO  with -EIO ?

A multiple-block direct-IO can complete those blocks (actually the BIOs) in
any order.  How do we communicate to userspace that segments 0, 1, 3 and 5
completed OK, but segments 2 and 4 had errors?

The best we could do is to tell userspace that 0 and 1 completed and ignore
everything after the first I/O error.

But I don't think it's worth the effort.  Simply returning EIO for the
whole thing is probably good enough.  The only situation I can think of
where someone would care down to that level of detail is a specialised
recover-data-from-a-bad-disk application (for which direct-io would be a
good tool).  Such an application should have the brains to go
sector-at-a-time if larger I/O's throw errors.

