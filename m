Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966275AbWKNTVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966275AbWKNTVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966278AbWKNTVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:21:52 -0500
Received: from dvhart.com ([64.146.134.43]:37509 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S966275AbWKNTVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:21:51 -0500
Message-ID: <455A174E.3070601@mbligh.org>
Date: Tue, 14 Nov 2006 11:21:50 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Mel Gorman <mel@skynet.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie> <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 14 Nov 2006, Mel Gorman wrote:
>> 2.6.19-rc5-mm2
>>
>> Am seeing errors with systems using ext2. First machine is a plan old x86
>> using initramfs. Console output looks like;
>> ...
>> Configuring network interfaces...BUG: soft lockup detected on CPU#3!
>> ...
>>  [<c01b3b80>] ext2_try_to_allocate+0xdb/0x152
>>  [<c01b3e72>] ext2_try_to_allocate_with_rsv+0x4b/0x1b2
>>
>> I've not investigated yet what patches might be at fault.
> 
> I expect you'll find it's
> ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch
> which gets stuck in a loop there for me too: back it out and all seems fine.
> 
> It's not obvious which part of the patch is to blame: mostly it's
> cleanup, but a few variables do change size: I'm currently narrowing
> down to where a fix is needed.

Humpf. that was meant to be one of those "so obvious I can't screw it
up" patches.

typedef unsigned long ext2_fsblk_t;
typedef int ext2_grpblk_t;

in ext2_alloc_blocks we do change from "unsigned long long" to
"unsigned long" for new_blocks[], but akpm thinks that was garbage
before (same for ext2_alloc_branch's current_block)

The ext2_grpblk_t ones all look innocuous.

