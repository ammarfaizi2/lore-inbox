Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284761AbSAGSUs>; Mon, 7 Jan 2002 13:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbSAGSUj>; Mon, 7 Jan 2002 13:20:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13699 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284761AbSAGSUW>; Mon, 7 Jan 2002 13:20:22 -0500
Date: Mon, 7 Jan 2002 13:22:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: lseek() on an iso9660 file
In-Reply-To: <a1cn1j$sev$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.3.95.1020107131256.19774A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2002, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.3.95.1020107091316.18091A-100000@chaos.analogic.com>
> By author:    "Richard B. Johnson" <root@chaos.analogic.com>
> In newsgroup: linux.dev.kernel
> > 
> > Using Linux 2.4.1 I discovered a problem with lseek on CDROM files
> > (iso9660). I just installed 2.4.17 and found the same problem.
> > 
> > The problem:
> > 
> > (1) A portion of the file, existing on a CDROM,  is read and its the
> >     contents are written to an output file on writable media.
> > 
> > (2) The current input file-position is obtained using
> >     pos = lseek(fd, 0, SEEK_CUR); The value returned is exactly
> >     the expected value.
> > 
> > (3) The rest of the CDROM file is read and written to the output file.
> > 
> > (4) The file-position of the CDROM file is then set back to the saved
> >     position using lseek(fd, pos, SEEK_SET); The value returned is
> >     exactly the expected value.
> > 
> > (5) The CDROM file is then read and its contents are observed to be
> >     scrambled in some strange manner in which word-length groups of
> >     bytes from near the end of the file are interleaved with the
> >     correct bytes. Basically, the file ends up being about twice
> >     as long as the original, with every-other two-byte interval
> >     being filled with bytes from near the end of the file.
> > 
> 
> a) How long is the file?

The file is 43,814,956 bytes in length.

> b) What is the offset?

Both 36 and 44 bytes hurt.

> c) What particular iso9660 options (RockRidge, Joliet, zisofs...)
>    does your disk use?

RockRidge attributes created by:

if  ! test $1 ; then
    echo "Usage cp.iso <directory>"
    exit 1
fi
umount /mnt 2>/dev/null
DEV=`cdrecord -scanbus | grep ROM | cut -f2,2`
echo Using CD-ROM device, ${DEV}
echo Trying to erase the media
cdrecord dev=${DEV} blank=fast
echo Starting to write the media 
nice --18 mkisofs -L -l -R $1 | cdrecord -v fs=6m dev=${DEV} speed=4 -eject - 


> d) Mount options?
> 

Just what 'mount' finds:

mount /dev/cdrom /mnt

It gets "fixed" by doing:

mount -o loop /dev/cdrom /mnt

/dev/cdrom is a sym-link to /dev/scd0


> This seems to be a rather serious bug, so I'd like to get to the
> bottom with it.
> 

This showed up when trying to use a "wave-file-copy-truncation" routine
with the source file on a CDROM.

The source-code for these "wave-file" tools is:

	ftp://boneserver.analogic.com/pub/downloads/wave_tools.tar.gz

Broken windows users have to access as:

	ftp:/boneserver.analogic.com/pub/downloads/wave_tools.tar.gz
  or else windows adds ..//ftp/.., a known bug.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


