Return-Path: <linux-kernel-owner+w=401wt.eu-S933568AbWLJVfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933568AbWLJVfZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933640AbWLJVfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:35:25 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:1349 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933568AbWLJVfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:35:24 -0500
Date: Sun, 10 Dec 2006 22:35:19 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strncpy optimalisation? (lib/string.c)
Message-ID: <20061210213518.GD30197@vanheusden.com>
References: <20061210205230.GB30197@vanheusden.com>
	<20061210210614.GD24090@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210210614.GD24090@1wt.eu>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Dec 11 21:32:58 CET 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> > now I wonder isn't this ineffecient when strlen(src) < count? It would
> > then, if I'm correct, iterate count-strlen(src) times doing useless
> > increment/decrement. And since there are aprox. 580 instances in the
> > 2.6.18.2 source, maybe some efficency can be won here.
> > Wouldn't it be better to do:
> >                 if ((*tmp = *src) == 0x00)
> >                         break;
> > So that would be:
> > --- lib/string.c	2006-11-04 02:33:58.000000000 +0100
> > +++ string-new.c	2006-12-10 21:50:05.000000000 +0100
> > @@ -97,8 +97,8 @@
> >  	char *tmp = dest;
> >  
> >  	while (count) {
> > -		if ((*tmp = *src) != 0)
> > -			src++;
> > +		if ((*tmp = *src) == 0x00)
> > +			break;
> >  		tmp++;
> >  		count--;
> >  	}
> While your code is faster, it does not do exactly the same.
> Original code completely pads the destination with zeroes,
> while yours only adds the last zero. Your code does what
> strncpy() is said to do, but maybe there's a particular
> reason for it to behave differently in the kernel (helping
> during debugging, or filling specific structs).
> Just out of curiosity, have you tried to do a general
> benchmark to check if original code eats much CPU ?

My patch was incorrect; it would only repeatingly copy the first
character from the source.
This one (tested in test-code seperate from kernel) works:
diff -uNrBbd lib/string.c string-new.c
--- lib/string.c        2006-11-04 02:33:58.000000000 +0100
+++ string-new.c        2006-12-10 22:34:39.000000000 +0100
@@ -97,9 +97,10 @@
        char *tmp = dest;

        while (count) {
-               if ((*tmp = *src) != 0)
-                       src++;
+               if (unlikely((*tmp = *src) == 0x00))
+                       break;
                tmp++;
+               src++;
                count--;
        }
        return dest;

The improvement in speed depends on the size of the source and
destination. Maybe i did something wrong but it seems that in all cases
the new version is faster.

Test can be found here:
http://www.vanheusden.com/misc/kernel-strncpy-opt-test.c


Signed-off by: Folkert van Heusden <folkert@vanheusden.com>

Folkert van Heusden

-- 
www.vanheusden.com/multitail - win een vlaai van multivlaai! zorg
ervoor dat multitail opgenomen wordt in Fedora Core, AIX, Solaris of
HP/UX en win een vlaai naar keuze
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
