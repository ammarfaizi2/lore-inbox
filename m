Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271413AbRIAVhg>; Sat, 1 Sep 2001 17:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271419AbRIAVh2>; Sat, 1 Sep 2001 17:37:28 -0400
Received: from tantalophile.demon.co.uk ([193.237.65.219]:26496 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S271413AbRIAVhS>; Sat, 1 Sep 2001 17:37:18 -0400
Date: Sat, 1 Sep 2001 22:26:59 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andries.Brouwer@cwi.nl
Cc: viro@math.psu.edu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC] lazy allocation of struct block_device
Message-ID: <20010901222659.A4089@thefinal.cern.ch>
In-Reply-To: <200109012042.UAA17644@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109012042.UAA17644@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Sep 01, 2001 at 08:42:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     From viro@math.psu.edu Sat Sep  1 18:26:53 2001
>     > A kdev_t is a pointer to a struct that has the info now found in
>     > the arrays (and major, minor fields, and a name function..).
>     > This struct is allocated by the driver.
> 
>     Umm... Apply the arguments from the char_device thread - pointers to
>     unions are rather bad idea.  IOW, kdev_t must die - kernel always
>     knows which kind we are dealing with.
>[...]
> However, a union is not so bad. It seems a pity to avoid unions
> and waste 4 bytes for every inode with separate i_bdev and i_cdev
> instead of a single i_bcdev.

Please, a union of different pointer types is much nicer.  You can have
i_bdev and i_cdev without wasting any bytes.

This form works with GCC 2.96:

		union {
			struct char_device * i_cdev;
			struct block_device * i_bdev;
		};

If you're using a really old compiler that doesn't support anonymous unions,
(GCC 2.95 might be in this category, I'm not sure), then you'll need this:

	#define i_bdev __i_bcdev_union.i_bdev
	#define i_cdev __i_bcdev_union.i_cdev
		union {
			struct char_device * i_cdev;
			struct block_device * i_bdev;
		} __i_bcdev_union;

Either way, you avoid pointers to unions and you also avoid having a
named union type which contains pointers.

-- Jamie
