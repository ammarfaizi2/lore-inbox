Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTBKWXD>; Tue, 11 Feb 2003 17:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbTBKWXD>; Tue, 11 Feb 2003 17:23:03 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:29631 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266431AbTBKWW7>; Tue, 11 Feb 2003 17:22:59 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Ford <david+cert@blue-labs.org>
Date: Wed, 12 Feb 2003 09:32:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15945.31207.919161.654770@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Current NFS issues (2.5.59)
In-Reply-To: message from David Ford on Tuesday February 11
References: <3E46E1D6.20709@blue-labs.org>
	<15944.30340.955911.798377@notabene.cse.unsw.edu.au>
	<3E492B0D.4020004@blue-labs.org>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 11, david+cert@blue-labs.org wrote:
> 
> No, no automount of any sort.  Server 1 and server 2 share /home and 
> apache virtuals back and forth, shell and web server.  So they are 
> mounted at boot.
> 
> Server 1 is the shell server, 2 is the web server.  When the shell 
> server is restarted, all the clients that fetch other mounts off the web 
> server get '1's for the df information in short order.  There is some 
> delay, not sure what the delay is for.  During that delay, 
> /nfsmountpoint access stalls on the clients.  Unfortunately my own home 
> directory comes off that mountpoint and the wonder coding of Raster 
> causes multiple large explosions and instantaneous destruction of your 
> graphical session.  So I've lost a fair amount of NFS debug notes 
> unexpectedly :S
> 
> If I'm fast on the draw and run exportfs on server 2 quick enough, I 
> manage to save my desktop before that timeout hits.

I think I would need a precise description of everything that is
mounted and exactly where.  I don't know what use this would actually
be, but it is very hard to reason about this sort of thing in the
abstract.  Maybe there will be something in the details that will ring
a bell.

> >>
> >
> >Can you capture the panic and send it to me please?
> >
> 
> I plan to setup a notebook w/ serial console capture.

Thanks.

> >I think this might be a reiserfs problem.  Someone else mentioned that
> >this started happening when they upgrade from an earlier 2.5 kernel.
> >If you can capture the NFS traffic 
> >	tcpdump -s 1500 -w /tmp/afile host $server and host $client
> >we could have a look at the directory cookies and see what is
> >happening.
> >
> 
> Is this important to start the tcpdump before the mount is established?  
> If I start the tcpdump after I've detected the looping, is that useful?  
> There's a lot of NFS traffic :)

Starting the tcpdump once the looping has started would be fine.
However your description of repeated rings makes it sould very much
like a directory cookie problem.

Could you run this program on the server:
--------------------------
#include <sys/types.h>
#include <dirent.h>

main()
{
	DIR *dir;
	struct dirent *de;
	dir = opendir(".");
	
	while ((de = readdir(dir)))
		printf("%10lu %10lu %s\n",
		       de->d_off,
		       de->d_ino,
		       de->d_name);
}
----------------------------
In the directory that is causing problems.  The first column printed
is the cookie.  If it ever repeats, you have simple proof that
reiserfs is doing the wrong thing, and you should report it to the 
reiserfs team.

NeilBrown
