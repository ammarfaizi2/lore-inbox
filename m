Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVHVVZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVHVVZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVHVVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:25:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23235
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751222AbVHVVZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:25:25 -0400
Date: Mon, 22 Aug 2005 14:25:26 -0700 (PDT)
Message-Id: <20050822.142526.60284583.davem@davemloft.net>
To: tedu@coverity.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing spin_unlock in tcp_v4_get_port
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <430A40F0.6030601@coverity.com>
References: <430A40F0.6030601@coverity.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ted Unangst <tedu@coverity.com>
Subject: missing spin_unlock in tcp_v4_get_port
Date: Mon, 22 Aug 2005 14:17:36 -0700

> There appears to be a missing spin_unlock in tcp_v4_get_port.
> 
>                  do {    rover++;
>                          if (rover > high)
>                                  rover = low;
>                          head = &tcp_bhash[tcp_bhashfn(rover)];
>                          spin_lock(&head->lock);
> head->lock is acquired.
>                          tb_for_each(tb, node, &head->chain)
>                                  if (tb->port == rover)
>                                          goto next;
> we don't find what we want.  break out of while loop.
>                          break;
>                  next:
>                          spin_unlock(&head->lock);
>                  } while (--remaining > 0);
>                  tcp_port_rover = rover;
>                  spin_unlock(&tcp_portalloc_lock);
> 
>                  /* Exhausted local port range during search? */
>                  ret = 1;
>                  if (remaining <= 0)
>                          goto fail;
> here we go to fail; head->lock is still acquired.

Only if remaining <= 0, in which case we broke out of the loop due to
the "while (--remaining > 0)" test, not because of the "break;"
statement, and thus the lock is not held.
