Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUHVVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUHVVbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUHVVax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:30:53 -0400
Received: from pop.gmx.de ([213.165.64.20]:39055 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266303AbUHVVao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:30:44 -0400
X-Authenticated: #5874409
Message-ID: <412910A3.6070100@gmx.net>
Date: Sun, 22 Aug 2004 23:31:15 +0200
From: Jens Maurer <Jens.Maurer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [1/4] /dev/random: Fix latency in rekeying sequence	number
References: <E1By1Sh-0001TJ-1U@thunk.org> <1092978626.10063.15.camel@krustophenia.net>
In-Reply-To: <1092978626.10063.15.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell wrote:
> This patch does not actually fix the problem, as 3-700usecs is still
> spent in the spinlocked region, this just causes it to be done out of a
> workqueue.

May I suggest that get_random_bytes() be called *outside* of the
spinlocked region on a temporary buffer, assuming that the SHA
algorithm is the problem here?

Something like this (untested):

   u32 tmp[sizeof(keyptr->secret)/4];      /* on stack */
   get_random_bytes(tmp, sizeof(tmp));
   spin_lock_bh(&ip_lock);
   memcpy(keyptr->secret, tmp, sizeof(keyptr->secret));
   /* ... other housekeeping ... */
   spin_unlock_bh(&ip_lock);

Jens Maurer

