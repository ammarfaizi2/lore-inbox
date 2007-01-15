Return-Path: <linux-kernel-owner+w=401wt.eu-S1751304AbXAOSy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbXAOSy4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXAOSyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:54:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:19253 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXAOSyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:54:55 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LmmJtkrrlsgKkLgnGIWAp8ORhoXkX+s1HQ/SuqLXE8kA/fvIkHsZKOBGfyTDKTnXA4eYQC4Qv+BWvlh6teGvShqx3ecFxWNJUncdfSzLQSi/Z/8iWh0TSCYdSTjhxaoDHwaTDPOX/9DMekmErUgaTrZA/EZh4rAOE6f+DiP4G78=
Message-ID: <59ad55d30701151054j48831ca1v96f2700dccd4d512@mail.gmail.com>
Date: Mon, 15 Jan 2007 13:54:52 -0500
From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
To: "Philipp Beyer" <philipp.beyer@alliedvisiontec.com>
Subject: Re: ieee1394 feature needed: overwrite SPLIT_TIMEOUT from userspace
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1168867271.5190.9.camel@ahr-pbe-lx.avtnet.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local>
	 <tkrat.0ae1f576575bc02e@s5r6.in-berlin.de>
	 <1168867271.5190.9.camel@ahr-pbe-lx.avtnet.local>
X-Google-Sender-Auth: 477efd9b5dd4c3cb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Philipp Beyer <philipp.beyer@alliedvisiontec.com> wrote:
>
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
>
> Also I dont like the idea of having such a big timeout for every bus
> transaction. In case of 'normal' operation the device runs fine with
> a standard timeout value.

I read the thread briefly, so I may be off here, but another solution
is to implement an FCP-style protocol.  That is, instead of trying to
cram a long operation into the SPLIT_TIMEOUT window, just use two
write transactions to device specific address areas: one for the
request from the PC and one for the response from the device.  Or you
could even use a vendor specific FCP frame.

If you use unified transactions (i.e. your devices sends ACK_COMPLETE
when it receives the write) it doesn't even generate more traffic on
the bus.  And since the device will send the response write request
once it has completed programming the flash, it doesn't need to
respond to packets while it is programming.  But even if the write
transactions themselves are split transactions, it is still a low
overheads solution to your problem that avoids messing with
SPLIT_TIMEOUT.

cheers,
Kristian
