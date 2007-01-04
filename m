Return-Path: <linux-kernel-owner+w=401wt.eu-S932302AbXADGv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbXADGv1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 01:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbXADGv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 01:51:27 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:34251 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932302AbXADGv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 01:51:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=u2NM9AAmD9DQ3r46YX6hUeMFjz+8JuK73/bcFzLjX6Yi/mbV3mNUGuP50/KymJzILqUCK1ngoD5nFR5oN2Ypw92DtEMc8ZZaaJcQsTq2X2tNnoqSKxToHIz4UE9y8LseZAcSpDoA0L6ktzf2GVzsSOZTOoDWs6QOGtEqKBmZZEs=  ;
X-YMail-OSG: F1epeTEVM1lwO2gleWvmP942iSL2yi21YvUgHTIiXkq4LqV7SouUE2qn8Jg73RBMYXNxWxH8O9.X_R6JS9.O51Xm1JBdowgRs53eTpxPMjZQfpHcrEwitsC09fPgJR_bB0N08WWDWMa3JyM-
Message-ID: <459CA3A3.5090106@yahoo.com.au>
Date: Thu, 04 Jan 2007 17:50:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-aio@kvack.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <459C95FE.1090802@yahoo.com.au> <20070104062622.GB24532@in.ibm.com>
In-Reply-To: <20070104062622.GB24532@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> On Thu, Jan 04, 2007 at 04:51:58PM +1100, Nick Piggin wrote:

>>So long as AIO threads do the same, there would be no problem (plugging
>>is optional, of course).
> 
> 
> Yup, the AIO threads run the same code as for regular IO, i.e in the rare
> situations where they actually end up submitting IO, so there should
> be no problem. And you have already added plug/unplug at the appropriate
> places in those path, so things should just work. 

Yes I think it should.

>>This (is supposed to) give a number of improvements over the traditional
>>plugging (although some downsides too). Most notably for me, the VM gets
>>cleaner ;)
>>
>>However AIO could be an interesting case to test for explicit plugging
>>because of the way they interact. What kind of improvements do you see
>>with samba and do you have any benchmark setups?
> 
> 
> I think aio-stress would be a good way to test/benchmark this sort of
> stuff, at least for a start. 
> Samba (if I understand this correctly based on my discussions with Tridge)
> is less likely to generate the kind of io patterns that could benefit from
> explicit plugging (because the file server has no way to tell what the next
> request is going to be, it ends up submitting each independently instead of
> batching iocbs).

OK, but I think that after IO submission, you do not run sync_page to
unplug the block device, like the normal IO path would (via lock_page,
before the explicit plug patches).

However, with explicit plugging, AIO requests will be started immediately.
Maybe this won't be noticable if the device is always busy, but I would
like to know there isn't a regression.

> In future there may be optimization possibilities to consider when
> submitting batches of iocbs, i.e. on the io submission path. Maybe
> AIO - O_DIRECT would be interesting to play with first in this regardi ? 

Well I've got some simple per-process batching in there now, each process
has a list of pending requests. Request merging is done locklessly against
the last request added; and submission at unplug time is batched under a
single block device lock.

I'm sure more merging or batching could be done, but also consider that
most programs will not ever make use of any added complexity.

Regarding your patches, I've just had a quick look and have a question --
what do you do about blocking in page reclaim and dirty balancing? Aren't
those major points of blocking with buffered IO? Did your test cases
dirty enough to start writeout or cause a lot of reclaim? (admittedly,
blocking in reclaim will now be much less common since the dirty mapping
accounting).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
