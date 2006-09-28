Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWI1AQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWI1AQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWI1AQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:16:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15650 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965168AbWI1AQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:16:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JUwkDMEbkeRvpokRxEBkLAJhdFcVLEjoa3AwDPzax84395+iglhYL19P01vcTSauX3OKzEihoRenZ0s27MMmTsxJohzUfQLn3MPjRHHBOcmtYwbOnqQYplHjBxMxMMxDsuTRfIoPUqQC1kLcuumRsgmGo6rALFucq220O4554Og=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: James Ketrenos <jketreno@linux.intel.com>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed: info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
Date: Thu, 28 Sep 2006 02:15:18 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Jouni Malinen <jkmaline@cc.hut.fi>
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com> <20060927131849.ba64412c.akpm@osdl.org> <451B01FB.2000408@linux.intel.com>
In-Reply-To: <451B01FB.2000408@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609280215.18561.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 00:58, James Ketrenos wrote:
> Andrew Morton wrote:
> > On Wed, 27 Sep 2006 13:47:18 -0700
> > James Ketrenos <jketreno@linux.intel.com> wrote:
> > 
> >> +static int snprint_line(char *buf, size_t count,
> >> +			const u8 * data, u32 len, u32 ofs)
> >> +{
> >> +	int out, i, j, l;
> >> +	char c;
> >> +
> >> +	out = snprintf(buf, count, "%08X", ofs);
> >> +
> >> +	for (l = 0, i = 0; i < 2; i++) {
> >> +		out += snprintf(buf + out, count - out, " ");
> >> +		for (j = 0; j < 8 && l < len; j++, l++)
> >> +			out += snprintf(buf + out, count - out, "%02X ",
> >> +					data[(i * 8 + j)]);
> >> +		for (; j < 8; j++)
> >> +			out += snprintf(buf + out, count - out, "   ");
> >> +	}

Dumping this will slow things down,
there will be a lot of calls to snprinf.
Consider making it a bit less slow by handling
full 16-byte lines a bit faster, like:

	if (len >= 16) {
		printk( "%02X %02X %02X %02X %02X %02X %02X %02X  "
			"%02X %02X %02X %02X %02X %02X %02X %02X ",
			ptr[0], ptr[1], ptr[2], ptr[3],
			ptr[4], ptr[5], ptr[6], ptr[7],
			ptr[8], ptr[9], ptr[10], ptr[11],
			ptr[12], ptr[13], ptr[14], ptr[15]);
		num -= 16;
		ptr += 16;
	}

Just my 0.02 euros
--
vda
