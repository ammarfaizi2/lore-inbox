Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbULPOTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbULPOTH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbULPOTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:19:07 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:19614 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S262685AbULPORq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:17:46 -0500
In-Reply-To: <20041216060346.GH17946@alpha.home.local>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com> <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org> <20041216060346.GH17946@alpha.home.local>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3FD33CA0-4F6D-11D9-91A1-003065B11AE8@dberg.org>
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
From: Adam Denenberg <adam@dberg.org>
Subject: Re: bind() udp behavior 2.6.8.1
Date: Thu, 16 Dec 2004 09:17:42 -0500
To: Willy Tarreau <willy@w.ods.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the issue with this currently is that the resolver is not using a new 
"Transaction ID" in the DNS porttion of the packet.  This is the one 
unique piece of informatino that helps distinguish what query belongs 
to what response (since same source port and ip is used).  So if the 
transaction id in the DNS header of the query is not updated, there is 
no real way to distinguish these dns requests.  Also keep in mind the 
linux box is requesting the same A record, so even that is not unique 
among these requests.

I am trying to figure out why the resolver (redhat 8 glibc) is behaing 
this way, b/c it is breaking applications.  If it simply updated its 
transaction ID in the packet i dont think this would be an issue.

thanks
adam


Please CC me I am not on this list.


On Dec 16, 2004, at 1:03 AM, Willy Tarreau wrote:

> On Tue, Dec 14, 2004 at 09:23:43PM -0500, Adam Denenberg wrote:
>> i think you guys are all right.  However there is one concern.  Not
>> clearing out a UDP connection in a firewall coming from a high port is
>> indeed a security risk.  Allowing a high numbered udp port to remain
>> open for a prolonged period of time would definitely impose a security
>> risk which is why the PIX is doing what it does.
>
> Absolutely NO ! it is not "keeping the port open", it is "keeping a 
> SESSION
> open". The firewall should allow traffic from the same ip:port to the 
> other
> ip:port and from no other server on the net. You new session is totally
> unrelated to the old one.
>
>>  The linux server is
>> "reusing" the same UDP high numbered socket however it is doing so
>> exactly as the firewall is clearing its state table (60 ms) from the
>> first connection which is what is causing the issue.
>
> it is not the same session if you connect to a different remote server,
> and there is absolutely no reason to arbitrary prevent an internal 
> server
> from connecting to two external ones from the same IP:port. Of course, 
> if
> you reconnect to the same destIP:port, it should work because in this 
> case
> it is a continuation of the same session.
>
>> I think a firewall ought to be aware of such behavior, but at the same
>> time be secure enough to not just leave high numbered udp ports wide
>> open for attack.  I am trying to find out why the PIX chose 60 ms to
>> clear out the UDP state table.  I think that is a random number and
>> probably too short of a span for this to occur however i am still
>> researching it.
>
> it is not the timing which causes trouble, it is the way it confuses 
> new
> and already established sessions. Although 60 ms may seem short (you 
> can
> probably never resolve anything on ADSL with a loaded link), it may be
> perfectly valid if the firewall agrees to open several sessions when 
> you
> connect to several servers. And if you connect several times to the 
> same
> server, of course it must re-open the session.
>
>> Any other insight would be greatly appreciated.
>
> unfortunately, googling for "pix udp problem" returns 25600 
> responses...
>
> Regards,
> willy
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

