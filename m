Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWGRMpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWGRMpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGRMpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:45:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:60472 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751334AbWGRMpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:45:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lDSYX8RWJ2nVMeTe9ukJmpARfppr9pwwh/zUfASV/SkdpQDFnv0oS3pow+NTZQuln7LBB1BpRToeN1hj4RKhteEyKrhICnN46aKQt4ESffzRuoHDTfvUYNeU3eDR4IY9RFnIr7VIHA3bxkHHljIYWD8D8Qz7w7ObOcNxTp56hOw=
Message-ID: <d120d5000607180545v2fa45d6nab6a5132f18a1306@mail.gmail.com>
Date: Tue, 18 Jul 2006 08:45:07 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: Null dereference errors in the kernel
Cc: "Thomas Dillig" <tdillig@stanford.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <44BCA8CD.5070508@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BC5A3F.2080005@stanford.edu> <44BCA8CD.5070508@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/06, Daniel Drake <dsd@gentoo.org> wrote:
> Thomas Dillig wrote:
> > Hello,
> >
> > We are PhD students at Stanford University working on a static analysis
> > project called SATURN (http://glide.stanford.edu/saturn). We have
> > implemented a checker that finds potential null dereference errors and
> > ran our tool on the kernel version 2.6.17.1. We have identified around
> > 300 potential issues related to null errors, and we've included 20
> > sample reports below. If you would be interested, we can post all the
> > issues we found. Also, we apologize in advance if we aren't supposed to
> > post these error reports here, and we are happy to submit bug reports
> > elsewhere if you tell us where to post these.
>
> Interesting idea. I just looked at one of them out of curiosity, but I'm
> not sure it is valid. Either that or I have misunderstood the problem it
> is identifying?
>
> > [13]
> > 1176, 1180 drivers/char/isicom.c
> > Possible null dereference of variable "tty" checked for NULL at
> > (1183:drivers/char/isicom.c).
>
> This function is part of the tty_operations API, that would be a pretty
> broken interface if it provided the possibility of a NULL tty to work
> on. Additionally, all of the callers seem to do this:
>
>        tty->driver->put_char(tty, c);
>
> If tty is NULL here, we have larger problems at hand :)
>

That if (!tty...) check is bogus. The tool is apparently unhappy
because the code does:

struct isi_port *port = tty->driver_data;
....
if (!tty || !port->xmit_buf)
        return;

It looks like the problem is gone in the latest -git. The same issue
is in isicom_close() WRT port argument.

-- 
Dmitry
