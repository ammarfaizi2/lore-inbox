Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSHBSRT>; Fri, 2 Aug 2002 14:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSHBSRT>; Fri, 2 Aug 2002 14:17:19 -0400
Received: from pool-129-44-58-21.ny325.east.verizon.net ([129.44.58.21]:51717
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S316390AbSHBSRS>; Fri, 2 Aug 2002 14:17:18 -0400
Date: Fri, 2 Aug 2002 14:20:46 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [RFC] Push BKL into chrdev opens
Message-ID: <20020802142046.A28878@arizona.localdomain>
References: <3D490BF2.2000709@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D490BF2.2000709@us.ibm.com>; from haveblue@us.ibm.com on Thu, Aug 01, 2002 at 03:22:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 03:22:42AM -0700, Dave Hansen wrote:
> This patch adds the BKL to each character device's open() function. 
> The BKL will remain in chrdev_open() until the module unload races are 
> fixed, but this makes it unnecessary there for any other reason.
[...]
> diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
> --- a/drivers/char/istallion.c	Wed Jul 31 10:25:53 2002
> +++ b/drivers/char/istallion.c	Wed Jul 31 10:25:53 2002
> @@ -1022,6 +1022,8 @@
>  
>  /*****************************************************************************/
>  
> +#define returnout(x) ret=x;goto out;
> +
>  static int stli_open(struct tty_struct *tty, struct file *filp)
>  {
>  	stlibrd_t	*brdp;
> @@ -1037,21 +1039,21 @@
>  	minordev = minor(tty->device);
>  	brdnr = MINOR2BRD(minordev);
>  	if (brdnr >= stli_nrbrds)
> -		return(-ENODEV);
> +		returnout(-ENODEV);

Hi Dave,

The returnout macro is incredibly ugly.  It is also broken.  (The "goto
out" is on the same level as the if and is executed regardless of the if
condition.)

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
