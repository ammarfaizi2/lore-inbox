Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272735AbRIGPql>; Fri, 7 Sep 2001 11:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272734AbRIGPqb>; Fri, 7 Sep 2001 11:46:31 -0400
Received: from mx4.port.ru ([194.67.57.14]:33803 "EHLO smtp4.port.ru")
	by vger.kernel.org with ESMTP id <S272732AbRIGPqW>;
	Fri, 7 Sep 2001 11:46:22 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109072009.f87K92G06330@vegae.deep.net>
Subject: Re: Recent kernels sound crash  solution found?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Sep 2001 20:09:01 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15fNMa-0001qL-00@the-village.bc.nu> from "Alan Cox" at Sep 07, 2001 04:16:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Alan Cox wrote:"
> 
> >       * comment to point 2: very rare circumcistances includes
> >    that some time should pass to fragment memory
> 
> The alloc_dmap code returns -ENOMEM when the allocation fails. That causes
> the open_dmap call to return -ENOMEM which in turn causes DMAbuf_open
> to return -ENOMEM which causes audio_openb to return -ENOMEM, which gets
> back to userspace. 
> 
> I don't see a problem.
> 
> [sound btw also supports a module option to keep the dmabuffers allocated
>  once and hang onto them]
> 
   Alan, actually i wanted to tell you about other place:
from dmabuf.c:
        /*
         * Now loop until we get a free buffer. Try to get smaller buffer if
         * it fails. Don't accept smaller than 8k buffer for performance
         * reasons.
         */
    ===>  _here_ is a dead-loop  <===
        while (start_addr == NULL && dmap->buffsize > PAGE_SIZE) {
                for (sz = 0, size = PAGE_SIZE; size < dmap->buffsize; sz++, size                dmap->buffsize = PAGE_SIZE * (1 << sz);
                start_addr = (char *) __get_free_pages(GFP_ATOMIC|GFP_DMA, sz);
                if (start_addr == NULL)
                        dmap->buffsize /= 2;
        }

      Solutions:
        1. make it accept 0-order allocations
        2. make CONFIG_SOUND_DMAP not a config, but the only option   


cheers, Sam

