Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUFKWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUFKWsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUFKWsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:48:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:39416 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264382AbUFKWsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:48:07 -0400
To: =?iso-8859-1?Q?Andrew_Morton?= <akpm@osdl.org>
Subject: =?iso-8859-1?Q?Re:_[PATCH]_s390:_speedup_strn{cpy,len}_from_user=2E?=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: =?iso-8859-1?Q?Martin_Schwidefsky?= <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Message-Id: <26879984$108699332440ca33ac7140a7.75829358@config21.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Sat, 12 Jun 2004 00:46:01 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.148
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> schrieb am 12.06.2004, 00:19:18:
> Martin Schwidefsky  wrote:
> >  static inline long
> >  strncpy_from_user(char *dst, const char *src, long count)
> >  {
> >          long res = -EFAULT;
> >          might_sleep();
> > -        if (access_ok(VERIFY_READ, src, 1))
> > -                res = __strncpy_from_user_asm(dst, src, count);
> > +        if (access_ok(VERIFY_READ, src, 1)) {
> > +                res = __strncpy_from_user_asm(count, dst, src);
> > +	}
> >          return res;
> >  }
> 
> Shouldn't the access_ok() check be passed `count', rather than `1'?

No, AFAIU, the logic in strncpy_from_user is that it succeeds for any
string that is limited by either 'count' or a trailing zero or the end
of the user mapping, whichever comes first. This means only one
byte needs to be addressable.

On s390, it doesn't matter anyway because access_ok() is always true,
but the check for access_ok() is the same on all architectures.

       Arnd <><
