Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWEQTr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWEQTr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWEQTr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:47:58 -0400
Received: from web81101.mail.mud.yahoo.com ([68.142.199.93]:51552 "HELO
	web81101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751051AbWEQTr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:47:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ameritech.net;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=56cYSUGBkYT+gF5ziAixzccmAxkLdOaOm+/igijdUZHUUsxMmL2IPoESTeKBxSeMsXy4FI493joG60qiS6TbjmQ9prMiFA8bHWs2lpD07xS4EqLazz8AkEj6cuTrTC+dXaZc8VJnuMzEhL5GfxDUuFFuxDqKA4/ubYjMHfVgwEI=  ;
Message-ID: <20060517194757.6566.qmail@web81101.mail.mud.yahoo.com>
Date: Wed, 17 May 2006 12:47:57 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [patch] add input_enable_device()
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <446B58F5.4020501@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Stas Sergeev <stsp@aknet.ru> wrote:

> Hello.
> 
> Dmitry Torokhov wrote:
> > I really believe that instead of shoving this into input core you need to
> > split pcspkr driver to allow concurrent access to the hardware.
> I split pcspkr and someone else will say that there is
> already enough of the midlayers to handle the like things,
> to not introduce another one just for the particular driver.
> Besides, I don't beleive people will be happy with having
> 2 modules for just handling the terminal beeps.
> The input midlayer looks like the best solution. It allows
> to deal with the modules as soon as they are loaded. It has
> enough of the information needed to precisely identify the
> module (I now use INPUT_DEVICE_ID_MATCH_BUS). The pcspkr *is*
> an "input driver" after all, so why not to deal with it via
> an input API?

pcspkr is still an input driver. Now you are adding another
driver to drive the same piece of hardware and you need
to mediate access to that hardware. It is not responsibility
of the input layer to do that. Like input core does not handle
PS/2 ports or USB hardware directly it should not do that for
the speaker either. Also, even now pcspkr implementation is
deficient - issuing SND_BELL will kill SND_TONE going at the
moment.

> If the input should not be used for anything
> related to the port IO,

Input core itself should not. It is positioned not at physical
device level. It gets and propagates events from individual
drivers which talk to hardware, maybe via port IO. 
  
>  then why it carries the information
> about the ports and the bus that are used by the device?
> Why does it have the INPUT_DEVICE_ID_MATCH_BUS after all?

For userspace benefits.

> The input API only lacks a very small piece of the functionality -
> disabling the device, which can easily be used by anything else
> in the future. Is there a reason not to include that functionality
> only because the snd-pcsp is going to use it, or is there any *other*
> reason?
>

See above. Your module wants to access hardware concurrently with
another module so implement it properly. While you are fine with
disabling beeps while music is playing otherpeoplr might still want
to hear them.
 
--
Dmitry
