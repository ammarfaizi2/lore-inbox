Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTK1Ak1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 19:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTK1Ak1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 19:40:27 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:7689 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261758AbTK1AkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 19:40:25 -0500
Date: Fri, 28 Nov 2003 09:40:22 +0900 (JST)
Message-Id: <20031128.094022.106776635.yoshfuji@linux-ipv6.org>
To: felipe_alfaro@linuxmail.org
Cc: rmk+lkml@arm.linux.org.uk, davem@redhat.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031128.092642.47232575.yoshfuji@linux-ipv6.org>
References: <1069974209.5349.7.camel@teapot.felipe-alfaro.com>
	<20031128.092326.39861126.yoshfuji@linux-ipv6.org>
	<20031128.092642.47232575.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031128.092642.47232575.yoshfuji@linux-ipv6.org> (at Fri, 28 Nov 2003 09:26:42 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> >  3)   if (len)
> >          strncpy(dst, src, len - 1);
> >       dst[len] = 0;

grr, another mistake...:

          if (len) {
             strncpy(dst, src, len - 1);
             dst[len - 1];
          }

----------------
1) use strlcpy0(dst, src, len)

size_t strlcpy0(char *dst, const char *src, size_t maxlen)
{
  size_t len = strlcpy(dst, src, maxlen);
  if (likely(maxlen != 0) && len < maxlen - 1)
    memset(dst + len + 1, 0, maxlen - len - 1);
}

2a) use strncpy0(dst, src, len)

char *strncpy0(char *dst, const char *src, size_t maxlen)
{
  memset(dst, 0, maxlen);
  if (likely(maxlen != 0))
    strncpy(dst, src, maxlen - 1);
}

2b) fix strncpy() to zero-out rest of destination buffer 
    and use strncpy0(dst, src, len)

char *strncpy0(char *dst, const char *src, size_t maxlen)
{
  if (likely(maxlen != 0)) {
    strncpy(dst, src, maxlen - 1);
    dst[maxlen - 1] = 0;
  }
}


I prefer 1 > 2b >> 2a.

--yoshfuji
