Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVHaTDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVHaTDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVHaTDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:03:53 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:31362 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932519AbVHaTDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:03:52 -0400
Message-ID: <4315FF08.5020500@austin.rr.com>
Date: Wed, 31 Aug 2005 14:03:36 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org, penberg@cs.Helsinki.FI, hch@infradead.org
Subject: Re: [PATCH] mm: return ENOBUFS instead of ENOMEM in generic_file_buffered_write
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > As noticed by Dmitry Torokhov, write() can not return ENOMEM
It turns out that Linux is ok here returning ENOMEM (even from a strict 
POSIX perspective) so the patch is not needed.

I consulted our longstanding POSIX workgroup representative to see what 
he could find out about this topic, and this particular one has some 
history (and it turns out ENOMEM is ok).   Also note that you can return 
more return codes as long as they do not conflict with meanings 
assignmed to others, and ENOBUFS was added not to exclude ENOMEM but to 
match some out of network buffer cases coming back from the 
corresponding socket case.   That the listed return codes for the read 
case and write cases were not symmetric (in listing return codes) was 
noticed as something needing fixing even by the guy who added ENOBUFS in 
the first place and is something that should be fixed up in future POSIX 
specs.

 > We've always been returning more errnos than SuS mentioned and Linus 
declared it's fine.
Christoph (see above line) is correct not just from a Linus perspective 
- it can be legal from a posix perspective to return other error codes 
(there are some exceptions e.g. when the case the new return code covers 
is the same as a listed return code creating obvious duplication)

See below:
          -------------------------------------------
<via Mark Brown, member of the POSIX 1003.1/1003.2 WG and its
Interpretions list>

First off, just because a specific errno is not listed in the ERRORS section
of a given API, doesn't mean that that errno can not be returned by an
implementation (1003.1-2001 Base Definitions Sec 2.3). The ERRORS section
describes errnos that must be used for a given condition, but other
conditions not explicitly listed may be reported. There are some APIs that
disallow reporting of additional error conditions, but they explicitly say
so in their entry.

Sec 2.3 does state that one cannot return a different errno than the one 
that
is listed for a given condition - You can't return EACCES when you mean 
ENOENT
and ENOENT is on the API's list. Does this mean that you can't return
ENOMEM (when getting space for a datastruct) if ENOBUFS is present?

My answer is that ENOMEM is conforming behavior. ENOBUFS has a different
meaning than ENOMEM. The complete descriptions of ENOBUFS and ENOMEM, taken
from the same Section 2.3:

ENOBUFS
No buffer space available. Insufficient buffer resources were available in
the system to perform the socket operation.

ENOMEM
Not enough space. The new process image requires more memory than is allowed
by the hardware or system-imposed memory management constraints.

Also, the history these errnos in both read() and write() shows that 
they were
not present in versions of 1003.1 before the 2001 version. These errnos were
added to the spec for the 2001 version in an attempt to rationalize their
behavior with recv() and send(), which can operate like read() or write()
under certain circumstances. recv() had both ENOBUFS and ENOMEM, so they
went into read(), send() only had ENOBUFS. However, it was conforming 
behavior
to return ENOMEM before the 2001 specification, and no specific intent
was offered to break existing conforming implementations by this change.


-------------------
Mark Brown/Austin/IBM
STSM, UNIX/Linux OS Standards
