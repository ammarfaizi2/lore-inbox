Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279950AbRKNB1z>; Tue, 13 Nov 2001 20:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279951AbRKNB1p>; Tue, 13 Nov 2001 20:27:45 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:46066 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S279950AbRKNB1Y>; Tue, 13 Nov 2001 20:27:24 -0500
Date: Tue, 13 Nov 2001 20:27:17 -0500
From: Ben Collins <bcollins@debian.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Differences between 2.2.x and 2.4.x initrd
Message-ID: <20011113202717.P329@visi.net>
In-Reply-To: <20011113150317.G329@visi.net> <E163kVM-0005Rf-00@gondolin.me.apana.org.au> <20011113163443.I329@visi.net> <3BF1A359.296F7AE2@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF1A359.296F7AE2@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 05:48:57PM -0500, Jeff Garzik wrote:
> Ben Collins wrote:
> > 
> > On Wed, Nov 14, 2001 at 07:50:00AM +1100, Herbert Xu wrote:
> > > Ben Collins <bcollins@debian.org> wrote:
> > >
> > > > Well, the point being that 2.2.x worked implicitly, and 2.4.x doesn't. I
> > > > don't want to have to tell people who have been using tilo forever and a
> > > > day that they now have to add additional command line to get it to work
> > > > with 2.4.x.
> > >
> > > You don't have to.  Just setup linuxrc to echo the right stuff into
> > > /proc/sys/kernel/real-root-dev
> > 
> > Yeah, which is listed under the "Obsolete" section in
> > Documentation/initrd.txt. The assumption I'm making here is that if
> > /linuxrc fails to execute, it falls back to /sbin/init on the currently
> > mounted root filesystem. Assumptions are bad, but I don't see why it
> > can't work like this. If there is a filesystem already mounted, it
> > should be used.
> 
> Really?  I always thought the standard behavior of initrd was "umount
> ramdisk unless" not "umount ramdisk if", implying you need to do
> something special (like root=/dev/ram) to keep the initrd around.

That's if /linuxrc remains the initial process (which should in turn
exec /sbin/init, atleast according to my reading of the same document):

	When finished with its duties, linuxrc typically changes the
	root device and proceeds with starting the Linux system on the
	"real" root device.

After it changes root (pivot_root):

	Now, the initrd can be unmounted and the memory allocated by the
	RAM disk can be freed:

	# umount /initrd
	# blockdev --flushbufs /dev/ram0    # /dev/rd/0 if using devfs

Then there's this note:

	Note: if linuxrc or any program exec'ed from it terminates for
	some reason, the old change_root mechanism is invoked (see
	section "Obsolete root change mechanism").

The old mechanism is described as using /proc/sys/kernel/real-root-dev,
rdev or root= mechanisms.

Now, on 2.2, if any of those were empty (which is the case), it just
used the already mounted filesystem (the ramdisk). In 2.4 it assumes
that if initrd is enabled, and the root device string is empty, then
/dev/fd is the default device. Why this is done, I'm not sure.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
