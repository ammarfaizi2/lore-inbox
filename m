Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277434AbRJRHQ1>; Thu, 18 Oct 2001 03:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277599AbRJRHQS>; Thu, 18 Oct 2001 03:16:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:19463 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277434AbRJRHQF>;
	Thu, 18 Oct 2001 03:16:05 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15310.33191.397106.8530@cargo.ozlabs.ibm.com>
Date: Thu, 18 Oct 2001 17:15:51 +1000 (EST)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs
In-Reply-To: <3BCE4BB5.8060603@zytor.com>
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com>
	<3BCBE29D.CFEC1F05@alacritech.com>
	<9qjfki$ob5$1@cesium.transmeta.com>
	<15310.18125.367838.562789@cargo.ozlabs.ibm.com>
	<3BCE4BB5.8060603@zytor.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> What kind of extensions?

/me pages that bit of his brain in...

I added a Z_PACKET_FLUSH value for the `flush' parameter.  For deflate
it is like Z_SYNC_FLUSH except that it omits the 00 00 ff ff bytes
that Z_SYNC_FLUSH will put on the end of the output.  For inflate it
checks that we are at a packet boundary once we have consumed all the
input, i.e. that we have seen the "000" block type code (meaning a
"stored" block) and we are waiting for the 2-byte length.

I added a deflateOutputPending routine which returns the number of
bytes of data that the compressor has pending to give to you.

I added an inflateIncomp routine which takes uncompressed data and
adds it to the decompressor history.  The reason this is needed is
that if PPP-deflate goes to compress a packet and it expands, it sends
the packet uncompressed instead.  The receiver still needs to add the
packet data to the history though, since the packet data has been
processed by the compressor on the sending end.

I added a check so that it is legal to set strm->next_out to NULL and
the de/compressor will just discard its output data.  This is useful
on the sending side for PPP-deflate because there are situations where
the transmitted data has to be added to the compressor's history but
may not be transmitted in compressed form.

I also made various other minor changes so it would all compile
happily combined together into one file and in the kernel environment.

None of these changes affect its behaviour if you use it in the normal
way, i.e. if you don't use Z_PACKET_FLUSH and don't set strm->next_out
to NULL.

Most of these things are optimizations to reduce time and memory usage
for PPP-deflate.  The one thing that I don't think could be done with
the stock zlib is the check for the decompressor state that
Z_PACKET_FLUSH on inflate() provides.  That is not *strictly*
necessary since it is just a check, but it does give us some chance of
detecting if we receive a corrupted compressed packet that still has
the correct FCS.

Paul.
