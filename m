Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbTCDBvo>; Mon, 3 Mar 2003 20:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268986AbTCDBvo>; Mon, 3 Mar 2003 20:51:44 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:2065 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S268963AbTCDBvl>; Mon, 3 Mar 2003 20:51:41 -0500
Date: Mon, 3 Mar 2003 18:02:03 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030304020203.GD7329@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk> <20030303010409.GA3206@pegasys.ws> <3E634916.6AE643EB@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E634916.6AE643EB@daimi.au.dk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 01:22:46PM +0100, Kasper Dupont wrote:
> jw schultz wrote:
> > 
> > On Sun, Mar 02, 2003 at 03:16:21PM +0100, Kasper Dupont wrote:
> > > And we should rather aim for an implementation
> > > in /proc and have mount write there directly. But there are a few
> > > open questions I'd like answered before trying to implement a
> > > /proc/mtab.
> > 
> > You are talking about adding hacks to workaround the
> > original hack.  Nothing should write to mtab.  Say it with
> > me "Nothing should write to mtab".
> 
> You obviously haven't read all I have written. There is nothing
> I'd like more than an implementation where the kernel could
> always provide the correct information, and mount would never
> have to store it anywhere else. However I don't know if that is
> possible, and until somebody proves it possible, we will need
> mtab.

I had read all you wrote in this thread.  I'll grant that i
might have missed what you wrote elsewhere or perhaps what you
implied.

> There are three groups of options:
> - VFS options
> - Filesystem options
> - Userspace options
> 
> The VFS options are given to the mount system call in a bitmask,
> and they are available through the /proc/mounts pseudo file.
> 
> The filesystem options are more complicated. They are given to
> mount in the data argument. When the filesystem is first mounted
> it would be trivial to save the string and provide it in
> /proc/mounts (or /proc/mtab). But if the filesystem is later
> remounted with a different set of options, it is nontrivial to
> know in general which parts should be taken from the old string,
> and which parts should be taken from the new strings. Even some
> of the filesystems have gotten this wrong and would read
> uninitialized variables if a remount did not specify every single
> possible option.
> 
> Finally the userspace options are used by mount itself. One example
> is in the case of a user option being specified in /etc/fstab,
> mount will store the name of the user calling mount in /etc/mtab.
> I don't know if that kind of options are also given in the data
> argument, but they have no business in the kernel, they are only
> used by a feature implemented in userspace. But since they are
> related to a mount point, it would be nice to have the kernel
> delete them once the mountpoint is unmounted.

OK.  I was less that certain that there weren't options that
couldn't be listed in data or flags.  It makes sense that
there would be.

> As long as these options is not yet stored in the kernel, we
> need /etc/mtab. The question is how to get them into the kernel.
> One possibility would be that mount could open /proc/mtab for
> writing and write a single line in the usual format. Otherwise
> we could extent mount with another string argument, or we could
> put them into the data argument, where they really don't belong.
> 
> Since you seem to have some opinions on how this should be done,
> I'd like to know how *you* would store those options.

Writing to /proc/mtab like we do /etc/mtab means allowing
full file read,write,truncate,seek functionality on a
multi-page tlob just to emulate current behavior and support
a second data source with a disconnect from the kernel.

[description of problems with /etc/mtab, kernel disconnect]

> Before we can get rid of /etc/mtab we need to agree on how
> to solve those problems. There might be other cases I don't
> know about, where /etc/mtab contains special values.
> 
> The remaining fields is AFAIK no problem, the current
> /proc/mounts implementation get them right. The target
> field in /proc/mounts did get fixed with 2.4, and the
> filesystem field also contains the right value. In the case
> of bind mounts /etc/mtab will contain none in the filesystem
> field, but I consider that to be a bug and /proc/mounts to
> be correct. And finally the last two fields always contain
> 0, and only exist to keep the format identical with /etc/fstab.
> 
> > 
> > mount(8) and umount(8) are the only almost the only things that
> > write mtab all others are readers.
> 
> What are you saying? Are they the only writers, or are there
> other writers? IIRC smbmount will write /etc/mtab on its own.

Hence the qualifier.  My point is that the list of things
that call mount(2) directly and write to /etc/mtab is small
and the most critical of them are linux specific.  This
gives us a degree of freedom in our approach.

> > I may be wrong but the
> > data argument to mount(2) looks like it should support
> > everything missing from /proc/mounts.
> 
> I don't think it has everything.

OK.  So it doesn't

> > Alternatively change
> > mount(2) and mount(8) and any other mount(2) callers will
> > be revealed.
> 
> Sounds like a good idea on a long term. Probably it should
> be possible to get warnings from the kernel like it has been
> done with other obsolete interfaces.
> 
> > 
> > The reason to leave a /etc/mtab symlink is so that the
> > old tools other than (u)mount don't need updates.
> 
> On a long term I agree with that. But first we need a
> replacement for /etc/mtab. I have come with some suggestions,
> but there are still a few blanks to fill in.

What i would lean towards, assuming that data couldn't list
all options not supported by mountflags would be to add a
char *userdata or useropts argument.  That would be attached
to struct vfsmount.  Userdata would be what /proc/mtab or
whatever reported, either as the option list or the whole
line.

To detect the old interface users a NULL userdata or (as
alternatives) a missing MS_USERDATA flag or calling the old
mount syscall would cause a warning that identifies the
offending process.  For the short term either construct a
fake userdata or mtab could fallback to what /proc/mounts
does when it hits NULL.  Long term might be to fail mount(2)
on such an error.

I think our goals are the same.  The only reason i chimed in
on this discussion was to remind people that /etc/mtab was a
hack we no longer really need and then because it sounded
like what was being proposed was to emulate that
obsolescence with another layer of cruft.  Emulating the
read behavior is good.  A link in /etc is needed to
accommodate the numerous utilities that read /etc/mtab.  It
is emulating the write behavior, or persisting in preserving
the disconnected file, that makes me a bit uncomfortable.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
