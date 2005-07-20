Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVGTPGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGTPGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGTPGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:06:38 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:16322 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261348AbVGTPFP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:05:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jEu0/XPsHTFgWkqx37ZSwhLHNEBwj0/EidyJMCQ2fTiJPlHI87SqmMfNM0i4/6vfpUcEcnw24jUXuukxrFHMTT7C0K048yY92WGSCn4WAHgw7A/BY8X3E5kBEupFZlXLAIJt7jfcLMT1UnKAy94OjzMELYTi9eoG7HY2vJIu3EY=
Message-ID: <d120d50005072008057d8a9043@mail.gmail.com>
Date: Wed, 20 Jul 2005 10:05:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Synaptics and TrackPoint problems in 2.6.12
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050720183420.282f72f4.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a71293c2050719204047bd2afe@mail.gmail.com>
	 <20050720183420.282f72f4.vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, Sergey Vlasov <vsu@altlinux.ru> wrote:
> On Tue, 19 Jul 2005 23:40:18 -0400 Stephen Evanchik wrote:
> 
> > I have been receiving a lot of complaints that TrackPoints on
> > Synaptics pass-thru ports stopped working with 2.6.12. I retested
> > 2.6.9 and 2.6.11-rc3 successfully, I believe 2.6.11.7 may also work
> > but that is unconfirmed at this point.
> >
> > The behavior is always the same .. after sending the read secondary ID
> > command, the TrackPoint seems to be disabled from that point forward.
> >
> > Any ideas?
> 
> Looks like this problem was introduced by the change from PSMOUSE_PS2 to
> PSMOUSE_TRACKPOINT in the TrackPoint support patch.  The Synaptics
> driver needs to know whether the device on the pass-thru port is using
> 3-byte or 4-byte packets; however, instead of checking child->pktsize,
> it checks child->type >= PSMOUSE_GENPS - and this check is now giving a
> wrong result.  Therefore the Synaptics driver configures the pass-thru
> port for 4-byte packets, and all 3-byte packets from TrackPoint seem to
> be thrown away.

Oh, yes, that would do it.

> The patch below is reported to fix the problem - now the 4-byte mode is
> used only if child->pktsize == 4. 

That is the correct fix.

> Another option is to change the
> PSMOUSE_TRACKPOINT value so that it is less than PSMOUSE_GENPS, 

No, protocol numbers should not be changed as userspace drivers/setups
check them and rely on them being stable. That's why psmouse->pktsize
was introduced to begin with. Unfortunately synaptics pass-through
piece was missed and not adjusted.

I will add the patch to my tree, thanks!

> In theory, someone could attach a device which uses 6-byte packets to
> the Synaptics pass-thru port; I'm not sure what would happen in this
> case, but with Synaptics confugured for 3-byte packets (as the patch
> below will do) this configuration even has a chance of working.

I don't think it can support more than 4 byte packets. bytes 0 and 3
are protocol markers and can't be readily used for transmitting other
protocols data.

-- 
Dmitry
