Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750854AbWFEKGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWFEKGy (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWFEKGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:06:54 -0400
Received: from mout1.freenet.de ([194.97.50.132]:21727 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1750812AbWFEKGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:06:53 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Mon, 5 Jun 2006 12:06:49 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au
References: <200606041516.46920.jfritschi@freenet.de> <200606042110.15060.ak@suse.de>
In-Reply-To: <200606042110.15060.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606051206.50085.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 21:10, Andi Kleen wrote:
> On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
> > This patch adds the twofish x86_64 assembler routine.
> >
> > Changes since last version:
> > - The keysetup is now handled by the twofish_common.c (see patch 1 )
> > - The last round of the encrypt/decrypt routines where optimized saving 5
> > instructions.
> >
> > Correctness was verified with the tcrypt module and automated test
> > scripts.
>
> Do you have some benchmark numbers that show that it's actually worth
> it?

Here are the outputs from the tcrypt speedtests. They haven't changed much 
since the last patch:

http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-x86_64.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-x86_64.txt

Summary for cycles used for CBC encrypt decrypt (256bit / 8k blocks) assembler 
vs. generic-c:

i586 encrypt:   - 17%
i568 decrypt:   -24%
x86_64 encrypt: -22%
x86_64 decrypt: -17%

The numbers vary a bit with different blocksizes / keylength and per test.

I also did some filesystem benchmarks (bonnie++) with various ciphers. Most 
write tests maxed out my drives writing to disk.  But at least for the read 
speed you can see some notable performance improvements:
(Note: The x86 and x86_64 numbers are not comparable since the tests were done 
on different machines)

http://homepages.tu-darmstadt.de/~fritschi/twofish/output_20060531_160442_x86.html

Summary:
Sequential read speed improved between 25-32%
Sequential write speed improved at least 15% but the disk maxed out
Twofish 256 is a little bit faster than AES 128

http://homepages.tu-darmstadt.de/~fritschi/twofish/output_20060601_113747_x86_64.html

Summary:
Sequential read speed improved 13%
Seqential write speed maxed out the drives

> > +/* Defining a few register aliases for better reading */
>
> Maybe you can read it now better, but for everybody else it is extremly
> confusing. It would be better if you just used the original register names.

The problem with the registers is that the original naming is really crappy in 
the first place. The lower registers use the old x86 naming scheme plus some 
extensions but the upper registers are totally different. Since i use a lot 
of the lower / higher 8bit and 32 bit parts it would be virtually impossible 
to write simple macros with this naming scheme because there would be no easy 
way to switch from a (unknown) register to its 8bit subregister or the 32bit 
in a macro. While there might be some way to do this, i have not found any 
example in the kernel or any other source code.
As an explanation i can only add that i looked at the aes assembler 
implementation and used it as a example. I know refering to bad coding style 
in the kernel is no excuse for more bad coding but it seems to me that it is 
the only way to deal with the insane original register naming.
Imho using the original names would only complicate the macros and complicate 
understanding the algorithm itself. For the algorithm itself the the actual 
registers are simply irrelevant . It calls no other functions or uses any 
syscalls. It only uses them as storage. That way reffering to them in a 
numbered order with a suffix for 8/16/32bit was an easy way to improve 
readability and easier programming.
There might be some way to further improve readability but i have not found 
any other way. I'm open to suggestions :)

Regards,

Joachim
