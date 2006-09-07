Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWIGIzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWIGIzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWIGIzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:55:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18335 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751150AbWIGIzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:55:37 -0400
Subject: Re: [PATCH 14/16] GFS2: The DLM interface module
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609051352110.24010@yvahk01.tjqt.qr>
References: <1157031710.3384.811.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609051352110.24010@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 07 Sep 2006 10:01:52 +0100
Message-Id: <1157619712.3384.1044.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-09-05 at 14:05 +0200, Jan Engelhardt wrote:
> >+/* make_strname - convert GFS lock numbers to a string */
> >+
> >+static inline void make_strname(struct lm_lockname *lockname,
> >+				struct gdlm_strname *str)
> >+{
> >+	sprintf(str->name, "%8x%16llx", lockname->ln_type,
> >+		(unsigned long long)lockname->ln_number);
> 
> Is this format specifier safe enough? "%08x%016llx" perhaps?
> 
> Imagine (if this happens at all):
> 
>   ln_type = 1; ln_number = 16;
>   %8x = "1", "%16llx" = "10", giving us "110"
> 
>   ln_type = 17; ln_number = 0;
>   %8x = "11", "%16llx" = "0", giving us "110".
> 
> Whoops, name clash.
> 
In this case the field sizes mean that the numbers are padded with
spaces. Also we "know" that ln_type will always be a single digit at
least with the current implementation.

[lines snipped]
> >+	op->info.owner		= (__u64)(long) fl->fl_owner;
> 
> Can't op->info.owner be a 'struct fowner *'? Is op->info.owner shared over the
> network?
> 
It is shared over the network.

> >+static ssize_t block_show(struct gdlm_ls *ls, char *buf)
> >+{
> >+	ssize_t ret;
> >+	int val = 0;
> >+
> >+	if (test_bit(DFL_BLOCK_LOCKS, &ls->flags))
> >+		val = 1;
> >+	ret = sprintf(buf, "%d\n", val);
> 
> Safe enough - @buf big enough?
> 
Yes, buf is one page in size. However Dave Teigland has sent me a couple
of patches to update these routines to the "best practice" according to
the docs for sysfs.

> >+	if (val == 1)
> >+		set_bit(DFL_BLOCK_LOCKS, &ls->flags);
> >+	else if (val == 0) {
> >+		clear_bit(DFL_BLOCK_LOCKS, &ls->flags);
> >+		gdlm_submit_delayed(ls);
> >+	} else
> >+		ret = -EINVAL;
> 
> Ingo surely wants you to {} it.
> 
I've fixed that now. This email's patches are:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=c53921248c79197befa7caa4c17b1af5c077a2c2
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=3204a6c05588788f7686bc45585185a9a4788430
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=a1d144c71ddc11d3e9d9f29e92cf037da382a541
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=62f140c173f2c85e15527eefc6e2fb3c37a97eb1

Steve.


