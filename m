Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130168AbRAKR4l>; Thu, 11 Jan 2001 12:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRAKR4c>; Thu, 11 Jan 2001 12:56:32 -0500
Received: from hermes.mixx.net ([212.84.196.2]:60423 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130168AbRAKR41>;
	Thu, 11 Jan 2001 12:56:27 -0500
Message-ID: <3A5DF312.35FB8EAB@innominate.de>
Date: Thu, 11 Jan 2001 18:53:22 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
In-Reply-To: <200101111639.KAA72525@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> 
> Daniel Phillips <phillips@innominate.de>:
> > Jamie Lokier wrote:
> > >
> > > Daniel Phillips wrote:
> > > >         DN_OPEN       A file in the directory was opened
> > > >
> > > > You open the top level directory and register for events.  When somebody
> > > > opens a subdirectory of the top level directory, you receive
> > > > notification and register for events on the subdirectory, and so on,
> > > > down to the file that is actually modified.
> > >
> > > If it worked, and I'm not sure the timing would be reliable enough, the
> > > daemon would only have to have open every directory being accessed by
> > > every program in the system.  Hmm.  Seems like overkill when you're only
> > > interested in files that are being modified.
> >
> > It gets to close some too.  Normally just the directories in the path to
> > the file(s) being modified would be open.
> >
> > Good point about the timing.  A directory should not disappear before an
> > in-flight notification has been serviced.  I doubt the current scheme
> > enforces this.  There is no more room for 'works most of the time' in
> > this than there is in our memory page handling.
> >
> > > It would be much, much more reliable to do a walk over d_parent in
> > > dnotify.c.  Your idea is a nice way to flag kernel dentries such that
> > > you don't do d_parent walks unnecessarily.
> >
> > It's bottom-up vs top-down.  It's worth analyzing the top-down approach
> > a little more, it does solve a lot of problems (and creates some as you
> > pointed out, or at least makes some existing problems more obvious).
> > For make it's really quite nice.  The make daemon only needs to register
> > in the top level directory of the source tree.  I think this solves the
> > hard link problem too, because each path that's interested in
> > notification will receive it.
> 
> It makes security checks impossible though. You would have to reboot
> the system every time a directory changes permission to block unauthorized
> monitoring of files that are no longer accessable by the user.

Heh.  *No reboots*.  At worst you would have to kill, but I don't see
what is impossible about this.  It's not worse than the current
situation, which is just to check permissions on open and trust they
don't change.  That is not a reason to give up and accept the status
quo:

In a separate thread (Re: Subtle MM bug) "Albert D. Cahalan" wrote:
> 
> Credentials could be changed on syscall exit. It is a bit like
> doing signals I think, with less overhead than making userspace
> muck around with signal handlers and synchronization crud.

IOW, I don't think this notification method makes things worse for
security.  In fact, it could have important benefits for security.  How
about a security daemon that gets notified every time a file is changed
and sounds alarms when it doesn't make sense?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
