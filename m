Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTFJOkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTFJOkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:40:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:60843 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262912AbTFJOkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:40:33 -0400
Date: Tue, 10 Jun 2003 09:53:41 -0500
Subject: Re: Misc 2.5 Fixes: cp-user-zoran
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
To: dipankar@in.ibm.com
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030610102255.GL2194@in.ibm.com>
Message-Id: <53B8B044-9B53-11D7-8E3D-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, Jun 10, 2003, at 05:22 US/Central, Dipankar Sarma wrote:
>
> diff -puN drivers/media/video/zr36120.c~cp-user-zoran 
> drivers/media/video/zr36120.c
> --- 
> linux-2.5.70-ds/drivers/media/video/zr36120.c~cp-user-zoran	2003-06-08 
> 04:10:38.000000000 +0530
> +++ linux-2.5.70-ds-dipankar/drivers/media/video/zr36120.c	2003-06-08 
> 04:10:38.000000000 +0530
> @@ -1693,12 +1693,12 @@ long vbi_read(struct video_device* dev,
>  			for (x=0; optr+1<eptr && x<-done->w; x++)
>  			{
>  				unsigned char a = iptr[x*2];
> -				*optr++ = a;
> -				*optr++ = a;
> +				__put_user(a, optr++);
> +				__put_user(a, optr++);
>  			}
>  			/* and clear the rest of the line */
>  			for (x*=2; optr<eptr && x<done->bpl; x++)
> -				*optr++ = 0;
> +				__put_user(0, optr++);
>  			/* next line */
>  			iptr += done->bpl;
>  		}
> @@ -1715,10 +1715,10 @@ long vbi_read(struct video_device* dev,
>  		{
>  			/* copy to doubled data to userland */
>  			for (x=0; optr<eptr && x<-done->w; x++)
> -				*optr++ = iptr[x*2];
> +				__put_user(iptr[x*2], optr++);
>  			/* and clear the rest of the line */
>  			for (;optr<eptr && x<done->bpl; x++)
> -				*optr++ = 0;
> +				__put_user(0, optr++);
>  			/* next line */
>  			iptr += done->bpl;
>  		}
> @@ -1727,7 +1727,7 @@ long vbi_read(struct video_device* dev,
>  	/* API compliance:
>  	 * place the framenumber (half fieldnr) in the last long
>  	 */
> -	((ulong*)eptr)[-1] = done->fieldnr/2;
> +	__put_user(done->fieldnr/2, ((ulong*)eptr)-1);
>  	}
>
>  	/* keep the engine running */

It's funny, I did the exact same thing for the version currently in 
bk... but I just realized that __put_user still returns an error code, 
so all those calls should be checked.

-- 
Hollis Blanchard
IBM Linux Technology Center

