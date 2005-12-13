Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVLMPnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVLMPnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLMPnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:43:42 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:20693 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751031AbVLMPnm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:43:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q8kHCUStHoOZ9LFie3cVsYV3xNwmAuWis0wC9p5J8CTuRPR9X/JyuK01Dcppuir7AsHFULG335PNMsmtgt6kXasuGSazA5HDHD0IVe1xiOy2nxWHrNtRVniRUBOk3QcSGLsfAjdx3TNz6+iDulSSSzavfsiQjlhSeVOJyLybNaQ=
Message-ID: <41840b750512130743n39acbe28qced81c909c7c5187@mail.gmail.com>
Date: Tue, 13 Dec 2005 17:43:40 +0200
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Subject: Re: tp_smapi conflict with IDE, hdaps
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1134486843.28684.89.camel@betsy.boston.ximian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486843.28684.89.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Robert Love <rlove@rlove.org> wrote:
> On Tue, 2005-12-13 at 16:35 +0200, Shem Multinymous wrote:
> Alan's response is the correct course of action here,

Ideally, but I'm not sure we understand the interface sufficiently
well to abstract it beyond a mere mutex. Compare your hdaps.c code to
the following relevant code from tp_smapi.c (stripped down a bit for
simplicty):

----------------------------------------
#define APS_ROW_LEN 16
static int read_aps_row(u8 arg1610, u8 arg161F, u8* buf) {
	int retries, i;
	int ret = -EIO;

	for (retries=APS_MAX_RETRIES; retries>0; --retries) {
		if (inb(0x1604)&0x40) { /* readout pending? */
			inb(0x161F); /* discard it */
			udelay(10);
		} else {
			outb(arg1610, 0x1610);
			if (inb(0x1604)&0x20)
				goto wrote1610;
		}
	}
	goto out;
wrote1610:
	outb(arg161F, 0x161F);
	for (retries=APS_MAX_RETRIES; retries>0; --retries) {
		if (inb(0x1604)&0x40) /* readout pending? */
			goto gotdata;
			udelay(10);
	}
	goto out;
gotdata:
	for (i=0; i<APS_ROW_LEN; ++i) {
		buf[i] = inb(0x1610+i);
	}
	ret = 0;
out:
	return ret;
}
----------------------------------------
(Yes, the loop/goto structure should be cleanup up a bit.)

Not to mention the HDAPS init code, which is voodoo.


> question: What other data in 0x1604-0x161F is there?

I looked only at the readout "rows" given by arg1610=1,..,18 and
arg161F=0,1. In that range, I didn't see anything obviously
interesting in the "rows" not already used by the battery readout and
HDAPS. I don't think any of the Windows driver reads other "rows". But
for all we know, this could be a window into the embedded controller's
memory or something of the sorts. Also, some of these "rows" are
actually commands given during HDAPS init, so the "read_row"
abstraction is obviously not accurate.

  Shem
