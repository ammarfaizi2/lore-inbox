Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274972AbRJRMPz>; Thu, 18 Oct 2001 08:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275043AbRJRMPp>; Thu, 18 Oct 2001 08:15:45 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:260 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S274972AbRJRMPe>;
	Thu, 18 Oct 2001 08:15:34 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15310.51180.802846.33348@cargo.ozlabs.ibm.com>
Date: Thu, 18 Oct 2001 22:15:40 +1000 (EST)
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs
In-Reply-To: <15310.33191.397106.8530@cargo.ozlabs.ibm.com>
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com>
	<3BCBE29D.CFEC1F05@alacritech.com>
	<9qjfki$ob5$1@cesium.transmeta.com>
	<15310.18125.367838.562789@cargo.ozlabs.ibm.com>
	<3BCE4BB5.8060603@zytor.com>
	<15310.33191.397106.8530@cargo.ozlabs.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> I added a deflateOutputPending routine which returns the number of
> bytes of data that the compressor has pending to give to you.

I just checked and in fact ppp_deflate doesn't use this.

> I added a check so that it is legal to set strm->next_out to NULL and
> the de/compressor will just discard its output data.  This is useful
> on the sending side for PPP-deflate because there are situations where
> the transmitted data has to be added to the compressor's history but
> may not be transmitted in compressed form.

ppp_deflate doesn't use next_out = NULL in this case, but it does use
next_out = NULL when we are compressing a packet and the compressed
packet turns out to be larger than the uncompressed.  With deflate
there is a limit on how much larger the compressed packet would be, so
it would be possible to give it a small extra buffer on the stack
instead of using next_out = NULL.

If we were going to standardize on a newer zlib in the kernel, I could
change ppp_deflate to cope with that without too much pain, I think.
The main thing I would want to add is a way to check what state the
decompressor is in at the end of each packet - we want
strm->state->blocks->mode == LENS at that point, which is not
something that can be checked using the existing zlib interface.

Paul.
