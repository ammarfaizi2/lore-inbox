Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVJUSDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVJUSDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVJUSDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:03:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965050AbVJUSDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:03:35 -0400
Date: Fri, 21 Oct 2005 10:58:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, adilger@clusterfs.com
Subject: Re: [RFC] page lock ordering and OCFS2
Message-Id: <20051021105811.2de09059.akpm@osdl.org>
In-Reply-To: <435928BC.5000509@oracle.com>
References: <20051017222051.GA26414@tetsuo.zabbo.net>
	<20051017161744.7df90a67.akpm@osdl.org>
	<43544499.5010601@oracle.com>
	<435928BC.5000509@oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
>  The specific exports it needs from 2.6.14-rc4-mm1 are:
> 
>  $ grep '+EXPORT' patches/*.patch
>  patches/add-wake_up_page_all.patch:+EXPORT_SYMBOL(__wake_up_bit_all);
>  patches/add-wake_up_page_all.patch:+EXPORT_SYMBOL(wake_up_page_all);
>  patches/export-pagevec-helpers.patch:+EXPORT_SYMBOL_GPL(pagevec_lookup);
>  patches/export-page_waitqueue.patch:+EXPORT_SYMBOL_GPL(page_waitqueue);
>  patches/export-truncate_complete_pate.patch:+EXPORT_SYMBOL(truncate_complete_page);
>  patches/export-wake_up_page.patch:+EXPORT_SYMBOL(wake_up_page);

Exporting page_waitqueue seems wrong.  Might be better to add a core
function to do the wait_event(*page_waitqueue(page), PageFsMisc(page)); and
export that.

How did you come up with this mix of GPL and non-GPL?

>  that wake_up_page_all() is just a variant that provides 0 nr_exclusive to
>  __wake_up_bit():
> 
>  -void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
>  +static inline int __wake_up_bit_nr(wait_queue_head_t *wq, void *word, int bit,
>  +                                  int nr_exclusive)
>   {
>          struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
>          if (waitqueue_active(wq))
>  -               __wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE, 1, &key);
>  +               __wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE,
>  +                         nr_exclusive, &key);
>  +}
>  +
>  +void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
>  +{
>  +       __wake_up_bit_nr(wq, word, bit, 1);
>   }
>   EXPORT_SYMBOL(__wake_up_bit);
> 
>  +void fastcall __wake_up_bit_all(wait_queue_head_t *wq, void *word, int bit)
>  +{
>  +       __wake_up_bit_nr(wq, word, bit, 0);
>  +}
>  +EXPORT_SYMBOL(__wake_up_bit_all);
> 
>  Is this preferable to the core changes and is it something that's mergeable?
>  We'd love to come to a solution that won't be a barrier to merging so we can
>  get on with it.  I can send that exporting series if we decide this is the
>  right thing.

The above looks sane enough.  Please run it by Bill?
