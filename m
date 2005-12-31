Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVLaNYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVLaNYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 08:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVLaNYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 08:24:20 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:64222 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1751322AbVLaNYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 08:24:20 -0500
Message-ID: <43B6866F.9080701@sw.ru>
Date: Sat, 31 Dec 2005 16:23:59 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: oom-killer causes lockups in cpuset_excl_nodes_overlap()
References: <20051228004026.72F3474005@sv1.valinux.co.jp>
In-Reply-To: <20051228004026.72F3474005@sv1.valinux.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, we found the same problem while looking at the code.
and this is not the only cpuset function which might sleep, but is 
called from atomic context... :(

> The oom-killer causes lockups because it calls
> cpuset_excl_nodes_overlap() with tasklist_lock read-locked.
> cpuset_excl_nodes_overlap() gets cpuset_sem (or callback_sem in
> later linux versions) semaphore, which might_sleep even if the
> semaphore could be down without sleeping.  If processes call
> exit() or fork() when the oom-killer sleeps in the down(), they
> lockup because they call write_lock_irq(&tasklist_lock).
> 
> The lockup occurred on linux-2.6.14.  The problem also seems to exist
> in linux-2.6.15-rc5-mm3 and linux-2.6.15-rc7.
> 
> Regards,
> 
