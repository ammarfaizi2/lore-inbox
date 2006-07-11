Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWGKVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWGKVsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWGKVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:48:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932138AbWGKVsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:48:00 -0400
Date: Tue, 11 Jul 2006 14:51:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: kkeil@suse.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, hjlipp@web.de
Subject: Re: [mm Patch] isdn4linux: Gigaset driver: fix __must_check warning
Message-Id: <20060711145117.25dd09f2.akpm@osdl.org>
In-Reply-To: <20060711115359.C9A4D1B8F4F@gx110.ts.pxnet.com>
References: <20060711115359.C9A4D1B8F4F@gx110.ts.pxnet.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tilman Schmidt <tilman@imap.cc> wrote:
>
> This patch to the Siemens Gigaset driver fixes the compile warning
> "ignoring return value of 'class_device_create_file', declared with
> attribute warn_unused_result" appearing with CONFIG_ENABLE_MUST_CHECK=y
> in release 2.6.18-rc1-mm1.
> 
> Signed-off-by: Tilman Schmidt <tilman@imap.cc>
> Acked-by: Hansjoerg Lipp <hjlipp@web.de>
> ---
> 
>  proc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.18-rc1-orig/drivers/isdn/gigaset/proc.c	2006-07-09 17:19:49.000000000 +0200
> +++ linux-2.6.18-rc1-mm1-work/drivers/isdn/gigaset/proc.c	2006-07-09 18:31:15.000000000 +0200
> @@ -83,5 +83,6 @@ void gigaset_init_dev_sysfs(struct cards
>  		return;
>  
>  	gig_dbg(DEBUG_INIT, "setting up sysfs");
> -	class_device_create_file(cs->class, &class_device_attr_cidmode);
> +	if (class_device_create_file(cs->class, &class_device_attr_cidmode))
> +		dev_warn(cs->dev, "could not create sysfs attribute\n");
>  }

hm.

With this change we'll emit a warning (actually it's an error - I'll make
it dev_err(), OK?) and then we'll continue execution, pretending that the
sysfs file actually got registered.  Later, we'll try to unregister a
not-registered sysfs file.

So it's all a bit flakey when you look at it in a dumb fashion.

But I think the patch is OK - if that class_device_create_file() fails,
then there's some other bug somewhere, and the warning you've added is
sufficient - it tells the developers what the initial failure was, when it
happens.  So later, if someone reports a crash, we'll see that warning in
their logs and it'll lead us to the real bug.  We certainly couldn't
justify adding additional code which attempts to "continue working" if the
class_device_create_file() fails, because it just shouldn't fail.


It's probable that the message will never come out ever, so it's not worth
adding a ton of code to support this.

It'd be better if we had a class_device_create_file_warn() which does the
warning for you: its semantics are "this is expected to succeed".  But if
we do that to class_device_create_file() then we'd need to do it to 200
other things too.

