Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWGMJij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWGMJij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWGMJii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:38:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964876AbWGMJii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:38:38 -0400
Date: Thu, 13 Jul 2006 02:38:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: serue@us.ibm.com, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-Id: <20060713023829.c19881be.akpm@osdl.org>
In-Reply-To: <20060712230228.GA19656@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
	<20060627054612.GA15657@sergelap.austin.ibm.com>
	<Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
	<20060711194932.GA27176@sergelap.austin.ibm.com>
	<20060711171752.4993903a.akpm@osdl.org>
	<20060712032647.GA24595@sergelap.austin.ibm.com>
	<20060711204637.bba6e966.akpm@osdl.org>
	<20060712230228.GA19656@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 18:02:29 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> +		if (lo->lo_state == Lo_rundown) {
> +			spin_unlock_irq(&lo->lo_lock);
> +			while (!kthread_should_stop());

eww.

A schedule_timeout_uninterruptible(1) or even cpu_relax() would be less
sinful, but still unpleasant.

It's strange that the problem of kthread_stop(already_exitted_task) hasn't
occurred before.

Again: why is this so hard?  It shouldn't be.  Perhaps because loop is
using completions in bizarre ways where it should be using
wake_up_process(), wait_event(), etc.
