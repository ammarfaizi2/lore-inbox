Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTJTAEG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 20:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJTAEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 20:04:06 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:31969
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262333AbTJTAD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 20:03:59 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Willy Tarreau <willy@w.ods.org>, Michael Buesch <mbuesch@freenet.de>
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Date: Sun, 19 Oct 2003 19:00:47 -0500
User-Agent: KMail/1.5
Cc: Nick Piggin <piggin@cyberone.com.au>, Daniel Egger <degger@fhm.edu>,
       linux-kernel@vger.kernel.org
References: <200310180018.21818.rob@landley.net> <200310191245.55961.mbuesch@freenet.de> <20031019210453.GE16761@alpha.home.local>
In-Reply-To: <20031019210453.GE16761@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310191900.47300.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 October 2003 16:04, Willy Tarreau wrote:
> On Sun, Oct 19, 2003 at 12:45:46PM +0200, Michael Buesch wrote:
> > What about making it configurable? If someone want's bzip2
> > and if he want's to wait longer to boot, (s)he may
> > compile bzip2 support.
> > If someone dislikes it, (s)he may use gzip.
>
> I don't know if people have already tested LZO and NRV (used in UPX).
> Perhaps LZO might already be a little better than gzip, while faster and
> with less code. NRV is surely better, but is not open source IIRC. Perhaps
> Markus would agree to release a free NRV decompressor if asked kindly ?

You know, I remember the days of arj, zoo, arc, lha, lzw, the big switchover
from pkzip 1.x to pkzip 2.x, and about 8 zillion others...  And I must say
that the depth of my lack of caring truly cannot be expressed in words.

As soon as I have to start seeing a lot of blah.tar.upx files on ftp sites,
and the tools for dealing with them come with my Linux distribution, then
maybe I'll start caring.  Until then, no.  I'm interested in bzip because
A) it reliably compresses smaller than gzip by margin big enough to care
about, B) it's in widespread use.

You're talking about something that compresses _less_ well than bzip, but
does it faster.  We have one, it's called gzip.

Ville Herva sent me this table yesterday:                                                                    
-----
original vmlinux: 2718814 bytes, 2.4.18pre3                                     
                                                                                
gzip -1 gzip    gzip -9   bzip2 -1 bzip2   bzip2 -9  upx -1   upx     upx -9  upx --best                                                             
compress     0.736   1.289   5.300     5.342    10.810  10.585    1.672    4.794   12.361  20.054                                                                 
decompress   0.157   0.278   0.210     1.360     1.920   1.948    0.156    0.158   0.153   0.159                                                                  
bytes        1247526 1151202 1145777   1118671  1101465 1101465   1311390  1180222 1179325 1178953                                                        
                                                                                
upx is upx-1.22.  
-----

So you're talking about something that compresses LESS well than gzip.  Why?
(I'm told the UPX numbers include a self-extraction decompressor, and the
gzip numbers don't.  The self-extractor would have to be 33k for this to
bring it _even_ with gzip.  And no, gzip -9 does not add anything to
decompression time, only compression time.  I ported info-zip to java 1.0
just before java 1.1 came out with deflate as part of the standard API, I
know how deflate/inflate works pretty well.  I could make deflate work in
place pretty easily.  I can make bunzip work in-place if you'd like (the
symbols occur sequentially, just stick the compressed data at the end of
a buffer the size of the decompressed data, and by the time you're
overwriting any given symbol you must already have read it).  Although bzip
would still need 2-4 megabytes of scratch space to undo the burrows-wheeler
transform, and gzip only needs something like a 64k dictionary.  And doing
either in-place assumes you know the size of the decoded data ahead of
time, but storing the size in 4k pages means 2 bytes gets you a 256
megabyte capacity, which is plenty for the kernel.  (No, I'm not bothering
to overwrite the decompressor.  You can execute that out of flash, why copy
it to dram at all?)

So why should anyone care about UPX?  (Is there really a situation where
gzip isn't fast enough anymore?)  I'm curious why more than one person has
brought it up.  Am I missing something...?

> Regards,
> Willy

Rob

(P.S.  I don't remember info-zip having as much cruft in its deflate
implementation as bzip did, but I intend to do a cleaning pass over
busybox's gzip/gunzip when I get around to it, and I'd be happy to
port the improvements (if any) to the linux kernel afterwards.)
