Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbTLFT3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbTLFT3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:29:24 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:30945 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S265231AbTLFT3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:29:21 -0500
Date: Sat, 6 Dec 2003 20:29:19 +0100
From: Michal Rokos <m.rokos@sh.cvut.cz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test11] VFAT fix for UTF-8 and trailing dots
Message-ID: <20031206192919.GA31981@nightmare.sh.cvut.cz>
References: <20031206085539.GA3134@nightmare.sh.cvut.cz> <87d6b2vt94.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6b2vt94.fsf@devron.myhome.or.jp>
X-Crypto: GnuPG/1.0.6 http://www.gnupg.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 07, 2003 at 12:52:07AM +0900, OGAWA Hirofumi wrote:
> Michal Rokos <m.rokos@sh.cvut.cz> writes:
> 
> > The problem is: even if vfat_striptail_len() counts len of name without
> > trailing dots and sets len to the correct value, utf8_mbstowcs() doesn't
> > care about len and takes whole name.
> > So dirs and files with dots can be created on vfat fs and that will
> > cause some problems as you know :)
> 
> [...]
> 
> >  	if (utf8) {
> > +		int name_len = strlen(name);
> > +
> >  		*outlen = utf8_mbstowcs((wchar_t *)outname, name, PAGE_SIZE);
> > -		if (name[len-1] == '.')
> > -			*outlen-=2;
> > +
> > +		/* 
> > +		 * We stripped '.'s before and set len appropriately,
> > +		 * but utf8_mbstowcs doesn't care about len
> > +		 */
> > +		*outlen -= (name_len-len);
> > +
> >  		op = &outname[*outlen * sizeof(wchar_t)];
> 
> Indeed. However, this looks not right fix. I think utf8_mbstowcs()
> should take the length of both outname and name, so we should fix the
> utf8_mbstowcs().

I don't know... Functions in nls_base.c have specification the same as
those from userspace (defined by ISO/ANSI C or UNIX98).

Probably we should. This was meant as minimal patch.

In case you'll be modifiing nls_base.c, please, decide whether this
shouldn't be in...


--- linux-2.6.0-test11/fs/nls/nls_base.c.old	2003-11-26 21:44:31.000000000 +0100
+++ linux-2.6.0-test11/fs/nls/nls_base.c	2003-12-06 20:09:01.000000000 +0100
@@ -99,6 +99,7 @@ utf8_mbstowcs(wchar_t *pwcs, const __u8 
 			}
 		} else {
 			*op++ = *ip++;
+			n--;
 		}
 	}
 	return (op - pwcs);
> 
> For example, utf8_mbstowcs(outbuf, outlen, inbuf, inlen);
> 

I'd would propose uft8_mbsntowcs(outbuf, outlen, inbuf, inlen);

BR

	Michal

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Michal Rokos                         Czech Technical University, Prague
e-mail: m.rokos@sh.cvut.cz    icq: 36118339     jabber: majkl@jabber.cz
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
