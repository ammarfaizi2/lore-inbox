Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274337AbRJJDBb>; Tue, 9 Oct 2001 23:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRJJDBV>; Tue, 9 Oct 2001 23:01:21 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:52544 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S274337AbRJJDBM>; Tue, 9 Oct 2001 23:01:12 -0400
Message-ID: <71714C04806CD51193520090272892178BD6DB@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: adilger@turbolabs.com, rgooch@ras.ucalgary.ca
Cc: torvalds@transmeta.com, alan@redhat.com, Martin.Wilck@Fujitsu-Siemens.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] EFI GUID Partition Tables
Date: Tue, 9 Oct 2001 22:01:35 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard and Andreas, thanks for your feedback.

> You've put the devfs_unregister_slave() inside an #ifdef. Yuk! It
> shouldn't be conditional.

Richard, I'm happy to make this change.

> Would it be possible to put this somewhere else and/or rename it?  It
> appears that GUIDs are really DCE UUIDs (which are used by 
> other things
> like ext2, XFS, MD RAID, etc) so if we are "advertising" 
> UUIDs from the
> kernel, we may as well make it "sensible" for other users.  How about
> "/dev/dis[ck]s/uuid", unless there are other users of UUID 
> identifiers?

Yes, UUIDs and GUIDs are the same thing, fortunately.
I'll have to defer this to the author of this piece of code.  Martin, any
reason why it shouldn't be renamed?  Richard, any preferred name?

> On a side note, I have a user-space library which locates/identifies
> devices by UUID/LABELs as well.  It is likely to become part 
> of e2fsprogs
> and mount as a way to consolidate all of the fs identification code,
> but it could easily to partition identification also (hasn't 
> been possible until now).

This would be great!  How can I help?

> Given that 2.5 will likely push a lot of stuff out to user-space, does
> it make sense to add something to the kernel which could just 
> as easily be done in userspace?

Perhaps.  The basis of this code is already in the 2.4 IA-64 kernel port
patch.  Given that I needed to update it to accomodate the page cache
changes in 2.4.10pre, I thought it was time to pull it out of the IA-64
patch and put it in the mainstream patch.  If it had been mainstream, Al
would have fixed up my code too. :-)   Until 2.5, what's the best approach,
mainstream kernel or IA-64 patch?

> Another question, does GPT support user-defined names/LABELs 
> for partitions?

Yes.  36 efi_char_t (Unicode, really UCS-2, 72 bytes) per partition name
field. :-)  No relying on the file system (e.g. swap doesn't support names).


> If this is going into the kernel, it should first of all just 
> be called
> "uuid_unparse()" to match the equivalent function in user-space, it
> should be exported and not static (maybe put into "lib/" or similar),
> and it is also very useful for it to return "out" so you can 
> use it like
> "Dprintk("UUID is", uuid_unparse(uuid, buf));" and have the 
> whole thing
> disappear if you are not compiling with debugging on (which otherwise
> requires an extra "#ifdef DEBUG" around the uuid_unparse().

Happy to.  I haven't done an extensive grep for other uuid uses in the
kernel (besides knowing they're used for ext2).  If lib/ is a better place
to combine them, I'll do that.


> Have you looked at the DocBook stuff?  It would be desirable (not that
> I'm complaining about ANY documentation, mind you) if the 
> comments were
> in DocBook format (as some parts of the kernel are moving).

No, I haven't looked at DocBook.  I can do that if it's important.


> I take it these are verbose ways of defining a "partition 
> type"?  If this
> is the case (i.e. single GUID defined for RAID/LVM/SWAP) then 
> the whole
> concept of the "U" in GUID = "Unique" is broken, and this 
> format is useless,
> as how could you use it in /proc/guid to point to a single disk?

I prefer to think of it as "partition content type", with a single type for
all normal file systems (ext2, ext3, etc), and different types for different
content uses (LVM, RAID, SWAP should be grouped in with normal file systems,
but for historical reasons isn't).

Each disk and each partition also includes a UniquePartitionGUID which is
what /proc/guid points to, separate from the PartitionTypeGUID.

> How is this different than a "struct partition" in 
> <linux/genhd.h> (aside
> from the fact that "struct partition" should use fixed-sized 
> types because
> it is referring to on-disk data)?

Same thing, but I didn't want to go mucking about with struct partition in
exactly that way, as it's used in a variety of places across the kernel, and
I didn't want this GPT patch to be so invasive.

> Are there not already plenty of crc32 functions in the kernel, or does
> this one have different coefficients?

Yes, in fact I grabbed this one out of the CIPE kernel patch and put it in
lib/ for that reason.  CIPE had it as a table (it needs to be fast as it's
processing network packets at that point), so I wanted to have a single 1KB
array that both use.  There are other crc32 functions in the kernel, but
this happens to be the one that Intel is using in their firmware (despite
what their spec says).


Thanks for the feedback!
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
