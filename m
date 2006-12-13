Return-Path: <linux-kernel-owner+w=401wt.eu-S964948AbWLMGR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWLMGR5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 01:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWLMGR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 01:17:57 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:36958 "EHLO
	asav04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964945AbWLMGR4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 01:17:56 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 01:17:56 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CABYnf0VKhQ0nVWdsb2JhbACNSQEr
From: Dmitry Torokhov <dtor@insightbb.com>
To: Andres Salomon <dilinger@debian.org>
Subject: Re: [PATCH] psmouse split
Date: Wed, 13 Dec 2006 01:08:17 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, warp@aehallh.com
References: <457F822E.4040404@debian.org>
In-Reply-To: <457F822E.4040404@debian.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612130108.19447.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andres,

On Tuesday 12 December 2006 23:31, Andres Salomon wrote:
> Hi,
> 
> When Zephaniah Hull sent in a patch for the OLPC touchpad [0], it was
> suggested that the psmouse driver be split out into separate components.
>  What's currently there is way too fat, and people are not happy about
> adding even more code to the driver.
> 
> I've taken a stab at doing just that.  The attached patch splits the
> various protocol extensions into their own modules, defines a protocol
> registration layer, and allows modules to define their own psmouse
> protocols.  Psmouse-base now only registers a few extensions, and then
> scans the ps/2 ports.  Other modules (ie, psmouse-alps) register their
> extension, and force a rescan of all serio ports that the psmouse driver
> happens to be using.  The max_proto stuff has been removed, with the
> intention that people should be loading (or unloading) only the modules
> they need, rather than playing around w/ module arguments.  Rather than
> playing games w/ extension detection ordering, I opted to just reset the
> port before every scan.
> 

Unfortunately I do not think this is going to work well in in default case:

1. PS/2 probing order is important. You need to probe for intellimouse
   explorer last otherwise you might miss that mouse supports extended
   protocol.

2. Synaptics hardware has to be probed even if synaptics protocol is not
   used, otherwise intellimouse probe will case trackpoint on passthrough
   port not working.

3. Doing full reset after every protocol probe will cause long delays in
   mouse detection. 

4. Maxproto is still needed - psmouse base still contains several protocols
   and sometimes users need to force "standard" protocols (Intellimouse/
   Explorer), for example when using a KVM switch.

Also, splitting psmouse into several modules as opposed to having monolitic
psmouse with an option to exclude some protocols via Kconfig does not really
buy us anything - because protocol autoload is not possible (we do not know
what protocols port uses until we actually do the probe) distributions will
have to compile and load everything anyway. Custom kernel users will just
have to compile protocols they need into psmouse.

And some comments for the patch itself:

> +               if (proto->detect(psmouse, set_properties) == 0) {
> +                       if (proto->type == PSMOUSE_SYNAPTICS)
> +                               synaptics_hardware = 1;
> +                       if (!set_properties) {
> +                               if (proto->init && proto->init(psmouse) != 0)
> +                                       continue; 

I think you wanted if (set_properties)...

> +static void psmouse_rescan(struct serio *serio, void *data)
> +{
> +       if (serio->drv->driver.name == "psmouse")
> +               serio_rescan(serio);
> +}

This is going to crash if you encounter unconnected port
(serio->drv == NULL).

> +MODULE_AUTHOR("C. Scott Ananian <cananian@alumni.priceton.edu>");
> +MODULE_DESCRIPTION("Synaptics TouchPad PS/2 mouse driver");
> +MODULE_LICENSE("GPL");

You need to be careful with code attribution - for example Synaptics driver
was written by Peter Osterlund. He took some code from tpconfig utility,
that's why there is C. Scott Ananian copyright notice but _module_ author
is still Peter.

> +       psmouse_protocol_register(&genius_proto, 0);
> +       psmouse_protocol_register(&imps_proto), 0;

Hmm, does this compile?

-- 
Dmitry
