Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280366AbRJaR4c>; Wed, 31 Oct 2001 12:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280364AbRJaR4Q>; Wed, 31 Oct 2001 12:56:16 -0500
Received: from miro.qualcomm.com ([129.46.64.223]:33748 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S280352AbRJaRyw>; Wed, 31 Oct 2001 12:54:52 -0500
Message-Id: <5.1.0.14.0.20011031095211.0dbc23f0@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 31 Oct 2001 09:55:47 -0800
To: <pcg@goof.com ( Marc A. Lehmann )>, "David S. Miller" <davem@redhat.com>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: 2.4.13-ac5 && vtun not working
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011031104323.A2263@schmorp.de>
In-Reply-To: <20011031.003056.63128206.davem@redhat.com>
 <5.1.0.14.0.20011029174700.08e93090@mail1>
 <20011029.175312.26299226.davem@redhat.com>
 <20011031010500.B383@schmorp.de>
 <20011031.003056.63128206.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:43 AM 10/31/01 +0100, pcg@goof.com ( Marc) (A.) (Lehmann ) wrote:
>On Wed, Oct 31, 2001 at 12:30:56AM -0800, "David S. Miller" <davem@redhat.com> wrote:
>> You're right, it should allow the "string has no '%' at all" case
>> as well.  Please, someone send me a patch which does this.
>
>My original mail contained a one-line fix, suboptimal but works fine for me.
>I also found a more elaborate patch:
>
>   http://www.geocrawler.com/lists/3/SourceForge/12162/0/6896612/
>
>it seems to use a fancier algorithm and has been used by more people.

Here is the patch for TUN/TAP to remove that suboptimality :). 
So we won't call dev_alloc_name if name is not a template.

--- tun.c.old   Tue Oct 30 21:00:55 2001
+++ tun.c       Tue Oct 30 21:10:17 2001
@@ -377,8 +377,11 @@
                if (*ifr->ifr_name)
                        name = ifr->ifr_name;
 
-               if ((err = dev_alloc_name(&tun->dev, name)) < 0)
-                       goto failed;
+               if (strchr(name, '%')) { 
+                       err = dev_alloc_name(&tun->dev, name);
+                       if (err) goto failed;
+               }
+
                if ((err = register_netdevice(&tun->dev)))
                        goto failed;

Untested but looks obvious. 

Max

