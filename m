Return-Path: <linux-kernel-owner+w=401wt.eu-S1161027AbXALHy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbXALHy7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbXALHy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:54:59 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:34114 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161027AbXALHy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:54:58 -0500
Message-ID: <45A73E90.7050805@bull.net>
Date: Fri, 12 Jan 2007 08:53:52 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
References: <45A3BFAC.1030700@bull.net>	<45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org>
In-Reply-To: <20070111134615.34902742.akpm@osdl.org>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/01/2007 09:03:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/01/2007 09:03:08,
	Serialize complete at 12/01/2007 09:03:08
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
 > OK.  Unfortunately patches 2-4 don't apply without #1 present and the fix
 > is not immediately obvious, so we'll need a respin+retest, please.

Ok, I'll provide updated patches for -mm ASAP.

> On Thu, 11 Jan 2007 09:47:28 -0800
> Ulrich Drepper <drepper@redhat.com> wrote:

>> if the patches allow this, I'd like to see parts 2, 3, and 4 to be in
>> -mm ASAP.  Especially the 64-bit variants are urgently needed.  Just
>> hold off adding the plist use, I am still not convinced that
>> unconditional use is a good thing, especially with one single global list.

Just to avoid any misunderstanding (I (really) understand your point about 
performance issue), but:

* the problem I mention about several futexes hashed on the same key, and thus 
with all potential waiters listed on the same list, is _not_ a new problem which 
comes with this patch: it already exists today, with simple list.

* the measures of performance done with pthread_broadcast (and thus with 
futex_requeue) is a good choice (well, may be not realistic, when considering 
real applications (*)) to put in evidence the performance impact, rather than 
threads making FUTEX_WAIT/FUTEX_WAKE: what is expensive with plist is the 
plist_add operation (which occurs in FUTEX_WAIT), not plist_del (which occurs 
during FUTEX_WAKE => thus, no big impact should be noticed here). Any measure 
will be difficult to do with only FUTEX_WAIT/WAKE.

=> futex_requeue does as many plist_del/plist_add operations as the number of 
threads waiting (minus 1), and thus has a direct impact on the time needed to 
wake everybody (or to wake the first thread to be more precise).

(*) I'll try the volano bench, if I have time.


-- 
Pierre
