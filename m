Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWFSSOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWFSSOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWFSSOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:14:45 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:11964 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1751277AbWFSSOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:14:45 -0400
Message-ID: <4496E982.3040607@nortel.com>
Date: Mon, 19 Jun 2006 12:14:26 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: vatsa@in.ibm.com, Sam Vilain <sam@vilain.net>,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au>
In-Reply-To: <4493C1D1.4020801@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2006 18:14:31.0454 (UTC) FILETIME=[35F5A3E0:01C693CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> So, from my POV, I would like to be convinced of the need for this first.
> I would really love to be able to keep core kernel simple and fast even if
> it means edge cases might need to use a slightly different solution.

We currently use a heavily modified CKRM version "e".

The "resource groups" (formerly known as CKRM) cpu controls express what 
we'd like to do, but they aren't nearly accurate enough.  We don't make 
use the limits, but we do use per-cpu guarantees, along with the 
hierarchy concept.

Our engineering guys need to be able to make cpu guarantees for the 
various type of processes.  "main server app gets 90%, these fault 
handling guys normally get 2% but should be able to burst to 100% for up 
to 100ms, that other group gets 5% in total, but a subset of them should 
get priority over the others, and this little guy here should only be 
guaranteed .5% but it should take priority over everything else on the 
system as long as it hasn't used all its allocation".

Ideally they'd really like sub percentage (.1% would be nice, but .5% is 
proably more realistic) accuracy over the divisions.  This should be 
expressed per-cpu, and tasks should be migrated as necessary to maintain 
fairness.  (Ie, a task belonging to a group with 50% on each cpu should 
be able to run essentially continuously, bouncing back and forth between 
cpus.)  In our case, predictability/fairness comes first, then performance.

If a method is accepted into mainline, it would be nice to have NPTL 
support it as a thread attribute so that different threads can be in 
different groups.

Chris
