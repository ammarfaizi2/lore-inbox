Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWI2Ty4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWI2Ty4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWI2Tyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:54:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50313 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161890AbWI2Tyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:54:54 -0400
Subject: Re: [PATCH] fix compiler warning in drivers/media/video/video-buf.c
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@google.com>, Sujoy Gupta <sujoy@google.com>,
       LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com
In-Reply-To: <20060928105108.88b37304.akpm@osdl.org>
References: <451C070E.8080800@google.com>
	 <20060928105108.88b37304.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 29 Sep 2006 16:54:07 -0300
Message-Id: <1159559648.10055.35.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2006-09-28 às 10:51 -0700, Andrew Morton escreveu:
> On Thu, 28 Sep 2006 10:31:58 -0700
> Martin Bligh <mbligh@google.com> wrote:

> That being said, this driver is wrong to be storing dma addresses in a
> void*.  And indeed there is a FIXME regarding this at
> include/linux/videodev2.h:476, so I guess hiding this warning won't obscure
> any fault which wasn't already known about..

Yes. The original structure is:

struct v4l2_framebuffer
{
        __u32                   capability;
        __u32                   flags;
        void*                   base;
        struct v4l2_pix_format  fmt;
};

Since this is used at ioctl definition, changing this would break
userspace apps. We might replace this to something like:

struct v4l2_framebuffer
{
        __u32                   capability;
        __u32                   flags;
	union {
	        void*		base_ptr; /*FOO definition to avoid breaking userpace apps */
		dma_addr_t	base;
	}
        struct v4l2_pix_format  fmt;
};

This way, base will have the expected type, and it won't break any
userspace app if sizeof(void *)<=sizeof(base). I think this is true for
all architectures (anyway, if it isn't, v4l is broken anyway).

What do you think?

Cheers, 
Mauro.

