Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131185AbRCGVD0>; Wed, 7 Mar 2001 16:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131186AbRCGVDQ>; Wed, 7 Mar 2001 16:03:16 -0500
Received: from servo.isi.edu ([128.9.160.111]:30473 "EHLO servo.isi.edu")
	by vger.kernel.org with ESMTP id <S131185AbRCGVDJ>;
	Wed, 7 Mar 2001 16:03:09 -0500
Message-Id: <200103072102.f27L24w09461@servo.isi.edu>
To: Alexander Viro <viro@math.psu.edu>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another? 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Wed, 07 Mar 2001 04:49:56 EST." <Pine.GSO.4.21.0103070429140.2127-100000@weyl.math.psu.edu> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9458.983998924.1@servo.isi.edu>
Date: Wed, 07 Mar 2001 13:02:04 -0800
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
>Erm. If ioctls are device-specific - the program is already bound to
>specific driver. If they are for class of devices (and if I guessed
>right that's the case you are interested in - sound, isn't it?) we
>could let the stub driver in kernel open two pipes and redirect
>read()/write() on device to the first one turn ioctls into read()/write()
>on the second. That way you can get userland programs serving that
>stuff with no magic required.

One problem, in addition to the points Abramo made, is that there's no
metadata that goes along with the data you're writing to the pipe.
This is fine as long as there's only one process reading, but in the
case of a single driver serving multiple instances of an open file,
there has to be some way for the userspace driver to communicate to
the kernel which open file needs to get the data.

A similar problem is that metadata needs to accompany the read request
when the userspace driver gets it (i.e., current file position, file
flags, size of the read that was requested, etc.)  Although, that data
might be transmitted on the OOB channel.

Also, even though my framework right now only does character devices,
it's a pretty simple extension to support userspace block devices and
network devices as well.  In these cases I think using a pipe gets
more and more complicated.

>From reading all the responses to the thread (thanks, everyone, for
your useful comments), it sounds like the best thing to do is use
Manfred's zerocopy pipe code as a model and implement something
similar in my framework.  It's not really that much code anyway so
it's not much of a waste reimplementing it.  And, I think
reimplementing those 30 lines will be much simpler than trying to
manage 2 parallel channels.  If the zerocopy patch becomes part of the
kernel anyway, it gets even simpler, since I can probably just call
pio_copy_to_user instead of copying it.

Regards,
Jer
