Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWFGAG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWFGAG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFGAG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:06:57 -0400
Received: from gw.goop.org ([64.81.55.164]:22685 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751384AbWFGAG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:06:57 -0400
Message-ID: <44861899.1040506@goop.org>
Date: Tue, 06 Jun 2006 17:06:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Andrew Morton <akpm@osdl.org>, Don Zickus <dzickus@redhat.com>, ak@suse.de,
       shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org> <20060606230504.GC11696@redhat.com> <20060606162201.f0f9f308.akpm@osdl.org> <200606070938.34927.ncunningham@linuxmail.org>
In-Reply-To: <200606070938.34927.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> * Driver suspend and resume calls should only handle cpu0, and should not 
> touch other processors. The same semantics regarding hardware state and 
> values of variables apply here.
>   
Isn't the trouble that in this case, the devices themselves are the 
CPUs, and so the CPUs themselves need to operate on their own state?

Or perhaps, to look at it another way, suspend/resume is just a special 
case of:

   1. unplug cpus 1-N
   2. [something]
   3. re-plug cpus 1-N

where [something] in this case is "suspend cpu0". 

But the problem is that there's nothing which keeps track of whether the 
re-plugged cpus 1-N are the "same" as the unplugged 1-N, and so nothing 
can apply the same per-cpu settings to them.  In the suspend/resume case 
they clearly are, but in the general remove/add case, do you really want 
the new CPU to get the same state as the old one just because it ends up 
with the same logical CPU number?  Perhaps, but what if it doesn't even 
have the same capabilities?  (Do we support heterogeneous CPUs anyway?)

    J
