Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290680AbSARMMv>; Fri, 18 Jan 2002 07:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290677AbSARMMm>; Fri, 18 Jan 2002 07:12:42 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:53410 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S290681AbSARMM1>; Fri, 18 Jan 2002 07:12:27 -0500
Message-Id: <200201181212.g0ICCGq14563@bliss.uni-koblenz.de>
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Fri, 18 Jan 2002 13:12:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: nfs@lists.sourceforge.net, zaitcev@redhat.com
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201171855.g0HIt1314492@devserv.devel.redhat.com>
In-Reply-To: <200201171855.g0HIt1314492@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 17. January 2002 19:55, Pete Zaitcev wrote:
> >[from linux-kernel]
> > I have to increase the number of anonymous filesystems the kernel can
> > handle and found the array unnamed_dev_in_use fs/super.c and changed the
> > array size from the default of 256 to 1024. Testing this patch by
> > mounting more and more NFS-filesystems I found that still no more than
> > 800 NFS mounts are possible. One more mount results in the kernel saying:
...
>
> Initially I did a sysctl, but Trond M. asked for a mount
> argument, in case you have to mount from several servers,
> some of which require reserved ports, some do not.
> Our NetApps work ok with non-reserved ports on clients.
>
> I am surprised anyone is interested. If you need more than 800
> mounts I think your system planning may be screwed.
>

First of all, thank you for your answer. Well I don't think that such a setup 
is really screwed. Just as a reasoning I can give some examples why I think 
that it is basically very useful for many sites running a large count of 
users:

At our site we store all user (~4000 users) data 
centrally on several NFS servers (running solaris up to now). In order to 
ease administration we chose the approach to mount each user directory 
direcly (via automount configured by NIS) on a NFS client where the user 
wants to access his data. The most 
important effect of this is, that each users directory is always reachable 
under the path /home/<user>. This proofed to be very useful (from the 
administrators point of view) when moving users from one server to another, 
installing additionl NFS servers etc, because the only path the user knows 
about and sees when e.g. issuing pwd is /home/<user>. The second advantage 
is, that there is no need to touch the client system: No need for NFS mounts 
in /etc/fstab to mount the servers export directory and so there are no 
unneeded dependencies frpm any client to the NFS servers. 

Now think of a setup where no user directory mounts are configured but the 
whole directory of a NFS server with many users is exported. Of course this 
makes things easyer for the NFS-system since only one mount is needed but on 
the client you need to create link trees or something similar so the user 
still can access his home under /home/<user> and not something like 
/home/server1/<user>. Moreover even if you create link trees when you issue 
commands like pwd you see the real path (eg /server1/<user>) instead of the 
logical (/home/<user>). Such paths are soon written into scripts etc, so that 
if the user is moved sometime later  things will be broken. 
You simply loose a layer of abstraction if you do not mount the users dir 
directly. The only other solution I know of would be amd. Amd automatically 
places a link. But since we come from the sun world, we simply uses suns 
automounter and there were no problems up to now. 

As another not umcommon setup you might think of  NAS storage in a larger 
company. Again you have  the choice to mount on a per user basis or you mount 
the parent directory containing many users. In  the latter case again you 
loose the /home abstraction to some degree. 

So I think it would be really good to have at least the option to have more 
than 256 NFS mounts even if one has to use unsecure ports for this purpose. 

Thanks 
Rainer
-- 
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz, 		   http://www.uni-koblenz.de/~krienke
Rechenzentrum,                     Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
