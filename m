Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272744AbRILK5T>; Wed, 12 Sep 2001 06:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272746AbRILK5J>; Wed, 12 Sep 2001 06:57:09 -0400
Received: from elin.scali.no ([62.70.89.10]:29701 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S272744AbRILK5A>;
	Wed, 12 Sep 2001 06:57:00 -0400
Message-ID: <3B9F3E4B.AB5E1D12@scali.no>
Date: Wed, 12 Sep 2001 12:51:55 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: Duron kernel crash (i686 works)
In-Reply-To: <E15goos-0002le-00@the-village.bc.nu> <9184118686.20010912095919@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA wrote:
> 
> >>         ...
> >>         kernel_fpu_end();
> >> +       from-=4096;
> >> +       to-=4096;
> >> +       if(memcmp(from,to,4096)!=0) {
> >> +               printk("Athlon bug!"); //add printout of from,to,...?
> >> +               memcpy(to,from,4096);
> >> +       }
> >> }
> 
> RJD> I then get 'Athlon bug!' Still oopses.
> 
> Waah! That means movntq's moved data to some other place in memory!
> memcmp detected that and memcpy fixed, but that 'other place' was
> corrupted and that's the cause of oops.
Well, not necessarily. It might be that data just hasn't "arrived" yet because
of the movntq instruction.

One thing that also puzzels me is that my is the fast_copy_page() routine laid
out like this :

		"2: movq (%0), %%mm0\n"
		"   movntq %%mm0, (%1)\n"
		"   movq 8(%0), %%mm1\n"
		"   movntq %%mm1, 8(%1)\n"
		"   movq 16(%0), %%mm2\n"
		"   movntq %%mm2, 16(%1)\n"
		"   movq 24(%0), %%mm3\n"
		"   movntq %%mm3, 24(%1)\n"
		"   movq 32(%0), %%mm4\n"
		"   movntq %%mm4, 32(%1)\n"
		"   movq 40(%0), %%mm5\n"
		"   movntq %%mm5, 40(%1)\n"
		"   movq 48(%0), %%mm6\n"
		"   movntq %%mm6, 48(%1)\n"
		"   movq 56(%0), %%mm7\n"
		"   movntq %%mm7, 56(%1)\n"

When it's more intuitively more effective to fill the registers with reads first
and then write it with "movntq" like this :

		"2: movq (%0), %%mm0\n"
		"   movq 8(%0), %%mm1\n"
		"   movq 16(%0), %%mm2\n"
		"   movq 24(%0), %%mm3\n"
		"   movq 32(%0), %%mm4\n"
		"   movq 40(%0), %%mm5\n"
		"   movq 48(%0), %%mm6\n"
		"   movq 56(%0), %%mm7\n"
		"   movntq %%mm0, (%1)\n"
		"   movntq %%mm1, 8(%1)\n"
		"   movntq %%mm2, 16(%1)\n"
		"   movntq %%mm3, 24(%1)\n"
		"   movntq %%mm4, 32(%1)\n"
		"   movntq %%mm5, 40(%1)\n"
		"   movntq %%mm6, 48(%1)\n"
		"   movntq %%mm7, 56(%1)\n"

Regards,
-- 
  Steffen Persvold   |  Scali Computer AS   |   Try out the world's best   
 mailto:sp@scali.no  | http://www.scali.com | performing MPI implementation:
Tel: (+47) 2262 8950 |  Olaf Helsets vei 6  |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |  N0621 Oslo, NORWAY  | >300MBytes/s and <4uS latency
