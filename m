Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSFKEEg>; Tue, 11 Jun 2002 00:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSFKEEf>; Tue, 11 Jun 2002 00:04:35 -0400
Received: from [209.237.59.50] ([209.237.59.50]:4202 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S316746AbSFKEEe>; Tue, 11 Jun 2002 00:04:34 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: wjhun@ayrnetworks.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <15619.9534.521209.93822@nanango.paulus.ozlabs.org>
	<20020609.212705.00004924.davem@redhat.com>
	<20020610110740.B30336@ayrnetworks.com>
	<20020610.201033.66168406.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 21:04:30 -0700
Message-ID: <52lm9m7969.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    David> Wait a second, forget all of this cache alignment crap.  If
    David> we can avoid drivers seeing it, we should by all means
    David> necessary.

    David> We should just tell people to use PCI pools and be done
    David> with it.  That way all the complexity about buffer
    David> alignment and all this other crapola lives strictly inside
    David> of the PCI pool code.

That's fine but there are drivers (USB, etc) doing

	struct something {
	        int field1;
	        char dma_buffer[SMALLER_THAN_CACHE_LINE];
	        int field2;
	};

	struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);

Do they have to change to

	struct something {
	        int field1;
	        char *dma_buffer;
	        int field2;
	};

	struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
        dev->dma_buffer = kmalloc(SMALLER_THAN_CACHE_LINE, GFP_KERNEL);

(This is always safe because as you said kmalloc can never return a
slab that's not safe for DMA)  I don't see how PCI pools help here.

Best,
  Roland
