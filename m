Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTK0H1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 02:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTK0H1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 02:27:12 -0500
Received: from blr-dsmaster.blr.novell.com ([164.99.147.9]:45604 "EHLO
	BLR-DSMASTER.BLR.NOVELL.COM") by vger.kernel.org with ESMTP
	id S264436AbTK0H1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 02:27:11 -0500
Subject: Re: Fix for "MT2032 Fatal Error: PLLs didn't lock"
From: "Subbu K. K." <kksubramaniam@novell.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1069743507.1270.2.camel@dog.blr.novell.com>
References: <20031124004835.3abbb4cf.akpm@osdl.org>
	 <20031124114620.GA29771@bytesex.org>
	 <1069743507.1270.2.camel@dog.blr.novell.com>
Content-Type: text/plain
Message-Id: <1069917999.1914.85.camel@dog.blr.novell.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 27 Nov 2003 12:56:39 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-25 at 12:28, Subbu K. K. wrote:
> Let me poke around in the assembly code tonight to find out why the sign
> change happens on my box. I suspect this could be due to gcc/athlon
> combo.
> 
ok. Found the error.

bttv-0.7.103 and earlier (kernel 2.4.20 and earlier) had the following
lines in two places:
  mt2032_set_if_freq(c,freq* 1000*1000/16, ...
When freq is defined as int, this computation causes a sign extension
error when freq is 2244 (140.25MHz). The error disappears if
1000*1000/16 is replaced with 62500 and/or if freq is defined as
unsigned int.

Here is a simple test to surface this error:
// test with gcc -o signext signext.c && ./signext
main(int argc, char *argv[])
{
	int s; unsigned f;

	s = 2244; f = s;
	printf("freq=%d rfin=%d\n", s*62500, s*1000*1000/16);
	printf("freq=%d rfin=%d\n", f*62500, f*1000*1000/16);
}
the output shows:
freq=14025000 rfin=-128185456
freq=14025000 rfin=140250000

bttv-0.7.104+ and kernel 2.4.21+ have the fix. Still, I thought of
recording the error for those still on older kernels.

Subbu K. K.

