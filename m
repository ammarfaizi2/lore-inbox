Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUDNPZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUDNPZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:25:43 -0400
Received: from p4.ensae.fr ([195.6.240.202]:63676 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S264261AbUDNPZd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:25:33 -0400
From: Guillaume =?iso-8859-15?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: Pascal Schmidt <der.eremit@email.de>
Subject: Re: Using compression before encryption in device-mapper
Date: Wed, 14 Apr 2004 17:25:31 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <1KykU-4VD-17@gated-at.bofh.it> <1KTfJ-5gK-25@gated-at.bofh.it> <E1BDluf-00007s-PB@localhost>
In-Reply-To: <E1BDluf-00007s-PB@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404141725.31660.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mercredi 14 Avril 2004 17:02, Pascal Schmidt a écrit :
> On Wed, 14 Apr 2004 16:10:20 +0200, you wrote in linux.kernel:
> > Actually (see my reply to Timothy Miller) I really want to do
> > "compression" even if it does not reduce space: it is a matter of growing
> > the per-bit entropy rather than to gain space (see
> > http://jsam.sourceforge.net).
>
> How is the per-bit entropy higher when the same amount of data (and
> thus entropy on that data) is sometimes contained in *more* bits?
>
> I can see the argument if data is really compressed, because then more
> bits than would normally fit into, say, a sector, contribute to the
> entropy of the final sector.
You are perfectly right. If I recall correctly from Paul Li and Ming Vitanyi, 
An Introduction to Kolmogorv Complexity, then the minimum length of an 
encoding (e.g. a static two-pass Huffman encoding) is equal to the total 
entropy of the text, or one more than that (this is also asymptotically equal 
to the Kolmogorov complexity of the text). In particular the static encoding 
can not be longer than the original text.

However I do _not_ want to have any form of meta-data, dictionnary, etc. Thus 
I need to use dynamic encoding, were the huffman tree is dynamically updated 
(both while compressing or while decompressing) as characters are 
read/written. The problem is that the encoding "evolves" and in particular it 
can be (and usually is) worse than the static encoding.

J. S. Vitter showed that the dynamic algorithm by Faller, Gallager and Knuth 
can use twice more bytes plus one bit per byte than the optimal static 
Huffman encoding. On the other hand J. S. Vitter discusses  dynamic algorithm 
that uses only one more bit per byte in the worst case when compared to the 
static encoding.

You are right that in this very case, the per-bit entropy will be
(1 - 1/(1+1/8) ) ~ 12% lower than in the original text. The point is that this 
case (which has nothing to do with the case where a text can be well 
compressed or not, this is the worst _relative_ performance of dynamic versus 
static encoding) does not happen "too often".

Note that I wish to prepend random bytes followed by the block of real text 
before compressing and ciphering, so as to make the distribution of huffman 
trees uniform. The ultimate goal being to let no other solution to an 
attacker than to brute force test all possible keys. An indirect consequence 
on this is that the probability of being in the "poor dynamic performance" 
case does not depend on the data itself (but on the random drawing).

I hope that I made things clearer and that I didn't make any mistake (please 
feel free to correct me).

Guillaume.

