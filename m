Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVCBVsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVCBVsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVCBVso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:48:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60842 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262463AbVCBVdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:33:31 -0500
Date: Wed, 2 Mar 2005 13:59:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Mark Yeatman <myeatman@vale-housing.co.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
Message-ID: <20050302165917.GA3235@logos.cnet>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk> <20050302120332.GA27882@logos.cnet> <Pine.LNX.4.61.0503022253360.9132@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503022253360.9132@kai.makisara.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 11:17:19PM +0200, Kai Makisara wrote:
> On Wed, 2 Mar 2005, Marcelo Tosatti wrote:
> 
> > On Wed, Mar 02, 2005 at 11:15:42AM -0000, Mark Yeatman wrote:
> > > Hi
> > > 
> > > Never had to log a bug before, hope this is correctly done.
> > > 
> > > Thanks
> > > 
> > > Mark
> > > 
> > > Detail....
> > > 
> > > [1.] One line summary of the problem:    
> > > SCSI tape drive is refusing to rewind after backup to allow verify and
> > > causing illegal seek error
> > > 
> > > [2.] Full description of the problem/report:
> > > On backup the tape drive is reporting the following error and failing
> > > it's backups.
> > > 
> > > tar: /dev/st0: Warning: Cannot seek: Illegal seek
> > > 
> > > I have traced this back to failing at an upgrade of the kernel to 2.4.29
> > > on Feb 8th. The backups have not worked since. Replacement Drives have
> > > been tried and cables to no avail. I noticed in the the changelog that a
> > > patch by Solar Designer to the Scsi tape return code had been made. 
> 
> BTW, this "fix" by Solar Designer introduces a bug to 2.4.29: a tape 
> driver is supposed to return ENOMEM in the case that was changed to return 
> EIO ;-(

Reverted.

> > v2.6 also contains the same problem BTW.
> > 
> > Try this:
> > 
> > --- a/drivers/scsi/st.c.orig	2005-03-02 09:02:13.637158144 -0300
> > +++ b/drivers/scsi/st.c	2005-03-02 09:02:20.208159200 -0300
> > @@ -3778,7 +3778,6 @@
> >  	read:		st_read,
> >  	write:		st_write,
> >  	ioctl:		st_ioctl,
> > -	llseek:		no_llseek,
> >  	open:		st_open,
> >  	flush:		st_flush,
> >  	release:	st_release,
> 
> This change covers up the problem. The real bug is in tar. The following 
> code is from tar is supposed to reposition the tape to the beginning of 
> the file jus written:
> 
> #ifdef MTIOCTOP
>   {
>     struct mtop operation;
>     int status;
> 
>     operation.mt_op = MTBSF;
>     operation.mt_count = 1;
>     if (status = rmtioctl (archive, MTIOCTOP, (char *) &operation), status 
> < 0)
>       {
>         if (errno != EIO
>             || (status = rmtioctl (archive, MTIOCTOP, (char *) 
> &operation),
>                 status < 0))
>           {
> #endif
>             if (rmtlseek (archive, (off_t) 0, SEEK_SET) != 0)
>               {
>                 /* Lseek failed.  Try a different method.  */
>                 seek_warn (archive_name_array[0]);
>                 return;
>               }
> #ifdef MTIOCTOP
>           }
>       }
>   }
> #endif
> 
> 
> Here is output from strace showing what happens with 'tar -c -W' applied 
> at the beginning of the tape (this is using kernel 2.6.11-rc4 but the same 
> probably happens with 2.4.29):
> ...
> ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 
> 0x7fffffffecd0) = -1 EIO (Input/output error)
> ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 
> 0x7fffffffecd0) = -1 EIO (Input/output error)
> lseek(3, 0, SEEK_SET)                   = -1 ESPIPE (Illegal seek)
> 
> So, both tape positioning commands fail and the code falls back to lseek. 
> Earlier it has returned success even though it has not done anything (this 
> was on purpose because it is the way some other Unices behave and with 
> reason). In that case this tar succeeded but it was pure luck. The first 
> BSF did position the tape correctly although it did fail.
> 
> The 2.6 st driver does contain this near the beginning of st_open():
> 
>         nonseekable_open(inode, filp);
> 
> This probably makes lseek fail. This code has been in st.c since 2.6.8.

Thanks for the cluebat Kai, is this problem fixed in newer versions of tar? 

I suspect v2.4 should work with older versions of tar, so we should keep 
"lseek" working to make it happy. What is your opinion?
