Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTDYUiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263877AbTDYUiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:38:24 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:59577 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263087AbTDYUiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:38:23 -0400
Date: Fri, 25 Apr 2003 16:48:15 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Swap Compression
To: linux-kernel@vger.kernel.org
Message-id: <200304251648150320.007079A7@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <200304251640110420.0069172B@smtp.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please CC a copy to me personally; I am not subscribed.

Sorry if this is HTML mailed.  I don't know how to control those settings


COMPRESSED SWAP

This is mainly for things like linux on iPaq (handhelds.org) and people who like to play (me :), but how about compressed swap and RAM as swap?  To be plausable, we need a very fast compression algorithm.  I'd say use the following back pointer algorithm (this is headerless and I coded a decompressor in 6502 assembly in about 315 bytes) and 100k block sizes (compress streams of data until they are 100k in size, then stop.  Include the cap at the end in the 100k).

Here is how the compression works (use fixed width font):
;
; Type Size Description
; Byte 1 Distance to the next backpointer. 0 means end-of-stream.
; Stream X Just straight data, no work needbe performed on it.
; Byte 1 Distance (up to 256, it's base 1) back to seek
; Byte 1 Number of bytes (Up to 255) to copy. 0 means don't
; really do anything (for chaining pointers in large
; areas of nonredundant data)
;
; The above repeats until the end of the stream is reached. Teach by example!
;
; 04 00 01 02 03 03 03 04 00 01 02 03 05 04 06 01 03 00 00 00
; ^ & # ^ & # ^ & # ^
; ^ = Distance to next; & = backseek; # = duplicate length
;
; The above stream uncompresses to:
; 00 01 02 03 00 01 02 00 01 02 03 01 02 00 01 01 03
;
; Note how very small datasets do not compress well. Very large would
; begin to catch up. This is only a 17 byte dataset.

Also, use a booyer-moore algorithm to do the redundancy searching (modify the one in the fdber project at fdber.sourceforge.net to work on binary data, for instance) to further speed it up.  In the end I'd project about a 2-4k code increase (compiled/assembled) in the kernel size, plus 256 bytes for the compression/decompression buffer, plus the dedicated 100k to load the compressed block into RAM.  So about 2-4k increase in the kernel size and 105k increase in RAM usage.

The feature should be optional, and controlled by swapon options.  For instance:

swapon -o compress /dev/hda5

The above could turn a swap partition on under compressed swap mode.  Of course we only would want to use 100k blocks of compressed data, but some extra code can allow the user to configure it:

swapon -o compress=1M /dev/hda5

1 MB block size for instance if you want.  Don't make this too limited; if such a thing were implimented, with such an option, I'd still expect the following to work:

swapon -o compress=1247299 /dev/hda5

to load a swap partition with 1,247,299 byte blocks.  Of course there'd be a rediculous cap on the high end (500 MB block size?!!!!!!!!!!!!), and an impossible cap on both ends (block size > available RAM; block size < 5 (a valid stream fits in 4 but it can't store any data or be processed)).

For predicting available swap, just take statistics and do some calculations, figure out what the average ratio is, and give that times real size as the total swap size.  If you really really care that much, discard outliers.

SWAP ON RAM

The other feature, for handheld devices, is for all those iPaqs with 32 or 64 MB RAM:  swap-on-RAM.  This is useless (i.e. swap on a RAMdisk), but with the swap compression it becomes useful.

Swap on RAM allows the swap driver to use RAM directly as swap, i.e. not as a swap file on a ramdisk.  For instance:

swapon -o compress -o swaponram=16M

The above would use 16 MB of my RAM as a compressed swap file, negating the overhead of disk access, filesystem control, ramdisk control, and so on.  On an iPaq with 32 MB RAM, I could access say 16 M RAM (physical) and 32 MB swap now, giving me 1.5x my real ram (predicted).  With 64 MB, it would be 82 MB RAM (1.25x real RAM), or I could just use 32MB (1.5x = 96 MB) or even 48 MB (1.75x = 112 MB).  Can't use all of it of course; and the more I use the more it swaps.

When a real swap and a RAM swap exist, a RAM swap should be the first choice for swapping out (highest precidence).  This would keep performence up the most under these odd conditions.


CONCLUSION

I think compressed swap and swap-on-ram with compression would be a great idea, especially for embedded systems.  High-performance systems that can handle the compression/decompression without blinking would especially benefit, as the swap-on-ram feature would give an almost seamless RAM increase.  Low-performance systems would take a performance hit, but embedded devices would still benefit from the swap-on-ram with compression RAM boost, considering they can probably handle the algorithm.  I am looking forward to seeing this implimented in 2.4 and 2.5/2.6 if it is adopted.

-- Bluefox Icy

