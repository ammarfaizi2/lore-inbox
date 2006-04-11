Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWDKX7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWDKX7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDKX7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:59:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751091AbWDKX7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:59:23 -0400
Date: Tue, 11 Apr 2006 16:59:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: John Heffner <jheffner@psc.edu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 regression: Very slow net transfer from some hosts
Message-ID: <20060411165913.5b6bfa0b@localhost.localdomain>
In-Reply-To: <443C4471.7040407@gentoo.org>
References: <443C03E6.7080202@gentoo.org>
	<443C024C.2070107@psc.edu>
	<443C0B74.50305@gentoo.org>
	<443C09A7.2040900@psc.edu>
	<443C1738.20605@gentoo.org>
	<443C178B.3030805@psc.edu>
	<443C2BBA.5010804@gentoo.org>
	<20060411153315.4132b477@localhost.localdomain>
	<443C4471.7040407@gentoo.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006 01:06:09 +0100
Daniel Drake <dsd@gentoo.org> wrote:

> Stephen Hemminger wrote:
> >> This is very familiar, and I just found the article I was thinking of: 
> >> http://lwn.net/Articles/92727/
> >>
> >> I was also hit by that bug, on the same collection of websites, but that 
> >> particular problem was fixed for 2.6.8 or so. So I guess it is extremely 
> >> likely that my ISP has broken routers. nmap isn't able to identify the 
> >> OS of any ISP routers in my path.
> > 
> > We never fixed it, its kind of hard to fix other peoples equipment ;-)
> 
> Weird, things started working for me around 2.6.9 without having to 
> modify any sysctl stuff.

What we did was default the window scaling needed to match the max
possible memory usage.  The normal value for tcp_wmem correlated to 
a window scale of 2.  If a corrupting middlebox lost the window
scale option, then connection would proceed but all windows would
be 1/4 of possible; and connection would still limp along at
somewhat reduced bandwidth.

John's changes cause tcp_wmem to be bigger, so we ask for a bigger
window scale. If the "window scale lost in translation" problem gets
too bad, the sender will never send anything because it thinks
the receiver is doing silly-window-syndrome.


> 
> > Turn off TCP window scaling, your performance will be limited but about
> > as good as you can get with a corrupting firewall in between.
> 
> I was wrong in my previous mail where I said that the rmem/wmem output 
> hasn't changed over the two kernels - it has, the 3rd column differs. I 
> simply set those values back to what they were on 2.6.16 and now things 
> work again - I presumably have window scale 2 (scale factor 4) again, 
> which appears to be a decent compromise between having a window and 
> things actually working.
> 
> For anyone else interested, the ISP is NTL (UK). The fix:
> 
> 	echo "4096    16384   131072 " > /proc/sys/net/ipv4/tcp_wmem
> 	echo "4096    87380   174760 " > /proc/sys/net/ipv4/tcp_rmem
> 
> 
> This issue is visible on my 1GB system but not on my laptop (256mb RAM). 
> The key thing is that more memory means a higher window scale factor is 
> used, which appears to trigger ntl's brokenness.
> 
> Daniel
