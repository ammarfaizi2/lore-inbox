Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVGTVqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVGTVqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 17:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGTVqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 17:46:39 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:55815 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261510AbVGTVpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 17:45:49 -0400
Date: Wed, 20 Jul 2005 23:46:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core
 (2/9)
Message-Id: <20050720234603.2b66560d.khali@linux-fr.org>
In-Reply-To: <20050720042755.GD26552@kroah.com>
References: <20050719233902.40282559.khali@linux-fr.org>
	<20050719234843.14cfb1ec.khali@linux-fr.org>
	<20050720042755.GD26552@kroah.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > Convert i2c-isa from a dumb i2c_adapter into a pseudo i2c-core for
> > ISA hardware monitoring drivers. The isa i2c_adapter is no more
> > registered with i2c-core, drivers have to explicitely connect to it
> > using the new i2c_isa_{add,del}_driver interface.
> 
> Ick, when I did this originally it was a hack, and it's still a hack.
> It's sad to see it spreading around, but that's proably my fault...

I didn't know that, I'm sorry. As I don't really know how the driver
core works, I just copied from the nearest working driver, which
happened to be i2c-core. If this isn't good and you want me to do it
differently, just tell me how and I'll tackle this. Actually it might be
more important for i2c-core than i2c-isa, as i2c-isa will die in the
long run.

> Anyway, what are your plans for after this?  How long will this code
> stay around?  What do you want to do next?
> 
> I don't have any real objections to this patch series at all, just
> very curious as to your proposed roadmap after this.

I'm sorry, I thought I had explained it in the first post of the set,
but now I realize that I explained in detail *what* I am doing, not
*why* nor the whole picture.

The whole point is to end with the current state where i2c and hardware
monitoring are the same subsystem. There are more and more non-i2c
hardware monitoring chip, in particular Super-I/O integrated sensors
(IT8712F, W83627HF, PC87366 and all their variants), which have a very
high overhead currently due to being linked to the i2c core for no
reason but historical.

The positive side effect is that there are a few ugly hooks in the
i2c-core (expecially the sensors part) to handle the non-i2c chips, and
we will be able to get rid of them and clean up a few things - as
details in my original post.

The reason why I am going into this now is that a totally different
hardware monitoring driver is in the process of being added to the Linux
kernel: bmcsensors, which is IPMI based. This would be yet another
driver articifially linked to the i2c subsystem, requiring yet other
hooks. So I wanted to clean up the mess first.

Another reason is that I now have a Super-I/O chip with integrated
sensors on one of my systems, as well as a legacy ISA hardware
monitoring chip on another one, so I should be able to test my changes
more efficiently than before in that field (although more hardware would
be even better, as usual).

The major steps in the process are:

1* Define a hardware monitoring class, which all hardware monitoring
drivers would register with. Mark M. Hoffman just did that a few weeks
ago.

2* Separate the non-i2c hardware monitoring drivers from the i2c-core.
This is what I am doing right now.

3* Have the user-space tools (libsensors) search for hardware monitoring
drivers through /sys/class/hwmon rather than (or, for the time being,
additionally to) /sys/bus/i2c. Next on my list.

4* Clean up the i2c core. This isn't directly related, but needs to be
done, and will be much easier now that the isa hooks are gone. This
includes a full rewrite of the way the i2c chip driver module parameters
are handled, and a merge of i2c_probe and i2c_detect, to name only the
two major ones. We might also get rid of some IDs that don't seem to be
strictly needed (in i2c_algorithm and i2c_driver). And maybe split the
SMBus 1 and 2 implementations away from i2c-core, not too sure what it
would take.

5* Really attach the non-i2c drivers to their right location in the
sysfs tree. I don't know exactly where the correct location is, but
we'll have to find. Once the hwmon class is in use, moving the drivers
around in the sysfs tree will not break the user-space compatibility.

Note that 3* depends on 1* and 4* depends on 2*. Also, we will need to
wait some time (6 months? 1 year?) between 3* and 5* so as to not break
user-space compatibility too much. This is the reason why I made 2* and
5* different points even though it would sound saner to do them in a
single step. This approach also lets me parallelize with 4*, which I
want to do now rather than wait for 5* to happen.

So, the approximate timeline would be 1* to 3* right now, 4* after that
as time permits, and 5* when we estimate that 3* happened long enough
ago (roughly 1st half of 2006?)

I hope I explained it correctly this time. If not, just complain ;)

Thanks,
-- 
Jean Delvare
