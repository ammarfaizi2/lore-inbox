Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVHEH4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVHEH4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVHEH4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:56:19 -0400
Received: from mx1.invoca.ch ([157.161.91.34]:60119 "EHLO ns1.invoca.ch")
	by vger.kernel.org with ESMTP id S262905AbVHEH4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:56:17 -0400
Message-ID: <34082.213.188.237.106.1123228569.squirrel@localhost>
In-Reply-To: <20050804195853.0866ade9.akpm@osdl.org>
References: <45138.213.188.237.106.1123086677.squirrel@localhost>
    <20050804195853.0866ade9.akpm@osdl.org>
Date: Fri, 5 Aug 2005 09:56:09 +0200 (CEST)
Subject: Re: File corruption on LVM2 on top of software RAID1
From: "Simon Matter" <simon.matter@invoca.ch>
To: "Andrew Morton" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernel-maint@redhat.com,
       linux-raid@vger.kernel.org, dm-devel@redhat.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Simon Matter" <simon.matter@invoca.ch> wrote:
>>
>> Hi,
>>
>> Please CC me as I'm not subscribed to the kernel list.
>>
>> I had a hard time identifying a serious problem in the 2.6 linux kernel.
>
> Yes, it is a serious problem.
>
>> It all started while evaluating RHEL4 for new servers. My data integrity
>> tests gave me bad results - which I couldn't believe - and my first idea
>> was - of course - bad hardware. I ordered new SCSI disks instead of the
>> IDE disks, took another server, spent some money again, tried again and
>> again. That's all long ago now...
>>
>> In my tests I get corrupt files on LVM2 which is on top of software
>> raid1.
>> (This is a common setup even mentioned in the software RAID HOWTO and
>> has
>> worked for me on RedHat 9 / kernel 2.4 for a long time now and it's my
>> favourite configuration). Now, I tested two different distributions,
>> three
>> kernels, three different filesystems and three different hardware. I can
>> always reproduce it with the following easy scripts:
>>
>
> Thanks for doing that.
>
> There's one fix against 2.6.12.3 which is needed, but 2.6.9 didn't have
> the
> bug which this fix addresses.  So unless 2.6.9 has a different problem,
> this won't help.

Sorry for the confusion, the 2.6.9 in question is a "RedHat Enterprise
Kernel" which includes lots of backported patches and features. So it is
no plain 2.6.9.

The real problem is that most current distributions include this bug in
one or the other way. They either have one of the affected versions in the
kernel package or have an older kernel with the bug backported. What I
know for sure is that the following distributions are affected:
RedHat Enterprise 4
Fedora Core 4
SuSE 9.3
Debian with the latest "unstable" 2.6 kernel
I couldn't verify Mandrake, Gentoo and others, but I expect them to be at
risk too.

While looking at some data corruption vulnerability reports on
Securityfocus I wonder why this issue does not get any attention from
distributors. I have an open bugzilla report with RedHat, have an open
customer service request with RedHat, have mailed peoples directly. No
real feedback.
I'm now in the process of restoring intergrity of my data with the help of
backups and mirrored data. Maybe I just care too much about other peoples
data, but I know that this bug will corrupt files on hundreds or thousands
of servers today and most people simply don't know it. Did I miss
something?

Simon

>
> But still, you should include this in testing please.
>
>
> diff -puN fs/bio.c~bio_clone-fix fs/bio.c
> --- devel/fs/bio.c~bio_clone-fix	2005-07-28 00:39:40.000000000 -0700
> +++ devel-akpm/fs/bio.c	2005-07-28 01:02:34.000000000 -0700
> @@ -261,6 +261,7 @@ inline void __bio_clone(struct bio *bio,
>  	 */
>  	bio->bi_vcnt = bio_src->bi_vcnt;
>  	bio->bi_size = bio_src->bi_size;
> +	bio->bi_idx = bio_src->bi_idx;
>  	bio_phys_segments(q, bio);
>  	bio_hw_segments(q, bio);
>  }
> _
>
>

