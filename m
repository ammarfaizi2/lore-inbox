Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274490AbRIYEtz>; Tue, 25 Sep 2001 00:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274493AbRIYEtq>; Tue, 25 Sep 2001 00:49:46 -0400
Received: from femail42.sdc1.sfba.home.com ([24.254.60.36]:48551 "EHLO
	femail42.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274490AbRIYEta>; Tue, 25 Sep 2001 00:49:30 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Mon, 24 Sep 2001 21:49:51 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924200537.SRVB23487.femail38.sdc1.sfba.home.com@there> <20010925021113.B22073@emma1.emma.line.org>
In-Reply-To: <20010925021113.B22073@emma1.emma.line.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010925044949.JNOU8313.femail42.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 September 2001 05:11 pm, Matthias Andree wrote:
> On Mon, 24 Sep 2001, Nicholas Knight wrote:
> > Would you like to read the rest of my message please? Cheap UPS's
> > can provide protection against power failures. If your data is that
> > valuble, you can afford a cheap UPS to give you 5 minutes to shut
> > down.
>
> No UPS can protect you from system crashes. The problem is, with the
> drive cache on, the drive will acknowledge having written the data
> early and reorder its writes, but who makes guarantees it can write
> its whole 2 MB to disk should the power fail? No-one. ATA6 drafts
> have a NOTE that says, the FLUSH CACHE command may take longer than
> 30 s to complete.
>
> Journalling File systems don't get you anywhere if the drive reorders
> its blocks before the write (I presume, most will do), they may
> instead turn the whole partition to junk without notice, because any
> assumptions as to the on-disk structure don't hold.
>
> > > Linear writing as dd mostly does is BTW something which should
> > > never be affected by write caches.
> >
> > Explain the numbers then.
>
> I can't, any explanation right now would be conjecture. I can
> reproduce the numbers on my IBM DTLA-307045 (Promise) and on my
> Western Digital CAC420400D (VIA KT133, the disk looks like an IBM
> DJNA-352030 OEM, though).
>
> However, would you care to elaborate how switching OFF the cache
> should harm data, provided you don't need to cater for power outages
> (UPS attached, e. g.)?

It's a very remote possability of failure, like most instances where 
write-cache would cause problems. Catastrophic failure of the IDE cable 
in mid-write will cause problems. If write cache is enabled, the write 
stands a higher chance of having made it to the drive before the cable 
died, with it off, it stands a higher chance of NOT having made it 
entirely to the drive.
For most drives, I don't know for sure if they'd finish the write 
that's now sitting in their cache, but I expect higher quality drives 
(such as our IBM drives) definitely would. Infact I may even be willing 
to test this later (my swap partition looks like it wants to help :)

>
> hdparm:
>
> "       -W     Disable/enable the IDE drive's  write-caching  fea­
>               ture (usually OFF by default)."
>
> > I followed *YOUR* instructions for disabling write caching.
>
> No-one doubts you did. I said it's weird that the drive write cache
> has an impact on dd figures. It may be worthwhile to investigate
> this, but again, any try to explain this would be a guess.
>
> It may be an implementation problem in our IBM drives which ship with
> their write caches enabled, someone please do this test on current
> Fujitsu, Maxtor or Seagate IDE drives or with different controllers.

Either Maxtor or Western Digital share very close designs to IBM 
drives, I belive they had some sort of development partnership. I'm not 
sure if it was Maxtor or WD. 

>
> It would suffice if the kernel could flush the drive's buffers on
> fsync() and other synchronous operations, but a flush command has
> only recently appeared in the ATA standards, as it seems. I only have
> drafts here, ATA 3 draft rev. 6 did not offer any command to flush
> the cache, ATA 6 draft makes it mandatory for all devices that do
> offer a PACKET interface. Not sure about the actual ATA 3, 4, or 5
> standards.
>
> Why are disk drives slower with their caches disabled on LINEAR
> writes?

Maybe the cache isn't doing what we think it is?
You're right, now that I'm thinking about it, it doesn't make a whole 
lot of sense. The cache on our IBM's is just 2MB.
Does anyone have contacts at IBM and/or Western Digital? Something's 
up... The 256MB write with write-cache off was going at 5.8MB/sec, and 
with it on it was going at 14.22MB/sec (averages). One interesting 
thing, the timings are showing a pretty consistant but tiny increase in 
sys time with write caching on.
