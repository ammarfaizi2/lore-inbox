Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314327AbSDRLzS>; Thu, 18 Apr 2002 07:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314328AbSDRLzR>; Thu, 18 Apr 2002 07:55:17 -0400
Received: from ns.suse.de ([213.95.15.193]:53262 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314327AbSDRLzP>;
	Thu, 18 Apr 2002 07:55:15 -0400
Date: Thu, 18 Apr 2002 13:55:05 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Doug Ledford <dledford@redhat.com>, jh@suse.cz,
        linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole
Message-ID: <20020418135505.A31355@wotan.suse.de>
In-Reply-To: <20020418131431.B22558@wotan.suse.de> <E16yATQ-0004V1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 12:53:12PM +0100, Alan Cox wrote:
> > > Intel folks are actually saying even back in Pentium MMX days that it isnt
> > > guaranteed that the FP/MMX state are not seperate registers
> > 
> > In this case it would be possible to only do the explicit clear
> > when the CPU does support sse1. For mmx only it shouldn't be needed.
> > For sse2 also not.
> 
> Do you have a documentation cite for that claim ?

Actually I did some more tests: 

test program

main()
{
	unsigned int i[4], o[4]; 

	i[0] = 1; i[1] = 2; i[2] = 3; i[3] = 4;
	asm("movups %1,%%xmm1 ; fninit ; movups %%xmm1,%0" : "=m" (o) : "m" (i)); 
	printf("%x %x %x %x\n",o[0],o[1],o[2],o[3]);

	asm("movups %1,%%xmm1 ; movups %%xmm1,%0" : "=m" (o) : "m" (i)); 
	printf("%x %x %x %x\n",o[0],o[1],o[2],o[3]);
}

Result on a pentium4: 

./xmm
bffff68c 8048431 8049640 8049660
bffff68c bffff68c bffff68c 8048431

So fninit seems to change something in XMM1. 

and pentium 3: 

bffff81c 8048431 8049640 8049660
bffff81c bffff81c bffff81c 8048431

changes something different ? 

If even Intel cannot agree on this it is probably safest to do an explicit
zeroing like Andrea's patch does. I retract the origina suggestion.

-Andi
