Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbTCTPJt>; Thu, 20 Mar 2003 10:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261536AbTCTPJk>; Thu, 20 Mar 2003 10:09:40 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:12967 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261522AbTCTPIM>;
	Thu, 20 Mar 2003 10:08:12 -0500
Date: Thu, 20 Mar 2003 16:19:12 +0100
From: bert hubert <ahu@ds9a.nl>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [some more data]  Re: [BUG] 2.5.65 ipv6 TCP checksum errors (capture attached)
Message-ID: <20030320151912.GA25487@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org, davem@redhat.com
References: <20030319124533.GA14363@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20030319124533.GA14363@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2003 at 01:45:33PM +0100, bert hubert wrote:
> Interestingly, the initial ssh connection worked, the second one failed.
> Subsequent attempts fail too.

I've since let loose the excellent ethereal on this and found out:

> hubert# tcpdump -r file -v -v
> 29.09 snapcount.33408 > hubert.ssh: S [tcp sum ok] 2737328594:2737328594(0) win 5760 <mss 1440,sackOK,timestamp 10690463 0,nop,wscale 0> (len 40, hlim 64)
> 29.09 hubert.ssh > snapcount.33408: S [tcp sum ok] 2399386333:2399386333(0) ack 2737328595 win 5712 <mss 1440,sackOK,timestamp 10865690 10690463,nop,wscale 0> (len 40, hlim 64)
> 29.09 snapcount.33408 > hubert.ssh: . [tcp sum ok] 1:1(0) ack 1 win 5760 <nop,nop,timestamp 10690464 10865690> (len 32, hlim 64)

So far so good.

> 29.10 hubert.ssh > snapcount.33408: P [bad tcp cksum 4f2!] 1:41(40) ack 1 win 5712 <nop,nop,timestamp 10865695 10690464> (len 72, hlim 64)
> 29.30 hubert.ssh > snapcount.33408: P [bad tcp cksum 3bf1!] 1:41(40) ack 1 win 5712 <nop,nop,timestamp 10865896 10690464> (len 72, hlim 64)
> 29.83 hubert.ssh > snapcount.33408: P [bad tcp cksum 23ef!] 1:41(40) ack 1 win 5712 <nop,nop,timestamp 10866432 10690464> (len 72, hlim 64)
> 30.86 hubert.ssh > snapcount.33408: P [bad tcp cksum 23eb!] 1:41(40) ack 1 win 5712 <nop,nop,timestamp 10867456 10690464> (len 72, hlim 64)

These packets all have an identical csum of 0x680d, it is not being updated.
So, the SYN/SYNACK/ACK stuff went fine, the initial data however has a wrong
checksum. 

For completeness, I've attached the capture again.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
--NzB8fVQJ5HfG6fxh
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=bad-csum
Content-Transfer-Encoding: base64

1MOyoQIABAAAAAAAAAAAANwFAAABAAAAiWR4Pht3AQBeAAAAXgAAAAAIoRnw8ACgzMjyXIbd
YAAAAAAoBkAgAQiIEDYAAAIIof/+GfDxIAEIiBA2AAACCKH//hnw8IKAABajKFHSAAAAAKAC
FoACJAAAAgQFoAQCCAoAox+fAAAAAAEDAwCJZHg+wHcBAF4AAABeAAAAAKDMyPJcAAihGfDw
ht1gAAAAACgGQCABCIgQNgAAAgih//4Z8PAgAQiIEDYAAAIIof/+GfDxABaCgI8Dut2jKFHT
oBIWUOuhAAACBAWgBAIICgClzBoAox+fAQMDAIlkeD5KeAEAVgAAAFYAAAAACKEZ8PAAoMzI
8lyG3WAAAAAAIAZAIAEIiBA2AAACCKH//hnw8SABCIgQNgAAAgih//4Z8PCCgAAWoyhR048D
ut6AEBaAGiIAAAEBCAoAox+gAKXMGolkeD5XigEAfgAAAH4AAAAAoMzI8lwACKEZ8PCG3WAA
AAAASAZAIAEIiBA2AAACCKH//hnw8CABCIgQNgAAAgih//4Z8PEAFoKAjwO63qMoUdOAGBZQ
aA0AAAEBCAoApcwfAKMfoFNTSC0xLjk5LU9wZW5TU0hfMy41cDEgRGViaWFuIDE6My41cDEt
NQqJZHg+7pkEAH4AAAB+AAAAAKDMyPJcAAihGfDwht1gAAAAAEgGQCABCIgQNgAAAgih//4Z
8PAgAQiIEDYAAAIIof/+GfDxABaCgI8Dut6jKFHTgBgWUGgNAAABAQgKAKXM6ACjH6BTU0gt
MS45OS1PcGVuU1NIXzMuNXAxIERlYmlhbiAxOjMuNXAxLTUKiWR4Pv/GDAB+AAAAfgAAAACg
zMjyXAAIoRnw8IbdYAAAAABIBkAgAQiIEDYAAAIIof/+GfDwIAEIiBA2AAACCKH//hnw8QAW
goCPA7reoyhR04AYFlBoDQAAAQEICgClzwAAox+gU1NILTEuOTktT3BlblNTSF8zLjVwMSBE
ZWJpYW4gMTozLjVwMS01CopkeD4pJA0AfgAAAH4AAAAAoMzI8lwACKEZ8PCG3WAAAAAASAZA
IAEIiBA2AAACCKH//hnw8CABCIgQNgAAAgih//4Z8PEAFoKAjwO63qMoUdOAGBZQaA0AAAEB
CAoApdMAAKMfoFNTSC0xLjk5LU9wZW5TU0hfMy41cDEgRGViaWFuIDE6My41cDEtNQqMZHg+
0/QJAH4AAAB+AAAAAKDMyPJcAAihGfDwht1gAAAAAEgGQCABCIgQNgAAAgih//4Z8PAgAQiI
EDYAAAIIof/+GfDxABaCgI8Dut6jKFHTgBgWUGgNAAABAQgKAKXaAACjH6BTU0gtMS45OS1P
cGVuU1NIXzMuNXAxIERlYmlhbiAxOjMuNXAxLTUKj2R4PkXxDgB+AAAAfgAAAACgzMjyXAAI
oRnw8IbdYAAAAABIBkAgAQiIEDYAAAIIof/+GfDwIAEIiBA2AAACCKH//hnw8QAWgoCPA7re
oyhR04AYFlBoDQAAAQEICgCl5wAAox+gU1NILTEuOTktT3BlblNTSF8zLjVwMSBEZWJpYW4g
MTozLjVwMS01CpZkeD6mqAkAfgAAAH4AAAAAoMzI8lwACKEZ8PCG3WAAAAAASAZAIAEIiBA2
AAACCKH//hnw8CABCIgQNgAAAgih//4Z8PEAFoKAjwO63qMoUdOAGBZQaA0AAAEBCAoApgEA
AKMfoFNTSC0xLjk5LU9wZW5TU0hfMy41cDEgRGViaWFuIDE6My41cDEtNQo=

--NzB8fVQJ5HfG6fxh--
