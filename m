Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbQLZVW3>; Tue, 26 Dec 2000 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132003AbQLZVWT>; Tue, 26 Dec 2000 16:22:19 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:27919 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S131985AbQLZVWH>; Tue, 26 Dec 2000 16:22:07 -0500
Message-ID: <3A4904CA.EA1062AF@dm.ultramaster.com>
Date: Tue, 26 Dec 2000 15:51:22 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom changes in test13-pre2 slow down cdrom access by 70%
In-Reply-To: <3A43D48D.B1825354@dm.ultramaster.com> <20001223133737.D300@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Fri, Dec 22 2000, David Mansfield wrote:
> > Jens,
> >
> > The cdrom changes that went into test13-pre2 really kill the performance
> > of my cdrom.  I'm using cdparanoia to read audio data, and it normally
> > reads at 2-3x.  Since test13-pre2 it's  down to .6 - .7x.  I've reverted
> > the following files to the ones from test13-pre1 and it's back to
> > normal:
> 
> Humm, interesting.
> 
> > This is a huge patch, is there some way I could break it apart to see
> > what the relevant changes are?
> 
> The change affecting you is most likely the CDROMREADAUDIO change,
> where we now just read a single cdda frame at the time. This gives
> us less data per interrupt, and apparently this is more than a
> theoretical slowdown for you. Please try with attached patch. If
> this solves it (as it should), then we should probably try and do
> persistent allocation of a bigger buffer for things like this.
> Grabbing > 1 frame was disabled because multi-page allocation is not
> reliable.
> 
> --- drivers/cdrom/cdrom.c~      Sat Dec 23 13:27:33 2000
> +++ drivers/cdrom/cdrom.c       Sat Dec 23 13:30:39 2000
> @@ -1985,7 +1985,7 @@
>                 }
>         case CDROMREADAUDIO: {
>                 struct cdrom_read_audio ra;
> -               int lba;
> +               int lba, frames;
> 
>                 IOCTL_IN(arg, struct cdrom_read_audio, ra);
> 
> @@ -2002,7 +2002,9 @@
>                 if (lba < 0 || ra.nframes <= 0)
>                         return -EINVAL;
> 
> -               if ((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW, GFP_KERNEL)) == NULL)
> +               frames = ra.nframes > 8 ? 8 : ra.nframes;
> +
> +               if ((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW * frames, GFP_KERNEL)) == NULL)
>                         return -ENOMEM;
> 
>                 if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
> @@ -2011,12 +2013,14 @@
>                 }
>                 cgc.data_direction = CGC_DATA_READ;
>                 while (ra.nframes > 0) {
> -                       ret = cdrom_read_block(cdi, &cgc, lba, 1, 1, CD_FRAMESIZE_RAW);
> -                       if (ret) break;
> -                       __copy_to_user(ra.buf, cgc.buffer, CD_FRAMESIZE_RAW);
> -                       ra.buf += CD_FRAMESIZE_RAW;
> -                       ra.nframes--;
> -                       lba++;
> +                       ret = cdrom_read_block(cdi, &cgc, lba, frames, 1, CD_FRAMESIZE_RAW);
> +                       if (ret)
> +                               break;
> +                       __copy_to_user(ra.buf, cgc.buffer,
> +                                      CD_FRAMESIZE_RAW * frames);
> +                       ra.buf += (CD_FRAMESIZE_RAW * frames);
> +                       ra.nframes -= frames;
> +                       lba += frames;
>                 }
>                 kfree(cgc.buffer);
>                 return ret;
> 

Yes.  test13-pre4 + the above patch is back to normal speed.  I had
spotted that too as a likely candidate, especially because when the
accesses were slow, the light on the cdrom was blinking at a much higher
rate than before (I suppose it was processing 8x the number of commands,
right?).

Anyway, do you think a 'try to allocate 8, if that fails, try to
allocate 1' solution would be a simple compromise?  That should be easy
to do, based on the above code (if kmalloc returns NULL && frames > 1,
frames = 1, retry...).

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
