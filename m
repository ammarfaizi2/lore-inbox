Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbUCAByn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUCAByn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:54:43 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.14.91]:8697 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262212AbUCAByk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:54:40 -0500
Message-ID: <404297D1.5010301@myrealbox.com>
Date: Sun, 29 Feb 2004 17:54:25 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Lee <johnl@aurema.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.jgj0bdi.b3u6qk@ifi.uio.no>
In-Reply-To: <fa.jgj0bdi.b3u6qk@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How hard would it be to make shares hierarchial?  For example (quoted names are 
just descriptive):

      "guaranteed" (10 shares)       "user" (5 shares)
                |                          |
       -----------------            -----------------
       |               |            |               |
  "root" (1)      "apache" (2)    "bob" (5)       "fred" (5)
       |               |            |               |
(more groups?)    (web servers)   etc.            etc.


This way one user is prevented from taking unfair CPU time by launcing too many 
processes, apache gets enough time no matter what, etc.  In this scheme, numbers 
of shares would only be comparable if they are children of the same node.  Also, 
it now becomes safe to let users _increase_ priorities of their processes -- it 
doesn't affect anyone else.

Ignoring limts, this should be just an exercise in keeping track of shares and 
eliminating the 1/420 limit in precision.  It would take some thought to figure 
out what nice should do.


Also, could interactivity problems be solved something like this:

   prio = (  (old EBS usage ratio) - 0.5  ) * i + 0.5

"i" would be a per-process interactivity factor (normally 1, but higher for 
interactive processes) which would only boost them when their CPU usage is low. 
  This makes interactive processes get their timeslices early (very high 
priority at low CPU consumption) but prevents abuse by preventing excessive CPU 
consumption.  This could even by set by the (untrusted) process itself.


I imagine that these two together would nicely solve most interactivity and 
fairness issues -- the former prevents starvation by other users and the latter 
prevents latency caused by large numbers of CPU-light tasks.


Is this sane?  And does it break the O(1) promotion algorithm?

--Andy
