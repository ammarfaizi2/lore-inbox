Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSG1QRj>; Sun, 28 Jul 2002 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSG1QRj>; Sun, 28 Jul 2002 12:17:39 -0400
Received: from [209.184.141.189] ([209.184.141.189]:7385 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S316896AbSG1QRh>;
	Sun, 28 Jul 2002 12:17:37 -0400
Subject: RE: About the need of a swap area
From: Austin Gonyou <austin@digitalroadkill.net>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Ville Herva <vherva@niksula.hut.fi>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <FJEIKLCALBJLPMEOOMECOEPFCPAA.b.lumpkin@attbi.com>
References: <FJEIKLCALBJLPMEOOMECOEPFCPAA.b.lumpkin@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 28 Jul 2002 11:20:52 -0500
Message-Id: <1027873252.16407.21.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-27 at 17:22, Buddy Lumpkin wrote:
> >You really must think beyond the desktop as well. With large servers
> >running many databases, or a single large database, you will inherently
> >use swap. Maybe not much, but it will get used.
> >On a P4 Xeon 1MB L3 server with 8GB ram, I've got 4GB swap configured,
> >and use about 2 of that with a 4 oracle instances running. The largest
> >instance is ~700GB, whereas the 4 others are ~30GB ea.
> 
> >In this scenario you have a large SHMMAX defined (4GB in this case), or
> >50% available RAM. As Oracle, Java, and other bits are used in the
> >system threading or not, most of the entirety of the availble ram will
> >eventually get used. The available to cache ratio on a box like this
> >with 2.4.19-rc1 is ~2% free ram, and 95% cached, and 3% active.
> >Swap is ~50% right now. So regardless of how much ram you have, you will
> >swap some, somewhere.
> 
> 
> I thought linux worked more like Solaris where it didn't use any swap (AT
> ALL) until it has to... At least, I hope linux works this way.


Let me preface that. We are in a migration from E4500s to X86. Our
production boxen are using > 12GB Swap ea. Most of the time and have 8GB
ram ea. We do a lot of monitoring of our db because of the data types
we're using. Essentially, not OLTP, but batch loading and historical
data mining. 

> I manage a couple of Sun E10K domains (currently 20 procs, 20GB ram) running
> Oracle instances that are in excess
> of 1.5TB (for a single instance, this is considered very large for OLTP
> based usage of an Oracle instance)
> and we rarely see any use of our swap devices.
> 
...See above...
> I believe Linux does something similar (even though the implementations
> probably look completely different)...

It could but Linux does act very different in this respect, and is
usually more efficient about it.

> The point to make here is that this mechanism doesn't even kick in until
> free physical memory on the system drops
> to a low watermark (in Solaris it could be cachefree or lotsfree depending
> on version and whether it's using priority paging).
> Your not gonna have *anything* on the swap device until you have reached one
> of these watermarks (1/64 physical memory free in Solaris 8).
> 
> Solaris recently added an option to vmstat to look at paging statistics. It
> nicely seperates out executable anonymous and filesystem page in/outs. Heres
> some sample output fom one of the domains mentioned above:
> 
> # uname -a
> SunOS <hostname removed> 5.8 Generic_108528-07 sun4u sparc
> SUNW,Ultra-Enterprise-10000
> # prtconf | head
> System Configuration:  Sun Microsystems  sun4u
> Memory size: 20480 Megabytes
> System Peripherals (Software Nodes):
> 
> SUNW,Ultra-Enterprise-10000
>     packages (driver not attached)
>         terminal-emulator (driver not attached)
>         deblocker (driver not attached)
>         obp-tftp (driver not attached)
>         disk-label (driver not attached)
> 
> # vmstat -p 2
>      memory           page          executable      anonymous
> filesystem
>    swap  free  re  mf  fr  de  sr  epi  epo  epf  api  apo  apf  fpi  fpo
> fpf
>  80330680 10599432 2613 14569 352 0 8 144 3    3   16   38   38 1294  382
> 310
>  79949440 11044024 3 234 0  0   0    0    0    0    0    0    0    0    0
> 0
>  79946224 11041472 0 286 0  0   0    0    0    0    0    0    0    0    0
> 0
>  79940672 11037392 0 227 0  0   0    0    0    0    0    0    0    0    0
> 0
>  79939440 11035592 0 0  0   0   0    0    0    0    0    0    0    0    0
> 0
>  79936296 11031664 12 577 28 0  0    0    0    0    0    0    0    0   28
> 28
>  79934240 11030512 51 249 0 0   0    0    0    0    0    0    0    0    0
> 0
>  79931920 11029176 18 227 172 0 0    0    0    0    0    0    0    0  172
> 172
>  79930704 11028264 0 58 0   0   0    0    0    0    0    0    0    0    0
> 0
>  79926096 11025032 3 205 0  0   0    0    0    0    0    0    0    0    0
> 0
>  79927752 11024472 57 691 0 0   0    0    0    0    0    0    0    0    0
> 0
>  79922632 11019248 0 223 0  0   0    0    0    0    0    0    0    0    0
> 0
>  79920776 11017768 98 984 0 0   0    0    0    0    0    0    0    0    0
> 0

Yeah...I know. We page our asses off...on Solaris. :-D


>  Nothing went to the swap device.

I think it's application and type related. 

> Now there is a little sitting on the swap device here, but this system has
> been up for several days. What im stressing here is that it doesn't normally
> use the swap devices at all.

Our boxen were up for > 60 days before our latest maintenance window,
and yes, we're at ~12GB again now.

> When you size your DB you have control over how much memory is used for
> buffer caches and sort area (for hash joins, etc..). you should be able to
> size your instances so that they only occasionally hit the swap device. Now
> if you can't afford the correct amount of hardware to stay off the swap
> device, then that's another story, 

Not so much about large DBs, but large DBs with lots of different things
around it. Let's put it more into perspective, that our systems don't
swap until oracle starts doing stuff..it could easily be schema and
package related, there are a *few* table-scans we *must* do in our
application. Until the code is changed in the future, that will not
change. We also have about 50-100 sqlplus operations going 100% of the
time, in addition to our loading connections.

We've tweaked, re-tweaked, etc, over and over and over, had countless
people from oracle come to take a crack, and actually, this is as good
as it gets for us ATM. :-D At least on Linux we're only using 2GB. 

> but what you imply above is that you
> always use the swap device when runnning large DB's, and that just doesn't
> make any sense to me.

I'm not implying that at all, but I can see how you might think so. What
I was really implying, is that regardless if you have a lot of memory or
not, it's how you use that memory in relationship with how much you have
that will determine if you swap or not. In a perfect world, it might be
safe to say "I don't need swap at all ever.", but I can't say that it's
something that *has* become normal practice with production desktops and
servers. 

Almost everything can use a little bit of swap, regardless of how much
ram you might have. 

> --Buddy
-- 
Austin Gonyou <austin@digitalroadkill.net>
