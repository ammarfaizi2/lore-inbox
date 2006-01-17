Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWAQSML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWAQSML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWAQSMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:12:10 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:47188 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932281AbWAQSMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:12:08 -0500
Message-ID: <43CD3388.9050107@tls.msk.ru>
Date: Tue, 17 Jan 2006 21:12:24 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Vandegrift <ross@jose.lug.udel.edu>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru> <20060117095019.GA27262@localhost.localdomain> <43CCD453.9070900@tls.msk.ru> <20060117160829.GA16606@lug.udel.edu>
In-Reply-To: <20060117160829.GA16606@lug.udel.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Vandegrift wrote:
> On Tue, Jan 17, 2006 at 02:26:11PM +0300, Michael Tokarev wrote:
> 
>>Raid code is already too fragile, i'm afraid "simple" I/O errors
>>(which is what we need raid for) may crash the system already, and
>>am waiting for the next whole system crash due to eg superblock
>>update error or whatnot.
> 
> I think you've got some other issue if simple I/O errors cause issues.
> I've managed hundreds of MD arrays over the past ~ten years.  MD is
> rock solid.  I'd guess that I've recovered at least a hundred disk failures
> where data was saved by mdadm.
> 
> What is your setup like?  It's also possible that you've found a bug.

We've about 500 systems with raid1, raid5 and raid10 running for about
5 or 6 years (since 0.90 beta patched into 2.2 kernel -- I don't think
linux softraid existed before, or, rather, I can't say that was something
which was possible to use in production).

Most problematic case so far, which I described numerous times (like,
"why linux raid isn't Raid really, why it can be worse than plain disk")
is when, after single sector read failure, md kicks the whole disk off
the array, and when you start resync (after replacing the "bad" drive or
just remapping that bad sector or even doing nothing, as it will be
remapped in almost all cases during write, on real drives anyway),
you find another "bad sector" on another drive.  After this, the array
can't be started anymore, at least not w/o --force (ie, requires some
user intervention, which is sometimes quite difficult if the server
is several 100s miles away).  More, it's quite difficult to recover
it even manually (after --force'ing it to start), without fixing that
bad sector somehow -- if first drive failure is "recent enouth" we've
a hope that this very sector can be read from that first drive. if
the alot of filesystem activity happened since that time, that chances
are quite small; and with raid5 it's quite difficult to say where the
error is in the filesystem, due to the complex layout of raid5.

But this has been described here numerous times, and - hopefully -
with current changes (re-writing of bad blocks) this very issue will
go away, at least most common scenario of it (i'd try to keep even
"bad" drive, even after some write errors, because it still contains
some data which can be read; but that's problematic to say the best
because one has to store a list of bad blocks somewhere...).

(And no, I don't have all bad/cheap drives - it's just when you have
hundreds or 1000s of drives, you've quite high probability that some
of them will fail sometimes, or will develop a bad sector etc).

>>I saw all sorts of failures due to
>>linux softraid already (we use it here alot), including ones
>>which required complete array rebuild with heavy data loss.
> 
> Are you sure?  The one thing that's not always intuitive about MD - a
> faild array often still has your data and you can recover it.  Unlike
> hardware RAID solutions, you have a lot of control over how the disks
> are assembled and used - this can be a major advantage.
> 
> I'd say once a week someone comes on the linux-raid list and says "Oh no!
> I accidently ruined my RAID array!".  Neil almost always responds "Well,
> don't do that!  But since you did, this might help...".

I know that.  And I've quite some expirience too, and I studied mdadm
source.

There was in fact two cases like that, not one.

First was mostly due to operator error, or lack of better choice at
2.2 (or early 2.4) times -- I relied on raid autodetection (which I
don't do anymore, and strongly suggest others to switch to mdassemble
or something like that) -- a drive failed (for real, not bad blocks)
and needed to be replaced, and I forgot to clear the partition table
on the replacement drive (which was in our testing box) - in a result,
kernel assembled a raid5 out of components which belonged to different
arrays..  I only vaguely remember what it was at that time -- maybe
kernel or I started reconstruction (not noticiyng the wrong array),
or i mounted the filesystem - can't say anymore for sure, but the
result was that I wasn't able to restore the filesystem, because i
didn't have that filesystem anymore.  (it should have been assembling
boot raid1 array but assembled a degraided raid5 instead)

And second case was when, after an attempt to resync the array (after
that famous 'bad block kicked off the whole disk) which resulted in an
OOPS (which I didn't notice immediately, but it continued the resync),
it wrote some garbage all over, resulting in badly broken filesystem,
and somewhat broken nearby partition too (which I was able to recover).
It was at about 2.4.19 or so, and I had that situation only once.
Granted, I can't blame raid code for all this, because I don't even
know what was in the oops (machine locked hard but someone who was
near the server noticied it OOPSed) - it sure may be a bug somewhere
else.

As a sort of conclusion.

There are several features that can be implemented in linux softraid
code to make it real Raid, with data safety goal.  One example is to
be able to replace a "to-be-failed" drive (think SMART failure
predictions for example) without removing it from the array with a
(hot)spare (or just a replacement) -- by adding the new drive to the
array *first*, and removing the to-be-replaced one only after new is
fully synced.  Another example is to implement some NVRAM-like storage
for metadata (this will require the necessary hardware as well, like
eg a flash card -- I dunno how safe it can be).  And so on.

The current MD code is "almost here", almost real.  It still has some
(maybe minor) problems, it still lacks some (again maybe minor) features
wrt data safety.  Ie, it still can fail, but it's almost here.

While current development is going to implement some new and non-trivial
features which are of little use in real life.  Face it: yes it's good
when you're able to reshape your array online keeping servicing your
users, but i'd go for even 12 hours downtime if i know my data is safe,
instead of unknown downtime after I realize the reshape failed for some
reason and I dont have my data anymore.  And yes it's very rarely used
(which adds to the problem - rarely used code paths with bugs with stays
unfound for alot of time, and bite you at a very unexpected moment, when
you think it's all ok...)

Well, not all is that bad really.  I really apprecate Neil's work, it's
all his baby after all, and I owe him alot of stuff because of all our
machines which, due to raid code, are running fine (most of them anyway).
I had a hopefully small question, whenever the new features are really
useful, and just described my point of view to the topic.. And answered
your, Ross, questions as well.. ;)

Thank you.

/mjt
