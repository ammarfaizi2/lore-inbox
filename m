Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbTDJPTe (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTDJPTe (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 11:19:34 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:41221 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264071AbTDJPTb (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 11:19:31 -0400
Subject: Re: 64-bit kdev_t - just for playing
From: James Bottomley <James.Bottomley@steeleye.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304101033500.5042-100000@serv>
References: <1049913637.1993.73.camel@mulgrave> 
	<Pine.LNX.4.44.0304092202570.5042-100000@serv>
	<1049941189.4467.186.camel@mulgrave> 
	<Pine.LNX.4.44.0304101033500.5042-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 10 Apr 2003 10:30:59 -0500
Message-Id: <1049988660.1998.100.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 07:47, Roman Zippel wrote:
> If you want to use only a single SCSI major, won't it change the device 
> numbers?

They will collapse down to a single major, yes.  No application should
be relying on knowing the device number, though (and if you are trying
to argue that they do, you must see that in that scenario dynamic
mapping is a total failure).  Once /dev is rebuilt, no-one will know. 
Depending on whether people still dual boot 2.4 and 2.5, someone may
also come up with a compatibility layer, but one is not required.

> What will happen to setups, which already use more than 16 disks 
> (but are still way below the 128 disk limit)?
> Do you want to go to 64 partitions during 2.6? If yes, how? Won't that 
> change the device numbers too?

It won't matter to a user application whether /dev/sdaa7 is 65,161 or
257,1667.  As you should understand, since dynamic device numbers relies
on this property.

> Changes in these area require kernel policy, exactly like dynamic device 
> numbers. If you want to maintain compatibility, you likely require user 
> space support, exactly like dynamic device numbers. So why don't we even 
> consider dynamic device numbers, especially as they have the promise of 
> the simpler long term solution. The required kernel changes are certainly 
> not more complex than the patches Andries got merged and still wants to 
> get merged. If you actually look at the character device patches I posted, 
> they already allow simple cleanups for 2.6.

Ah, OK, this may be the misunderstanding.  Kernel dev_t can be expanded
without any change to the current naming policy.  The only change is the
numbering in /dev, which is simple.

> > I said in my last mail that "thanks to the work of Al Viro and others,
> > the problem of dynamic majors for block devices lies predominantly in
> > user space".  The piece that you label "trivial" is the missing
> > character device and user space components.  I don't happen to believe
> > it is at all trivial, but you're welcome to prove me wrong.
> 
> The only nontrivial missing piece is how we want to map the sysfs and 
> other information to static device names.

So we agree.

> OTOH if you only need a 
> solution for scsi now, it should be rather simple to expand scsidev.
> If you can live with dynamic device names (what scsi currently has), it's 
> a simple shell script to generate the device nodes.

But, as I've said before, not simpler than expanding kernel dev_t.

> If you want to have thousands of disk, you need some kind of user support 
> anyway, but I get surprisingly little answers, about how people want to 
> actually manage that much devices? All I hear is "we want them and we 
> want them now!", this makes it difficult to actually answer the question, 
> how kernel should support this. In the kernel it's simpler to keep this 
> dynamic, scsi does that already anyway. How will user space find these 
> devices? Will it continue to scan thousands of nodes in /dev or will it 
> just use the information already easily available via sysfs?

:-)

You take me back a decade to the "thirty two bits is enough for"
everybody and "why would an application want more than 640k of memory"

Operating systems which impose arbitrary limits on their users, or
demand cast iron justification before adding features tend to be at a
competitive disadvantage.

However, if you want an example of how it works today, consider
clustering tools:  They have to identify the same piece of shared
storage as it gets passed around a cluster.  The way we do it (for a few
hundred discs) is to get the SCSI WWN from all the discs (via sg, then
map sg<->sd).  Our application policy is to use the WWN to identify the
device and a number for the partition.  Other cluster tools use the
volume label, still others use the LVM UUID.

The point is that none of these applications cares whether the kernel
uses dynamic or static, all they need to do is be able to identify all
the devices in the system.

> I know I'm asking a lot of annoying questions, but I have the feeling, 
> that hardly anyone really thought all these problems through or someone 
> withholds some important information (e.g. Peter's vague hints about "a 
> fair number of the problems" for dynamic schemes or "collective global 
> experience with numberspaces" don't really help without further 
> explanation).

I wouldn't characterise the questions like that.  Not listening to the
answers now...

> Considering all the information I currently have, dynamic device numbering 
> is the better long term solution and is also usable for 2.6. I'm still 
> looking for the deciding reason, which would give static device numbers a 
> real advantage.

No, dynamic device numbering may turn out to be the better long term
solution.  To justify "is", we'd have to be able to see the solution.

As far as SCSI is concerned, the complete solution has already been
presented for the expansion of kernel dev_t, no such complete solution
has been presented for dynamic devices.  That constitutes a real
advantage to dev_t expansion in my book.

James


