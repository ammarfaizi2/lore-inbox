Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUABCyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 21:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUABCyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 21:54:40 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:2185 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263228AbUABCyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 21:54:39 -0500
Message-ID: <3FF4DD6B.2080705@colorfullife.com>
Date: Fri, 02 Jan 2004 03:54:35 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: [rfc/patch] wake_up_info() draft ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

I think the patch adds unnecessary bloat, and mandates one particular 
use of the wait queue info interface.
For example, why does remove_wait_queue_info copy the wakeup info 
around? That's now how I would use it for fasync: I would send the 
necessary signals directly from the wakeup handler, and 
remove_wait_queue_info is called during sys_close handling, info discarded.

I'm thinking about a simpler approach: add a wake_up_info() function, 
and forward the info parameter to the wait_queue_func_t. This means 
changing the prototype of this function - there shouldn't be that many 
instances. NULL is passed if the normal wake_up functions are used. No 
additional fields in the wait queue entry are required. Then I would 
convert kill_fasync to that interface, with the band value from 
kill_fasync as the info parameter. A custom wait queue func does the 
signal sending. fasync_helper would be kmalloc+add_wait_queue.

--
    Manfred

