Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269504AbUIZHwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269504AbUIZHwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 03:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269503AbUIZHwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 03:52:00 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:1929 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269504AbUIZHvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 03:51:45 -0400
Date: Sun, 26 Sep 2004 08:51:42 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409260828200.18239@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409260850410.18239@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409240926580.32117@ppc970.osdl.org>
 <Pine.LNX.4.60.0409242059420.5443@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409241930510.2317@ppc970.osdl.org>
 <Pine.LNX.4.60.0409260828200.18239@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2004, Anton Altaparmakov wrote:

> On Fri, 24 Sep 2004, Linus Torvalds wrote:
> > On Fri, 24 Sep 2004, Anton Altaparmakov wrote:
> > > On Fri, 24 Sep 2004, Linus Torvalds wrote:
> > > > 
> > > > Btw, Al is fixing this. We'll make enum's properly typed, rather than just 
> > > > plain integers. It's not traditional C behaviour, but it gives you better 
> > > > type safety, and Al points out that other C compilers (the Plan 9 one, to 
> > > > be specific) have done the same thing for similar reasons.
> > 
> > Well, when I said "Al is fixing this", I lied.
> > 
> > I just fixed it myself. 
> 
> Great.  (-:
> 
> > > This is good news.  Once that is done I will be very happy to go back to 
> > > using enums as I also agree that they can and in this case do look a 
> > > lot nicer...
> > 
> > Try the current sparse, I think it should work for you.
> > 
> > So if you make an enum where the initializer expression is a little-endian 
> > expression, the type of that (single) enumerator will be little-endian.
> > 
> > HOWEVER, the type of an enum _variable_ will still be just "int". So
> > 
> > 	enum myenum {
> > 		one = 1ULL,
> > 		two = 2,
> > 	};
> > 
> > has the strange behaviour that if you use "one" in an expression, it will
> > have the type "unsigned long long", but if you use a "enum myenum" entry
> > (even if it has the value "1"), it will be an "int":
> > 
> > 	sizeof(one) == 8
> > 	sizeof(enum myenum) == 4
> > 
> > So I would stronly suggest (and I may make sparse warn) against using
> > non-integertyped enum values with any enum that actually has any backing
> > store (ie if you ever use a variable of type "enum myenum", that would
> > result in a warning - you can really just use the values "one" and "two"
> > directly).
> 
> Ah, I was using them for backing store as well and I was using the 
> __attribute__((packed)) gcc extension to make them the bit-width I wanted 
> in combination with a "filler element" at the end of the enum.
> 
> So for example to get a 16-bit enum type I was using:
> 
> typedef enum {
> 	RESTART_VOLUME_IS_CLEAN = const_cpu_to_le16(0x0002),
> 	REST_AREA_SPACE_FILLER  = 0xffff	/* Just to make flags 
> 16-bit. */
> } __attribute__ ((__packed__)) RESTART_AREA_FLAGS;
> 
> And then when defining the structure containing these flags I would just 
> do:
> 
> typedef struct {
> 	...
> 	RESTART_AREA_FLAGS flags;
> 	...
> } __attribute__ ((__packed__)) RESTART_AREA;
> 
> Also I use the enum type as parameters to functions, for example in the 
> above case I might have:
> 	int blah(RESTART_AREA_FLAGS flags);
> 
> So this use doesn't work with the sparse update either.  At the moment I 
> have changed everything to just a bunch of #defines followed by a:
> 
> typedef le16 RESTART_AREA_FLAGS;
> 
> So I guess with your sparse update I can now go to a point in between the 
> old one and the new one:
> 
> enum {
> 	RESTART_VOLUME_IS_CLEAN = const_cpu_to_le16(0x0002),
> } __attribute__ ((__packed__)) RESTART_AREA_FLAGS;

Silly cut'n'paste error.  I meant:

> } __attribute__ ((__packed__));

> 
> typedef le16 RESTART_AREA_FLAGS;
> 
> So I get the enum rather than bunch of defines and I get my proper types 
> as well.
> 
> That only looses the ability for the compiler to warn if people use the 
> wrong constant when trying to set such a variable or pass a wrong constant 
> into a function but that is not nearly as useful a warning as the wrong 
> endianness bitwise warnings we have now gained so I am not going to worry 
> about losing it.
> 
> Best regards,
> 
> 	Anton
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
