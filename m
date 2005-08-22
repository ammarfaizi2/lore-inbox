Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVHVVRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVHVVRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVHVVRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:17:04 -0400
Received: from supmuscle.dreamhost.com ([66.33.192.105]:4070 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S1751171AbVHVVRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:17:03 -0400
Message-ID: <430A40F0.6030601@coverity.com>
Date: Mon, 22 Aug 2005 14:17:36 -0700
From: Ted Unangst <tedu@coverity.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.7.3) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: missing spin_unlock in tcp_v4_get_port
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a missing spin_unlock in tcp_v4_get_port.

                 do {    rover++;
                         if (rover > high)
                                 rover = low;
                         head = &tcp_bhash[tcp_bhashfn(rover)];
                         spin_lock(&head->lock);
head->lock is acquired.
                         tb_for_each(tb, node, &head->chain)
                                 if (tb->port == rover)
                                         goto next;
we don't find what we want.  break out of while loop.
                         break;
                 next:
                         spin_unlock(&head->lock);
                 } while (--remaining > 0);
                 tcp_port_rover = rover;
                 spin_unlock(&tcp_portalloc_lock);

                 /* Exhausted local port range during search? */
                 ret = 1;
                 if (remaining <= 0)
                         goto fail;
here we go to fail; head->lock is still acquired.
....
fail_unlock:
         spin_unlock(&head->lock);
fail:
         local_bh_enable();
         return ret;

Is this a real bug?  The same code was also copy-pasted into 
tcp_v6_get_port.


-- 
Ted Unangst             www.coverity.com             Coverity, Inc.
