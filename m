Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUFTRrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUFTRrq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFTRpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:45:30 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:5901 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265880AbUFTRoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:44:01 -0400
To: Eduard Bloch <edi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: doesn't recognize "iocharset=utf8" and doesn't use
 NLS_DEFAULT
References: <87659mjnps.fsf@devron.myhome.or.jp>
	<20040620160656.GA14769@zombie.inka.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 21 Jun 2004 02:43:18 +0900
In-Reply-To: <20040620160656.GA14769@zombie.inka.de>
Message-ID: <87u0x6i0qx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch <edi@gmx.de> writes:

> > FAT uses the "iocharset=utf8" as default.  But, since "iocharset=utf8"
> > doesn't provide the function (lower <-> upper conversion) which FAT
> > needs, so FAT can't provide suitable behavior.
> 
> I (as user) am completely confused now. I though that "iocharset" was
> the option to convert the (UCS) VFAT names from Unicode (on disk) to some
> limited encoding represented the Unix system (eg. ISO-8859-1) and vice
> versa;

No, iocharset is used for user visible filename.
Is the following enough as example?

                     user
            ^                       |
            |                       |
         <euc-jp>                <euc-jp>
            |                       |
   ------ lookup ---------------- create ------
            |                       |
         <euc-jp>                <euc-jp>
            |                       |
      ["iocharset"]           ["iocharset"]
            |                       |
          <UCS>                   <UCS>
            |                       |
      +-----+-----+            (long name)
      |           |             |        |
["codepage"]      |       ["codepage"]   |
      |           |             |        |
 (8.3 alias) (long name)   (8.3 alias)   |
      ^           ^             |        |
      |           |             V        V
 <shift-jis>    <UCS>     <shift-jis>  <UCS>
 ------------------------------------------
                     disk

> but it was limited to single-byte encodings, so "utf8" switch was
> invented to do direct UCS<->UTF-8 conversion.

No. But multi-byte encodings has some problem on the letter case conversion.

> > Then, this patch does,
> > 
> >      - doesn't recognize "utf8" as "iocharset"
> >      - doesn't use NLS_DEFAULT as default "iocharset"
> 
> Is it possible to extend iocharset to allow UCS<->UTF-8 conversion?
> Wouldn't this make the utf8 switch obsolete?

Yes. But I think that we'll need to rewrite the NLS stuff and some
part of filesystems.

> >      - instead of NLS_DEFAULT, adds FAT_DEFAULT_CODEPAGE and
> >        FAT_DEFAULT_IOCHARSET
> 
> Excuse me, why do you need a special IOCHARSET setting for FAT
> filesystems? Why should it be different from any other filesystems? Are
> there any other filesystems except those from MS that support (widechar)
> Unicode filenames on disk?

NLS_DEFAULT is used by befs, cifs, vfat, isofs, ncpfs, udf.

> > NOTE: the following looks like buggy, so it's not recommended
> > 
> >     "codepage=437,iocharset=iso8859-1,utf8"
> > 
> > however, some utf8 file name can handle. (in this case, it uses the
> > table of iso8859-1 for lower <-> upper conversion)
> 
> What do you man with "lower <-> upper"? The letter case?

Yes. Sorry for my bad English.

> Isn't this a task for the FAT16-names access method?

Yes, but 8.3-alias is stored always even if it's long name.

> > +config FAT_DEFAULT_CODEPAGE
> > +	int "Default codepage for FAT"
> > +	depends on MSDOS_FS || VFAT_FS
> > +	default 437
> > +	help
> > +	  This option should be set to the codepage of your FAT filesystems.
> > +	  It can be overridden with the 'codepage' mount option.
> 
> Should describe explicitely that only the short "MS-DOS" names are meant
> here.

Ok. Any suggestion?

> > +config FAT_DEFAULT_IOCHARSET
> > +	string "Default iocharset for FAT"
> > +	depends on VFAT_FS
> > +	default "iso8859-1"
> > +	help
> > +	  Set this to the default I/O character set you'd like FAT to use.
> 
> What is the "I/O charset"? The description is completely useless for a
> user, it does not explain what is converted and where and why and what
> happens with the data or what is this good for. In contrary, I would
> think that this is the conversion method from a local encoding to equaly
> limited I/O encoding.

Yes, but it's very old, is widely used in linux filesystems.
If it changed, old users may be confused instead.

> > +	  It should probably match the character set that most of your
> > +	  FAT filesystems use, and can be overridded with the 'iocharset'
> > +	  mount option for FAT filesystems.  Note that UTF8 is *not* a
> > +	  supported charset for FAT filesystems.
> 
> UTF-8 is not a charset, it is an encoding. Don't mix things together.

Yes, I'll fix. How about the following?

> > +	  supported encoding for FAT filesystems.

Thanks
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
