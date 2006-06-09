Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWFIPIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWFIPIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWFIPIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:08:30 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:9611 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030203AbWFIPI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:08:29 -0400
Message-ID: <44898EE3.6080903@garzik.org>
Date: Fri, 09 Jun 2006 11:08:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
In-Reply-To: <20060609083523.GQ5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please fix your mailer to stop creating bogus Mail-Followup-To headers, 
headers which exclude the original poster, and cause compliant MUAs to 
incorrectly build To/CC.


Andreas Dilger wrote:
> On Jun 08, 2006  22:49 -0400, Jeff Garzik wrote:
>> One of my common complaints about massive ext3 updates such as this is 
>> the ever-growing "which ext3 filesystem am I mounting?" problem.
>>
>> I really think extents and 48bit-ness should imply
>> 	cp -a fs/ext3 fs/ext4
>> and go from there.
> 
> The problem with this approach (as seen with ext2 and ext3) is that one
> tree or the other gets stale w.r.t. bug fixes and now we have the case
> where ext2 has a noticably different implementation in some areas and
> bug fixes are no longer trivial to apply to both trees.
> 
> I think all of the ext3 maintainers think this split was a bad idea in
> hindsight, and having an ext3 mode where it can mount without a journal
> would be much more desirable.

Please look beyond just ext2/3.  Other filesystems which have "version 
1", "version 2", "version 3", ... formats are all nasty as hell.  The 
end-result bloated code essentially supports several filesystems, all 
within the same code base, and its a nightmare of ugliness.

Further, its not only bloated, but slow.  The code inevitably winds up 
in one of two forms:

	if (spiffy new-feature metadata)
		...
	else if (updated metadata)
		...
	else /* original metadata */
		...

_or_ you add a level of indirection, by creating internal-to-the-fs 
pointer operations.

Stuffing more and more features into fs/ext3 means you are following the 
path that leads to reiser4...  where EVERYTHING under the hood is 
mutable, all within fs/ext3.


>> IMHO the ext3 back-compat situation is already really hairy, with all 
>> the features added since the original ext3 release.
> 
> While partially true, ext2/ext3 has a very good history w.r.t. compatibility
> (with one exception being the EAs on symlinks problem that slipped through
> with selinux).
> 
> Yes, the extents format will be incompatible with older ext3, but it isn't
> enabled by default so it will be completely up to the sysadmin when they
> make their filesystem incompatible.  They also won't impact any existing
> files.  The earlier extents support gets into a kernel.org kernel the
> more systems will be able to mount a filesystem with the changes when
> they becomes widely used.
> 
> All of the other features that are going to be introduced will only going
> to be applicable for format time (filesystems larger than 16TB), or if
> exceeding limits of the current ext3 support (e.g. files larger than 2TB
> in size).

Yet more progressive incompatibility, yet more

	if (metadata v2)
		...
	else /* metadata v1 */
		...

Why do you insist upon calling the end result ext3, when the truth is 
that you are slowing rewriting ext3?

As time progresses, more and more admins must ask themselves the 
question "what flavor of ext3 filesystem is on my hard drive?"

Here's a key question for ext3 developers, which I bet has no answer: 
when is it enough?  Is the plan to continually introduce incompatible 
features into ext3, over time, ad infinitum?


>> People (including me) still switch back and forth between ext2 and ext3 
>> mounts of the same filesystem on occasion.  I think creating an "ext4" 
>> would allow for greater developer flexibility in implementing new 
>> features and ditching old ones -- while also emphasizing to the user 
>> that switching back and forth between ext4 and ext[23] is a bad idea.
> 
> While this is partly true, one of the big benefits is that you can
> transparently upgrade your system to use the new features and improve
> performance without a long outage window.  Having a completely separate

Changing the name to ext4 doesn't erase this capability.


> ext4 filesystem doesn't improve the compatibility story at all.  There
> has been renewed discussion on implementing "mounting ext3 without a
> journal", just for a recovery mode, because ext2 will not be modified
> to get all of these features (running e2fsck on a huge filesystem each
> reboot would be insane).

So now you are going backwards, and implementing ext2-within-ext3?

Are you ready to admit, yet, that ext3 is 100% mutable in the minds of 
ext3 developers?  Why not implement the minix filesystem format within 
ext3, at this point?  We could call it a "plugin", I bet.


>> Overall, after applying extent (and 48bit) patches, I think it is wrong 
>> to keep calling it ext3.  That will break some existing user 
>> assumptions, and continue to restrict developers' freedom to implement 
>> nifty new features.
> 
> Just FYI, all of the ext3 developers are on board with this patch series
> and it has been discussed and reviewed for many weeks already, it isn't
> just being pushed by one party.

That is completely irrelevant to this thread.

If all the ext3 developers are on board, that just implies that there is 
no clear definition of what "ext3" really means.  With this patch 
series, and with future plans described here and elsewhere, the name 
"ext3" will become more and more meaningless.  It could mean _any_ of 
several filesystem metadata variants, and the admin will have no clue 
which variant they are talking to until they try to mount the blkdev 
(and possibly fail the mount).

At SOME point, clueful developers will say "we should better concentrate 
our energy on a new filesystem."

But I see no one at all defining that "some point."

At some point you are beating a dead horse.  At some point, you are 
pushing features into a filesystem that was never designed to support 
said features.

	Jeff


