Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTEZOuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTEZOuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:50:08 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:63908 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264397AbTEZOuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:50:05 -0400
Date: Mon, 26 May 2003 10:10:03 -0400
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [2.5 patch] Change strlcpy and strlcat
Message-ID: <20030526141003.GS2657@phunnypharm.org>
References: <20030525112150.3994df9b.l.s.r@web.de> <3ED0FC58.D1F04381@gmx.de> <20030525210509.09429aaa.l.s.r@web.de> <1053911585.367899@palladium.transmeta.com> <20030526132955.GC9104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526132955.GC9104@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   if (strlcpy(dest, src, sizeof(dest)) >= sizeof(dest))
>       goto toolong;
> 
> If strlcpy would return 0 for successful copies this would simplify to
> 
>   if (!strlcpy(dest, src, sizeof(dest)))
>       goto toolong;

Part of the idea behind strlcpy was to explicity return the sizeof of
the result. Read the papers on the function itself.  The idea is that a
lot of callers will usually do strlen() after calling strncpy.

Now, I'll be honest, I don't remember seeing one single usage of strncpy
that was able to use the return of strlcpy. In fact, a few places that
could have, shouldn't have since the value returned didn't translate to
what the actual size of the string was. For example, you could not do:

	len = strlcpy(dest, myLongString, sizeof(dest));
	copy_to_user((void *)arg, dest, len);

If truncation occured, len would be the length it should have been, and
not what it really was.

Also, 99% of the users didn't care about truncation either because it
was known that it should never happen (e.g. netdevice names) or because
truncation didn't cause any problems (e.g. informational strings). The
use of strlcpy here was merely as a way to keep the kernel from choking
on itself in the event of something really stupid happening (it's a lot
easier to see a broken string than to trace overwriting random memory
from a strcpy gone long).

So your return value is as useless as the current return value. But I
think changing our strlcpy to mismatch *BSD would be even worse than
what is there now.

What might be nice is a function that has two bits of info. a) Truncation,
and b) The actual length of the resulting string. Maybe something like:

int strxcpy(char *dest, const char *src, size_t size, size_t *result)
{
	size_t src_size = strlen(src);
	size_t len = 0;

	if (size) {
		len = (src_size >= size) ? size - 1 : src_size;
		memcpy(dest, src, len);
		dest[len] = '\0';
		if (result)
			*result = len;
	}

	if (result)
		*result = len;

	return src_size >= size;
}

So the return value is zero for success and non-zero for truncation. In
addition, if *result is non-NULL, the actual length of the result is set
in that variable. The above example could then be:

	size_t len;
	strxcpy(dest, myLongString, sizeof(dest), &len);
        copy_to_user((void *)arg, dest, len);

IMO, this would only be for a few users, which is < 5% from what I can
see. One place where I saw this might be useful is in the usb-sound
driver where it creates an information string based on local info from
the device firmware and from the USB structures, depending on whether
the data was available in one place or both. It was complex, and the
result size would have been very useful (instead I had to write it to
use strlen in between strlcpy calls). Again, that's _one_ place out of
hundreds.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
