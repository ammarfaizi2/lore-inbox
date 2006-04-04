Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWDDUXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWDDUXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWDDUXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:23:46 -0400
Received: from wproxy.gmail.com ([64.233.184.237]:17755 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750840AbWDDUXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:23:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bNLytg4SKX0wECTYZzU8cglHur/RLhxpGU278gwi+Ye0fjoQKr6xyepBR2P0HLQsg+5U4EG75AZ8cK/O1atRDrpiNxDW6xf0W19pwajTsjHj2nUukf+prrheJnZIu9iwqbHCvcJ+YqE0UweECQlSkiSvv8HG2cwjtxnKeJdUK7k=
Message-ID: <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com>
Date: Tue, 4 Apr 2006 16:23:43 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "gregkh@suse.de" <gregkh@suse.de>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <1FQquz-2CO-00@press.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/06, gregkh@suse.de <gregkh@suse.de> wrote:
>
> --- gregkh-2.6.orig/drivers/base/bus.c
> +++ gregkh-2.6/drivers/base/bus.c
> @@ -372,14 +372,17 @@ int bus_add_device(struct device * dev)
>
>        if (bus) {
>                pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
> -               device_attach(dev);
> +               error = device_attach(dev);
> +               if (error < 0)
> +                       goto exit;

I do not believe that this is correct. The fact that _some_ driver
failed to attach to a device does not necessarily mean that device
itself does not exist. While this assuption might work for platform
devices it won't work for other busses.

As fasr as ALSA goes, if they want to abort loading module if device
is not present they will have to separate device probing from final
driver binding.

--
Dmitry
