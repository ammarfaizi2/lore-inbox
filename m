Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVAREay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVAREay (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 23:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVAREay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 23:30:54 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:12641 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261228AbVAREab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 23:30:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mBb/R6dLGipDfr8wxi2QAgQjxYhZarWoQ+TUdqFDYzxXvfvz77lQrQFNHsOeZcMi+l9NVfMfj9PWxa+TAX88u1AwyZRD2pI65cgT7+mE79248tjsG5gVLSIyl1kioYtyXxFrW/dci3MT9FlJU+g9pylwv+xStGPPKIG/w95knUA=
Message-ID: <727e501505011720303ba4f2cd@mail.gmail.com>
Date: Mon, 17 Jan 2005 22:30:30 -0600
From: Aaron Cohen <remleduff@gmail.com>
Reply-To: Aaron Cohen <remleduff@gmail.com>
To: karim@opersys.com
Subject: Re: 2.6.11-rc1-mm1
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <41EC8AA2.1030000@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050114002352.5a038710.akpm@osdl.org>
	 <41E899AC.3070705@opersys.com>
	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>
	 <41EA0307.6020807@opersys.com>
	 <Pine.LNX.4.61.0501161648310.30794@scrub.home>
	 <41EADA11.70403@opersys.com>
	 <Pine.LNX.4.61.0501171403490.30794@scrub.home>
	 <41EC2DCA.50904@opersys.com>
	 <Pine.LNX.4.61.0501172323310.30794@scrub.home>
	 <41EC8AA2.1030000@opersys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I'm very much a newbie to all of this, but I'm finding this
discussion fairly interesting.

  I've got a quick question and I just want to be clear that it
doesn't have a political agenda behind it.
  
Here goes, why can't LTT and/or relayfs, work similar to the way
syslog does and just fill a buffer (aka ring-buffer or whatever is
appropriate), while a userspace daemon of some kind periodically reads
that buffer and massages it.  I'm probably being naive but if the
difficulty is with huge several hundred-gig files, the daemon if it
monitors the buffer often enough could stuff it into a database or
whatever high-performance format you need.

 It also seems to me that Linus' nascent "splice and tee" work would
be really useful for something like this to avoid a lot of unnecessary
copying by the userspace daemon.


On Mon, 17 Jan 2005 23:03:46 -0500, Karim Yaghmour <karim@opersys.com> wrote:
> 
> Hello Roman,
> 
> Roman Zippel wrote:
> > Why is so important that it's at the start of the buffer? What's wrong
> > with a special event _near_ the start of a buffer?
> [snip]
> > What gives you the idea, that you can't do this with what I proposed?
> > You can still seek freely within the data at buffer boundaries and you
> > only have to search a little into the buffer to find the delimiter. Events
> > are not completely at random, so that the little reordering can be done at
> > runtime. Sorry, but I don't get what kind of unsolvable problems you see
> > here.
> 
> Actually I just checked the code and this is a non-issue. The callback
> can only be called when the condition is met, which itself happens only
> on buffer switch, which itself only happens when we try to reserve
> something bigger than what is left in the buffer. IOW, there is no need
> for reserving anything. Here's what the code does:
>         if (!finalizing) {
>                 bytes_written = rchan->callbacks->buffer_start ...
>                 cur_write_pos(rchan) += bytes_written;
>         }
> 
> With that said, I hope we've agreed that we'll have a callback for
> letting relayfs clients know that they need to write the begining of
> the buffer event. There won't be any associated reserve. Conversly,
> I hope it is not too much to ask to have an end-of-buffer callback.
> 
> > Wrong question. What compromises can be made on both sides to create a
> > common simple framework? Your unwillingness to compromise a little on the
> > ltt requirements really amazes me.
> 
> Roman, of all people I've been more than happy to change my stuff following
> your recommendations. Do I have to list how far down relayfs has been
> stripped down? I mean, we got rid of the lockless scheme (which was
> one of ltt's explicit requirements), we got rid of the read/write capabilities
> for user-space, etc. And we are now only left with the bare-bones API:
> rchan* relay_open(channel_path, bufsize, nbufs, flags, *callbacks);
> int    relay_close(*rchan);
> int    relay_reset(*rchan);
> int    relay_write(*rchan, *data_ptr, count, **wrote-pos);
> 
> char*  relay_reserve(*rchan, len, *ts, *td, *err, *interrupting);
> void   relay_commit(*rchan, *from, len, reserve_code, interrupting);
> void   relay_buffers_consumed(*rchan, u32);
> 
> #define relay_write_direct(DEST, SRC, SIZE) \
> #define relay_lock_channel(RCHAN, FLAGS) \
> #define relay_unlock_channel(RCHAN, FLAGS) \
> 
> This is a far-cry from what we had before, have a look at the
> relayfs.txt file in 2.6.11-rc1-mm1's Documentation/filesystems if
> you want to compare. Please at least acknowledge as much.
> 
> I'm more than willing to compromise, but at least give me something
> substantive to feed on. I've explained why I believe there needs to be
> two modes for relayfs. If you don't think they are appropriate, then
> please explain why. Either my experience blinds me or it rightly
> compels me to continue defending it.
> 
> You ask what compromises can be found from both sides to obtain a
> single implementation. I have looked at this, and given how
> stripped down it has become, anything less from relayfs will make
> it useless for LTT. IOW, I would have to reimplement a buffering
> scheme within LTT outside of relayfs.
> 
> Can't you see that not all buffering schemes are adapted to all
> applications and that it's preferable to have a single API
> transparently providing separate mechanisms instead of a single
> mechanism that doesn't satisfy any of its users?
> 
> If I can't convince you of the concept, can I at least convince
> you to withhold your final judgement until you actually see the
> code for the managed vs. ad-hoc schemes?
> 
> Karim
> --
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
