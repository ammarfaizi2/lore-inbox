Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUHaWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUHaWON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268982AbUHaWMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:12:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:30126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268010AbUHaWG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:06:57 -0400
Date: Tue, 31 Aug 2004 15:10:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@ximian.com>
Cc: greg@kroah.com, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-Id: <20040831151029.449770ec.akpm@osdl.org>
In-Reply-To: <1093989601.4815.48.camel@betsy.boston.ximian.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	<20040831150015.2e0e0906.akpm@osdl.org>
	<1093989601.4815.48.camel@betsy.boston.ximian.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@ximian.com> wrote:
>
> On Tue, 2004-08-31 at 15:00 -0700, Andrew Morton wrote:
> 
> > Why not share the implementation here?
> 
> Because we will probably want to export do_send_kevent(), with a
> different name, if this thing starts getting used, because there are
> places where the kobj path is already computed and although inexpensive
> it does cost a few cycles to go kobject -> path as a string.
> 

That's unrelated.   I meant:

static int __send_kevent(enum kevent type, struct kset *kset,
		struct kobject *kobj, const char *signal, int gfp_flags)
{
	const char *path;
	int ret;

	path = kobject_get_path(kset, kobj, gfp_flags);
	if (!path)
		return -ENOMEM;

	ret =  do_send_kevent(type, gfp_flags, path, signal);
	kfree(path);

	return ret;
}

int send_kevent(enum kevent type, struct kset *kset,
		struct kobject *kobj, const char *signal)
{
	return __send_kevent(type, kset, kobj, signal, GFP_KERNEL);
}
EXPORT_SYMBOL_GPL(send_kevent);


int send_kevent_atomic(enum kevent type, struct kset *kset,
		struct kobject *kobj, const char *signal)
{
	return __send_kevent(type, kset, kobj, signal, GFP_ATOMIC);
}
EXPORT_SYMBOL_GPL(send_kevent_atomic);
