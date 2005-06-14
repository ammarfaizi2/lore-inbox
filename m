Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVFNUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFNUGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVFNUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:06:52 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:26528 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261318AbVFNUGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:06:38 -0400
Date: Tue, 14 Jun 2005 22:04:45 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050614200445.GA28134@electric-eye.fr.zoreil.com>
References: <26107136.1118758462265.JavaMail.www@wwinf1518>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26107136.1118758462265.JavaMail.www@wwinf1518>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[20050613-2.6.12-rc-sis190-test.patch]
> I tried it : 
> - false mode detection
> - as you expected, ping -s 157 was OK, ping -s 158 failed.
> 
> Nice, it begins to work!

Yes.

Notice how the supposedly Rx DMA address ends in your log:
sk_buff[0]->tail = ffff810006a3e012
                                  ^
I have tweaked the rx copybreak path to perform a shift from two bytes
before this address and surprisingly enough we get exactly the two
missing bytes. The normal path has not been modified and it is taken
as soon as there is at least 200 bytes of data, i.e. your 186 icmp
payload: it fails as it misses two bytes. Two possible explanations:
1 - I can not find where the two bytes are lost and it is actually a bug
    in the driver. So far, you have been quite good at detecting my mistakes.
    You know what you have to do :o)
2 - the asic can only DMA to a 4 bytes aligned address.

(actually the asic could also always DMA 2 bytes before the expected address,
whatever the adress, but I'd be happily surprized).

If 2) applies, the driver will need an extra copy to align the IP headers
(or someone will find some secret documentation which explains how to
remove two bytes and fix the issue).

The patch of the day uses a 4 bytes aligned Rx buffer address (at least for
the usual MTU) and copies the Rx data. Can you reproduce the usual testing
and tell if it makes a difference ?

Patch available at:
http://www.fr.zoreil.com/people/francois/misc/20050614-2.6.12-rc-sis190-test.patch

--
Ueimor
