Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWBMPm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWBMPm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWBMPm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:42:56 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:42819 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750768AbWBMPmz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:42:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IrCid2H2HqzFPezU2wyjX3lq3u0msFUknqrG3O4yJmvdT15i/KIlcRMkF4UhGpOB2bJD1EDnMJQgMXlzfiEI62EVwhNstQRR+aICDF61K3j+WHxgB7IEqKZQ9Jxo4vXdTgZlrx6EpCjXASspnD5uY4z5UaDDSxDLyI4qeoAAZzA=
Message-ID: <5a2cf1f60602130742j7df5bbf5y23a9308cd465c732@mail.gmail.com>
Date: Mon, 13 Feb 2006 16:42:52 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, davidsen@tmr.com,
       chris@gnome-de.org, axboe@suse.de
In-Reply-To: <43F0A509.nailKUSY13VFY@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	 <20060125144543.GY4212@suse.de>
	 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	 <20060125153057.GG4212@suse.de> <43ED005F.5060804@tmr.com>
	 <1139615496.10395.36.camel@localhost.localdomain>
	 <43F088AB.nailKUSB18RM0@burner>
	 <5a2cf1f60602130607v5954d1a6qc738dd608aaf9b96@mail.gmail.com>
	 <43F0A509.nailKUSY13VFY@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> > On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > [...]
> > > > > Since -scanbus tells you a
> > > > > device is a CDrecorder, or something else, *any user* is likely to be
> > > > > able to tell it from DCD, CD-ROM, etc. Nice like of text for most devices...
> > > >
> > > > Well, "any user" just opens his Windows Explorer and takes a look at the
> > > > icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
> > > > interesting to see professional programmers often argue that a
> > >
> > > This is not true: a drive letter mapping does not need to exist on MS-WIN
> > > in order to be able to access it via ASPI or SPTI.
> >
> > But from a user perspective, how one is supposed to identify between 2
> > identical burners named D: and E: on their system if cdrecord only
> > provides b,t,l naming and "b,t,l to cd burner name" mapping?
>
> Drive letters do not have real relevence from a OS view if talking about MS-WIN

Most complaints about cdrecord are to try to make it fit with the user
perspective, not the OS one.
Mostly nobody complain about the results of cdrecord job (otherwise it
would have been rewritten). People just complain on its command line
interface.


> > The "OS specific to b,t,l" mapping is clearly lacking although
> > cdrecord knows it there as well. Cf. scsi-wnt.c:
> >
> > #ifdef _DEBUG_SCSIPT
> >         js_fprintf(scgp_errfile,  "SPTI: Adding drive %c: (%d:%d:%d)\n", 'A'+i,
> >                                         pDrive->ha, pDrive->tgt, pDrive->lun);
> > #endif
>
> The is no mapping,

Maybe we disagree on the word "mapping".
Didn't this code print out the mapping between a drive letter and a
b,t,l number ?

> libscg just let's the user use the addressing used inside
> the MS-WIN kernel.
>
> The drive letter related code was contributed by a russion guy who did
> try to find a way to lock a drive in use by cdrecord, preventing
> automount/autoexec. This is unfortunately a bit brain-dead and caused by
> MS-WIN oddities.

Quote from scsi-wnt.c where I took the code extract from:

/*
 * Initialization of SCSI Pass Through Interface code.  Responsible for
 * setting up the array of SCSI devices.  This code will be a little
 * different from the normal code -- it will query each drive letter from
 * C: through Z: to see if it is  a CD.  When we identify a CD, we then
 * send CDB with the INQUIRY command to it -- NT will automagically fill in
 * the PathId, TargetId, and Lun for us.
 */

The code I am pointing at just maps the various OS specific drives to
SCSI b,t,l, like it is done on Linux.

This mapping is done in every single scsi-*.c file I had a look at.

E.g. openserver:

	if (scgp->debug > 0) {
		for (l = 0; l < nlm; l++)
		js_fprintf((FILE *)scgp->errfile,
			"%-4s = %5s(%d,%d,%d,%d) -> %s\n",
			cmtbl[l].typ,
			cmtbl[l].drv,
			cmtbl[l].hba,
			cmtbl[l].bus,
			cmtbl[l].tgt,
			cmtbl[l].lun,
			cmtbl[l].dev);
		js_fprintf((FILE *)scgp->errfile, "-------------------- \n");
	}

So can you make this 'mapping' available to wrapper applications in a
parsable format?

Jerome
