Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSHZTvV>; Mon, 26 Aug 2002 15:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSHZTvV>; Mon, 26 Aug 2002 15:51:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3589 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318231AbSHZTvT>; Mon, 26 Aug 2002 15:51:19 -0400
Date: Mon, 26 Aug 2002 20:55:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Reinhard Moosauer <rm@moosauer.de>, linux-kernel@vger.kernel.org
Subject: Re: Want to test a patch: H323-masquerading in Linux 2.4 (SuSE 8.0)
Message-ID: <20020826205531.D4763@flint.arm.linux.org.uk>
References: <200208261757.53371.rm@moosauer.de> <Pine.LNX.4.44.0208261013250.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208261013250.3234-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Mon, Aug 26, 2002 at 10:17:20AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 10:17:20AM -0600, Thunder from the hill wrote:
> I've put a patch by David Hildeshagen (url...) at 
> <URL:http://m1b.de/content/know/linux/nat_h323_suse80.html> which was 
> ported to Linux Kernel 2.4.18, as from SuSE 8.0. (I've manually resolved 
> all the rejects.)
> 
> Works for me. Maybe somebody is interested in testing the whole thing. I'm 
> looking forward to comments.
> 
> Kind regards, Reinhard.
> 
> That's the translation, for the interested...

thanks for the translation. 8)

I'd like to point out that there are some problems with the H.323 NAT
modules:

+	for (i = 0; data < (data_limit - 5); data++, i++) {
+		data_ip = *((u_int32_t *)data);
+		if (data_ip == iph->saddr) {
+			data_port = *((u_int16_t *)(data + 4));

These modules scan byte by byte the packets for source IPs in order
to perform NAT, and will modify the contained data based on what they
find.

Consider the chances of your IP address coming up in some essentially
random data.  For example, if I had the ip address (iirc) 3.0.0.163
then the effect if the nat modules would be to rewrite the RFC1006
header which is part of these packets, thereby destroying the packet
completely.  (iirc the 4 byte RFC1006 header on packets leaving me
contained the values 0x03 0x00 0x00 0xa3; since they'll always start
with 0x03 0x00 <16-bit len>, anyone using a 3.0.x.x IP address with
these modules are likely to rewrite the RFC1006 header.)

My main point here is that given the right IP address and this method
of "NAT"ing the contained data, any data contained within the packet
will be altered in some manner causing unexpected failures.

Unfortunately H.323 is a rather opaque protocol which appears to
require lots of knowledge about the data contained within the packet
to decode it properly.

(Oh, and guess who renumbered their network to eliminate the NAT rather
than run the H.323 netfilter modules.  Umm, and the IETF appear to have
lost RFC1006 from their web site; either that or Mozilla is getting
stressed again.  However, RFC1006 has been updated by RFC2126 and the
TPKT header can be found within that document.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

