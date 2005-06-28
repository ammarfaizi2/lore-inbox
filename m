Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVF1OP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVF1OP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVF1OP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:15:27 -0400
Received: from iona.labri.fr ([147.210.8.143]:8132 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S261685AbVF1ONv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:13:51 -0400
Date: Tue, 28 Jun 2005 15:43:16 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628134316.GS5044@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is something wrong with the current madvise(MADV_DONTNEED)
implementation. Both the manpage and the source code says that
MADV_DONTNEED means that the application does not care about the data,
so it might be thrown away by the kernel. But that's not what posix
says:

http://www.opengroup.org/onlinepubs/009695399/functions/posix_madvise.html

It says that "The posix_madvise() function shall have no effect on the
semantics of access to memory in the specified range". I.e. the data
that was recorded shall be saved!

The current linux implementation of MADV_DONTNEED is rather an
implementation of solaris' MADV_FREE, see its manpage:
http://docs.sun.com/app/docs/doc/816-5168/6mbb3hrde?a=view

Hence the current madvise_dontneed() implementation could be renamed
into madvise_free() and the appropriate MADV_FREE case be added, while
a new implementation of madvise_dontneed() _needs_ be written. It may
for instance go through the range so as to zap clean pages (since it is
safe), and set dirty pages as being least recently used so that they
will be considered as good candidates for eviction.

(And the manpage should get corrected too)

Regards,
Samuel Thibault
