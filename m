Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVLUShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVLUShp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVLUShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:37:45 -0500
Received: from main.gmane.org ([80.91.229.2]:960 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751155AbVLUSho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:37:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: rcuref optimization
Date: Wed, 21 Dec 2005 13:35:12 -0500
Message-ID: <doc72s$g43$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can get rid of the requirement for atomic_inc_not_zero logic
if you use the logic I first proposed here in c.l.c++.m.
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=3E7C83DD.B126DE24%40xemaps.com
for weakptrs where the same kind of logic was required for the strong count.
This will allow you to use fetch_inc (e.g. LOCK INC on x86) instead of compare
and swap logic which might be more efficient on some processors.  You might
even be able to get rid of the the "unincrement" if you are pretty sure the
maximum number of increments won't put the refcount to zero.

Summary for those who can't follow the link.  Basically, if you decrement the
refcount to zero, you attempt to set the refcount to the minimum signed value
(e.g. 0x80000000 for 32 bits).  If successful you can schedule the object
for deallocation using RCU.  If unsuccessful, some other thread has incremented
the refcount and object is still in use and even deallocated by some other thread.
Incrementing of the refcount is only considered successful if the result is greater
than zero.  If less than zero, object is being scheduled for deallocation.

--
Joe Seigh

