Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWFAKZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWFAKZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWFAKZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:25:11 -0400
Received: from gw.openss7.com ([142.179.199.224]:40857 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S965016AbWFAKZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:25:09 -0400
Date: Thu, 1 Jun 2006 04:24:57 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601042457.B25584@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <20060601001825.A21730@openss7.org> <20060601063012.GC28087@2ka.mipt.ru> <20060601004608.C21730@openss7.org> <20060601070136.GA754@2ka.mipt.ru> <20060601011125.C22283@openss7.org> <20060601083805.GB754@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060601083805.GB754@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Thu, Jun 01, 2006 at 12:38:05PM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Thu, 01 Jun 2006, Evgeniy Polyakov wrote:

For purely random numbers you could amplify thermal noise off an
open transitor junction (the audiofile's white noise generator)
and feed it into an analog to digital converter.

> 
> I've run it with following source ip/port selection algo:
> 	if (++sport == 0) {
> 		saddr++;
> 		sport++;
> 	}
> 
> Starting IP was 1.1.1.1 and sport was 1.
> Destination IP and port are the same 192.168.0.1:80
> 
> Jenkins hash started to show different behaviour:
> it does not have previous artefacts, but instead it's dispersion is
> _much_ wider than in XOR case.

Aha!  But perhaps this is too easy a data set.  HTTP clients typically
dynamically allocate port numbers within a range and source address
are typically not less than a certain value.  That is why I suggested
something like:

       sport = 10000;
       saddr = 0x0a000000;  /* 10.0.0.0 */

       ...

       if (++sport == 16000) {
	       sport = 10000;
	       saddr++;
       }

If this shows artifacts worse than XOR then more realistic gaps in the
input values will cause artifacts.

> 
> With following ip/port selection algo:
> 	if (++sport == 0) {
> 		//saddr++;
> 		sport += 123;
> 	}
> 
> I see yet another jenkins artefacts, but again different from previous
> two.

Adding primes.  Again, the arithmetic series of primes might auto-correlate
with the Jenkins function.  Or it plain might not like gaps.

> 
> But each time both folded and not folded hashes behave exactly the same.
> 
> > Can you show the same artifacts for jenkins_3word?
> 
> What should be used as starting point there?
> If I use 0 it is the same as jhash_2words().
> If I use 123123 - artefacts are the same, just slighly shifted (I tested
> only the latest test above though).
> 
> Looking into the code we can see that jhash_2words() is jhash_3words()
> with zero "C" value, so it will show the same nature.

Skip that then.
