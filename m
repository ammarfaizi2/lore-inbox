Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285630AbRLWJPD>; Sun, 23 Dec 2001 04:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286840AbRLWJOy>; Sun, 23 Dec 2001 04:14:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23300 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285630AbRLWJOp>; Sun, 23 Dec 2001 04:14:45 -0500
Message-ID: <3C25A06D.7030408@zytor.com>
Date: Sun, 23 Dec 2001 01:14:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have looked through the various forms of tar and cpio, and I'm getting 
the feeling that both are ugly as hell for the purpose of initializing 
initramfs.  The block-based setup of tar (and of the new Austin group 
"pax" format -- really just a new rev of tar) is awful, but some of the 
tape-oriented aspects of cpio isn't much better.  What concerns me about 
cpio in particular:

a) Several different formats; <cpio.h> only documents one of them; I 
have only found info on that one so some of these things may not apply.

b) No obvious ways to handle hard links, that doesn't require you 
keeping a table of the inode numbers already seen (at least for which 
c_nlink > 1) and hard link to them on the decompression side.  Since we 
have an assymetric setup, it seems like its done at the wrong end.

c) The use of TRAILER!!! as an end-of-archive marker (first, it's a 
valid name, and second, there shouldn't be a need for an end-of-archive 
marker in this application as long as each individual file is 
self-terminating thus returning the dearchiver to its ground state.  If 
we stick with cpio, I would like these entries to have no effect.

d) c_rdev, c_uid, c_gid, c_dev, and c_ino are too small, at least in the 
<cpio.h> format.

e) The use of octal ASCII numbers is somewhat ugly.

f) No ctime, no atime.

It seems to me that this application doesn't really have a particular 
need for backward compatibility, nor for the I/O blocking stuff of 
tar/cpio.  I would certainly be willing to write a set of portable 
utilities to create an archive in a custom format, if that would be more 
desirable.  We'd still use gzip for compression, of course, and have the 
buffer composed as a combination of ".rfs" and ".rfs.gz" files, 
separated by zero-padding.

What I'm talking about would probably still look a lot like the cpio 
header, but probably would use bigendian binary (bigendian because it 
allows the use of the widely portable htons() and htonl() macros), have 
explicit support for hard links, and not require a trailer block.

	-hpa

