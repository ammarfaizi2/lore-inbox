Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130989AbQL3Cdh>; Fri, 29 Dec 2000 21:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbQL3Cd1>; Fri, 29 Dec 2000 21:33:27 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:5130 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130989AbQL3CdX>; Fri, 29 Dec 2000 21:33:23 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dave Gilbert <gilbertd@treblig.org>
Date: Sat, 30 Dec 2000 13:02:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14925.16964.875883.863169@notabene.cse.unsw.edu.au>
Cc: linux-alpha@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: memmove broken on alpha - was Re: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
In-Reply-To: message from Dave Gilbert on Saturday December 30
In-Reply-To: <14925.12964.995179.63899@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.10.10012300105100.26235-100000@tardis.home.dave>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ extra detail included because I have added linux-alpha and lins to
the cc list] 

It appears that memmove is broken on the alpha architecture.

memmove is used by net/sunrpc/xdr.c:xdr_decode_string
to move a string 4 bytes down in memory.
memmove(X-4, X, 8) should change
    
 X:  00 00 00 08  67 69 6c 62 65 72 74 64
to
 X:  67 69 6c 62  65 72 74 64 65 72 74 64

Instead it changes it to

 X:  65 72 74 64  65 72 74 64 65 72 74 64

This is my first time in alpha assembler, but it looks fairly readable
and the comments help....

Working from 
  arch/alpha/lib/memmove.S

As the two regions overlap, it doesn't fall back on memcpy,
As the two regions are not co-aligned so it jumps to $misaligned.

Now the code in $misaligned, like all the code in memmove.S seems to
move a block of memory starting at the top, and moving downwards.
But in this example, we need to start at the bottom and move upwards.

Currently the code falls back on memcpy :

 if (dest+n <= src || dest >= src + n)

However if should also fall back on memcpy:
 
 if (dest <= src)

So the test should be:

  if (dest <= src || dest >= src + n)

which I think translates to the following patch:

--- arch/alpha/lib/memmove.S	2000/12/30 01:59:28	1.1
+++ arch/alpha/lib/memmove.S	2000/12/30 01:59:49
@@ -17,7 +17,7 @@
 memmove:
 	addq $16,$18,$4
 	addq $17,$18,$5
-	cmpule $4,$17,$1		/*  dest + n <= src  */
+	cmpule $16,$17,$1		/*  dest <= src  */
 	cmpule $5,$16,$2		/*  dest >= src + n  */
 
 	bis $1,$2,$1


NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
