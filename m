Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUIXASQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUIXASQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUIXAQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:16:42 -0400
Received: from science.horizon.com ([192.35.100.1]:19513 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S267518AbUIXAJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:09:02 -0400
Date: 24 Sep 2004 00:08:56 -0000
Message-ID: <20040924000856.16796.qmail@science.horizon.com>
From: linux@horizon.com
To: helge.hafting@hist.no
Subject: Re: truncate shows non zero data beyond the end of the inode with
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could this "garbage" possibly be confidential data?
> I.e. one user repeatedly makes and mmaps a 1-byte file,
> extends it to 4k, and looks at the 4095 bytes of "garbage".
> Maybe he finds some "interesting stuff" when someone else's
> confidential file just got dropped from pagecache
> so he could mmap this 1-byte file?

No, it couldn't.  The sequence of operations is:

- char *p = mmap(1-byte file).  p[1] through p[4095] are guaranteed to be zero.
- Write to p[1] through p[4095].  If the file is flushed at this point,
  the extra bytes are guaranteed NOT to be written to disk.
- ftruncate() the file to 4096 bytes
- At this point, Linux may flush the non-zero bytes p[1]..p[4095] to disk.

*That* is the issue being complained about.  If you write to p[1] through
p[4095] *before* calling truncate(2) or ftruncate(2), it can get written
back to disk.

If you don't write past the EOF, it doesn't arise.

The only security issue is that, although you technically are guaranteed
access to the trailing partial page, so a correct program *could*
rely on it, it's more commonly evidence of a bug, and bugs often have
security implications.
