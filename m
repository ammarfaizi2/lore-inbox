Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVJUURO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVJUURO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVJUURO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:17:14 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:4239 "EHLO
	churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S965147AbVJUURM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:17:12 -0400
Message-ID: <43594CD6.3020308@churchillrandoms.co.uk>
Date: Fri, 21 Oct 2005 13:17:26 -0700
From: Stefan Jones <stefan.jones@churchillrandoms.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051003)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.13.4] Memoryleak - idr_layer_cache slab - inotify?
References: <43593240.9020806@churchillrandoms.co.uk>
In-Reply-To: <43593240.9020806@churchillrandoms.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Jones wrote:

Made a standalone testcase, run this and the kernel will eat up your
memory (seen via slabtop):

[ creates a inotify_dev, and a watch and exits ; repeat via fork ... ]

Tracked it down me thinks:

struct inotify_device {
...
	struct idr		idr;		/* idr mapping wd -> watch */
...
}

idr gets allocated each time inotify_init() is called:

asmlinkage long sys_inotify_init(void)
{
..
idr_init(&dev->idr);
..
}

Looking in lib/idr.c you see:

  * You can release ids at any time. When all ids are released, most of
  * the memory is returned (we keep IDR_FREE_MAX) in a local pool so we
  * don't need to go to the memory "store" during an id allocate, just
  * so you don't need to be too concerned about locking and conflicts
  * with the slab allocator.

So even if you free all ids which create_watch->inotify_dev_get_wd 
creates you will still have menory in your struct idr.

So when
static inline void put_inotify_dev(struct inotify_device *dev)
{
	if (atomic_dec_and_test(&dev->count)) {
		atomic_dec(&dev->user->inotify_devs);
		free_uid(dev->user);
		kfree(dev);
	}
}

is called I think this is whre the memory gets lost. ( linux/idr.h has 
not free function I see )

Stefan
