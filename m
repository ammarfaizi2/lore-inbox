Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSIDVMM>; Wed, 4 Sep 2002 17:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSIDVMM>; Wed, 4 Sep 2002 17:12:12 -0400
Received: from ns.splentec.com ([209.47.35.194]:9996 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S315419AbSIDVMK>;
	Wed, 4 Sep 2002 17:12:10 -0400
Message-ID: <3D767830.66A0963B@splentec.com>
Date: Wed, 04 Sep 2002 17:16:32 -0400
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
References: <dledford@redhat.com> <200209032148.g83LmeP09177@localhost.localdomain> <20020903184216.F12201@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> Not really.  It hasn't been done yet, but one of my goals is to change the
> scsi commands over to reasonable list usage (finally) so that we can avoid
> all these horrible linear scans it does now looking for an available
> command

Using the struct list_head for this will literally allow you to do _magic_.
Avoiding the linear scan is the last thing this will fix.

It would allow for a lot better/simpler/sound design of all of
the mid layer/SCSI core. Things will be/become easier as you
point out below. Currently the mid-layer queuing is hairy at best.

I'm all for it.

> So,
> basically, you have a list item struct on each command.  When you build
> the commands, you add them to SDpnt->free_list.  When you need a command,
> instead of searching for a free one, you just grab the head of
> SDpnt->free_list and use it.  Once you've built the command and are ready
> to hand it off to the lldd, you put the command on the tail of the
> SDpnt->active_list.  When a command completes, you list_remove() it from
> the SDpnt->active_list and put it on the SDpnt->complete_list to be
> handled by the tasklet.  When the tasklet actually completes the command,
> it frees the scsi command struct by simply putting it back on the
> SDpnt->free_list.

Great!

Once you're on that train, you may want to rethink the whole queuing
mechanism of the mid-layer (straight from sd/etc and internally down to LLDD)
for an improved design.

There'd be problems like cmd moving b/n lists is atomic, only cmd movers
can actually cancel a command, move before calling queuecommand(), etc,
but is nothing extraordinary.

> Now, granted, that is more complex than going straight to a BDR, but I
> have to argue that it *isn't* that complex.  It certainly isn't the
> nightmare you make it sound like ;-)

No, it certainly is NOT!

Granted, by looking at the code it will not be overly clear
who moves what and when, but a 2 page commentary on the design
would only leave one exlaiming ``Aaaaah... such simplicity, so great!'' 

> Well, as I've laid it out above, I don't really think it's all that much
> to implement ;-)  At least not in the mid layer.

Right, it's not. This type of queuing mechanism would only make things
more consistent and easy to manipulate.

There'd be logistical issues, but those are easy to figure out
with pen and paper.

-- 
Luben

``Perfection is achieved not when there is nothing more to add
  but when there is nothing left to take away.''
                              Antoine de Saint Exupery
