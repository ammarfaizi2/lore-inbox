Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTJTA0M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 20:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJTA0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 20:26:12 -0400
Received: from dyn-ctb-210-9-246-209.webone.com.au ([210.9.246.209]:15108 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262349AbTJTA0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 20:26:09 -0400
Message-ID: <3F932B81.2040202@cyberone.com.au>
Date: Mon, 20 Oct 2003 10:25:37 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Osterlund <petero2@telia.com>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8, DEBUG_SLAB, oops in as_latter_request()
References: <m2ismlovep.fsf@p4.localdomain> <20031019142042.2f41eb68.akpm@osdl.org>
In-Reply-To: <20031019142042.2f41eb68.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Peter Osterlund <petero2@telia.com> wrote:
>
>>I was running 2.6.0-test8 compiled with CONFIG_DEBUG_SLAB=y. When
>> testing the CDRW packet writing driver, I got an oops in
>> as_latter_request. (Full oops at the end of this message.) It is
>> repeatable and happens because arq->rb_node.rb_right is uninitialized.
>>
>
>deadline seems to have the same problem.
>
>We may as well squish this with the big hammer?
>

Thanks for the report, Peter.

The request is a special request, so either blk_attempt_remerge should
never be called on it, or blk_attempt_remerge (or as_latter_request) should
check for this. Its up to Jens.

I would say to stick something like
if (!rq_mergeable(rq))
    return;

into blk_attempt_remerge.

I'd say we shouldn't expect drivers to try to get this right.

