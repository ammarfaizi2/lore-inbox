Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTDUUQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTDUUQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:16:52 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:47829 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261892AbTDUUQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:16:51 -0400
Message-ID: <3EA45485.2080500@colorfullife.com>
Date: Mon, 21 Apr 2003 22:28:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH] fix verify_write for 80386 support
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Real 80386 cpus have a special feature: they ignore the write-protected 
bit in the page tables if the kernel runs at ring 0. This feature breaks 
COW, the software must manually check the write protected bit before 
writing.

Right now the check happens only in access_ok(VERIFY_WRITE).
This is broken, because:
- some codepaths call access_ok(VERIFY_READ), and then write.
- kswapd might change the page permissions between access_ok and the 
actual write access.


