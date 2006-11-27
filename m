Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933817AbWK0VwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933817AbWK0VwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933835AbWK0VwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:52:04 -0500
Received: from gw1.cosmosbay.com ([86.65.150.130]:57251 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S933817AbWK0VwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:52:02 -0500
Message-ID: <456B5E04.50007@cosmosbay.com>
Date: Mon, 27 Nov 2006 22:52:04 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs : reorder some 'struct inode' fields to speedup i_size
 manipulations
References: <20061120151700.4a4f9407@frecb000686>	<20061123092805.1408b0c6@frecb000686>	<20061123004053.76114a75.akpm@osdl.org>	<200611231157.30056.dada1@cosmosbay.com> <20061127133748.4ebcd6b3.akpm@osdl.org>
In-Reply-To: <20061127133748.4ebcd6b3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [86.65.150.130]); Mon, 27 Nov 2006 22:51:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> On Thu, 23 Nov 2006 11:57:29 +0100
> Eric Dumazet <dada1@cosmosbay.com> wrote:
> 
>> On 32bits SMP platforms, 64bits i_size is protected by a seqcount 
>> (i_size_seqcount).
>>
>> When i_size is read or written, i_size_seqcount is read/written as well, so it 
>> make sense to group these two fields together in the same cache line.
>>
>> Before this patch, accessing i_size needed 3 cache lines (2 for i_size, one 
>> for i_size_seqcount). After, only one cache line is needed/ (dirtied on a 
>> i_size change).
> 
> I didn't understand that paragraph at all, really, so I took it out.
> 
> At present an i_size change will dirty one, two or three cachelines, most
> likely one or two.
> 
> After your patch an i_size change will dirty one or two cachelines, most
> likely one.
> 
> yes?

nope

Before :
---------
  offsetof(i_size) = 0x3C

i_size is 8 bytes, so i_size spans 2 cache lines (if 64 or 32 bytes cache lines)

and offsetof(i_size_seqcount) = 0x160, so a read of i_size (coupled with a 
read of seqcount) needed 3 cache lines. A change of i_size dirtied 2 or 3 
cache lines.


After :
--------
offsetof(i_size) = 0x40
offsetof(i_size_seqcount) = 0x48

One cache line 'only', reading or writing.


