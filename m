Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVHOVjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVHOVjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVHOVjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:39:33 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:35342 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964987AbVHOVjd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:39:33 -0400
Date: Mon, 15 Aug 2005 23:39:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] improve i2c probing
Message-Id: <20050815233958.1f170d15.khali@linux-fr.org>
In-Reply-To: <20050815175106.GA24959@litech.org>
References: <20050815175106.GA24959@litech.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> Virtually every i2c client driver uses exactly the same code, so
> there's little point in requiring them all to implement this callback.
> The first patch in this series adds two new fields to the i2c_driver
> structure, `address_data' and `detect_client', and if they are set by
> the driver, the i2c core will automatically call i2c_probe using those
> fields as the second and third argument.

This sounds very good to me. I have been wanting to do that some times
ago, but for some reason didn't. Most probably I was waiting to be done
with the various other i2c-core cleanups that were needed before (and
this just happened.)

> If the `class' field of the i2c_driver structure is set, it will be
> compared with the adapter class first.

I'm not sure I agree with the "if" clause, more about that below.

> Patches 2 and 3 add these fields to the i2c_driver initializer in the
> i2c hwmon and misc i2c chip drivers and remove the corresponding
> attach_adapter callbacks.

Looks good to me too.

> The second improvement (which is really the point of this patch set)
> is to add the functions i2c_probe_device and i2c_remove_device for
> directly creating and destroying i2c clients on a particular adapter:
> 
>     int i2c_probe_device(struct i2c_adapter *adapter, int driver_id,
>                          int addr, int kind);
>     int i2c_remove_device(struct i2c_adapter *adapter, int driver_id,
>                           int addr);
> 
> These functions make the i2c subsystem usable for special-purpose i2c
> buses where probing isn't possible, either because probing is known to
> be dangerous for devices that are present on the bus, or because the
> i2c adapter lacks quick writes and/or error reporting.
> 
> The final patch adds a new i2c adapter flag to indicate that the
> adapter should never be probed.

I think I understand the point of i2c_probe_device(). However, it would
help if you could additionally show how this is going to help the
media/video drivers. Currently, all these drivers use the traditional
probing mecanism, and have to jam "foreign" probes, right? I would hope
that these two patches will make it possible to improve this. Can you
provide a few  examples of use? We need to figure out how good this new
interface/mechanism is, and this can only be done with concrete
examples.

I do not understand the point of i2c_remove_device() though. You
shouldn't have to search for the clients you have been registering
explicitely before. Instead, you should keep a reference to them (which
suggests that maybe i2c_remove_device should return an i2c_client*
instead of an int.) With that reference, you should be able to
unregister the client directly, which is much more efficient that
walking all the list of clients for that adapter.

I am although a bit surprised that you are passing the adapter as an
i2c_adapter* and the driver as an id. Why not passing the driver as a
i2c_driver*? Or both the adapter and the driver as ids? This is a truly
naïve question, I just don't know. This is where concrete examples
really help.

I am not totally convinced by the reintroduction of the i2c_adapter
flags. I hope we can do without it.

One possibility would be to have an additional class of client, say
I2C_CLASS_MISC. This would cover all the chip drivers which do not have
a well-defined class, so that every client would *have to* define a
class (we could enforce that at core level - I think this was the
planned ultimate goal of .class when it was first introduced.) Adapters
that do not want to be probed would then simply *not* define a class, so
the class test would always fail for them, and no client could attach
through the "automatic" probe mechanism.

If I2C_CLASS_MISC doesn't please you, then we can simply keep the idea
that i2c_adapters that do not want to be probed do not define a class.
This alone could be a condition to skip any probing to that adapters, we
just have to make an explicit test on i2c_adapter.id not being 0 before
going on with generic probing.

Another possibility, in case you really don't like neither the first one
nor its variant, would be to keep two separate lists of i2c adapters,
one with those which want probing, and one with those which don't. As it
seems that these are two very different types of adapters, on which we
will use completely different probing functions, this seems to make
sense, and should speed up the processing on both sides. I admit I don't
know if doing so would have implications at the i2c-core level. Maybe
Greg can comment on this idea?

I have additional comments on the code itself, which I will post as
replies to each patch.

Thanks,
-- 
Jean Delvare
