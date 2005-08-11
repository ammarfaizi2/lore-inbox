Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVHKPHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVHKPHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVHKPG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:06:59 -0400
Received: from pat.uio.no ([129.240.130.16]:45815 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751072AbVHKPG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:06:59 -0400
Subject: Re: fcntl(F GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
In-Reply-To: <23689.1123771230@www9.gmx.net>
References: <1123769192.8251.75.camel@lade.trondhjem.org>
	 <23689.1123771230@www9.gmx.net>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 11:06:41 -0400
Message-Id: <1123772802.8251.123.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.467, required 12,
	autolearn=disabled, AWL 2.35, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 16:40 (+0200) skreiv Michael Kerrisk:
> I think my metapoint really is this: there has never been a 
> clearly documented statement of how File Leases are supposed 
> to behave on Linux.  There is just some code... how is one 
> supposed to know what it _should_ do?  (The manual page text 
> was my attempt to discover the details, after the fact.)
> 
> Can you provide an explanation of how file leases should 
> behave?  That is, a tabulation of the expected behavious 
> for the possible cimbinations of
> 
> [lease type] X 
> [open() access-mode employed file placing lease] X
> [open() access-mode employed by other process(es)]

The only document that I have is RFC3530 (the NFSv4 spec) which doesn't
really define file leases, but does define the caching protocol that
they act as support for.
In principle it is supposed to be the same protocol that CIFS uses
(although CIFS doesn't really have much in the form of documentation
that we can use to verify that fact).

To me, the NFSv4 requirements suggest:

     open()  |  lease requested    | effect on existing leases |
      flag   | F_RDLCK  | F_WRLCK  | F_RDLCK  | F_WRLCK        |
    ---------+----------+----------+---------------------------+
    O_RDONLY | okay     |  okay    |  none    |  recall        |
    O_WRONLY | EAGAIN   |  okay    |  recall  |  recall        |
    O_RDWR   | EAGAIN   |  okay    |  recall  |  recall        |

-----
 fcntl(SETLK)| effect on existing leases |
     flag    | F_RDLCK   | F_WRLCK       |
    ---------+---------------------------+
     F_RDLCK | none      | none          |
     F_WRLCK | recall    | none          |

-----
Other operation that should recall leases (both types!) are

unlink(), link(), f/l/chown(), f/chmod(), rename(), setfacl().

truncate() and utime() calls by another process.

-----
Finally, operations that should recall read leases only:

truncate() and utime() calls by your process.
-----

Cheers,
  Trond

