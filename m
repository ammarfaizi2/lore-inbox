Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTEaIox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTEaIox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:44:53 -0400
Received: from mail.webmaster.com ([216.152.64.131]:63974 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264232AbTEaIot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:44:49 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "David S. Miller" <davem@redhat.com>, <willy@w.ods.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Date: Sat, 31 May 2003 01:58:09 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAECGDFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <20030531.011210.34750891.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> __jhash_mix takes ~23 cycles on sparc64 in the original version for
> me.  I get the same measurement for your version.  Maybe your gcc
> version just stinks :-(

> Oh wait, yes, it's the memory operations it can't eliminate.
> It can't do that because it has no idea whether certain pointers
> alias or not.  (ie. it doesn't know whether 'a' and 'b' point
> to the same value)

	It's a macro, and the way it inlines, it should be obvious in most cases
that 'a', 'b', and 'c' can't be in the same place in memory.

	I've been messing with optimizing the Jenkins hash lately. I've found two
interesting optimizations.

	One is to check if the input pointer happens to be aligned on a double-word
boundary, and if so  optimize the inner loop to use dword fetches. Even most
strings, assuming you hash from the beginning, will be aligned on a dword
boundary. For very short strings, this has no effect. The longer the string,
the more of an affect this has. Basically, you change this:

 // handle most of the key
 while(len >= 12)
 {
  a += ((unsigned)ptr[0] + ((unsigned)ptr[1]<<8) +
       ((unsigned)ptr[2]<<16) + ((unsigned)ptr[3]<<24));
  b += ((unsigned)ptr[4] + ((unsigned)ptr[5]<<8) +
       ((unsigned)ptr[6]<<16) + ((unsigned)ptr[7]<<24));
  c += ((unsigned)ptr[8] + ((unsigned)ptr[9]<<8) +
       ((unsigned)ptr[10]<<16) + ((unsigned)ptr[11]<<24));
  J_MIX(a, b, c);
  ptr += 12;
  len -= 12;
 }

	to:

 // handle most of the key
 if( (((unsigned)data)&3) == 0)
 {
  while(len >= 12)
  {
   a += *  (unsigned *) ptr;
   b += *(((unsigned *) ptr)+1);
   c += *(((unsigned *) ptr)+2);
   J_MIX(a, b, c);
   ptr += 12;
   len -= 12;
  }
 }
 else
 {
  while(len >= 12)
  {
   a += ((unsigned)ptr[0] + ((unsigned)ptr[1]<<8) +
        ((unsigned)ptr[2]<<16) + ((unsigned)ptr[3]<<24));
   b += ((unsigned)ptr[4] + ((unsigned)ptr[5]<<8) +
        ((unsigned)ptr[6]<<16) + ((unsigned)ptr[7]<<24));
   c += ((unsigned)ptr[8] + ((unsigned)ptr[9]<<8) +
        ((unsigned)ptr[10]<<16) + ((unsigned)ptr[11]<<24));
   J_MIX(a, b, c);
   ptr += 12;
   len -= 12;
  }
 }

	How much this helps depends upon how often your inputs are dword aligned.
If you're hashing strings from the beginning, they almost always are.

	The other is to rework the switch/case statement into a tree of 'if(len>0)
{ len--; ...'. You have to reverse the order of the additions, basically
changing:

 switch(len) // all the case statements fall through
 {
  case 11: c+=((unsigned)ptr[10]<<24);
  case 10: c+=((unsigned)ptr[9]<<16);
  case 9 : c+=((unsigned)ptr[8]<<8);
    /* the first byte of c is reserved for the length */
  case 8 : b+=((unsigned)ptr[7]<<24);
  case 7 : b+=((unsigned)ptr[6]<<16);
  case 6 : b+=((unsigned)ptr[5]<<8);
  case 5 : b+=ptr[4];
  case 4 : a+=((unsigned)ptr[3]<<24);
  case 3 : a+=((unsigned)ptr[2]<<16);
  case 2 : a+=((unsigned)ptr[1]<<8);
  case 1 : a+=ptr[0];
//  case 0 : // nothing left to add
 }

	to

 if(len!=0) { len--; a+=ptr[0];
 if(len!=0) { len--; a+=((unsigned)ptr[1]<<8);
 if(len!=0) { len--; a+=((unsigned)ptr[2]<<16);
 if(len!=0) { len--; a+=((unsigned)ptr[3]<<24);
 if(len!=0) { len--; b+=ptr[4];
 if(len!=0) { len--; b+=((unsigned)ptr[5]<<8);
 if(len!=0) { len--; b+=((unsigned)ptr[6]<<16);
 if(len!=0) { len--; b+=((unsigned)ptr[7]<<24);
 if(len!=0) { len--; c+=((unsigned)ptr[8]<<8);
 if(len!=0) { len--; c+=((unsigned)ptr[9]<<16);
 if(len!=0) { len--; c+=((unsigned)ptr[10]<<24);
 } } } } } } } } } } }

	Yeah, it's uglier, and you'd think the extra conditionals would slow things
down, but actually, the branches predict better and the comparisons are
cheaper. The original switch/case statement translates into a
subtract/compare for nothing (to see if len>=12) followed by a totally
unpredictable indirect jump. With my version, the most frequently executed
comparisons are the easiest to predict (assuming random distribution of
lengths).

	I've confirmed by benchmark that both of these are in fact optimizations
(on my processor/compiler/options/etcetera). YMMV.

	DS

