Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWHLRYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWHLRYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWHLRYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:24:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:23171 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964931AbWHLRYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:24:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bNF2nkcMeUirnc/nHbLoWzLBc0SZt5hXvK6aCOv7PZ9XLxe/GXeZ30LuHYS3ROGzk55WHS6FdHYkHIK5qw45rbQGDFXt/gC24OXLQr9Gwyr0AAivxeqG7uwL6RoSBAV0txoh4UdOycorLDru7kSQcCAbrCF4+KfxZz4w/bTLF/4=
Message-ID: <62b0912f0608121024y1dde66aavcbf4df04631772c4@mail.gmail.com>
Date: Sat, 12 Aug 2006 19:24:06 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org, "Duane Griffin" <duaneg@dghda.com>
In-Reply-To: <20060812163834.GA11497@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
	 <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com>
	 <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com>
	 <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com>
	 <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com>
	 <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com>
	 <20060812163834.GA11497@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> > I'm especially worried about the "70058 files, 39754 blocks used (0%)"
> > message at the end of the e2fsck run.
>
> OK, so it looks like the primary block group descriptors got trashed,
> and so e2fsck had to fall back to using the backup block group
> descriptors.

Good to have backups.  It would be very useful to know whether e2fsck
contemplates writing those back as primary BGDs when it's done, but I
couldn't find that in the documentation.  Will it?

(Would be good to have the above information in the docs.  Perhaps in
a "what does this message mean?" section.)

(Such a section would also help a lot when confronted with the first
message: "Entry blah is a link to directory bluh. Clear? y/n".
Obviously I don't want to "clear" my data.  But why is e2fsck
confronting me with that question?  Is something wrong with it that it
should be cleared?)

> The summary information in the backup block group
> descriptors is not backed up, for speed/performance reasons.  This is
> not a problem, since that information can always be regenerated
> trivially from the pass 5 information.

Thanks for the information!
(Would be very helpful to have a copy/paste of the above in the docs too...)

> That's what all of "free inodes/blocks/directories count wrong"
> messages in your log were all about.

Ah, I'm relieved.  The sheer number of messages was an indicator to me
that e2fsck is doing something gruesomely wrong.

> The 39754 block used (0%) is just because you were using -n and the
> summary information is calculated from the filesystem summary data,
> not from the pass5 count information (which was thrown away since you
> were running -n and thus declined to fix the results).

Much relieved again, thanks.

I'm wondering why it even tries to use the corrupt information, instead of just:
* reconstructing it from scratch
* not asking the user?

That leaves me a little less relieved once again ;-).

> I can imagine accepting a patch which sets a flag if any discrepancies
> found in pass 5 are not fixed, and then if the summary information is
> requested,

Huh?  The user didn't request anything, it always prints.

> to print a warning message indicating that the summary
> information may not be correct.

Even not printing anything would probably be better than knowingly
printing wrong information...

> But no, it's not worth it to take
> into account changes that -n might make if the user had said "yes".
> The complexities that would entail would be huge, and in fact as it is
> e2fsck -n does give a fairly accurate report of what what is wrong
> with the filesystem.  Is it 100% accurate?  No, but that was never the
> goal of e2fsck -n.  If you want that, then use a dm-snapshot, and run
> e2fsck on the snapshot....

Agreed.  Running a r/w e2fsck on some kind of overlay would be the way
to implement a more useful (for me anyway) version of -n.

But I think dm-snapshot is useless in this case because:
 * It must be configured before MD is configured and the filesystem is
created, which I haven't done on this box.

And generally because:
 * It's rather good at corrupting the filesystems you store on top of
it *itself*...
 * Either you have to create snapshots on devices just as big as the
ones being snapshotted, or you'll have to live with the snapshot
failing any time because it's full.  There's no good management
framework to help you manage the full/failing situations either.

Thanks a lot for the information!

I take it that it's safe to run e2fsck on the filesystem, then...
