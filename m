Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbUDNGsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbUDNGsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:48:08 -0400
Received: from p4.ensae.fr ([195.6.240.202]:23868 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S263922AbUDNGsE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:48:04 -0400
From: Guillaume =?iso-8859-15?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: Timothy Miller <miller@techsource.com>
Subject: Re: Using compression before encryption in device-mapper
Date: Wed, 14 Apr 2004 08:48:00 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <407C1BEC.30801@techsource.com>
In-Reply-To: <407C1BEC.30801@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404140848.00477.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your prompt answers.
Le Mardi 13 Avril 2004 18:57, Timothy Miller a écrit :
[snip]
> I have a suggestion.  If you're compressing only for the sake of
> obfuscation, then don't really try to save any space.  Use a fast
> compression algorithm which doesn't necessarily do a great job.
I prefer speaking in terms of "entropy-per-bit" and "redundancy" rather than 
"obfuscation", although you got the idea.
Actually I plan to use a basic dynamic huffman : the rationale for this is 
that there is no meta-data (and any meta-data would help an attacker), since 
the weighted tree is updated along (de)compression. And from J. S. Vitter's 
article (Design and analysis of Dynamic Huffman Codes) we know that in the 
worst-case scenario the Huffman encoding will use one additional bit per 
byte. Thus allocating 9 native blocks for every 8 "compressed" blocks will 
do, although it is a bit more complicated than the 2-to-1 scheme I had 
suggested.

>
> When you're going to write, compress the block.  If it gets smaller,
> fine.  Store it in the same space it would have required even if it were
> uncompressed.  If the block gets bigger, then store it uncompressed.
> Whether or not the block could be compressed would be stored in metadata
> (in the inode, I guess).
Actually I do _not_ want to do that. The reason for that is that I want to add 
yet another layer before compression, which would interleave real data with 
random bytes. These random bytes are not drawn uniformly but rather drawn as 
to make the distribution on huffman trees (and thus on the encodings) 
uniform. This ensures that in order to decode my real data, an attacker has 
to decode the random data first; but since all _compressed_ random sequences 
are made equi-probable, there is (hopefully) no better way for him to do this 
than brute force. This is the idea I have (successfully ?) implemented in 
http://jsam.sourceforge.net .

Thus I still want to "compress" my data even if its size grows.

The problem I encounter however is that if forcibly allocating more space than 
required (e.g. 9 plain blocks every 8 compressed blocks) I will need padding. 
However padding is generally unwise cryptographically speaking ...


