Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266936AbUBSIKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267033AbUBSIKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:10:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:14216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266936AbUBSIKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:10:17 -0500
Date: Thu, 19 Feb 2004 00:10:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: keventd_create_kthread
Message-Id: <20040219001011.6245f163.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com>
References: <20040218231322.35EE92C05F@lists.samba.org>
	<Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> wrote:
>
>  i'd strongly advise against using wait_task_inactive() in
>  keventd_create_kthread() - it's _polling_. We must not do any polling like
>  that in any modern interface. Why does keventd_create_kthread() need
>  wait_task_inactive()?

The way it's designed, we _have_ to wait until the new kthread has gone to
sleep, because we poke him again with wake_up_process().

However, if that wake_up_process() comes too early we'll just flip the new
thread out of TASK_INTERUPTIBLE into TASK_RUNNING and the schedule() in
kthread() will fall straight through.  So perhaps we can simply remove the
wait_task_inactive()?

