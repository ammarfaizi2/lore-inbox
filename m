Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUJKQZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUJKQZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbUJKQXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:23:42 -0400
Received: from us1.server44secre01.de ([80.190.243.163]:52167 "EHLO
	us1.server44secre01.de") by vger.kernel.org with ESMTP
	id S269097AbUJKQWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:22:23 -0400
Date: Mon, 11 Oct 2004 18:21:53 +0200
To: Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041011162153.GA9101@t-online.de>
References: <20041007165410.GA2306@t-online.de> <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org> <20041009092801.GC3482@bytesex> <20041009112839.GA2908@t-online.de> <20041009121845.GE3482@bytesex> <20041010085541.GA1642@t-online.de> <20041011151455.GC23632@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011151455.GC23632@bytesex>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 05:14:55PM +0200, Gerd Knorr wrote:
> > +#define VTXIOCGETINFO	_IOR  (0x81,  1, vtx_info_t)
> > +#define VTXIOCCLRPAGE	_IOW  (0x81,  2, vtx_pagereq_t)
> > +#define VTXIOCCLRFOUND	_IOW  (0x81,  3, vtx_pagereq_t)
> > +#define VTXIOCPAGEREQ	_IOW  (0x81,  4, vtx_pagereq_t)
> > +#define VTXIOCGETSTAT	_IOW  (0x81,  5, vtx_pagereq_t)
> > +#define VTXIOCGETPAGE	_IOW  (0x81,  6, vtx_pagereq_t)
> > +#define VTXIOCSTOPDAU	_IOW  (0x81,  7, vtx_pagereq_t)
> 
> Hmm, _IOW for VTXIOCGET* looks bogous, is that really correct?

This is the definition of the argument to the VTXIOCGET* IOCTLs:

typedef struct 
{
	int page;	/* number of requested page (hexadecimal) */
	int hour;	/* requested hour (hexadecimal) */
	int minute;	/* requested minute (hexadecimal) */
	int pagemask;	/* mask defining which values of the above are set */
	int pgbuf;	/* buffer where page will be stored */
	int start;	/* start of requested part of page */
	int end;	/* end of requested part of page */
	void __user *buffer;	/* pointer to beginning of destination buffer */
}
vtx_pagereq_t;

The driver returns all data in the buffer field. Copying there is done by a seperate call to
copy_to_user(). All other fields are never changed by the driver. So the _IOW definition is ok.

> Note that you often need RW for read/get ioctls because even these
> often pass data to the driver as well (for example the vtx page number
> you want query the status for).  Please double-check that.  Otherwise
> the patch looks ok to me.

Thank you! Andrew, could you please forward the patch? 
Suggestion for a comment line:
Videotext: IOCTLs changed to match _IO macros in linux/ioctl.h

Michael
