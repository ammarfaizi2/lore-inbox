Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311197AbSCLNiW>; Tue, 12 Mar 2002 08:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311198AbSCLNiG>; Tue, 12 Mar 2002 08:38:06 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:43510 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S311197AbSCLNhs>; Tue, 12 Mar 2002 08:37:48 -0500
Date: Tue, 12 Mar 2002 15:37:29 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: zlib vulnerability and modutils
Message-ID: <20020312133729.GG128921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020311234516.GC128921@niksula.cs.hut.fi> <4394.1015887380@kao2.melbourne.sgi.com> <14719.1015891493@redhat.com> <20020312000828.GB132950@niksula.cs.hut.fi> <20020312094642.GD128921@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312094642.GD128921@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 11:46:42AM +0200, you [Ville Herva] wrote:
> On Tue, Mar 12, 2002 at 02:08:28AM +0200, you [Ville Herva] wrote:
> > >
> > > It may be a little more intrusive than you wanted though.
> > 
> > Quite possibly -- at least considering that some of the kernels I run are
> > still 2.2.x and even 2.0.x...
> 
> I suppose this patch
> 
> http://cvs.samba.org/cgi-bin/cvsweb/rsync/zlib/infblock.c.diff?r1=text&tr1=1.2&r2=text&tr2=1.6&f=u
> 
> is closer to what I need. It seems most vendors have only patched ppp's zlib
> implementation (drivers/net/zlib.c). I couldn't find that particular patch
> in redhat update kernel .src.rpm, tough. I guess I'll have to apply the zlib
> diff by hand.

Ok, I found the following in the redhat errata kernel .src.rpm. It was well
hidden in ipvs-1.0.6-2.2.19.patch... I guess this is the same that Arjan
sent to Alan.

However, this does not apply to 2.0. 


-- v --

v@iki.fi

--- linux/drivers/net/zlib.c	Fri Feb  8 10:35:28 2001
+++ linux/drivers/net/zlib.c	Fri Feb  8 10:35:30 2001
@@ -3860,10 +3860,11 @@
                              &s->sub.trees.tb, z);
       if (t != Z_OK)
       {
-        ZFREE(z, s->sub.trees.blens);
         r = t;
-        if (r == Z_DATA_ERROR)
+        if (r == Z_DATA_ERROR) {
           s->mode = BADB;
+          ZFREE(z, s->sub.trees.blens);
+        }
         LEAVE
       }
       s->sub.trees.index = 0;
@@ -3928,14 +3929,16 @@
 #endif
         t = inflate_trees_dynamic(257 + (t & 0x1f), 1 + ((t >> 5) & 0x1f),
                                   s->sub.trees.blens, &bl, &bd, &tl, &td, z);
-        ZFREE(z, s->sub.trees.blens);
         if (t != Z_OK)
         {
-          if (t == (uInt)Z_DATA_ERROR)
+          if (t == (uInt)Z_DATA_ERROR) {
             s->mode = BADB;
+            ZFREE(z, s->sub.trees.blens);
+          }
           r = t;
           LEAVE
         }
+        ZFREE(z, s->sub.trees.blens);
         Tracev((stderr, "inflate:       trees ok, %d * %d bytes used\n",
               inflate_hufts, sizeof(inflate_huft)));
         if ((c = inflate_codes_new(bl, bd, tl, td, z)) == Z_NULL)



