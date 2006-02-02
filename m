Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWBBWIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWBBWIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBBWIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:08:53 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:39597 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932335AbWBBWIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:08:52 -0500
Message-ID: <43E2834F.8040009@tmr.com>
Date: Thu, 02 Feb 2006 17:10:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com> <43CD8A19.3010100@cfl.rr.com>
In-Reply-To: <43CD8A19.3010100@cfl.rr.com>
Content-Type: multipart/mixed;
 boundary="------------020105070205040502060200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020105070205040502060200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Phillip Susi wrote:
> Your understanding of statistics leaves something to be desired.  As you 
> add disks the probability of a single failure is grows linearly, but the 
> probability of double failure grows much more slowly.  For example:
> 
> If 1 disk has a 1/1000 chance of failure, then
> 2 disks have a (1/1000)^2 chance of double failure, and
> 3 disks have a (1/1000)^2 * 3 chance of double failure
> 4 disks have a (1/1000)^2 * 7 chance of double failure

After the first drive fails you have no redundancy, the chance of an 
additional failure is linear to the number of remaining drives.

Assume:
   p - probability of a drive failing in unit time
   n - number of drives
   F - probability of double failure

The chance of a single drive failure is n*p. After that you have a new 
"independent trial" for the failure any one of n-1 drives, so the chance 
of a double drive failure is actually:
   F = (n*p) * (n-1)*p

But wait, there's more:
   p - chance of a drive failing in unit time
   n - number of drives
   R - the time to rebuild to a hot spare in the same units as p
   F - probability of double failure

So:

   F = n*p * (n-1)*(R * p)

If you rebuild a track at a time, each track takes the time to read the 
slowest drive plus the time to write the spare. If the array remains in 
use load increases those times.

And the ugly part is that p is changing all the time, there's infant 
mortality on new drives, fairly constant electronic probability and 
increasing probability of mechanical failure over time. If all of your 
drives are the same age they are less reliable than mixed age drives.

> 
> Thus the probability of double failure on this 4 drive array is ~142 
> times less than the odds of a single drive failing.  As the probably of 
> a single drive failing becomes more remote, then the ratio of that 
> probability to the probability of double fault in the array grows 
> exponentially.
> 
> ( I think I did that right in my head... will check on a real calculator 
>  later )
> 
> This is why raid-5 was created: because the array has a much lower 
> probabiliy of double failure, and thus, data loss, than a single drive. 
>  Then of course, if you are really paranoid, you can go with raid-6 ;)

If you're paranoid you mirror over two RAID-5 arrays. The mirrors are on 
independent controllers. RAID-10.

> 
> 
> Michael Loftis wrote:
> 
>> Absolutely not.  The more spindles the more chances of a double 
>> failure. Simple statistics will mean that unless you have mirrors the 
>> more drives you add the more chance of two of them (really) failing at 
>> once and choking the whole system.
>>
>> That said, there very well could be (are?) cases where md needs to do 
>> a better job of handling the world unravelling.
>> -
A small graph of the effect of the rebuild time on RAID-5 attached, it 
assumes probability of failure = 1/1000 per the original post, for 
various rebuild times the probability of failure drops.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

--------------020105070205040502060200
Content-Type: image/png;
 name="2dfail-2.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="2dfail-2.png"

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
dGcAAGBy/gN03SVN0P0slAAAAABJRU5ErkJggg==
--------------020105070205040502060200--
