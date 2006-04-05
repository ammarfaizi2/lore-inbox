Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWDEPJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDEPJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDEPJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:09:52 -0400
Received: from mivlgu.ru ([81.18.140.87]:4032 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1750813AbWDEPJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:09:51 -0400
Date: Wed, 5 Apr 2006 19:09:28 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: gregkh@suse.de
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers
 (CVE-2006-1055)
Message-Id: <20060405190928.17b9ba6a.vsu@altlinux.ru>
In-Reply-To: <20060404235947.GD27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
	<20060404235947.GD27049@kroah.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__5_Apr_2006_19_09_28_+0400_F1S3hoOv1lCBuwZ2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__5_Apr_2006_19_09_28_+0400_F1S3hoOv1lCBuwZ2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 4 Apr 2006 16:59:47 -0700 gregkh@suse.de wrote:

> No one should be writing a PAGE_SIZE worth of data to a normal sysfs
> file, so properly terminate the buffer.
> 
> Thanks to Al Viro for pointing out my stupidity here.
> 
> CVE-2006-1055 has been assigned for this.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  fs/sysfs/file.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.16.1.orig/fs/sysfs/file.c
> +++ linux-2.6.16.1/fs/sysfs/file.c
> @@ -183,7 +183,7 @@ fill_write_buffer(struct sysfs_buffer * 
>  		return -ENOMEM;
>  
>  	if (count >= PAGE_SIZE)
> -		count = PAGE_SIZE;
> +		count = PAGE_SIZE - 1;
>  	error = copy_from_user(buffer->page,buf,count);
>  	buffer->needs_read_fill = 1;
>  	return error ? -EFAULT : count;

This will break the "color_map" sysfs file for framebuffers -
drivers/video/fbsysfs.c:store_cmap() expects to get exactly 4096 bytes
for a colormap with 256 entries.  In fact, the original patch which
changed PAGE_SIZE - 1 to PAGE_SIZE:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9d9d27fb651a7c95a46f276bacb4329db47470a6

was done exactly for use with that "color_map" file.

This patch also does not completely guarantee that the buffer will be
null-terminated.  A program may first call read() on the sysfs file,
which will allocate buffer->page and invoke ->show to fill that page;
then subsequent write() on the same file will reuse buffer->page.  To
get really bad results, you need to have ->store which assumes
null-terminated buffer together with ->show which writes to the last
byte of the page (which is probably rare, but show_cmap() does exactly
that).

--Signature=_Wed__5_Apr_2006_19_09_28_+0400_F1S3hoOv1lCBuwZ2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEM92rW82GfkQfsqIRAjJnAJ4kOJ71t0ATW5PaM8RxKBiItdz48ACfdSO5
XCs/gzjuMHyQgMG25/FIaPs=
=hwuC
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Apr_2006_19_09_28_+0400_F1S3hoOv1lCBuwZ2--
