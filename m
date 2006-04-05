Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWDEPa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWDEPa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWDEPa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:30:57 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:5319 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750977AbWDEPa4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:30:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6u3Ps1OX7nMGk5zzg2v/CdIyd+PEf8+6zfo2SY+hx/UaCeDCqqAbB0txM1L51zvHJiKx5SWvbWAsf9uRPEbkWMpbomXuiCxrJaRcU0OnX2ITm2tBLKrtJpEUuhLSwL3Sv3lKefpU0dknf9fY6+NXfAM3nnYJgjc8maZaHqt06g=
Message-ID: <9e4733910604050830x2daf2ec1vd1fe16073b51de8c@mail.gmail.com>
Date: Wed, 5 Apr 2006 11:30:54 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Sergey Vlasov" <vsu@altlinux.ru>
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <20060405190928.17b9ba6a.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060404235634.696852000@quad.kroah.org>
	 <20060404235947.GD27049@kroah.com>
	 <20060405190928.17b9ba6a.vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Sergey Vlasov <vsu@altlinux.ru> wrote:
> On Tue, 4 Apr 2006 16:59:47 -0700 gregkh@suse.de wrote:
>
> > No one should be writing a PAGE_SIZE worth of data to a normal sysfs
> > file, so properly terminate the buffer.
> >
> > Thanks to Al Viro for pointing out my stupidity here.
> >
> > CVE-2006-1055 has been assigned for this.
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >
> > ---
> >  fs/sysfs/file.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-2.6.16.1.orig/fs/sysfs/file.c
> > +++ linux-2.6.16.1/fs/sysfs/file.c
> > @@ -183,7 +183,7 @@ fill_write_buffer(struct sysfs_buffer *
> >               return -ENOMEM;
> >
> >       if (count >= PAGE_SIZE)
> > -             count = PAGE_SIZE;
> > +             count = PAGE_SIZE - 1;
> >       error = copy_from_user(buffer->page,buf,count);
> >       buffer->needs_read_fill = 1;
> >       return error ? -EFAULT : count;
>
> This will break the "color_map" sysfs file for framebuffers -
> drivers/video/fbsysfs.c:store_cmap() expects to get exactly 4096 bytes
> for a colormap with 256 entries.  In fact, the original patch which
> changed PAGE_SIZE - 1 to PAGE_SIZE:
>
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9d9d27fb651a7c95a46f276bacb4329db47470a6
>
> was done exactly for use with that "color_map" file.
>
> This patch also does not completely guarantee that the buffer will be
> null-terminated.  A program may first call read() on the sysfs file,
> which will allocate buffer->page and invoke ->show to fill that page;
> then subsequent write() on the same file will reuse buffer->page.  To
> get really bad results, you need to have ->store which assumes
> null-terminated buffer together with ->show which writes to the last
> byte of the page (which is probably rare, but show_cmap() does exactly
> that).
>

That is correct, that the color_map attribute will break. Color_map is
not in general use outside the Mesa development community.

The whole scheme of using sysfs instead of IOCTLs is not working out
very well for framebuffer. The original idea was to let you control
your framebuffer with simple scripts or from the keyboard. But since
the attributes don't strip \n and blanks, it has made them more
complex to use from the keyboard.

The one attribute per file model doesn't work well when the attributes
need to be changed in a transaction. For example you want to change
your display to 1024x768 16bit color.  As you set the attributes one
at a time the display has to change since there is not guarantee that
you will complete the sequence. The framebuffer sysfs interface breaks
the one attribute per file rule and uses strings for grouped
attributes.

Ultimately I expect framebuffer will switch back to a helper app and
binary IOCTLs. Mainly because the help app can signal begin/end around
a change to a group of attributes.

--
Jon Smirl
jonsmirl@gmail.com
