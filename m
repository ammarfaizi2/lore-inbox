Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUJOIUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUJOIUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 04:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUJOIUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 04:20:20 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:13062 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S266517AbUJOIUE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 04:20:04 -0400
Date: Fri, 15 Oct 2004 10:15:49 +0200 (CEST)
To: mhoffman@lightlink.com
Subject: Re: [RFC] SMBus multiplexing for the Tyan S4882
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <upShh3B8.1097828149.3602420.khali@gcu.info>
In-Reply-To: <20041015022019.GC4035@jupiter.solarsys.private>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: Greg KH <greg@kroah.com>, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Expected Objections & Answers:
>>
>> O: The PCA9556 support could be moved to a separate driver.
>> A: I don't see no benefit. There is very little code for the PCA9556
>> driver among the code I added, and I believe that calling a PCA9556
>> interface would represent no less code. There is not much code to reuse
>> anyway, since the way the PCA9556 driver is used is specific to each
>> board. It could even be used for something compeletly different than
>> SMBus multiplexing, since it is a simple 8 channel I/O chip.
>>
>> O: The specific S4882 support could be moved to a completely different
>> driver.
>> A: This would duplicate most of the i2c-amd756 driver code. The
>> additional support will not affect non-S4882 users except for the size
>> of the driver. People concerned about the size can recompile the driver
>> without the S4882 support.
>>
>> Before I commit my changes to the lm_sensors CVS and port them to the
>> Linux 2.6 driver, I welcome constructive comments about my work.
>
>Heh, you definitely predicted my objections. :)  But I think you can
>support this board in an independent module without copying any amd756
>code.  It would look very much like your patch already...
>
>E.g. the i2c-s4882 module would act as a i2c-client for the mux chip,
>but also export four virtual adapters for the segments behind the mux.
>One would attach it to an existing adapter (in your case amd756) by
>passing it a module parameter (i2c bus id).  Is there any reason this
>wouldn't work?

First of all, there would be no need to provide a bus id as a module
parameter. since the i2c-s4882 driver would know knows which bus it has
to attach to. And anyway, i2c bus ids are not unique and may change, so
it wouldn't be very convenient.

I see one major downside to and one major issue with your approach.

First, depending on the multiplexer selection, mux'd chips will show on
the main bus or not. Even worse, when the the multiplexer selection
changes, the same address on the main bus will be a physically different
chip. There is no way for a client chip to know that it should ignore
chips at given addresses on the main bus. The only way to prevent that
is to unselect all mux'd channels after each command sent to a mux'd
chip. This means that the SMBus traffic will be increased by a rough
200% in all use cases. Doesn't sound good at all. With my approach, the
overhead is hardly noticeable in the typical use (5% maybe). In the
worst case it tops to 100%.

Second, how do you handle the case where a chip driver is already loaded
before the bus drivers are? Depending on the original multiplexer
selection, loading i2c-amd756 may trigger the registration of mux'd
chips. Then loading i2c-s4882 will hide that chip from the main bus, and
the registered client will point to a non-existing chip.

>The downside is that sensors-detect would need more help to recognize
>this setup.  But detection is, after all, what it does.

True. Sensors-detect would need to detect that specific board, and make
sure it loads the additional driver (i2c-s4882) before probing the main
bus. It admittedly shouldn't be too complex (it doesn't significantly
differ from other PCI device detection).

>The upside is that you don't need to modify the amd756 driver at all.
>Maybe that's not a big deal for this one board, but that slope is
>slippery.  How many other boards, slightly different, will need such
>support?

I remember of two 2-CPU boards with LM90 chips which were using bus
multiplexing as well (one of which I wrote the pca9540 driver for). I
don't think there are that many boards like this out there (so far at
least). Other requests for virtual adapters were for home-brew designs
if I remember correctly.

Anyway, I agree that my approach won't scale well if too many boards use
SMBus multiplexing.

>I think it's better to leave the real bus adapters alone
>and put the support for new combinations in new modules.

I agree in the theory. However, I don't know how this could be done
efficiently and safely. Looks like your approach is neither, unless the
problems I saw are either inexistent (I am ill for a couple days now and
may be missing things) or can somehow be solved.

Maybe we could go with my solution for now and reconsider if the number
of boards with multiplexing reaches an alert threshold?

>Somewhat related: since I wrote i2c-stub, I was thinking of creating
>i2c-trace... which would attach to an existing adapter while exporting
>another virtual adapter.  Anything attached to the i2c-trace adapter
>would generate log messages just like i2c-stub.  That's similar to
>your patch in a way; and that's why I think it can be independent
>from the real bus adapter code.

Similar but different. The core issue in my patch is not the virtual
adapters but the multiplexing. Having a single virtual adapter on top of
a real one like you propose with i2c-trace sounds sane (and having the
user select the bus through a module parameter also, since it would be
meant for debugging.) But when you have a multiplexer entering the
arena, things go way more complex.

Thanks,
Jean Delvare
