Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWG0UH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWG0UH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWG0UH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:07:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:11403 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161065AbWG0UH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:07:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qsgz5zZO3w9z41quBXIhMuFW5msmDnJR5TOkQ+ALDBUqZlcLg0ARLADpnNJ6SKZQ5u9NY2gNH6dbazujhO3fmVfmA8cFRaxlXkqOYNNyAmElu65yrIzL4FpDVqvBZD3XRUX/xq3MlxQjOm58a/N1XcDWPF4HNdpsWmGdzZjO9jQ=
Message-ID: <41840b750607271307w76016f07wf6c5a4a04a62e008@mail.gmail.com>
Date: Thu, 27 Jul 2006 23:07:53 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Daniel Barkalow" <barkalow@iabervon.org>
Subject: Re: Generic battery interface
Cc: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607271236440.9789@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011259C4@hdsmsx411.amr.corp.intel.com>
	 <41840b750607270923j21074661v6254ba52ec67b67a@mail.gmail.com>
	 <Pine.LNX.4.64.0607271236440.9789@iabervon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Maybe it would be best to have a virtual driver that knows about the union
> of the features, and makes whatever features are provided by the
> underlying driver available to userspace. That way, all of the drivers are
> implementing features out of a shared set, so you don't end up with
> thinkpad/force_discharge and something/discharge_battery. This is the
> principle behind, for example, the generic cdrom driver, which doesn't
> actually implement much but rather provides uniformity across devices
> handled by different drivers.
>
> I don't think this is a case where each driver provides very similar
> functionality, but with critical differences which can't be corrected for;
> it seems like features are clearly available or not.

It's a bit trickier than it first looks.

For example, take the "force discharge" and "inhibit charge" commands.
Do they take effect until further notice, or for a given time period?
Whichever variant you pick, the ThinkPad hardware can't do it: you can
only tell it to force discharging until further notice, and you can
only tell it to avoid charging for N minutes. Note that the variants
cannot emulate each other, because when the laptop is suspended the
embedded controller still ticks but the kernel can't use timers to
issue new commands.

Another examle: suppose one hardware interface provide average power
reading while another interface provides only voltage and average
current. The two are not equivalent: if you try to compute power as
voltage*current you'll get inaccurate results, because power is the
integral over (instantaneous current)*(instantaneous voltage) and the
latter fluctuates. So you'd want to somehow prioritize the first
interface over the second, at least when it comes to power readings.

These details are inconsequential for most applications, but some do
care. So an interface that forces a certain view and hides the rest
may not be a good idea.

  Shem
