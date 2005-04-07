Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVDGIPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVDGIPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVDGIPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:15:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2960 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262239AbVDGIOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:14:53 -0400
Date: Thu, 7 Apr 2005 10:14:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mingming Cao <cmm@us.ibm.com>
Cc: sct@redhat.com, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ext3 allocate-with-reservation latencies
Message-ID: <20050407081434.GA28008@elte.hu>
References: <1112673094.14322.10.camel@mindpipe> <20050405041359.GA17265@elte.hu> <1112765751.3874.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112765751.3874.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mingming Cao <cmm@us.ibm.com> wrote:

> It seems we are holding the rsv_block while searching the bitmap for a 
> free bit.  In alloc_new_reservation(), we first find a available to 
> create a reservation window, then we check the bitmap to see if it 
> contains any free block. If not, we will search for next available 
> window, so on and on. During the whole process we are holding the 
> global rsv_lock.  We could, and probably should, avoid that.  Just 
> unlock the rsv_lock before the bitmap search and re-grab it after it.  
> We need to make sure that the available space that are still available 
> after we re- grab the lock.
> 
> Another option is to hold that available window before we release the 
> rsv_lock, and if there is no free bit inside that window, we will 
> remove it from the tree in the next round of searching for next 
> available window.
> 
> I prefer the second option, and plan to code it up soon. Any comments?

doesnt the first option also allow searches to be in parallel? This 
particular one took over 1 msec, so it seems there's a fair room for 
parallellizing multiple writers and thus improving scalability. (or is 
this codepath serialized globally anyway?)

	Ingo
