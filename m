Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRIEJfj>; Wed, 5 Sep 2001 05:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270165AbRIEJf2>; Wed, 5 Sep 2001 05:35:28 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:21256 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S268916AbRIEJfY>; Wed, 5 Sep 2001 05:35:24 -0400
Date: Wed, 5 Sep 2001 10:35:40 +0100
From: Bob Dunlop <Bob.Dunlop@farsite.co.uk>
To: Kenneth Michael Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, torvalds@transmeta.com
Subject: Re: [CHECKER] security errors for 2.4.9 and 2.4.9-ac7 (FIX 1 of 112)
Message-ID: <20010905103540.A30856@farsite.co.uk>
In-Reply-To: <Pine.GSO.4.31.0109041405210.15852-100000@saga18.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0109041405210.15852-100000@saga18.Stanford.EDU>; from kash@stanford.edu on Wed, Sep 05, 2001 at 07:27:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep  5,  Kenneth Michael Ashcraft wrote:
> Hi All,
> 
> I've extended the security checker (makes sure that user lengths are
> bounds checked) quite a bit since my last report on July 13.  The checker
> makes sure that bounds checks are present before a user length is:
...
> ---------------------------------------------------------
> [BUG] this one looks nasty.  not only copy a large amount but copy it wherever (gem)
> /home/kash/linux/2.4.9/drivers/net/wan/farsync.c:1214:fst_ioctl: ERROR:RANGE:1203:1214: Using user length "size" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1203 [distance=12]

I'd agree it's nasty.  Don't you just love overflow math.

Fortunatly the fix is straight forward:


--- linux/drivers/net/wan/farsync.c.orig	Sun Aug 12 18:38:48 2001
+++ linux/drivers/net/wan/farsync.c	Wed Sep  5 09:52:33 2001
@@ -1200,7 +1200,8 @@
                 /* Sanity check the parameters. We don't support partial writes
                  * when going over the top
                  */
-                if ( wrthdr.size + wrthdr.offset > FST_MEMSIZE )
+                if ( wrthdr.size > FST_MEMSIZE || wrthdr.offset > FST_MEMSIZE
+                                || wrthdr.size + wrthdr.offset > FST_MEMSIZE )
                 {
                         return -ENXIO;
                 }



-- 
        Bob Dunlop
        FarSite Communications Ltd.
        http://www.farsite.co.uk/
