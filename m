Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUIUOOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUIUOOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIUOOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:14:42 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:24803 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267482AbUIUOOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:14:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Date: Tue, 21 Sep 2004 10:14:37 -0400
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>
References: <200409121128.39947.gene.heskett@verizon.net> <1095088378.2765.18.camel@sisko.scot.redhat.com> <20040921015020.7372faac.akpm@osdl.org>
In-Reply-To: <20040921015020.7372faac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409211014.37024.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [141.153.127.192] at Tue, 21 Sep 2004 09:14:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 04:50, Andrew Morton wrote:
>"Stephen C. Tweedie" <sct@redhat.com> wrote:
>> Hi,
>>
>> On Sun, 2004-09-12 at 16:28, Gene Heskett wrote:
>> > I just got up, and found advisories on every shell open that the
>> > journal had encountered an error and aborted, converting my /
>> > partition to read-only.
>>
>> ...
>>
>> > The kernel is 2.6.9-rc1-mm4.  .config available on request.
>> >
>> > This is precious little info to go on, but basicly I'm wondering
>> > if anyone else has encountered this?
>>
>> Well, we really need to see _what_ error the journal had
>> encountered to be able to even begin to diagnose it.  But
>> 2.6.9-rc1-mm3 and -mm4 had a bug in the journaling introduced by
>> low-latency work on the checkpoint code; can you try -mm5 or back
>> out
>> "journal_clean_checkpoint_list-latency-fix.patch" and try again?
>
>Turns out this is due to the reworked buffer/page sleep/wakeup code
> in recent -mm's.  If the journal timer wakes kjournald while
> kjournald is waiting on a read of a journal indirect block,
> kjournald just plunges ahead with a still-locked, non-uptodate
> buffer.  Which it treats as an I/O error, and things don't improve
> from there.

Classic understatement :)

That said, I've not had a repeat of this scene since I moved /var to a 
different drive a week or thereabouts ago.  OTOH, this will be 
building in a couple of minutes too,  many thanks.

>This should fix.
>
>--- 25/kernel/wait.c~wait_on_bit-must-loop 2004-09-21
> 01:33:18.000000000 -0700 +++ 25-akpm/kernel/wait.c 2004-09-21
> 01:44:36.706435616 -0700 @@ -157,8 +157,9 @@
> __wait_on_bit(wait_queue_head_t *wq, str int ret = 0;
>
>  prepare_to_wait(wq, &q->wait, mode);
>- if (test_bit(q->key.bit_nr, q->key.flags))
>+ do {
>   ret = (*action)(q->key.flags);
>+ } while (test_bit(q->key.bit_nr, q->key.flags) && !ret);
>  finish_wait(wq, &q->wait);
>  return ret;
> }
>_

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
