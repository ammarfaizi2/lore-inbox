Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVCPPtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVCPPtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVCPPtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:49:49 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:36757 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261267AbVCPPtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:49:43 -0500
Message-ID: <423864EE.52A3AE91@tv-sign.ru>
Date: Wed, 16 Mar 2005 19:55:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org,
       Shai Fultheim <Shai@Scalex86.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] del_timer_sync: proof of concept
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net> <4237192B.7E8AA85A@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> If we're prepared to rule that a timer handler is not allowed to do
> add_timer_on() then a recurring timer is permanently pinned to a CPU, isn't
> it?
>
> That should make things simpler?

I think that current inplementation of del_timer_sync() don't like
add_timer_on() too.

Consider the timer running on CPU_0. It sets timer->expires = jiffies,
and calls add_timer_on(1). Now it is possible that local timer interrupt
on CPU_1 happens and starts that timer before timer->function returns on
CPU_0.

del_timer_sync() detects that timer is running on CPU_0, waits while
->running_timer == timer, and returns. The timer still runs on CPU_1.

Oleg.
