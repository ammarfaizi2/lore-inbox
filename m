Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSFJHBz>; Mon, 10 Jun 2002 03:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSFJHBz>; Mon, 10 Jun 2002 03:01:55 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:48356 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316705AbSFJHBs> convert rfc822-to-8bit; Mon, 10 Jun 2002 03:01:48 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
Date: Mon, 10 Jun 2002 17:03:13 +1000
User-Agent: KMail/1.4.5
Cc: mc@cs.Stanford.EDU
In-Reply-To: <200206100355.UAA17040@csl.Stanford.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206101703.13780.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002 13:55, Dawson Engler wrote:
Thanks for these. Patch for 2.4.19-pre10 to fix catc and se401 bugs currently 
compile testing :)

But I think that you have a problem identifying the errors in these cases.


> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1430:se401_init:
> ERROR:NULL:1427:1430:Using ptr "(*se401).width" illegally! set by
> 'kmalloc_Rsmp_93d4cfe6':1427 [COUNTER=kmalloc_Rsmp_93d4cfe6:1427] [fit=46]
> [fit_fn=4] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z =
> -3.11592335081808] [fn-z = -7.54983443527075] return 1;
> 	}
> 	sprintf (temp, "ExtraFeatures: %d", cp[3]);
>
> 	se401->sizes=cp[4]+cp[5]*256;
> Start --->
> 	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	for (i=0; i<se401->sizes; i++) {
> Error --->
> 		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
> 		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
> 	}
> 	sprintf (temp, "%s Sizes:", temp);
> ---------------------------------------------------------
bradh: this one is right.

> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1435:se401_init:
> ERROR:NULL:1427:1435:Using ptr "(*se401).width" illegally! set by
> 'kmalloc_Rsmp_93d4cfe6':1427 [COUNTER=kmalloc_Rsmp_93d4cfe6:1427] [fit=46]
> [fit_fn=4] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z =
> -3.11592335081808] [fn-z = -7.54983443527075] return 1;
> 	}
> 	sprintf (temp, "ExtraFeatures: %d", cp[3]);
>
> 	se401->sizes=cp[4]+cp[5]*256;
> Start --->
> 	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	for (i=0; i<se401->sizes; i++) {
> 		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
> 		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
> 	}
> 	sprintf (temp, "%s Sizes:", temp);
> 	for (i=0; i<se401->sizes; i++) {
> Error --->
> 		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
> 	}
> 	info("%s", temp);
> 	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->size
>s-1]*3; ---------------------------------------------------------
bradh: this one is wrong. If it didn't oops on the previous one, it won't oops 
here :)

> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1438:se401_init:
> ERROR:NULL:1427:1438:Using ptr "(*se401).width" illegally! set by
> 'kmalloc_Rsmp_93d4cfe6':1427 [COUNTER=kmalloc_Rsmp_93d4cfe6:1427] [fit=46]
> [fit_fn=4] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z =
> -3.11592335081808] [fn-z = -7.54983443527075] return 1;
> 	}
> 	sprintf (temp, "ExtraFeatures: %d", cp[3]);
>
> 	se401->sizes=cp[4]+cp[5]*256;
> Start --->
> 	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	for (i=0; i<se401->sizes; i++) {
> 		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
> 		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
> 	}
> 	sprintf (temp, "%s Sizes:", temp);
> 	for (i=0; i<se401->sizes; i++) {
> 		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
> 	}
> 	info("%s", temp);
> Error --->
> 	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->size
>s-1]*3;
>
> 	rc=se401_sndctrl(0, se401, SE401_REQ_GET_WIDTH, 0, cp, sizeof(cp));
> 	se401->cwidth=cp[0]+cp[1]*256;
> ---------------------------------------------------------
bradh: this can't be the error, see above.

> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1431:se401_init:
> ERROR:NULL:1428:1431:Using ptr "(*se401).height" illegally! set by
> 'kmalloc_Rsmp_93d4cfe6':1428 [COUNTER=kmalloc_Rsmp_93d4cfe6:1428] [fit=46]
> [fit_fn=5] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z =
> -3.11592335081808] [fn-z = -7.54983443527075] }
> 	sprintf (temp, "ExtraFeatures: %d", cp[3]);
>
> 	se401->sizes=cp[4]+cp[5]*256;
> 	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> Start --->
> 	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	for (i=0; i<se401->sizes; i++) {
> 		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
> Error --->
> 		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
> 	}
> 	sprintf (temp, "%s Sizes:", temp);
> 	for (i=0; i<se401->sizes; i++) {
> ---------------------------------------------------------
This is the true bug.

> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1435:se401_init:
> ERROR:NULL:1428:1435:Using ptr "(*se401).height" illegally! set by
> 'kmalloc_Rsmp_93d4cfe6':1428 [COUNTER=kmalloc_Rsmp_93d4cfe6:1428] [fit=46]
> [fit_fn=5] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z =
> -3.11592335081808] [fn-z = -7.54983443527075] }
> 	sprintf (temp, "ExtraFeatures: %d", cp[3]);
>
> 	se401->sizes=cp[4]+cp[5]*256;
> 	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> Start --->
> 	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	for (i=0; i<se401->sizes; i++) {
> 		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
> 		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
> 	}
> 	sprintf (temp, "%s Sizes:", temp);
> 	for (i=0; i<se401->sizes; i++) {
> Error --->
> 		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
> 	}
> 	info("%s", temp);
> 	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->size
>s-1]*3; ---------------------------------------------------------
This can't be.

> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1438:se401_init:
> ERROR:NULL:1428:1438:Using ptr "(*se401).height" illegally! set by
> 'kmalloc_Rsmp_93d4cfe6':1428 [COUNTER=kmalloc_Rsmp_93d4cfe6:1428] [fit=46]
> [fit_fn=5] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z =
> -3.11592335081808] [fn-z = -7.54983443527075] }
> 	sprintf (temp, "ExtraFeatures: %d", cp[3]);
>
> 	se401->sizes=cp[4]+cp[5]*256;
> 	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> Start --->
> 	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> 	for (i=0; i<se401->sizes; i++) {
> 		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
> 		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
> 	}
> 	sprintf (temp, "%s Sizes:", temp);
> 	for (i=0; i<se401->sizes; i++) {
> 		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
> 	}
> 	info("%s", temp);
> Error --->
> 	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->size
>s-1]*3;
>
> 	rc=se401_sndctrl(0, se401, SE401_REQ_GET_WIDTH, 0, cp, sizeof(cp));
> 	se401->cwidth=cp[0]+cp[1]*256;
> ---------------------------------------------------------
This can't be.


