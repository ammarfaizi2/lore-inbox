Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRAMX1q>; Sat, 13 Jan 2001 18:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRAMX1g>; Sat, 13 Jan 2001 18:27:36 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:46369 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S129704AbRAMX11>; Sat, 13 Jan 2001 18:27:27 -0500
Message-ID: <3A60DA06.936CE1F2@paulbristow.net>
Date: Sat, 13 Jan 2001 23:43:18 +0100
From: Paul Bristow <paul@paulbristow.net>
Organization: http://paulbristow.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: ide-floppy [Fwd: Updated ATAPI FORMAT_UNIT patch.]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear LKML,

Sam & I have been discussing his patch for formatting 1.44MB floppies in
an LS-120 drive, and we decided to move the discussion out in the open. 
One of my concerns is that we don't take the ide-floppy driver in a
different direction to the other removeable media drives.

For Alan Cox, could you back out Sam's patch for now. It will be back
soon.

[Note to Richard Gooch, I haven't forgotten the devfs support]

Sams patches, and the userspace formatting utility are available at
http://www.email-scan.com/idefloppy/floppy-0.03.tar.gz

Comments, suggestions etc would be welcome.

This is the latest mail from Sam...

Sam Varshavchik wrote:
> 
> On Fri, 12 Jan 2001, Paul Bristow wrote:
> 
> > > There are a couple of things that are new:
> > >
> > > * Ability to open the device even if there's no disk in the drive.  This
> > > is needed by the userspace app to probe the device.  The open path sends a
> > > START UNIT packet to the drive, and it looks like most LS-120 drives
> > > report a sense error if there's no disk present.  After thinking about it,
> > > what I ended up doing is checking if the device is opened with O_EXCL flag
> > > set, if so the open path will ignore a START UNIT failure.  Everything is
> > > still initialized correctly, and I've tested it -- this appears to work
> > > quite well.  I would prefer for the open path to always work without any
> > > monkey business, like you can open /dev/fd even if there's no disk in the
> > > drive.  However, I'm not comfortable with that approach -- I'm pretty sure
> > > lots of stuff in ide and hd drivers depend on open failing if there's no
> > > actual disk present.  I see this approach as the best compromise, since it
> > > only affects the userland format utility, and nothing else.
> >
> > Let's put this suggestion out to the kernel mailing list.  There are
> > lots of other removeable media types out there and users will be
> > terribly confused if they behave differently.
> 
> Ok, but the alternatives are:
> 
> 1) A separate minor device that will open whether or not there's a
> formatted disk in the drive.  I don't like this approach.
> 
> 2) Forget the whole thing.  This means that with some drives you will not
> be able to format completely unformatted floppies, only reformat floppies
> that are already formatted.
> 
> The O_EXCL trick seems the cleanest way to be able to access the device
> when you know what you're doing.  The end result is that there needs to be
> a way to access device with or without formattable media.
> 
> > > * An additional flag bit on the packet structure to suppress logging an
> > > error if the packet fails.  The aforementioned dumb Matsushita drive
> > > returns a sense error in response to IDEFLOPPY_CAPABILITIES_PAGE request.
> > > This packet is only sent by my new code, and although this is not defined
> > > as an optional feature of LS-120 drives, Matsushita does not appear to
> > > implement it.  Something like that normally results in the driver
> > > reporting an I/O error to syslog.  There isn't an actual problem, it's a
> > > spurious error, so I'd rather suppress it instead of having people scream
> > > about I/O errors in syslog.  The new packet flag bit will only be used by
> > > the format code.
> >
> > Hmm, isn't this only useful for debugging, and therefore belongs in
> > IDEFLOPPY_DEBUG instead?
> 
> See below.
> 
> > > * Smarter handling of format progress reporting.  Format progress
> > > reporting is defined as optional in INF-8070.  Something has to be done if
> > > the drive doesn't support it.  After sending FORMAT_UNIT to the drive, if
> > > there's nothing else to be done the device will be closed from userland.
> > > The close path sends an unlock packet to the drive.  However, the drive
> > > has just begun formatting the floppy, and it's going to be busy for a
> > > while.  ide.c will wait for the drive to become available, then give up
> > > and do a bus reset.  No good.
> >
> > Agreed.
> 
> To check whether the device supports format progress reporting you need to
> send a MODE_SENSE packet for the IDEFLOPPY_CAPABILITIES_PAGE.  The deal is
> that IDEFLOPPY_CAPABILITIES_PAGE itself appears to be optional (see last
> paragraph on page 43 of INF-8070).  This explains why this packet is
> rejected by the drive.  As I mentioned before, this error condition
> results in the default error handler reporting an I/O error to syslog,
> unless it's suppressed by that portion of my patch.
> 
> One remote possibility is that I screwed up IDEFLOPPY_CAPABILITIES_PAGE,
> and the drive is rejecting it for that reason.  However, I note that the
> definition of that packet already existed in 0.9, and Gabi's ChangeLog
> mentions that he removed the code for that packet.  I suspect the reason
> was the same -- some drives reject it, causing errors logged to syslog.
> 
> > My suggestion would be that we ask Alan Cox to reverse the patch he
> > applied in ac4 for now, and then put some of these patches up onto the
> > mailing list for comment.  The reason is that I would like to get Clik!
> > support into 2.4.1, and maybe devfs support too.  If you don't mind I
> > will put a pointer to your web page, and describe the work you are doing
> > as experimental for now.
> 
> That's fine.  By the way: I didn't ask Alan to do anything -- he applied
> the patch on his own.
> 
> Also, feel free to simply forward my mail, with the patches, requesting
> folks to comment on it.
> 
> > If we had kernel 2.5 I would add it there without a qualm, but we don't
> > for now, and Linus will be really pissed if we start breaking disks in a
> > "stable" kernel.
> 
> I'm not in any particular hurry.  My primary motivation for doing this
> hack is that I finally got pissed that I couldn't format floppies after
> owning a couple of LS-120 drives for almost two years.  That's all.
> 
> Regarding the Clik drive -- I browsed that code briefly, for a minute or
> two.  You are checking the IDE model ID and selectively turning things off
> that the Clik can't handle.
>
> Suppose that two months from now the Clik drive gets new firmware that
> reports a slightly different model ID, say "IOMEGA Clik! 80 CZ ATAPI".
> Or, perhaps, it's a new model of the Clik drive, that shares the same
> shortcomings.

Yep. Looks extremely possible.  
 
> It will become necessary to patch the detection code to check for the new
> model ID.  That may take another month or two before a new kernel comes
> out, and even longer for the distribution to pick them up.
> 
> I would use ioctls to selectively enable/disable portions of the driver's
> functionality.  A usermode app can grab the model ID using HDIO_GETGEO,
> and configure the driver. Then, I would simply update the usermode app and
> release it.  No need to wait for a kernel rev.

Even better is to add module parameters that can manually enable/disable
features.  I think the driver should solve problems it knows about (like
Clik! drives) automatically.  With more and more non-hackers starting to
use Linux it has to be as friendly as we can make it.  For new drives,
there is then a chance that we can make them work just by adding an
"options ide-floppy=no_lock_mechanism" line to /etc/modules.conf.  If
this isn't possible then it's a new driver/kernel/distro loop anyway.
 
> Of course, I see some stuff needs to be done in driver init code, which
> complicates things, but that's the general idea.



> 
> --
> Sam

Regards, 

-- 

Paul

Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
