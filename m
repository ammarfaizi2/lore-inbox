Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSLZMsy>; Thu, 26 Dec 2002 07:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSLZMsy>; Thu, 26 Dec 2002 07:48:54 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:17909 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261376AbSLZMsw>;
	Thu, 26 Dec 2002 07:48:52 -0500
Date: Thu, 26 Dec 2002 13:57:05 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212261257.NAA02448@harpo.it.uu.se>
To: anton@samba.org
Subject: Re: [PATCH] 2.5 fast poll on ppc64
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard writes:
 > I was unable to boot 2.5-BK on ppc64 and narrowed it down to the fast
 > poll patch.  I found:
 > 
 > offsetof(struct poll_list, entries) == 12 but
 > sizeof(struct poll_list) == 16
 > 
 > This means pp+1 did not match up with pp->entries. Im not sure what the
 > alignment requirements are for a zero length struct (ie is this a
 > compiler bug) but the following patch fixes the problem and also changes
 > ->len to a long to ensure 8 byte alignment of ->entries on 64bit archs.
 > 
 > Anton
 > 
 > ===== fs/select.c 1.15 vs edited =====
 > --- 1.15/fs/select.c	Sat Dec 21 20:42:41 2002
 > +++ edited/fs/select.c	Thu Dec 26 17:31:16 2002
 > @@ -362,7 +362,7 @@
 >  
 >  struct poll_list {
 >  	struct poll_list *next;
 > -	int len;
 > +	long len;
 >  	struct pollfd entries[0];
 >  };

To me (I'm a compiler writer) it looks like your compiler did NOT
mess up. Assuming struct pollfd has 32-bit alignment, the compiler
is doing the right thing by starting entries[] at offset 12.
The 16-byte size for struct poll_list is because the 'next' field
has 64-bit alignment, which forces the compiler to pad struct
poll_lists's size to a multiple of 8 bytes, i.e. 16 bytes in this
case. So the compiler is not broken.

 >  
 > @@ -471,7 +471,7 @@
 >  			walk->next = pp;
 >  
 >  		walk = pp;
 > -		if (copy_from_user(pp+1, ufds + nfds-i, 
 > +		if (copy_from_user(pp->entries, ufds + nfds-i, 
 >  				sizeof(struct pollfd)*pp->len)) {

But the old code which assumed pp+1 == pp->entries is so horribly
broken I can't find words for it. s/pp+1/pp->entries/ is the correct fix.

/Mikael
