Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSAXI7V>; Thu, 24 Jan 2002 03:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285482AbSAXI7M>; Thu, 24 Jan 2002 03:59:12 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:45714 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S285369AbSAXI7B>; Thu, 24 Jan 2002 03:59:01 -0500
Message-Id: <200201240858.g0O8wnH03603@bliss.uni-koblenz.de>
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Thu, 24 Jan 2002 09:58:48 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201221523.g0MFNst03011@bliss.uni-koblenz.de> <20020122124518.B27968@devserv.devel.redhat.com>
In-Reply-To: <20020122124518.B27968@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22. January 2002 18:45, Pete Zaitcev wrote:
> > From: Rainer Krienke <krienke@uni-koblenz.de>
> > Date: Tue, 22 Jan 2002 16:23:54 +0100
> >
> > Thanks for the hint. I fixed pmap_create() according to your proposal and
> > now nfsd works again.
>
> Care to share the patch?

Sorry here it is. Its excatly what I described in my initial posting and very 
simple and only raises the limit of unnamed_dev_in_use:

diff -Naur linux-2.4.17.orig/fs/super.c linux-2.4.17/fs/super.c
--- linux-2.4.17.orig/fs/super.c        Fri Dec 21 18:42:03 2001
+++ linux-2.4.17/fs/super.c     Thu Jan 24 08:23:05 2002
@@ -489,13 +489,13 @@
  * filesystems which don't use real block-devices.  -- jrs
  */

-static unsigned long unnamed_dev_in_use[256/(8*sizeof(unsigned long))];
+static unsigned long unnamed_dev_in_use[4096/(8*sizeof(unsigned long))];

 kdev_t get_unnamed_dev(void)
 {
        int i;

-       for (i = 1; i < 256; i++) {
+       for (i = 1; i < 4096; i++) {
                if (!test_and_set_bit(i,unnamed_dev_in_use))
                        return MKDEV(UNNAMED_MAJOR, i);
        }


If you apply this patch as well as andis patch the system then is capable of 
mounting up to 4096 NFS dirs. I tested this and it worked without problems. 
The only thing I noticed is that the automounter needs quite a long time 
(several seconds) do exire such a mass of mounts. But this is only a 
performance issue.

...
> You did not send your patch (yet again), so there is no way
> to tell precisely what you have accomplished. I suspect that it may
> create pages with same device number that belong to different
> mounts. I do not pretend to understand how VFS and page cache
> use device numbers. If device numbers are used for any indexing,
> pages may be mixed up with resulting data corruption.
> I cannot say if this scenario is likely without looking
> at the VFS code. Perhaps we ought to ask Stephen, Al, or Trond
> about it.
>

Andis patch together with my small modification has still some problems you 
Pete already solved. On the other hand it has the advantage, that you can 
mount a very high number only limited by the bitmap unnamed_dev_in_use of NFS 
directories. The problems are:

1. You cannot start NFSD on a host patched with the above patches. So you 
cannot mount  an exported directory on  another linux box. Since you and 
Trond already described why this happend in Petes first patch it should be 
possible to  fix this.
2. You cannot NFS mount any filesystem exported by this host, since andis 
patch does not include a mount option to select either secure/non secure 
port. Since a "normal" kernel linux NFS Client wants always a secure port 
mounting is impossible. 
3. You cannot NFS mount from another linux box, again this happend since 
there is no mount option that would allow to say that only secure ports 
should be used. 

So I think if it would be possible to include the mount option "nores" like 
Pete did but now in andis patch as well as a patch so nfsd will run again, 
andis solution has the big adavantage of beeing able to mount more than 1279  
NFS directories. 

This was the reason why I was interested to know if there is a major 
drawback, if you simply do not use more major devices like Pete's patch does. 
If there are none, than I would propose to drop the use of new major devices.

Thanks Rainer
-- 
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz, 		   http://www.uni-koblenz.de/~krienke
Rechenzentrum,                     Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
