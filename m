Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVCIVCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVCIVCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVCIVAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:00:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9964 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262480AbVCIU7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:59:23 -0500
Date: Wed, 9 Mar 2005 13:41:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.30-pre3
Message-ID: <20050309164113.GA16320@logos.cnet>
References: <20050309153900.GF15690@logos.cnet> <1110400799.28860.236.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110400799.28860.236.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 08:40:00PM +0000, Alan Cox wrote:
> >   o Cset exclude: solar@openwall.com|ChangeSet|20041125155150|65356
> >   o Allow lseek on SCSI tapes
> >   o Allow lseek on osst to keep tar --verify happy
> 
> This seems odd since the scsi tape drives don't support lseek and the
> driver changes to correctly block it were part of the security fixes for
> lseek mishandling in 2.6 ? 

Thing is we can't cope with "tar --verify" failing on tapes. Better approach 
to fix this is welcome.

> Does anyone have the straces of tar breaking and the versions ?

Here is the relevant information.


Date: Wed, 2 Mar 2005 23:17:19 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mark Yeatman <myeatman@vale-housing.co.uk>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>, Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29

> On Wed, Mar 02, 2005 at 11:15:42AM -0000, Mark Yeatman wrote:
> > Hi
> > 
> > Never had to log a bug before, hope this is correctly done.
> > 
> > Thanks
> > 
> > Mark
> > 
> > Detail....
> > 
> > [1.] One line summary of the problem:    
> > SCSI tape drive is refusing to rewind after backup to allow verify and
> > causing illegal seek error
> > 
> > [2.] Full description of the problem/report:
> > On backup the tape drive is reporting the following error and failing
> > it's backups.
> > 
> > tar: /dev/st0: Warning: Cannot seek: Illegal seek
> > 
> > I have traced this back to failing at an upgrade of the kernel to 2.4.29
> > on Feb 8th. The backups have not worked since. Replacement Drives have
> > been tried and cables to no avail. I noticed in the the changelog that a
> > patch by Solar Designer to the Scsi tape return code had been made. 

BTW, this "fix" by Solar Designer introduces a bug to 2.4.29: a tape 
driver is supposed to return ENOMEM in the case that was changed to return 
EIO ;-(

> 
> v2.6 also contains the same problem BTW.
> 
> Try this:
> 
> --- a/drivers/scsi/st.c.orig	2005-03-02 09:02:13.637158144 -0300
> +++ b/drivers/scsi/st.c	2005-03-02 09:02:20.208159200 -0300
> @@ -3778,7 +3778,6 @@
>  	read:		st_read,
>  	write:		st_write,
>  	ioctl:		st_ioctl,
> -	llseek:		no_llseek,
>  	open:		st_open,
>  	flush:		st_flush,
>  	release:	st_release,

This change covers up the problem. The real bug is in tar. The following 
code is from tar is supposed to reposition the tape to the beginning of 
the file jus written:

#ifdef MTIOCTOP
  {
    struct mtop operation;
    int status;

    operation.mt_op = MTBSF;
    operation.mt_count = 1;
    if (status = rmtioctl (archive, MTIOCTOP, (char *) &operation), status 
< 0)
      {
        if (errno != EIO
            || (status = rmtioctl (archive, MTIOCTOP, (char *) 
&operation),
                status < 0))
          {
#endif
            if (rmtlseek (archive, (off_t) 0, SEEK_SET) != 0)
              {
                /* Lseek failed.  Try a different method.  */
                seek_warn (archive_name_array[0]);
                return;
              }
#ifdef MTIOCTOP
          }
      }
  }
#endif


Here is output from strace showing what happens with 'tar -c -W' applied 
at the beginning of the tape (this is using kernel 2.6.11-rc4 but the same 
probably happens with 2.4.29):
...
ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 
0x7fffffffecd0) = -1 EIO (Input/output error)
ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 
0x7fffffffecd0) = -1 EIO (Input/output error)
lseek(3, 0, SEEK_SET)                   = -1 ESPIPE (Illegal seek)

So, both tape positioning commands fail and the code falls back to lseek. 
Earlier it has returned success even though it has not done anything (this 
was on purpose because it is the way some other Unices behave and with 
reason). In that case this tar succeeded but it was pure luck. The first 
BSF did position the tape correctly although it did fail.

The 2.6 st driver does contain this near the beginning of st_open():

        nonseekable_open(inode, filp);

This probably makes lseek fail. This code has been in st.c since 2.6.8.




-- 
Kai
