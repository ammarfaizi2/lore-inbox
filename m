Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277353AbRJJSON>; Wed, 10 Oct 2001 14:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277352AbRJJSOD>; Wed, 10 Oct 2001 14:14:03 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:58616 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277349AbRJJSNw>;
	Wed, 10 Oct 2001 14:13:52 -0400
Date: Wed, 10 Oct 2001 11:14:04 -0700
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: RFC : Wireless Netlink events
Message-ID: <20011010111404.D17439@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011009184700.B16874@bougret.hpl.hp.com> <200110101749.VAA04827@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110101749.VAA04827@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Oct 10, 2001 at 09:49:52PM +0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 09:49:52PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > 	o Is there a way to do a reverse of SIOCGIFINDEX ? If you have
> > an interface index, how do you get its name ?
> 
> SIOCGIFNAME.

	Err... I feel stupid...

> But this does not matter, applications using rtnetlink should
> not use these ioctls. They have all the information from rtnetlink.

	That would not be the case of Wireless Events, the event would
just contain the type of change and the interface index. See reasons
for that below.

> > 	o Any other comments ?
> 
> I am not sure that it is right and in right place. I would not create one
> more message type for such... mmm... special case.
> Probably, you could add a new attribute to RTM_*LINK sort of
> IFLA_MISC and to send ifinfo messages.

	The problem is that I need to propagate the "command" field
(the ioctl number leading to the event), and there is no space for
that in the ifinfo structure. None of the flags in the ifinfo
structure would change when those ioctls are called.
	I don't mind adding a new attribute to struct ifinfo, but that
will break existing netlink apps (unless I missed something).

> But I see logical flaw: no way to _retrieve_ information about state
> on demand.

	Hu ? Just query any of the Wireless IOCTLs, and you get the
info you need. Check iwconfig.c on how to do that. I don't see the
need of duplicating the ioctl functionality in netlink, especially
that those ioctl can be big (encryption key, iwspy), complex (power
management) and have a variable geometry.
	The IOCTLs have been working to satisfaction, and I don't want
to duplicate this code. What I want is just a channel to propagate an
event.

> Hence no right application cannot rely only on these messages.
> Hence you should go all the way and to allow to dump this and,
> probably, to add statistics shown in /proc/net/wireless.

	On the contrary. The app get the event and can query the
related ioctl to see what has changed. I want those event to be *very*
lightweigth so that it is minimal overhead for the vast majority of
applications that could not care less about them and will end up
discarding them anyway.
	The whole Wireless configuration is in the order of 624 bytes
(including /proc/net/wireless, excluding iwspy/aplist and assuming
only one encryption key). You surely don't want me to push that with
every event ?
	The idea is like select() + read(). Select gives you the basic
event, you need to use read to get the data.

> Alexey

	It seems to me that what you are implying is that RTnetlink is
not the right place for me to propagate events. Any idea of what
mechanism might be better to propagate those events ? Maybe I should
create my own event channel.

	Thanks for the comments !

	Jean
