Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTDJXxL (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTDJXxL (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:53:11 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:21913 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263987AbTDJXxH (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:53:07 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Date: Thu, 10 Apr 2003 17:01:48 -0700 (PDT)
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <Pine.LNX.4.44.0304102029430.5042-100000@serv>
Message-ID: <Pine.LNX.4.44.0304101658030.7560-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but the compatability layer can be as simple as having the new kernel
recognise the old major/minor numbers and allocate the 'new' cleaned up
majors in the range that the old numbers don't use.

or it could be that the new major number gets stored in a different spot
on disk and the existing major/minor numbers become the new minor number
with a major number of 0

either way it doesn't break compatability until people choose to use the
new capibilities that they couldn't use otherwise, which is a reasonable
thing to do.

nobody has claimed that MAKEDEV and similar wouldn't need to be changed,
just that changing them is not a major deal, and is far less work then
implementing dynamic numbering.

David Lang

 On Fri, 11 Apr 2003,
Roman Zippel wrote:

> Date: Fri, 11 Apr 2003 01:53:07 +0200 (CEST)
> From: Roman Zippel <zippel@linux-m68k.org>
> To: James Bottomley <James.Bottomley@steeleye.com>
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: 64-bit kdev_t - just for playing
>
> Hi,
>
> On 10 Apr 2003, James Bottomley wrote:
>
> > > If you want to use only a single SCSI major, won't it change the device
> > > numbers?
> >
> > They will collapse down to a single major, yes.  No application should
> > be relying on knowing the device number, though (and if you are trying
> > to argue that they do, you must see that in that scenario dynamic
> > mapping is a total failure).  Once /dev is rebuilt, no-one will know.
> > Depending on whether people still dual boot 2.4 and 2.5, someone may
> > also come up with a compatibility layer, but one is not required.
>
> So we do break compatibility! Wow, it really took quite some time until
> someone confirmed this...
> The problem now is that unfortunately programs do know about the device
> number (e.g. MAKEDEV, scsidev), these programs will be broken and have to
> be "fixed" so that they now have to change their behaviour depending on
> the kernel version.
> This change will make it even more difficult for people to try a new
> kernel. I would say there are more people which use more than 16 disks
> than people who need more than 128 disks, but the former have to pay now
> for the latter?
> OTOH it is possible to keep all device numbers below 0x10000 constant and
> start allocating dynamic device numbers from above 0x10000. This won't
> change anything for the current users and only people who want to go
> beyond the current limits have to update their tools (what they have to do
> in either case).
>
> > > Changes in these area require kernel policy, exactly like dynamic device
> > > numbers. If you want to maintain compatibility, you likely require user
> > > space support, exactly like dynamic device numbers. So why don't we even
> > > consider dynamic device numbers, especially as they have the promise of
> > > the simpler long term solution. The required kernel changes are certainly
> > > not more complex than the patches Andries got merged and still wants to
> > > get merged. If you actually look at the character device patches I posted,
> > > they already allow simple cleanups for 2.6.
> >
> > Ah, OK, this may be the misunderstanding.  Kernel dev_t can be expanded
> > without any change to the current naming policy.  The only change is the
> > numbering in /dev, which is simple.
>
> The current numbering matches the naming, 0x0301 is /dev/hda1, 0x0802 is
> /dev/sda2 and 0x4103 is /dev/sdq3, the proposed patch does change the
> numbering _and_ naming policy.
>
> > > OTOH if you only need a
> > > solution for scsi now, it should be rather simple to expand scsidev.
> > > If you can live with dynamic device names (what scsi currently has), it's
> > > a simple shell script to generate the device nodes.
> >
> > But, as I've said before, not simpler than expanding kernel dev_t.
>
> This may be true in the kernel, but you move all the compatibility
> problems into user space and so we just added another ugly emulation
> layer.
>
> > > If you want to have thousands of disk, you need some kind of user support
> > > anyway, but I get surprisingly little answers, about how people want to
> > > actually manage that much devices? All I hear is "we want them and we
> > > want them now!", this makes it difficult to actually answer the question,
> > > how kernel should support this. In the kernel it's simpler to keep this
> > > dynamic, scsi does that already anyway. How will user space find these
> > > devices? Will it continue to scan thousands of nodes in /dev or will it
> > > just use the information already easily available via sysfs?
> >
> > :-)
> >
> > You take me back a decade to the "thirty two bits is enough for"
> > everybody and "why would an application want more than 640k of memory"
> >
> > Operating systems which impose arbitrary limits on their users, or
> > demand cast iron justification before adding features tend to be at a
> > competitive disadvantage.
>
> Splitting the device number into major and minor is such an arbitrary
> limit as well. If user space wants this it can do so, but it makes no
> sense in the kernel.
>
> > However, if you want an example of how it works today, consider
> > clustering tools:  They have to identify the same piece of shared
> > storage as it gets passed around a cluster.  The way we do it (for a few
> > hundred discs) is to get the SCSI WWN from all the discs (via sg, then
> > map sg<->sd).  Our application policy is to use the WWN to identify the
> > device and a number for the partition.  Other cluster tools use the
> > volume label, still others use the LVM UUID.
> >
> > The point is that none of these applications cares whether the kernel
> > uses dynamic or static, all they need to do is be able to identify all
> > the devices in the system.
>
> You cannot really compare the device number with other disk ids, because
> the device number is a purely local and dynamic number, while the other
> ids are global and static.
>
> > > I know I'm asking a lot of annoying questions,
> >
> > I wouldn't characterise the questions like that.  Not listening to the
> > answers now...
>
> Oh, I do listen, you can be sure of that, but what am I supposed to so,
> when it even takes weeks to get a clear answer about something simple as
> compatibility? When I ask questions, I get evading answers, when I say
> it's broken, I get silence, what else can I do?
>
> > As far as SCSI is concerned, the complete solution has already been
> > presented for the expansion of kernel dev_t, no such complete solution
> > has been presented for dynamic devices.  That constitutes a real
> > advantage to dev_t expansion in my book.
>
> Producing a patch isn't that difficult, but I'd rather be interested, if
> there is even interest in such a patch? I already got not a single comment
> about the last patch.
>
> bye, Roman
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
