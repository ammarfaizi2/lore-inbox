Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUDMPot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUDMPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 11:44:49 -0400
Received: from p4.ensae.fr ([195.6.240.202]:57790 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S263606AbUDMPop convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 11:44:45 -0400
From: Guillaume =?iso-8859-15?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: linux-kernel@vger.kernel.org
Subject: Using compression before encryption in device-mapper
Date: Tue, 13 Apr 2004 17:44:40 +0200
User-Agent: KMail/1.5.3
Cc: Linux@glacote.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404131744.40098.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope this is the right place to post this message; I tried to keep it small.
Basically I really would like to implement compression at the dm level, 
despite all of the problems. The reason for this is that reducing redundancy 
through compression tremendously reduces the possibilities of success for an 
attacker. I had implemented this idea in a java archiver ( 
http://jsam.sourceforge.net ).

Although I am not a good kernel hacker, I have spent some time reading 
compressed-loop.c, loop-aes, dm-crypt.c, and various threads from lkml 
including http://www.uwsg.iu.edu/hypermail/linux/kernel/0402.2/0035.html
Thus I would appreciate if you could answer the following questions regarding 
the implementation of a "dm-compress" dm personality. 

0) Has this problem already been adressed, and if yes, where ?

1) Using dm: I want to be able to use compression both above dm (to compress 
before encrypting a volume) and below it (to do a RAID on compressed 
volumes). I assume there is no other way than to make compression be a dm 
personality. Is this correct (or shall I use something more similar to a 
compressed loop device) ?

2) Block I/O boundaries: compression does not preserve size. I plan to use a 
mapping from real sectors to their compressed location (e.g. struct { 
sector_t sector; size_t compressed_length }* mapping; ). I believe this 
mapping can be stored on another dm target and bufferized dynamically. Is 
this correct, or shall it remain in (non-swappable ?) memory ?

3) Compressed sectors have varying sizes, while dm targets only deal with full 
blocks. Thus every compressed request may need to be fragmented into several 
block aligned requests. This might imply reading a full block before 
partially filling it with new data. Is it an exceedingly difficult task ? 
Will this kill performance ?

4) Block allocation on writes: this is the most difficult problem I believe. 
When rewriting a sector, its new compressed length might not be the same as 
before. This would require a whole sector allocation mechanism: magaging 
lists of free space, optimizing dynamic allocation to reduce fragmentation, 
etc. Is there another solution than to adapt algorithms used in for e.g. ext2 
?

5) As a workaround to 2,3,4 I plan to systematically allocate 2 sectors per 
real sector (space efficiency is _not_ my aim, growing entropy per bit is) 
and to use a trivial dynamic huffman compression algorithm. Is this solution 
(which means having half less space than physically available) acceptable ?

6) Shall this whole idea of compression be ruled out of dm and only be 
implemented at the file-system level (e.g. as a plugin for ReiserFS4) ?

I thank you very much in advance for your critics and advices.

G. Lacôte.


