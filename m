Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUBTU0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUBTUX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:23:29 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:5046 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261305AbUBTUTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:19:10 -0500
X-Mailer: exmh version 2.5+CL 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: haible@ilog.fr (Bruno Haible), Andries.Brouwer@cwi.nl (Andries Brouwer)
Subject: Re: stty utf8
X-URL: http://www.cl.cam.ac.uk/~mgk25/
X-image-url: http://www.cl.cam.ac.uk/~mgk25/markus2-48.jpg
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Feb 2004 20:19:02 +0000
From: Markus Kuhn <Markus.Kuhn@cl.cam.ac.uk>
Message-Id: <E1AuH76-0004hY-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries reposted on 17 February a UTF-8 mode patch, prepared 5 years ago
by Bruno Haible, to add a new bit to struct termios that switches the
backspace behaviour in cooked mode between what is needed for a
single-byte character set and UTF-8.

This is a change in the API that might warrant a bit more discussion,
because code that uses that bit will have to be added to numerous
applications. In fact, Bruno's patch came originally with various
application patches such as

  ftp://ftp.ilog.fr/pub/Users/haible/utf8/stty.diff
  ftp://ftp.ilog.fr/pub/Users/haible/utf8/telnet.diff
  ftp://ftp.ilog.fr/pub/Users/haible/utf8/xterm.diff
  ftp://ftp.ilog.fr/pub/Users/haible/utf8/xterm2.diff

and numerous other applications will need to set that bit as well.

I would like to suggest that we could alternatively add a 2-bit field to
struct termios that allows us to switch between four modes for how to
execute the ERASE function in ICANON mode:

  0    auto-detect
  1    single-byte encoding (ISO 8859-*, KOI*, etc.)
  2    UTF-8
  3    EUC (AT&T's Extended Unix Code, what East Asia used before UTF-8)

Values 1 and 2 are just what Bruno's patch offers.

The autodetection mode (0) would assume, by default, for each line that
the encoding used is UTF-8, until it encounters a malformed UTF-8
sequence. In that case, it will switch to single-byte mode, for that
single line only.

Background: UTF-8 has the very useful property that ISO 8859-* strings
with non-ASCII characters contain with very high probability (>> 99%)
byte sequences that are not valid UTF-8. In particular, any string with
a single non-ASCII byte surrounded by two ASCII bytes can never be
mistaken for UTF-8. A tested simple (public domain) function to scan
whether a string is correct UTF-8 is now available at

  http://www.cl.cam.ac.uk/~mgk25/ucs/utf8_check.c

I would suggest that, by default, the Linux tty driver should run in
this UTF-8 auto-detection mode. Applications (and users via "stty utf8")
can still decide to hardwire ERASE to a fixed encoding, but the
auto-detection mode will make sure that for all the applications for
which we forget to set the bits correctly, backspace will still work
correctly almost always.

(I perfectly understand that auto-detection can be a potential source of
problems, but in this context, it seems the lesser evil. Backspace is
used only during manual text entry, which is rather error prone anyway.
I would argue that the remaining error rate is far less evil than not
having auto-detection and therefore many people using the wrong setting
all the time.)

There are already a number of applications out there ("talk" for
instance), where UTF-8 was added by auto-detection, as the protocol
provides no way of negotiation character sets. And it works rather well.

Executive summary: Dedicate two bits instead of just one in struct
termios to signal what backspace needs to know about the encoding.

Markus

-- 
Markus Kuhn, Computer Laboratory, University of Cambridge
http://www.cl.cam.ac.uk/~mgk25/ || CB3 0FD, Great Britain

