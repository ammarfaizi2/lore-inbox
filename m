Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUGXLi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUGXLi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 07:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUGXLi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 07:38:26 -0400
Received: from gate.firmix.at ([80.109.18.208]:50087 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S268483AbUGXLiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 07:38:23 -0400
Subject: Re: [patch] kernel events layer
From: Bernd Petrovitsch <bernd@firmix.at>
To: Keith Owens <kaos@ocs.com.au>
Cc: Robert Love <rml@ximian.com>, Dan Aloni <da-x@gmx.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4956.1090644161@ocs3.ocs.com.au>
References: <4956.1090644161@ocs3.ocs.com.au>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1090669060.9040.10.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 13:37:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 06:42, Keith Owens wrote:
> On Fri, 23 Jul 2004 22:47:06 -0400, 
> Robert Love <rml@ximian.com> wrote:
> >On Sat, 2004-07-24 at 00:32 +0300, Dan Aloni wrote:
> >
> >> IMHO you either should not assume anything about the length of the object 
> >> string, _or_ do the complete safe string assembly e.g:
> >> 
> >>         len += snprintf(buffer, PAGE_SIZE, "From: %s\nSignal: %s\n", 
> >>                         object, signal);
> >> 
> >
> >Fair enough.  I guess what we want, exactly, is:
> >
> > len = snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
> > len += snprintf(&buffer[len], PAGE_SIZE - len "Signal: %s\n", signal);
> >
> >I will add that to the next revision.
> 
> man snprintf
> 
>   "If the output was truncated due to this limit then the return value
>   is the number of characters (not including the trailing '\0') which
>   would have been written to the final string if enough space had been
>   available. Thus, a return value of size or more means that the output
>   was truncated".
> 
> Never use the return value from snprintf to work out the next buffer
> position, it is not reliable when the data is truncated.  The example
> above uses a second call to snprintf which will generate a warning for
> truncated data and fail safe, but not all code is that trustworthy.  I

The kernel snprintf() is (and the shown warning is actually debatable.
Actually snprintf()s interface is not that optimal for easy handling,
since the size parameter is unsigned and not signed. But it is specified
in SUSv3 that way.).

> always use strlen to get the real buffer length.
> 
>   snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
>   len = strlen(buffer);
>   snprintf(buffer+len, PAGE_SIZE - len, "Signal: %s\n", signal);

Since "overflows" only occur if the destination buffer is full, one
could avoid the following snppritnf()s completely. Let alone the call of
strlen()
----  snip  ----
   len = snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
   if (len < PAGE_SIZE) {
      len += snprintf(buffer+len, PAGE_SIZE - len,
                      "Signal: %s\n", signal);
   }
----  snip  ----

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


