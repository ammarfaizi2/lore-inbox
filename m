Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWEWSkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWEWSkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWEWSkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:40:12 -0400
Received: from xenotime.net ([66.160.160.81]:30597 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932247AbWEWSkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:40:11 -0400
Date: Tue, 23 May 2006 11:42:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] kmap tracking
Message-Id: <20060523114241.936421b6.rdunlap@xenotime.net>
In-Reply-To: <4471EA2C.4010401@oracle.com>
References: <20060518155357.04066e9c.rdunlap@xenotime.net>
	<4471EA2C.4010401@oracle.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006 09:43:24 -0700 Zach Brown wrote:

> Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Track kmap/kunmap call history, storing caller function address,
> > action, and time (jiffies), if CONFIG_DEBUG_KMAP is enabled.
> > Based on a patch to 2.4.21 by Zach Brown that was used successfully
> > at Oracle to track down some kmap/kunmap problems.
> 
> Thanks for bringing this to 2.6.. sorry for the lag in reviewing.
> 
> > +enum {
> > +	KMAP_FIRST = 1,
> > +	KMAP_ADDREF,
> > +	KMAP_DECREF,
> > +	KMAP_LAST,
> > +};
> 
> I trust you got rid of these in the most recent version :)

Yes.

> > +#else
> > +#define kmap_record_action(nr, action, refcount, retaddr) do {} while (0)
> > +#endif
> 
> Make this an inline, please, so that we don't introduce unused var warnings.

What warnings?  I built the config option =y and =n and didn't see
any warnings.  (not that I mind changing it)

> > +static __init int kmap_history_init(void)
> > +{
> > +	kmap_history_file = debugfs_create_file("kmap-history", 0644, NULL,
> > +			kh_running, &kmap_running_seq_fops);
> > +	if (!kmap_history_file)
> > +		goto out1;
> > +
> > +	return 0;
> > +
> > +out1:
> > +	return -ENOMEM;
> 
> That seems noisy.. return -ENOMEM is probably fine for such a trivial
> funciton :).

noisy how/where?

> > +#define kmap(page)	__kmap(page, __builtin_return_address(0))
> > +#define kunmap(page)	__kunmap(page, __builtin_return_address(0))
> 
> Hmm, I was hoping we wouldn't have to do this.  Can we use
> __builtin_return_address(1) from within the debug paths instead of
> passing down (0)?  Then we wouldn't have to ifdef around the declarations..

I dunno.  I'll test it some. I thought that there were some
problems with __builtin_return_address(1), but I don't know for sure.

---
~Randy
