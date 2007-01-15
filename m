Return-Path: <linux-kernel-owner+w=401wt.eu-S1750696AbXAOOGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAOOGZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbXAOOGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:06:25 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:33910 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXAOOGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:06:24 -0500
Message-ID: <45AB8A5E.7040006@s5r6.in-berlin.de>
Date: Mon, 15 Jan 2007 15:06:22 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Philipp Beyer <philipp.beyer@alliedvisiontec.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ieee1394 feature needed: overwrite SPLIT_TIMEOUT from userspace
References: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local>	 <tkrat.0ae1f576575bc02e@s5r6.in-berlin.de> <1168867271.5190.9.camel@ahr-pbe-lx.avtnet.local>
In-Reply-To: <1168867271.5190.9.camel@ahr-pbe-lx.avtnet.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Beyer wrote:
> Thanks for your input. My post was based on the (wrong) idea that
> the kernel already uses different timeout values per node.
> 
> Therefore, having read your answer, I have a different opinion about
> how to solve this now.
> 
> About your suggestions:
> Unfortunately sending an early response and using a secondary register
> as indication for completed flash writes doesnt work. In short, the
> device isn't able to process packets while writing to flash and an early
> answer followed by a period of non-responsiveness might lead to problems
> on the windows side.

You don't need the early response if you would have the extra register.
(The config ROM instead of a register might work too.)

01) PC: sends write request (or whatever)
02) Dev: starts to process request, doesn't send response
03) PC: transaction times out
04) PC: now knows that either the request failed or the Dev is now busy
05) PC: sends read request to special register or to config ROM
<if Dev ready goto 08>
06) Dev: doesn't respond or even ack
07) PC: transaction times out
<goto 05>
08) Dev: responds to read request
09) PC: now assumes or knows that the request 01 was actually successful

If you used a special register, you can show by the contents of the read
response whether the action started in 02 was successful or failed.

> Also I dont like the idea of having such a big timeout for every bus
> transaction.

Me neither.

> In case of 'normal' operation the device runs fine with
> a standard timeout value.

If you don't want or can implement something like the above protocol, we
could patch the ieee1394 driver for non-standard time-outs. Then a
possible protocol could look like this:

0a) PC: reads current SPLIT_TIMEOUT on local node
0b) PC: writes large SPLIT_TIMEOUT to local node
0c) PC: sends write request (or whatever) to Dev
0d) Dev: starts to process request
<aeons pass>
0e) Dev: sends response
0f) PC: restores previous SPLIT_TIMEOUT on local node

As mentioned in the other post, a bus manager could interfere with the
manipulation of the SPLIT_TIMEOUT value. A bus manager is meant to
ensure that all nodes have the same SPLIT_TIMEOUT. I don't remember if
the spec also says when and how a bus manager is supposed to do this.
But this is irrelevant if there is only your device and the Linux PC.

> I will now try to work around this problem in userspace basically by
> ignoring the timeout error.

I.e. something similar but less sophisticated than the protocol 01...09?

> The correct transmission of the write 
> request will already be confirmed by the acknowledge packet, after all.

In case of a split transaction, the ack indeed confirms proper reception
of the request. In case of a unified transaction, it is even possible to
encapsulate a write response in the ack, i.e. to complete the
transaction with the ack to the request. Needless to say, unified
transactions require special support by the link layer hardware on the
responder's side.
-- 
Stefan Richter
-=====-=-=== ---= -====
http://arcgraph.de/sr/
