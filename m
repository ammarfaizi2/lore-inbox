Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVCBWbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVCBWbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVCBW3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:29:25 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:58533 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262499AbVCBWZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:25:33 -0500
Date: Wed, 2 Mar 2005 17:25:23 -0500
From: "John L. Males" <jlmales@softhome.net>
To: linux-kernel@vger.kernel.org
Cc: jlmales@softhome.net
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
Message-Id: <20050302172523.5eeafe70.jlmales@softhome.net>
Reply-To: jlmales@softhome.net
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.8.2-SrtRecipientSMTPAuthNDateSmartAcctSaveAllOpnNxtMsg (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="=_jive-9830-1109802332-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jive-9830-1109802332-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Marcelo,

My couple cents worth:

> On Wed, Mar 02, 2005 at 11:17:19PM +0200, Kai Makisara wrote:
> > On Wed, 2 Mar 2005, Marcelo Tosatti wrote:
> > 
> > > On Wed, Mar 02, 2005 at 11:15:42AM -0000, Mark Yeatman wrote:
> > > > Hi
> > > > 
> > > > Never had to log a bug before, hope this is correctly done.
> > > > 
> > > > Thanks
> > > > 
> > > > Mark
> > > > 
> > > > Detail....
> > > > 
> > > > [1.] One line summary of the problem:    
> > > > SCSI tape drive is refusing to rewind after backup to allow
> > > > verify and causing illegal seek error
> > > > 
> > > > [2.] Full description of the problem/report:
> > > > On backup the tape drive is reporting the following error and
> > > > failing it's backups.
> > > > 
> > > > tar: /dev/st0: Warning: Cannot seek: Illegal seek
> > > > 
> > > > I have traced this back to failing at an upgrade of the kernel
> > > > to 2.4.29 on Feb 8th. The backups have not worked since.
> > > > Replacement Drives have been tried and cables to no avail. I
> > > > noticed in the the changelog that a patch by Solar Designer to
> > > > the Scsi tape return code had been made. 
> > 
> > BTW, this "fix" by Solar Designer introduces a bug to 2.4.29: a
> > tape driver is supposed to return ENOMEM in the case that was
> > changed to return EIO ;-(
> 
> Reverted.
> 
> > > v2.6 also contains the same problem BTW.
> > > 
> > > Try this:
> > > 
> > > --- a/drivers/scsi/st.c.orig	2005-03-02 09:02:13.637158144 -0300
> > > +++ b/drivers/scsi/st.c	2005-03-02 09:02:20.208159200 -0300
> > > @@ -3778,7 +3778,6 @@
> > >  	read:		st_read,
> > >  	write:		st_write,
> > >  	ioctl:		st_ioctl,
> > > -	llseek:		no_llseek,
> > >  	open:		st_open,
> > >  	flush:		st_flush,
> > >  	release:	st_release,
> > 
> > This change covers up the problem. The real bug is in tar. The
> > following code is from tar is supposed to reposition the tape to
> > the beginning of the file jus written:
> > 
> > #ifdef MTIOCTOP
> >   {
> >     struct mtop operation;
> >     int status;
> > 
> >     operation.mt_op = MTBSF;
> >     operation.mt_count = 1;
> >     if (status = rmtioctl (archive, MTIOCTOP, (char *)
> >     &operation), status 
> > < 0)
> >       {
> >         if (errno != EIO
> >             || (status = rmtioctl (archive, MTIOCTOP, (char *) 
> > &operation),
> >                 status < 0))
> >           {
> > #endif
> >             if (rmtlseek (archive, (off_t) 0, SEEK_SET) != 0)
> >               {
> >                 /* Lseek failed.  Try a different method.  */
> >                 seek_warn (archive_name_array[0]);
> >                 return;
> >               }
> > #ifdef MTIOCTOP
> >           }
> >       }
> >   }
> > #endif
> > 
> > 
> > Here is output from strace showing what happens with 'tar -c -W'
> > applied at the beginning of the tape (this is using kernel
> > 2.6.11-rc4 but the same probably happens with 2.4.29):
> > ...
> > ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 
> > 0x7fffffffecd0) = -1 EIO (Input/output error)
> > ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 
> > 0x7fffffffecd0) = -1 EIO (Input/output error)
> > lseek(3, 0, SEEK_SET)                   = -1 ESPIPE (Illegal seek)
> > 
> > So, both tape positioning commands fail and the code falls back to
> > lseek. Earlier it has returned success even though it has not done
> > anything (this was on purpose because it is the way some other
> > Unices behave and with reason). In that case this tar succeeded
> > but it was pure luck. The first BSF did position the tape
> > correctly although it did fail.
> > 
> > The 2.6 st driver does contain this near the beginning of
> > st_open():
> > 
> >         nonseekable_open(inode, filp);
> > 
> > This probably makes lseek fail. This code has been in st.c since
> > 2.6.8.
> 
> Thanks for the cluebat Kai, is this problem fixed in newer versions
> of tar? 

My testing last week or so has been with the latest tar, tar-1.15.1-2,
tar 1.14 and 1.13 had same lseek --verify issues.

> 
> I suspect v2.4 should work with older versions of tar, so we should
> keep "lseek" working to make it happy. What is your opinion?


I would agree in the lseek sense.  I feel that if there is some bad
behaviour in tar it should be reported to the tar folks to be fixed so
long term things are done correctly and over time the kernel
worarounds can be depreciated.


Regards

John L. Males
Willowdale, Ontario
Canada
02 March 2005 (17:04 -) 17:25


==================================================================


"Boooomer ... Boom Boom, how are you Boom Boom"
"Meoaaaawwwww, meoaaaaaawwww" as Boomer loudly announces
     intent Boomer is coming for attention
Loved to kneed arm and lick arm with Boomers very large
     tongue
Able to catch, or at least hit, almost any object in flight
     withing reach of front paws
Boomer 1985 (Born), Adopted 04 September 1991
04 September 1991 - 08 February 2000 18:50

"How are you Mr. Sylvester?"
"... Grunt Grunt" ... quick licks of nose
Rolls over for pet and stomac rub when Dad arrives home
     and grunting
Runs back and forth from study, tilts head as glowing green
     eyes stare for "attention please", grunts and meows,
     repeats run, tilt head and stare few times for good
     measure, grunts and meows
Lays on floor just outside study to guard Dad
Loved to groom Miss Mahogany, and let Mahogany cuddle beside
Sylvester 1989 (estimated Born)
Found in building mail area noon hour 09 Feburary 1992
09 February 1992 - 19 January 2003 23:25

"Hello Miss Chicago 'White Sox', how are you 'Chico'?"
"Grunt" (thank you) ... as put out food for Chicago
"MEEEEEOOOOWWWW" So loud the world stops
A very determined Miss "White Sox"
AKA "Chico" ... Cheryl Crawford used as nickname
Loved to chase kibble slid down hall floor,
     bat about and then eat
Loved to hook paw in dish to toss out a single kibble
     at time, dart at as moved, then eat ... "Crunches"
Chicago "White Sox", "Chico" August 1989 (born),
     adopted 04 February 1991
05 October 2004 06:52 Quite "Grunts" ....
                      as lay Chicago on bed for last time
04 February 1991 - 05 October 2004 07:32


--=_jive-9830-1109802332-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFCJj1bsrsjS27q9xYRAt41AJ9wP1MMU+oXZ3isvcY779eZvdsmrACeIuT2
uN1ma3S7/uM2ra5zG5sjQ0E=
=/OuC
-----END PGP SIGNATURE-----

--=_jive-9830-1109802332-0001-2--
