Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVISFLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVISFLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVISFLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:11:06 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:6610 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932286AbVISFLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:11:05 -0400
Message-ID: <432E4865.3000109@v.loewis.de>
Date: Mon, 19 Sep 2005 07:11:01 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts 
References: <4NVHm-3yE-13@gated-at.bofh.it> <4NVHm-3yE-15@gated-at.bofh.it> <4NVHm-3yE-17@gated-at.bofh.it> <4NVHm-3yE-19@gated-at.bofh.it> <4NVHm-3yE-21@gated-at.bofh.it> <4NVHm-3yE-23@gated-at.bofh.it> <4NVHm-3yE-25@gated-at.bofh.it> <4NVHm-3yE-27@gated-at.bofh.it> <4NVHm-3yE-29@gated-at.bofh.it> <4NVHm-3yE-31@gated-at.bofh.it> <4NVHn-3yE-33@gated-at.bofh.it> <4NVHn-3yE-35@gated-at.bofh.it> <4NVHn-3yE-37@gated-at.bofh.it> <4NVHn-3yE-39@gated-at.bofh.it> <4Od1x-3e3-5@gated-at.bofh.it> <4Od1x-3e3-7@gated-at.bofh.it> <4Od1w-3e3-3@gated-at.bofh.it> <4OfZo-7AG-21@gated-at.bofh.it>
In-Reply-To: <4OfZo-7AG-21@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> For the benefit of those of us who are interested in the problem, but aren't
> in the mood to wade through a long standard looking for the answer to a
> specific question, can you elaborate?

See

http://www.unicode.org/faq/utf_bom.html#38

> It isn't as obvious as all that, because of all the nasty corner cases...

It really depends on the specific structure of the text file. For Python
scripts, the Python interpreter will reject a U+FEFF in the middle of
the file as a syntax error (*). This is, IMO, a reasonable reaction: you
just shouldn't concatenate Python scripts blindly. They may have
different source encodings, so any concatenation of Python scripts
needs to convert them both into a common encoding. The first script
may also fail to terminate with a newline, so concatenating Python
scripts also needs to insert a line break. In edition, you would
also typically want to remove the docstring in the second file.

The same holds for many other formats: for example, you cannot blindly
concatenate XML files, either (the result often won't be an XML file).
So that the BOM is treated as an error would give no problem.

> Given a file "a.txt" that's pure ASCII, and a file "b.txt" that has the BOM
> marker on it, what happens when you do "cat a.txt b.txt > c.txt"?

You answer the question yourself correctly:

> 'cat' doesn't know, and has no way of knowing, that c.txt needs a BOM at the
> *front* of the file until it's already written past the point in c.txt where
> the BOM has to go.
> 
> What does the Unicode standard say to do in this case?

The point is that the BOM *also* is a regular character, U+FEFF. It used
to have a specific function, too, but now U+2060 (WORD JOINER) should
be used for that function. So U+FEFF is exclusively used for the BOM
now. If you see it in the middle of a file, you know it doesn't belong
there (*). In processing the file, you can complain, you can ignore it,
and you can chose to strip it off. Which of these you do depends on
the application; if you don't know better, treating it as ZERO WIDTH
NON-BREAKING SPACE is the recommended reaction.

Regards,
Martin

(*) unless it occurs in a string literal, in which case it becomes
part of the string. In the case of concatenating two Python files,
it won't be part of a string literal, though, but instead occur
at the beginning of a line.
