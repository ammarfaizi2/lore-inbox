Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVDAJvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVDAJvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVDAJvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:51:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:50155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262680AbVDAJu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:50:56 -0500
Date: Fri, 1 Apr 2005 01:50:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: cn_queue.c
Message-Id: <20050401015027.047783eb.akpm@osdl.org>
In-Reply-To: <1112348048.9334.174.camel@uganda>
References: <20050331173215.49c959a0.akpm@osdl.org>
	<1112341236.9334.97.camel@uganda>
	<20050331235706.5b5981db.akpm@osdl.org>
	<1112344811.9334.146.camel@uganda>
	<20050401004804.52519e17.akpm@osdl.org>
	<1112348048.9334.174.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> cn_queue_free_dev() will wait until dev->refcnt hits zero 
>  before freeing any resources,
>  but it can happen only after cn_queue_del_callback() does 
>  it's work on given callback device [actually when all callbacks 
>  are removed].
>  When new callback is added into device, it's refcnt is incremented
>  [before adition btw, if addition fails in the middle, reference is
>  decremented], when callbak is removed, device's reference counter
>  is decremented aromically after all work is finished.

hm.

How come cn_queue_del_callback() uses all those barriers if no other CPU
can grab new references against cbq->cb->refcnt?

cn_queue_free_callback() forgot to do flush_workqueue(), so
cn_queue_wrapper() can still be running while cn_queue_free_callback()
frees up the cn_callback_entry, I think.

